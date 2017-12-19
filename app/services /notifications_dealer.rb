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

  def update_notification
    notifications = Notification.all
    notifications.each do |notification|
      notification.update(read: true)
    end
  end
end
