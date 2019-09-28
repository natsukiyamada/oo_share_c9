class CommentsController < ApplicationController
  def update
    respond_to do |format| 
      format.json { @new_comment = Comment.where('id > ?', params[:new_comment][:id]) } # json形式でアクセスがあった場合は、params[:new_comment][:id]よりも大きいidがないかCommentから検索して、@new_commentに代入する
    end
  end
  
  def create
    @event = Event.find_by(id: params[:event_id])
    @comment = @event.comments.build(comment_params)
    respond_to do |format|    
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to user_event_path(@event.user_id, @event) }
        flash.alert = "コメントの作成に失敗しました"
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id]) 
      respond_to do |format|
        if @comment.destroy
          format.js { render :index }
        end 
      end
  end

  private
    
    def comment_params
      params.require(:comment).permit(:user_id, :event_id, :content, :unknown_user_id)
    end

end
