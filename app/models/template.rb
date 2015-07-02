class Template
  include Mongoid::Document
  include Mongoid::Timestamps
  # 可以被多个 story 引用
  has_and_belongs_to_many :stories

  # 封面（一张图片）
  field :logo, type: String

  # 标题
  field :title, type: String

  # 简介
  field :desc, type: String

  # 保存对应模版
  field :body

  # 保存演示html
  field :sample_html

  # 正文的表现形式不明，先不设计
end
