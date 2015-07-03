class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  include StoryVisitRecord::StoryMethods

  # logo title desc 这三个字段的内容用来生成类似 infocard 的显示效果
  # 在朋友圈，微博分享的时候显示这个 infocard

  # 封面（一张图片）
  field :logo, type: String

  # 标题
  field :title, type: String

  # 简介
  field :desc, type: String

  # 页面正文
  # 目前预想的只有一个html页面
  # 这个字段保存 body 中的内容
  field :html_body

  # 修改后的页面正文
  # 这个字段保存 body 中的内容
  field :edit_html_body

  # 保存对应模版的数据, 用于生成最终的html
  field :data

  # 是否发布
  field :published_at, type: Time

  # 创建者
  belongs_to :user

  # 可以引用多个模板
  has_and_belongs_to_many :templates

  def to_html
    if data.blank?
      ''
    else
      array = JSON.parse data
      array.map do |hash|
        # TODO 理论上使用templates是不会出错的，但是要做好各种限制
        Mustache.render templates.find(hash.keys.first).body, hash.values.first
      end.join
    end
  end

  def edited?
    edit_html_body != html_body
  end

  def published?
    !!published_at
  end

  def publish!
    if !edit_html_body.nil? and edit_html_body != html_body
      update_attributes html_body: edit_html_body, published_at: Time.now
    end
  end

  def state_text
    if published?
      edited? ? '[新版本待发布]' : ''
    else
      '[未发布]'
    end
  end
end
