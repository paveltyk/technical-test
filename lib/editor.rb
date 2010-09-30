require 'image'
require 'readline'

class Editor
  def initialize(output)
    @output = output
  end
  def start
    @output.puts 'Welcome to Image Editor!'
    listen
  end

  def listen
    loop do
      cmd = Readline::readline '> ', true
      execute(cmd)
    end
  end

  def execute(cmd)
    case cmd
      when /^i (\d+)+ (\d+)+$/i
        @image = Image.new($1.to_i, $2.to_i)
      when /^c/i
        @image.clear
      when /^l (\d+) (\d+) ([a-z])$/i
        @image.colorize($1.to_i, $2.to_i,$3)
      when /^v (\d+) (\d+) (\d+) ([a-z])$/i
        @image.draw_vertical_segment($1.to_i, $2.to_i, $3.to_i, $4)
      when /^h (\d+) (\d+) (\d+) ([a-z])$/i
        @image.draw_horizontal_segment($1.to_i, $2.to_i, $3.to_i, $4)
      when /^f (\d+) (\d+) ([a-z])$/i
        @image.fill($1.to_i, $2.to_i, $3)
      when /^s$/i
        @output.puts @image.to_s
      when /^x$/i
        exit
      else
        puts 'Unknown command'
    end
  end
  
end