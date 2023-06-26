class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def show
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    if @comment.destroy
      redirect_to root_path
    else
      redirect_to article_path, status: see_other
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    if @comment.destroy
      redirect_to article_path
    else
      redirect_to article_path, status: see_other
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end