module Securities
  class CvssLevelMapper

    def initialize(cvss_version:)
      @cvss_version = cvss_version
    end

    def call score_string
      if cvss_version == Settings.company.cvss.v20
        score_to_20_level score_string.to_f
      else
        score_to_level score_string.to_f
      end
    end

    private

    attr_reader :cvss_version

    def score_to_20_level score
      if score >= 7.0
        'high'
      elsif score >= 4.0
        'medium'
      else
        'low'
      end
    end

    def score_to_level score
      if score >= 9.0
        'critical'
      elsif score >= 7.0
        'high'
      elsif score >= 4.0
        'medium'
      else
        'low'
      end
    end
  end
end
