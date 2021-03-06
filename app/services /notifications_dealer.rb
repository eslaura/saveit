class NotificationsDealer

  def item_notification
    @items = Item.all
    @items.each do |item|
      if item.notifications.all? { |notification| notification.read }
        item.update(notification: false)
      else
        item.update(notification: true)
      end
    end
  end

  def update_notification(id)
    notification = Notification.find(id)
    notification.update(read: true)
    item_notification
  end

  def update_new_notifications(user_id)
    notifications = Notification.joins(:item).where(items: { user_id: user_id}).all
    notifications.each do |notification|
      notification.update(new_notification: false)
    end
  end
end
