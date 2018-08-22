module MessageCodes
  MESSAGE_CODES = {
                   'can_not_found_cve_risk'    => {head: 422, error: '422-201', error_description: I18n.t('validation.errors.cve.not_found_cve')},
                   'unknown'                   => {head: 500, error: '500-001', error_description: I18n.t('validation.errors.common.unknown')}}.freeze

  class RestCode
    def self.get(key)
      code = MESSAGE_CODES[key]
      code.blank? ? MESSAGE_CODES['unknown'] : code
    end
  end
end
