module SkeletonGenerator
  class ViewModelGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    def generate_form_file
      copy_file 'application_view.rb', 'app/view_models/application_view.rb', skip: true
      template 'view_model_file.rb.erb', File.join('app/view_models', class_path, "#{file_name}_view.rb")
      template 'view_model_spec.rb.erb', File.join('spec/view_models', class_path, "#{file_name}_view_spec.rb")
    end
  end
end
