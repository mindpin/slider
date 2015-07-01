class StoriesController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  def index
    @stories = current_user.stories
  end

  def show
    @story = Story.find params[:id]
  end

  def new
    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.new(story_params)
  end

  def edit
    @story = current_user.stories.find params[:id]
  end

  def update
    @story = Story.find params[:id]
    if @story.update_attributes story_params
      redirect_to stories_path
    else
      render :new
    end
  end

  def destroy
    @story = current_user.stories.find params[:id]
    @story.destroy
    redirect_to stories_path
  end

  private
  def story_params
    params.require(:story).permit(:logo, :title, :desc, :edit_html_body)
  end
end
