class NotificationsController < ApplicationController
    def create 
        notification = Notification.new(notification_params)
        if notification.save
            render json: notification,status:201
        else
            render json: "error",status: :unprocessable_entity
        end
    end

    def show 
        chats =[]
        ans=[]
        notifications = Notification.where(user_id:params[:user_id])
        notifications.each do |notification|
            if !chats.include? (notification.chat_id)
                chats.push(notification.chat_id)
            end 
        end
        puts chats
        chats.each do |chat|
            aux=Notification.where(user_id:params[:user_id],chat_id:chat)
            puts aux
            ans.push(aux)
        end
        puts ans
        render json: ans, status:200
    end

    def destroy
        notification = Notification.find(params[:id])
        notification.destroy
    end

    def notification_params
        params.require(:notification).permit(:id, :message, :user_id, :sender_id, :chat_id)
    end
end
