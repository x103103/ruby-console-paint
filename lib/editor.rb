require 'os'
require_relative './image'
require_relative './drawer'
require_relative './image_presenter'

trap("INT") do |signal|
  puts signal == 2 ? "\b\bShutting down..." : "Exit status: #{signal}"
  exit
end

class Editor
  def call
    play_greeting
    puts 'Ohoho let\'s have some fun!'

    loop do
      args_string = gets.strip
      exec(parse_args(args_string))
    end
  end

  private

  def parse_args(args_string)
    args_string.to_s.gsub(/\s{2,}/, ' ').split(' ')
  end

  def exec(args)
    command = args[0]
    command_args = args[1..]
    case command.downcase.to_sym
    when :i
      create_image(*command_args)
    when :l
      update_pixel(*command_args)
    when :v
      update_vertical_segment(*command_args)
    when :h
      update_horizontal_segment(*command_args)
    when :f
      fill_region(*command_args)
    when :s
      print
    when :x
      exit
    end
  rescue ArgumentError => e
    puts 'Wrong arguments'
  rescue RuntimeError => e
    puts e.message
  rescue StandardError => e
    puts 'Something went wrong'
  end

  def create_image(m, n)
    @image = Image.new(m.to_i, n.to_i)
  end

  def update_pixel(x, y, color)
    check_image_presence!

    Drawer.new(@image).update_pixel(to_coordinate(x), to_coordinate(y), color)
  end

  def update_vertical_segment(x, y1, y2, color)
    check_image_presence!

    Drawer.new(@image).update_vertical_segment(to_coordinate(x), to_coordinate(y1), to_coordinate(y2), color)
  end

  def update_horizontal_segment(x1, x2, y, color)
    check_image_presence!

    Drawer.new(@image).update_horizontal_segment(to_coordinate(x1), to_coordinate(x2), to_coordinate(y), color)
  end

  def fill_region(x, y, color)
    check_image_presence!

    Drawer.new(@image).fill_region(to_coordinate(x), to_coordinate(y), color)
  end

  def print
    puts ImagePresenter.new(@image).to_s
  end

  def play_greeting
    if OS.mac?
      Thread.new do
        `afplay assets/welcome.mp3`
      rescue StandardError
        # whatever happens, it doesn't matter
      end
    end
  end

  private

  def check_image_presence!
    raise 'Image is absent' unless @image
  end

  def to_coordinate(i)
    i.to_i - 1
  end
end
