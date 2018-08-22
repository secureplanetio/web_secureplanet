class CveCodeSerializer < ActiveModel::Serializer
  attributes :cve, :score, :risk, :vulnerability_type, :publish_date, :update_date, :description

  def cve
    object.cve.strip
  end

  def score
    object.score.strip
  end

  def risk
    scope.call object.score
  end

  def vulnerability_type
    object.type.strip
  end

  def publish_date
    object.pdate&.strftime(SCAN_DATE_FORMAT) rescue nil
  end

  def update_date
    object.mdate&.strftime(SCAN_DATE_FORMAT) rescue nil
  end
end
