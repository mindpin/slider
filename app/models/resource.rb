class Resource
  include MindpinBuckets::BucketResourceMethods
  act_as_bucket_resource into: :folder

  # 资源类型
  field :kind, type: String

  # 纯文本类型的内容
  field :text, type: String

  # 图片 视频 音频 上传到七牛以后的访问url的 path 部分
  # host 部分由配置文件提供（因为有可能修改自定义域名）
  # 通过 img4ye api 上传音频视频图片到 qiniu，然后获取 qiniu_path 保存在这个字段
  field :qiniu_path, type: String

  # 地理位置信息
  field :location, type: Hash

  # 创建者
  belongs_to :user
end


