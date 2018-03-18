class CommentsController < ApplicationController


  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to @comment.customer
    else
      #今回は全然関係ないモデルに飛ばすので、temlateを用いる！！！
      render template: "customers/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    # @commentがdestroyされる前に、commentが誰のものかを変数に保存する
    customer = @comment.customer
    @comment.destroy
    # さっき保存したcustomerをここで使う
    redirect_to customer
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :customer_id)
  end
end
