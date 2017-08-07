class GroupsController < ApplicationController 
# Daniel note: add next line to limit "new group" must login 
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]  
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
  def index 
  	 @groups = Group.all 
  end
  def new 
  	 @group = Group.new 
  end  
  def show  
     @group = Group.find(params[:id])  
#    @posts = @group.posts                   
#    @posts = @group.posts.order("created_at DESC") 
#    @posts = @group.posts.recent
     @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 3) 
  end      
  def edit  
#    find_group_and_check_permission
#    @group = Group.find(params[:id]) 
#    if current_user != @group.user 
#       redirect_to root_path, alert: "You have no permission." 
#    end   
  end                 

  def create 
  	 @group = Group.new(group_params) 
     @group.user = current_user  
  	 if @group.save  
       current_user.join!(@group)
  	   redirect_to groups_path 
     else 
       render :new  
     end                       
  end  
  def update 
#    find_group_and_check_permission 
     if @group.update(group_params)  
       redirect_to groups_path, notice: "Update Success"  
     else 
       render :edit 
     end  
  end        
  def destroy 
#    find_group_and_check_permission
     @group.destroy   
     redirect_to groups_path, alert: "Group deleted"   
  end         
  # add 'def join' & 'def quit' below 
  def join
   @group = Group.find(params[:id])
  
    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "加入本討論版成功！"
    else
      flash[:warning] = "你已經是本討論版成員了！"
    end  
    redirect_to group_path(@group)
  end
  
  def quit
    @group = Group.find(params[:id]) 
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已退出本討論版！"
    else
      flash[:warning] = "你不是本討論討論版成員，怎么退出 XD"
    end             
    redirect_to group_path(@group)
  end

  private     
    def find_group_and_check_permission
    @group = Group.find(params[:id])
    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end              
  def group_params  
     params.require(:group).permit(:title, :description) 
  end 

end
