# Load Yaml
require 'yaml'
require 'fastimage'

begin

  # Load each section, check for errors such as invalid syntax
  # as well as if an image is missing
  main = YAML.load_file('_data/main.yml')
  main["sections"].each do |section|
    data = YAML.load_file('_data/' + section["id"] + '.yml')

    data['websites'].each do |website|
      image = "img/#{section['id']}/#{website['img']}"

      unless File.exists?(image)
        raise "#{website['name']} image not found."
      end

      image_dimensions = [32,32]

      unless FastImage.size(image) == image_dimensions
        raise "Image for #{website['img']} is not #{image_dimensions.join("x")}"
      end
          
      ext = ".png"
      unless File.extname(image) == ext
        raise "Image for #{website['img']} is not #{ext}"
      end
    end
  end

  # Load each provider and look for each image
  providers = YAML.load_file('_data/providers.yml')
  providers["providers"].each do |provider|
    pimage = "img/providers/#{provider['img']}";
    unless File.exists?(pimage)
      raise "#{provider['name']} image not found."
    end
    image_dimensions = [32,32]

    unless FastImage.size(pimage) == image_dimensions
      raise "Image for #{provider['img']} is not #{image_dimensions.join("x")}"
    end
          
    ext = ".png"
    unless File.extname(pimage) == ext
      raise "Image for #{provider['img']} is not #{ext}"
    end
  end

rescue Psych::SyntaxError => e
  puts 'Error in the YAML'
  puts e
  exit 1
rescue => e
  puts e
  exit 1
else
  puts 'No errors. You\'re good to go!'
end