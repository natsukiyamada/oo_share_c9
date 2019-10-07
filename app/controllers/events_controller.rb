class EventsController < ApplicationController
  def new
    @event = current_user.events.build
    @user = current_user
  end
  
  def show
    @user = current_user
    @event = Event.find(params[:id])
    @comments = @event.comments.all.order(created_at: "DESC")
    @comment_liked_ranks = @event.comments.joins(:likes).group(:id).order("count(likes.id) DESC")
    
    #ajax
    @new_comments = @event.comments.where('id > ?', params[:last_comment_id])
    @update = params[:update_comment_area]
    @last_comment = params[:last_comment_id]
    
    respond_to do |format| 
      format.html

      if @last_comment.present? && @update.present?
        format.js { render :show }
      elsif @last_comment.present?
        format.js { render :show }
      elsif @update.present?
        format.js { render :update }
      end
    end
  end
  
  def create
    @user = current_user
    @event = Event.new(event_params)
    
    if @event.save
	     flash.notice =  "イベントを作成しました"
	  else
	     flash.alert = "イベントの作成に失敗しました"
    end
	   redirect_to user_path(@user)
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    @user = @event.user
    
    flash.notice = "イベントを削除しました" if @event.destroy
  	redirect_to user_path(@user)
  end
  
  def update
    event = Event.find(params[:id])
    event.update!(event_params)
    redirect_to user_event_path(event.user, event)
  end
  
  private
  
  def event_params
    params.require(:event).permit(:user_id, :event_code, :name, :content)
  end
end
