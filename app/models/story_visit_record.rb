class StoryVisitRecord
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :ip,    type: String
  field :uv_id, type: String

  belongs_to :story

  module StoryMethods
    def self.included(base)
      base.has_many :story_visit_records
    end

    # 今天的 浏览量(PV)
    def today_pv_count
      where_distinct_count(get_time_range("today"))
    end

    # 昨天的 浏览量(PV)
    def yesterday_pv_count
      where_distinct_count(get_time_range("yesterday"))
    end

    # 最近七天的 浏览量(PV)
    def last_7day_pv_count
      where_distinct_count(get_time_range("last_7day"))
    end

    # 最近三十天的浏览量(PV)
    def last_30day_pv_count
      where_distinct_count(get_time_range("last_30day"))
    end

    # 今天的 访客数(UV)
    def today_uv_count
      where_distinct_count(get_time_range("today"), :uv_id)
    end

    # 昨天的 访客数(UV)
    def yesterday_uv_count
      where_distinct_count(get_time_range("yesterday"), :uv_id)
    end

    # 最近七天的 访客数(UV)
    def last_7day_uv_count
      where_distinct_count(get_time_range("last_7day"), :uv_id)
    end

    # 最近三十天的 访客数(UV)
    def last_30day_uv_count
      where_distinct_count(get_time_range("last_30day"), :uv_id)
    end

    # 今天的 IP数
    def today_ip_count
      where_distinct_count(get_time_range("today"), :ip)
    end

    # 昨天的 IP数
    def yesterday_ip_count
      where_distinct_count(get_time_range("yesterday"), :ip)
    end

    # 最近七天的 IP数
    def last_7day_ip_count
      where_distinct_count(get_time_range("last_7day"), :ip)
    end

    # 最近三十天的 IP数
    def last_30day_ip_count
      where_distinct_count(get_time_range("last_30day"), :ip)
    end

    # name => "today" | "yesterday" | "last_7day" | "last_30day"
    # result
    # {
    #   :created_at.gte => time, :created_at.lte => time
    #}

    private
    def get_time_range(name)
      case name
      when "today"
        start_time = Time.now.beginning_of_day
        end_time   = Time.now.end_of_day
      when "yesterday"
        start_time = Time.now.beginning_of_day - 1.day
        end_time   = Time.now.end_of_day - 1.day
      when "last_7day"
        end_time   = Time.now.end_of_day
        start_time = Time.now.end_of_day - 7.day + 1.second
      when "last_30day"
        end_time   = Time.now.end_of_day
        start_time = Time.now.end_of_day - 30.day + 1.second
      end
      { :created_at.gte => start_time, :created_at.lte => end_time }
    end

    def where_distinct_count(time_range, distinct_field = nil)
      if distinct_field == nil
        self.story_visit_records.where(time_range).count
      else
        self.story_visit_records.where(time_range).distinct(distinct_field).count
      end
    end

  end
end
