class Api::V1::PlanetsController < Api::V1::ApiController
  before_action :doorkeeper_authorize!

  def cve_code_info
    security_cve_info = EngineDatabases::GetPlanet.new(scope: SecurityCveInfo).call()
    cve_info = security_cve_info.where(cve: params[:cve_code]).order(:cve).last
    ActiveRecord::Base.remove_connection(security_cve_info)
    expose cve_info
  end

  def cve_chart
    component = params[:component]
    represent_version = params[:represent_version]
    return error_with_ui_code('can_not_found_cve_risk') if component.blank? or represent_version.blank?
    codes = EngineDatabases::ComponentNameCveCode.new(component_name: component, represent_version: represent_version).call_chart
    return error_with_ui_code('can_not_found_cve_risk') if codes.blank?
    expose codes
  rescue => e
    error_with_ui_code('can_not_found_cve_risk', message = e.message)
  end

  def cve_list
    component = params[:component]
    represent_version = params[:represent_version]
    return error_with_ui_code('can_not_found_cve_risk') if component.blank? or represent_version.blank?
    codes = EngineDatabases::ComponentNameCveCode.new(component_name: component, represent_version: represent_version).call_codes
    return error_with_ui_code('can_not_found_cve_risk') if codes.blank?
    cvss_version = Securities::CvssLevelMapper.new(cvss_version: Settings.company.cvss.v20)
    security_cve_info = EngineDatabases::GetPlanet.new(scope: SecurityCveInfo).call()
    cve_info = security_cve_info.where(cve: codes).order(:cve).reverse_order
    cve_info = cve_info.page(params[:page]).per(params[:limit]) if params[:page].present? && params[:limit].present?
    expose cve_info, each_serializer: CveCodeSerializer, scope: cvss_version
    ActiveRecord::Base.remove_connection(security_cve_info)
  rescue => e
    error_with_ui_code('can_not_found_cve_risk', message = e.message)
  end
end
