require 'spec_helper'
require 'image_arrays'

describe Image do
  let(:image) {Image.new(6,6)}
  describe "#initialize" do
    it "should create 6x6 array with 'O' elements" do
      image.instance_variable_get(:@image_arr).should eql(image_str_to_array IMAGE_CLEAN)
    end
  end
  describe "#to_s" do
    it "should return 'image string'" do
      image.to_s.should eql IMAGE_CLEAN
    end
  end
  describe "#colorize" do
    it "should set 'pixel' color to 'C'" do
      image.colorize(2, 3, 'C')
      image.to_s.should eql IMAGE_WITH_L_2_3_C
    end
  end

  describe "#draw_vertical_segment" do
    it "should draw vertical line with 'C' color" do
      image.draw_vertical_segment(2, 2, 4, 'C')
      image.to_s.should eql IMAGE_WITH_V_2_2_4_C
    end
    it "should draw vertical line with 'C' color even if Y coordinates are in reverse order" do
      image.draw_vertical_segment(2, 4, 2, 'C')
      image.to_s.should eql IMAGE_WITH_V_2_2_4_C
    end
  end

  describe "#draw_horizontal_segment" do
    it "should draw horizontal line with 'C' color" do
      image.draw_horizontal_segment(3, 3, 5, 'C')
      image.to_s.should eql IMAGE_WITH_H_3_3_5_C
    end
    it "should draw horizontal line with 'C' color even if X coordinates are in reverse order" do
      image.draw_horizontal_segment(3, 5, 3, 'C')
      image.to_s.should eql IMAGE_WITH_H_3_3_5_C
    end
  end

  describe "#fill" do
    it "should fill inner area" do
      image.instance_variable_set :@image_arr, image_str_to_array(IMAGE_RECTANGLE_COLORED_WITH_C)
      image.fill(3, 3, 'F')
      image.to_s.should eql IMAGE_RECTANGLE_COLORED_WITH_C_INNER_FILLED_WITH_F
    end
    it "should fill outer area" do
      image.instance_variable_set :@image_arr, image_str_to_array(IMAGE_RECTANGLE_COLORED_WITH_C)
      image.fill(1, 1, 'F')
      image.to_s.should eql IMAGE_RECTANGLE_COLORED_WITH_C_OUTER_FILLED_WITH_F
    end
  end

  describe "#clear" do
    it "should clear image to deault color" do
      image.instance_variable_set :@image_arr, image_str_to_array(IMAGE_CLEAN)
      image.clear
      image.to_s.should eql IMAGE_CLEAN
    end
  end
end

def image_str_to_array(image_str)
  image_str.split("\n").map{ |row| row.split }
end