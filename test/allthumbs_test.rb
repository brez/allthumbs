require './test/helper'

class AllthumbsTest < Test::Unit::TestCase
  context "Testing montage creation" do
    setup do
      assert IMAGES.size == 12
    end
  end
  should "generate a single 4 column (104x78) montage from 12 22px images with 2 pixel borders" do
    montage = Allthumbs.generate(IMAGES, 'test/tmp-montage.jpg', { :column => 4, :border => 2 })
    assert File.exists? montage
    assert dimensions(montage) == [104, 78]
  end
  should "generate a single 3x4 (78x104) from 12 22px images" do
    assert false
  end
  should "generate a single 4x3 (104x78) from 12 22px images with a 3 pixel border" do
    assert false
  end
  should "generate a single 3x4 (78x104) from 12 22px images with " do
    assert false
  end
  should "raise an exception when bad image files are passed" do
    assert false
  end
end

def dimensions file
  file = file.path if file.respond_to? "path"
  geometry = begin
               Cocaine::CommandLine.new("identify", "-format %wx%h :file", :file => "#{file}[0]").run
             rescue Cocaine::CommandNotFoundError => e
               raise "Could not run the 'identify' command. Please install ImageMagick."
             end
  parse(geometry) || (raise "#{file} is not recognized by the 'identify' command.")
end

def parse string
  if match = (string && string.match(/\b(\d*)x?(\d*)\b([\>\<\#\@\%^!])?/i))
    return match[1,3]
  end
end

