module SkeletonGenerator
  class BatchGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    def generate_batch_file
      copy_file 'application_batch.rb', 'app/batches/application_batch.rb', skip: true
      template 'batch_file.rb.erb', File.join('app/batches', class_path, "#{file_name}_batch.rb")
      template 'batch_spec.rb.erb', File.join('spec/batches', class_path, "#{file_name}_batch_spec.rb")
    end
  end
end
