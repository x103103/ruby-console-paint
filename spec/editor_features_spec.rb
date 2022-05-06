require 'spec_helper'

describe Editor do
  it 'does magic' do
    image = Image.new(5, 6)
    drawer = Drawer.new(image)
    drawer.update_pixel(1, 2, 'A')

    expected_text = <<~TEXT
      OOOOO
      OOOOO
      OAOOO
      OOOOO
      OOOOO
      OOOOO
    TEXT
    expect(ImagePresenter.new(image).to_s).to eq(expected_text)

    drawer.fill_region(2, 2, 'J')
    drawer.update_vertical_segment(1, 2, 3, 'W')
    drawer.update_horizontal_segment(2, 3, 1, 'Z')

    expected_text = <<~TEXT
      JJJJJ
      JJZZJ
      JWJJJ
      JWJJJ
      JJJJJ
      JJJJJ
    TEXT
    expect(ImagePresenter.new(image).to_s).to eq(expected_text)
  end
end
