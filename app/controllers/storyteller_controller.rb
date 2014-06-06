class StorytellerController < ApplicationController
	layout false
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:index]
  before_filter(:only => [:staff_pick, :staff_unpick]) do |controller_instance|
    controller_instance.send(:valid_role?, User::ROLES[:staff_pick])
  end


  def index
    @css.push("storyteller.css")
    @js.push("storyteller.js")

  	story = Story.select('id').is_published.find_by_permalink(params[:id])
  	@story = Story.is_published.fullsection(story.id) if story.present?  
    # record if the user has liked this story
    @user_likes = false
  	@user_likes = current_user.voted_up_on? @story if user_signed_in?
    
  	if @story.present?
      respond_to do |format|     
        format.html 
      end
      # record the view count
      impressionist(@story)
    else
      redirect_to root_path, :notice => t('app.msgs.does_not_exist')
    end
  end
  

  def staff_pick
  	story = Story.is_published.find_by_permalink(params[:id])
  	if story && !story.staff_pick
  	  story.staff_pick = true
  	  story.save(:validate => false)
  	end
  	
    respond_to do |format|     
      format.json { render json: nil , status: :created } 
    end
  end
  
  def staff_unpick
  	story = Story.is_published.find_by_permalink(params[:id])
  	if story && story.staff_pick
  	  story.staff_pick = false
  	  story.save(:validate => false)
  	end
  	
    respond_to do |format|     
      format.json { render json: nil , status: :created } 
    end
  end


  def like
    story = Story.is_published.find_by_permalink(params[:id])
    story.liked_by current_user
  
    respond_to do |format|     
      format.json { render json: nil , status: :created } 
    end
  
  end


  def unlike
    story = Story.is_published.find_by_permalink(params[:id])
    story.unliked_by current_user
  
    respond_to do |format|     
      format.json { render json: nil , status: :created } 
    end
  end
  
end
