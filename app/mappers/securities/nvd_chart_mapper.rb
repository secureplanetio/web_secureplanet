module Securities
  class NvdChartMapper
    def initialize(cve_info:, cvss_version: Settings.company.cvss.v20 )
      @cve_info = cve_info
      @cvss_version = cvss_version
      @cvss_level = Securities::CvssLevelMapper.new(cvss_version: cvss_version)
      @chart_restult = {}
    end

    def call
      return {} if cve_info.blank?
      pack_chart_data
      chart_restult
    end

    private

    attr_reader :cve_info, :cvss_version, :cvss_level, :chart_restult

    def pack_chart_data
      risk, publish_at = {}, {}
      risk[:cvss_version] = cvss_version
      risk[:critical] = 0 unless cvss_version == Settings.company.cvss.v20
      risk[:high], risk[:medium], risk[:low] = 0, 0, 0

      cve_info.each do |info|
        level = cvss_level.call info[0].strip
        unless cvss_version == Settings.company.cvss.v20
          risk[:critical] += 1 if level == 'critical'
        end
        risk[:high] += 1 if level == 'high'
        risk[:medium] += 1 if level == 'medium'
        risk[:low] += 1 if level == 'low'

        unless info[1].blank?
          date = info[1].to_datetime.year.to_s
          if publish_at[date].blank?
            publish_at[date] = 1
          else
            publish_at[date] += 1
          end
        end
      end
      chart_restult[:risk] = risk
      chart_restult[:publish_at] = publish_at
    end
  end
end
