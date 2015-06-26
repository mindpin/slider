require 'rails_helper'

RSpec.describe Story, type: :model do
  before do
    @story = create(:story)
  end

  it "#title" do
    @story.title.should == 'title'
  end
end
