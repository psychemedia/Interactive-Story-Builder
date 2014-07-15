class NotificationTrigger < ActiveRecord::Base
  attr_accessible :notification_type, :identifier, :processed
  scope :not_processed, where(:processed => false)

  def self.process_all_types
    process_new_user
    process_published_story 
  end

  #################
  ## new user
  #################
  def self.add_new_user(id)
    NotificationTrigger.create(:notification_type => Notification::TYPES[:new_user], :identifier => id)
  end

  def self.process_new_user
    triggers = NotificationTrigger.where(:notification_type => Notification::TYPES[:new_user]).not_processed    
    if triggers.present?
      I18n.available_locales.each do |locale|          
        message = Message.new
        message.bcc = Notification.for_new_user(locale,triggers.map{|x| x.identifier}.uniq)
        if message.bcc.present?
          message.locale = locale
          message.subject = I18n.t("mailer.notification.new_user.subject", :locale => locale)
          message.message = I18n.t("mailer.notification.new_user.message", :locale => locale)                  
          NotificationMailer.send_new_user(message).deliver
        end
      end
      NotificationTrigger.where(:id => triggers.map{|x| x.id}).update_all(:processed => true)
    end
  end

  #################
  ## published story
  #################
  def self.add_published_story(id)
    NotificationTrigger.create(:notification_type => Notification::TYPES[:published_story], :identifier => id)
  end

  def self.process_published_story
    triggers = NotificationTrigger.where(:notification_type => Notification::TYPES[:published_story]).not_processed    
    if triggers.present?
      I18n.available_locales.each do |locale|          
        message = Message.new
        message.bcc = Notification.for_published_story(locale)
        if message.bcc.present?
          message.locale = locale
          message.subject = I18n.t("mailer.notification.published_story.subject", :locale => locale)
          message.message = I18n.t("mailer.notification.published_story.message", :locale => locale)                  
          message.message2 = []

          triggers.map{|x| x.identifier}.uniq.each do |id|
            story = Story.published.find_by_id(id)
            if story.present?
              message.message2 << [story.title, story.permalink]
		        end
	        end
          NotificationMailer.send_published_story(message).deliver
        end
      end
      NotificationTrigger.where(:id => triggers.map{|x| x.id}).update_all(:processed => true)
    end
  end

  #################
  ## new story of user being followed
  #################
  def self.add_new_story_followed_user(id)
    NotificationTrigger.create(:notification_type => Notification::TYPES[:new_story_followed_user], :identifier => id)
  end

  def self.process_new_story_followed_user
    triggers = NotificationTrigger.where(:notification_type => Notification::TYPES[:new_story_followed_user]).not_processed    
    if triggers.present?
      I18n.available_locales.each do |locale|          
        message = Message.new
        message.bcc = Notification.for_new_story_followed_user(locale)
        if message.bcc.present?
          message.locale = locale
          message.subject = I18n.t("mailer.notification.new_story_followed_user.subject", :locale => locale)
          message.message = I18n.t("mailer.notification.new_story_followed_user.message", :locale => locale)                  
          message.message2 = []

          triggers.map{|x| x.identifier}.uniq.each do |id|
            story = Story.published.find_by_id(id)
            if story.present?
              message.message2 << [story.title, story.permalink]
		        end
	        end
          NotificationMailer.send_new_story_followed_user(message).deliver
        end
      end
      NotificationTrigger.where(:id => triggers.map{|x| x.id}).update_all(:processed => true)
    end
  end


  #################
  ## new news item
  #################
  def self.add_news(id)
    NotificationTrigger.create(:notification_type => Notification::TYPES[:news], :identifier => id)
  end

  def self.process_news
    triggers = NotificationTrigger.where(:notification_type => Notification::TYPES[:news]).not_processed    
    if triggers.present?
      I18n.available_locales.each do |locale|          
        message = Message.new
        message.bcc = Notification.for_news(locale,triggers.map{|x| x.identifier})
        if message.bcc.present?
          message.locale = locale
          message.subject = I18n.t("mailer.notification.news.subject", :locale => locale)
          message.message = I18n.t("mailer.notification.news.message", :locale => locale)                  
          message.message2 = []

          triggers.map{|x| x.identifier}.uniq.each do |id|
            news = News.published.find_by_id(id)
            if news.present?
              message.message2 << [news.title, news.permalink]
		        end
	        end
          NotificationMailer.send_news(message).deliver
        end
      end
      NotificationTrigger.where(:id => triggers.map{|x| x.id}).update_all(:processed => true)
    end
  end

end
