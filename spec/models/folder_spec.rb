require 'rails_helper'

describe Folder do

  before(:each) {
    @user = User.new(email: 'user@example.com') 
    @folder = @user.folders.create(name: 'name', desc: 'name')
  }

  subject { @folder }

  it { should respond_to(:resources) }
end

