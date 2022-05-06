class Drawer
  def initialize(image)
    @image = image
  end

  def update_pixel(x, y, color)
    raise 'Wrong color' if !color || color.size != 1
    raise 'Wrong coordinate' unless pixel_present?(x, y)

    @image[y][x] = color.upcase
  end

  def update_vertical_segment(x, y1, y2, color)
    raise 'Wrong coordinates' if !@image.dig(x, y1) || !@image.dig(x, y2)

    direction = y1 < y2 ? :up : :down
    y1.send("#{direction}to", y2) do |y|
      update_pixel(x, y, color)
    end
  end

  def update_horizontal_segment(x1, x2, y, color)
    raise 'Wrong coordinates' if !@image.dig(x1, y) || !@image.dig(x2, y)

    direction = x1 < x2 ? :up : :down
    x1.send("#{direction}to", x2) do |x|
      update_pixel(x, y, color)
    end
  end

  def fill_region(x, y, color)
    prev_color = @image.dig(y, x)
    update_pixel(x, y, color)
    fill_region_around(x, y, new_color: color, prev_color: prev_color)
  end

  private

  def fill_region_around(x, y, new_color:, prev_color:, direction: nil)
    return unless pixel_present?(x, y)
    return if direction && @image.dig(y, x) != prev_color

    update_pixel(x, y, new_color)

    direction != :up &&
      fill_region_around(x, y + 1, new_color: new_color, prev_color: prev_color, direction: :down)
    direction != :down &&
      fill_region_around(x, y - 1, new_color: new_color, prev_color: prev_color, direction: :up)
    direction != :left &&
      fill_region_around(x + 1, y, new_color: new_color, prev_color: prev_color, direction: :right)
    direction != :right &&
      fill_region_around(x - 1, y, new_color: new_color, prev_color: prev_color, direction: :left)
  end

  def pixel_present?(x, y)
    @image.dig(y, x)
  end
end
