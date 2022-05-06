class ImagePresenter
  def initialize(image)
    @image = image
  end

  def to_s
    @image.map { |row| "#{row.join}\n" }.join
  end
end
