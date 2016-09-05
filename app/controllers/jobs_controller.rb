class JobsController < ApplicationController
  before_action :clear_search_index, :only => [:index]

  def index
    @search = Job.search(params[:q])
    @search.sorts = 'created_at' if @search.sorts.empty?
    @jobs = @search.result(distinct: true).page(params[:page]).per(25).to_a.uniq
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to root_path
    else
      render ('new')
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      redirect_to root_path
    else
      render ('edit')
    end
  end

  def delete
    @job = Job.find(params[:id])
  end

  def destroy
    job = Job.find(params[:id]).destroy
    redirect_to root_path
  end

  private
  def job_params
    params.require(:job).permit(:company, :title, :url, :location)
  end
end
