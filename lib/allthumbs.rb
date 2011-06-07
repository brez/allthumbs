require 'cocaine' 
module Allthumbs
  # Generates the montage image for a list of file paths 
  # * options
  #   :border - surrounding border for each thumbnail in pixels
  #   :row    - number of thumbnails per row
  #   :column - number of thumbnails per column
  def self.generate files, out, options = {}
    row    = options[:row]
    column = options[:column]
    border = options[:border]

    raise "Incorrect number of files for specified row and column lengths" if files.size != (row * column) if row and column
    files.split.map { |file| raise "Attempting to generate with one or more invalid files" unless File.exists? file }

    begin
      Cocaine::CommandLine.new(
        "montage", "-geometry :geometry -tile :tile :files",
        :geometry => "+#{border}+#{border}", :tile => "#{column}x#{row}", :files => (files += " #{out}")).run
    rescue Cocaine::CommandNotFoundError => e
      raise "Could not run the 'montage' command. Please install ImageMagick."
    end

  end
end
