module SkeletonGenerator
  class FormGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    def generate_form_file
      copy_file 'application_form.rb', 'app/forms/application_form.rb', skip: true
      template 'form_file.rb.erb', File.join('app/forms', class_path, "#{file_name}_form.rb")
      template 'form_spec.rb.erb', File.join('spec/forms', class_path, "#{file_name}_form_spec.rb")
    end
  end
end
