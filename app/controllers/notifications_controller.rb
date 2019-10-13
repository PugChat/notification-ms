class NotificationsController < ApplicationController
    def create 
        users = params[:users]
        notifications=[]
        users.each do |user|
            notification = Notification.new(message: notification_params[:message], user_id: user, sender_id:notification_params[:sender_id], chat_id: notification_params[:chat_id])
            notifications.push(notification)
            if !notification.save
                render json: "error",status: :unprocessable_entity
                return
            end
        end
        render json: notifications, status: 200
    end

    def get_users
        return params[:users]
    end
    
    def show 
        if !params[:user_id]
            return
        end
        chats =[]
        ans=[]
        notifications = Notification.where(user_id:params[:user_id])
        notifications.each do |notification|
            if !chats.include? (notification.chat_id)
                chats.push(notification.chat_id)
            end 
        end
        chats.each do |chat|
            aux=Notification.where(user_id:params[:user_id],chat_id:chat).order("created_at ASC")
            ans.push(aux)
        end
        render json: ans, status:200
    end

    def destroy
        notifications = Notification.where(user_id:params[:user_id])
        puts notifications
        notifications.each do |notification|
            notification.destroy
        end
        render json: params[:user_id], status: 200
    end

    def notification_params
        params.require(:notification).permit(:id, :message, :user_id, :sender_id, :chat_id)
    end
end
