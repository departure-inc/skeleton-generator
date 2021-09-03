module SkeletonGenerator
  class ServiceGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    def generate_service_file
      copy_file 'application_service.rb', 'app/services/application_service.rb', skip: true
      template 'service_file.rb.erb', File.join('app/services', class_path, "#{file_name}_service.rb")
      template 'service_spec.rb.erb', File.join('spec/services', class_path, "#{file_name}_service_spec.rb")
    end
  end
end
