require 'rails_helper'

RSpec.describe Story, type: :model do
  before do
    @story = create(:story, html_body: '', edit_html_body: '')
  end

  it "#edited?" do
    @story.edited?.should == false

    @story.edit_html_body = 'changed'
    @story.edited?.should == true
  end

  it "#publish!" do
    # edit_html_body 为空不能发布
    @story.publish!.should be_nil

    @story.edit_html_body = 'changed'
    @story.publish!.should_not be_nil
  end

  it "#published?" do
    @story.published?.should == false

    @story.edit_html_body = 'changed'
    @story.publish!
    @story.published?.should == true
  end

  describe "#state_text" do
    it "未发布" do
      @story.state_text.should == '[未发布]'
    end

    it "已发布未修改" do
      @story.edit_html_body = 'changed'
      @story.publish!
      @story.state_text.should == ''
    end

    it "已发布已修改" do
      @story.edit_html_body = 'changed'
      @story.publish!
      @story.edit_html_body = '修改后的内容'
      @story.state_text.should == '[新版本待发布]'
    end
  end
end
