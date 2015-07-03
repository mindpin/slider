require 'rails_helper'

RSpec.describe StoryVisitRecord, type: :model do
  before do
    @story = create(:story, html_body: '', edit_html_body: '')

    # 创建今天的数据
    Timecop.freeze(Time.now) do
      # 1 个 ip
      # 2 个 uv
      # 3 个 pv
      @story.story_visit_records.create(:ip => "192.168.1.233", :uv_id => "a")
      @story.story_visit_records.create(:ip => "192.168.1.233", :uv_id => "b")
      @story.story_visit_records.create(:ip => "192.168.1.233", :uv_id => "b")
    end

    # 创建昨天的数据
    Timecop.freeze(Time.now-1.day) do
      # 2 个 ip
      # 4 个 uv
      # 6 个 pv
      @story.story_visit_records.create(:ip => "192.168.1.233", :uv_id => "a")
      @story.story_visit_records.create(:ip => "192.168.1.233", :uv_id => "b")
      @story.story_visit_records.create(:ip => "192.168.1.233", :uv_id => "b")
      @story.story_visit_records.create(:ip => "192.168.1.234", :uv_id => "c")
      @story.story_visit_records.create(:ip => "192.168.1.234", :uv_id => "d")
      @story.story_visit_records.create(:ip => "192.168.1.234", :uv_id => "d")
    end

    # 创建前天的数据
    Timecop.freeze(Time.now-2.day) do
      # 1 个 ip
      # 2 个 uv
      # 3 个 pv
      @story.story_visit_records.create(:ip => "192.168.1.235", :uv_id => "a")
      @story.story_visit_records.create(:ip => "192.168.1.235", :uv_id => "c")
      @story.story_visit_records.create(:ip => "192.168.1.235", :uv_id => "c")
    end

    # 创建十天前的数据
    Timecop.freeze(Time.now-10.day) do
      # 1 个 ip
      # 2 个 uv
      # 3 个 pv
      @story.story_visit_records.create(:ip => "192.168.1.236", :uv_id => "e")
      @story.story_visit_records.create(:ip => "192.168.1.236", :uv_id => "f")
      @story.story_visit_records.create(:ip => "192.168.1.236", :uv_id => "f")
    end

  end

  it '今天的 浏览量(PV)' do
    @story.today_pv_count.should == 3
  end

  it '昨天的 浏览量(PV)' do
    @story.yesterday_pv_count.should == 6
  end

  it '最近七天的 浏览量(PV)' do
    @story.last_7day_pv_count.should == 12
  end

  it '最近三十天的 浏览量(PV)' do
    @story.last_30day_pv_count.should == 15
  end

  it '今天的 访客数(UV)' do
    @story.today_uv_count.should == 2
  end

  it '昨天的 访客数(UV)' do
    @story.yesterday_uv_count.should == 4
  end

  it '最近七天的 访客数(UV)' do
    @story.last_7day_uv_count.should == 4
  end

  it '最近三十天的 访客数(UV)' do
    @story.last_30day_uv_count.should == 6
  end

  it '今天的 IP数' do
    @story.today_ip_count.should == 1
  end

  it '昨天的 IP数' do
    @story.yesterday_ip_count.should == 2
  end

  it '最近七天的 IP数' do
    @story.last_7day_ip_count.should == 3
  end

  it '最近三十天的 IP数' do
    @story.last_30day_ip_count.should == 4
  end

end
