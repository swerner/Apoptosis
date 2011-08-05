module Apoptosis
  class Apoptosis
    attr_accessor :contents, :basedir

    def initialize
      @basedir = Dir.pwd
      @contents = (`git ls-files`).split("\n")
    end

    def get_blame(file)
      `git blame #{@basedir+'/'+file}`
    end

    def process_blame(blame)
      offenders = []

      blame.each_line do |l|
        line_date = Date.parse(extract_date(l))
        if line_date && old?(line_date)
          offenders << l
        end
      end
      offenders
    end

    #Old is defined as a year for now, just for fun
    #Should probably make it command line configurable
    def old?(line)
      today = Date.today()
      return (today.year > line.year) && (today.month >= line.month) || ((today.year - line.year) > 1)
    end

    def process_contents
      outfile = File.open("DeathRow.md", "w+")
      @contents.each do |f|
        begin
          lines = process_blame(get_blame(f))
          if lines.length > 0
            outfile.puts(@basedir+'/'+f)
            outfile.puts("=====")
            lines.each do |l|
              outfile.puts(l)
            end
          end
        rescue
        end
      end
      outfile.close
    end

    def extract_date(line)
      line.scan(/[0-9]{4}-[0-9]{2}-[0-9]{2}/)[0]
    end

  end
end
