require 'rails/generators/erb'
require 'rails/generators/resource_helpers'

module Erb
  module Generators
    class ScaffoldGenerator < Base
      include Rails::Generators::ResourceHelpers

      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      class_option :singleton, :type => :boolean, :desc => "Supply to skip index view"

      def create_root_folder
        empty_directory File.join("app/views", controller_file_path)
      end

      def copy_view_files
        views = available_views
        views.delete("index") if options[:singleton]

        views.each do |view|
          filename = filename_with_extensions(view)
          template filename, File.join("app/views", controller_file_path, filename)
        end
      end

    protected

      def available_views
        %w(index edit show new _form)
      end
    end
  end
end
