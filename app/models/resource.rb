class Resource
  include MindpinBuckets::BucketResourceMethods
  act_as_bucket_resource into: :folder
end


