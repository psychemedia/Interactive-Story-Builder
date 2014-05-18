# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140518144246) do

  create_table "assets", :force => true do |t|
    t.integer  "item_id"
    t.integer  "asset_type"
    t.string   "caption",            :limit => 2000
    t.string   "source"
    t.integer  "option"
    t.string   "asset_file_name"
    t.string   "asset_content_type", :limit => 45
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer  "position"
    t.integer  "asset_subtype",                      :default => 0
  end

  add_index "assets", ["item_id", "asset_type"], :name => "index_assets_on_item_id_and_asset_type"
  add_index "assets", ["item_id", "position"], :name => "index_assets_on_item_id_and_position"
  add_index "assets", ["item_id"], :name => "index_assets_on_item_id"

  create_table "contents", :force => true do |t|
    t.integer  "section_id"
    t.string   "title"
    t.string   "sub_caption"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "caption"
  end

  add_index "contents", ["section_id"], :name => "index_contents_on_section_id"

  create_table "embed_media", :force => true do |t|
    t.integer  "section_id"
    t.string   "title"
    t.string   "url"
    t.text     "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "embed_media", ["section_id"], :name => "index_embed_media_on_section_id"

  create_table "impressions", :force => true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], :name => "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], :name => "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], :name => "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], :name => "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], :name => "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], :name => "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], :name => "impressionable_type_message_index", :length => {"impressionable_type"=>nil, "message"=>255, "impressionable_id"=>nil}
  add_index "impressions", ["user_id"], :name => "index_impressions_on_user_id"

  create_table "media", :force => true do |t|
    t.integer  "section_id"
    t.integer  "media_type"
    t.string   "title"
    t.string   "caption",                :limit => 2000
    t.integer  "caption_align"
    t.string   "source"
    t.string   "audio_path"
    t.string   "video_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name_old"
    t.string   "image_content_type_old"
    t.integer  "image_file_size_old"
    t.datetime "image_updated_at_old"
    t.string   "video_file_name_old"
    t.string   "video_content_type_old"
    t.integer  "video_file_size_old"
    t.datetime "video_updated_at_old"
    t.integer  "position"
    t.boolean  "video_loop",                             :default => true
  end

  add_index "media", ["section_id", "position"], :name => "index_media_on_section_id_and_position"
  add_index "media", ["section_id"], :name => "index_media_on_section_id"

  create_table "news", :force => true do |t|
    t.boolean  "is_published", :default => false
    t.date     "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news", ["is_published", "published_at"], :name => "index_news_on_is_published_and_published_at"

  create_table "news_translations", :force => true do |t|
    t.integer  "news_id"
    t.string   "locale"
    t.string   "title"
    t.text     "content"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news_translations", ["locale"], :name => "index_news_translations_on_locale"
  add_index "news_translations", ["news_id"], :name => "index_news_translations_on_news_id"
  add_index "news_translations", ["permalink"], :name => "index_news_translations_on_permalink"
  add_index "news_translations", ["title"], :name => "index_news_translations_on_title"

  create_table "sections", :force => true do |t|
    t.integer  "story_id"
    t.integer  "type_id"
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_marker",             :default => true
    t.string   "audio_file_name_old"
    t.string   "audio_content_type_old"
    t.integer  "audio_file_size_old"
    t.datetime "audio_updated_at_old"
  end

  add_index "sections", ["position"], :name => "index_sections_on_position"
  add_index "sections", ["story_id"], :name => "index_sections_on_story_id"

  create_table "slideshows", :force => true do |t|
    t.integer  "section_id"
    t.string   "title"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "media_author"
    t.boolean  "published",                  :default => false
    t.datetime "published_at"
    t.integer  "thumbnail_old"
    t.string   "thumbnail_file_name_old"
    t.string   "thumbnail_content_type_old"
    t.integer  "thumbnail_file_size_old"
    t.datetime "thumbnail_updated_at_old"
    t.integer  "template_id",                :default => 1
    t.integer  "impressions_count",          :default => 0
    t.integer  "reviewer_key"
    t.string   "permalink"
  end

  add_index "stories", ["permalink"], :name => "index_stories_on_permalink"
  add_index "stories", ["published"], :name => "index_stories_on_published"
  add_index "stories", ["published_at"], :name => "index_stories_on_published_at"
  add_index "stories", ["reviewer_key"], :name => "index_stories_on_reviewer_key"
  add_index "stories", ["template_id"], :name => "index_stories_on_template_id"
  add_index "stories", ["user_id"], :name => "index_stories_on_user_id"

  create_table "stories_users", :force => true do |t|
    t.integer "story_id"
    t.integer "user_id"
  end

  add_index "stories_users", ["story_id"], :name => "index_stories_users_on_story_id"
  add_index "stories_users", ["user_id"], :name => "index_stories_users_on_user_id"

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.string   "author"
    t.text     "params"
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",      :default => true
  end

  add_index "templates", ["title"], :name => "index_templates_on_title"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.integer  "role",                   :default => 0,  :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "nickname"
    t.string   "avatar"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
