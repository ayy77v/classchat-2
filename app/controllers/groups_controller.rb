class GroupsController < ApplicationController
before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy] 






	def index
        @groups = Group.all

    end

    def show
        @group = Group.find(params[:id])

        @Idx = @group.id
       
    end


    def new
        @group = Group.new
    end

    def edit
        @group = current_user.groups.find(params[:id])
    end




    def create
         @group = current_user.groups.new(group_params)


   if @group.save

ref = Bigbertha::Ref.new( 'https://classchat-999ba.firebaseio.com' )

ref =ref.child( 'group')

data = {}; 
data[@group.id] = '0'

ref.update(data)






    current_user.join!(@group)
         redirect_to groups_path
     else
        render :new
      end
    end

    def update
         @group = current_user.groups.find(params[:id])

   if @group.update(group_params)
     redirect_to groups_path, notice: "successful save changes, 桃李滿天下～"
   else
    render :edit
  end
    
    end


    def destroy
     @group = current_user.groups.find(params[:id])
   @group.destroy
   redirect_to groups_path, alert: "課程已刪除"
    
    end



     def join
   @group = Group.find(params[:id])

   if !current_user.is_member_of?(@group)
     current_user.join!(@group)
     flash[:notice] = "成功加入課程！"
   else
     flash[:warning] = "已自課程退出！"
   end

   redirect_to group_path(@group)
 end

 def quit
   @group = Group.find(params[:id])

   if current_user.is_member_of?(@group)
     current_user.quit!(@group)
     flash[:alert] = "已退出課程！"
   else
     flash[:warning] = "閣下並非本課程成員"
   end

   redirect_to group_path(@group)
 end





private

 def group_params 
   params.require(:group).permit(:title, :description)
 end


end
