class Image
  DEFAULT_COLOR = 'O'

  def initialize(m, n)
    @image_arr = Array.new
    n.times { @image_arr << Array.new(m, DEFAULT_COLOR) }
  end

  def clear
    @image_arr.each { |row| row.fill DEFAULT_COLOR}
  end

  def colorize(x, y, color)
    x, y = normalize_coords(x, y)
    @image_arr[y][x] = color
  end

  def draw_vertical_segment(x, y1, y2, color)
    x, y1, y2 = normalize_coords(x, y1, y2)
    y1, y2 = y2, y1 if y1 > y2
    @image_arr[y1..y2].each { |row| row[x] = color }
  end

  def draw_horizontal_segment(y, x1, x2, color)
    y, x1, x2 = normalize_coords(y, x1, x2)
    x1, x2 = x2, x1 if x1 > x2
    @image_arr[y].fill(color, x1..x2)
  end

  def fill(x,y,color)
    x, y = normalize_coords x, y
    flood_fill(x, y, @image_arr[y][x], color)
  end

  def to_s
    @image_arr.map{ |row| row.join(" ")}.join("\n")
  end

private

  def normalize_coords *args
    args.map! {|arg| arg - 1 } 
  end

  def flood_fill(x, y, original_color, new_color)
    return unless y >= 0 && y < @image_arr.size && x >= 0 && x < @image_arr[0].size

    return if @image_arr[y][x] != original_color
    return if @image_arr[y][x] == new_color

    @image_arr[y][x] = new_color

    flood_fill(x+1, y, original_color, new_color)
    flood_fill(x-1, y, original_color, new_color)

    flood_fill(x-1, y+1, original_color, new_color)
    flood_fill(x  , y+1, original_color, new_color)
    flood_fill(x+1, y+1, original_color, new_color)

    flood_fill(x-1, y-1, original_color, new_color)
    flood_fill(x,   y-1, original_color, new_color)
    flood_fill(x+1, y-1, original_color, new_color)
  end

end