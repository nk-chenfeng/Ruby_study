class IssuesController < ApplicationController
  def show
    #[Kieth] 调试语句
  	#render plain: params[:id].inspect
  	
  	@issue = Issue.find(params[:id])

    @comments = @issue.comments
  end

  def new
    if not current_user
      flash[:notice] = "Please login first"
      redirect_to :root
    else
     @issue = Issue.new
   end
 end

 def create
    #render plain: params[:issue].inspect
    Issue.create(issue_params)
    redirect_to :root
  end

  def edit
    @issue = Issue.find(params[:id])
  end

  def update
    i = Issue.find(params[:id])
    i.update_attributes(issue_params)
    redirect_to :root
  end

  def destroy
  	i = Issue.find(params[:id])
  	i.destroy
  	redirect_to :root
  end

  private
  def issue_params
    params.require(:issue).permit(:title, :content, :user_id)
  end
end
