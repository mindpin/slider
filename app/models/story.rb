class Story
  include Mongoid::Document
  include Mongoid::Timestamps

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

  # 是否发布
  field :is_published, type: Boolean

  # 创建者
  belongs_to :user

  # 可以引用多个模板
  has_and_belongs_to_many :templates
end
