require './test/helper'

class AllthumbsTest < Test::Unit::TestCase
  context "Testing montage creation" do
    setup do
      assert IMAGES.size == 12
    end
  end
  should "generate a single 4 column (104x78) montage from 12 22px images with 2 pixel borders" do
    Allthumbs.generate(IMAGES, TESTMONTAGE, { :column => 4, :border => 2 })
    assert File.exists? TESTMONTAGE
    assert dimensions(TESTMONTAGE) == ["104", "78", nil]
  end
  should "generate a single 3 column (90x120) montage from 12 22px images with 4 pixel borders" do
    Allthumbs.generate(IMAGES, TESTMONTAGE, { :column => 3, :border => 4 })
    assert File.exists? TESTMONTAGE
    assert dimensions(TESTMONTAGE) == ["90", "120", nil]
  end
  should "raise an exception when bad image files are passed" do
    assert_raise RuntimeError do
      Allthumbs.generate('some/nonexistent/file.jpg', TESTMONTAGE, { :column => 3, :border => 4 })
    end
  end
  should "raise an exception when bad column row values are passed" do
    assert_raise RuntimeError do
      Allthumbs.generate(IMAGES, TESTMONTAGE, { :column => 3, :row => 20, :border => 4 })
    end
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

