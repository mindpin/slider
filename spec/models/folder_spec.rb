require 'rails_helper'

describe Folder, type: :model do

  before(:each) {
    @user = create(:user)
    @folder = @user.folders.create(name: 'name', desc: 'name')
  }

  subject { @folder }

  it { should respond_to(:resources) }
end

