class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

  def show
    @job = Job.find(params[:id])
    if @job.is_hidden
      flash[:warning] = 'This is a already archieved'
      redirect_to root_path
  end
  end

  # def index
  # @jobs = Job.where(is_hidden: false).order('created_at DESC')
  # end

  def index
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.where(is_hidden: false).order('wage_lower_bound DESC')
            when 'by_upper_bound'
              Job.where(is_hidden: false).order('wage_upper_bound DESC')
            when 'by_wolf'
              Job.where(is_wolf: true).order('wolf_name DESC')
            when 'by_lion'
              Job.where(is_lion: true).order('lion_name DESC')
            when 'by_dragon'
              Job.where(is_dragon: true).order('dragon_name DESC')
            else
              Job.where(is_hidden: false).order('created_at DESC')
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      flash[:notice] = 'Job is here'

      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      flash[:warning] = 'Job is new'

      redirect_to jobs_path
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path
    flash[:alert] = 'Jobs deleted'
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
  end
end
