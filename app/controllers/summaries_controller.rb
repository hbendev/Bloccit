class SummariesController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @summary = Summary.new
    authorize @summary
  end

  def show
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @summary = @post.summary
  end

  def edit
    @post = Post.find(params[:post_id])
    @summary = @post.summary
    authorize @summary
  end

  def create
    @post = Post.find(params[:post_id])
    @summary = @post.build_summary(summary_params)
    @summary.post = @post
    authorize @summary

    if @summary.save
      flash[:notice] = "Summary was saved."
      redirect_to [@topic, @post, @summary]
    else
      flash[:error] = "There was an error saving the summary. Please try again."
      render :new
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @summary = @post.summary
    authorize @summary

    if @summary.update_attributes(summary_params)
      flash[:notice] = "Your summary was updated."
      redirect_to [@topic, @post, @summary]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def summary_params
    params.require(:summary).permit(:description)
  end

end
