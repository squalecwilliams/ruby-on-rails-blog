class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      redirect_to root_path, notice: 'Article was successfully destroyed.'
    else
      Rails.logger.error @article.errors.full_messages.join(', ')
      redirect_to @article, alert: 'Failed to destroy the article.'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @article.destroy
    redirect_to root_path(@article), status: :see_other
  end
  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
