module Apoptosis
  class Apoptosis
    attr_accessor :contents, :basedir

    def initialize
      @basedir = Dir.pwd
      @contents = Dir['**/*.*']
    end

    def get_blame(file)
      `git blame #{@basedir+'/'+file}`
    end

  end
end

ap = Apoptosis::Apoptosis.new

ap.contents.each do |f|
  puts ap.get_blame(f)
end
