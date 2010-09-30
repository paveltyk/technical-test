require 'spec_helper'

describe Editor do
  let(:output) { double('output').as_null_object }
  let(:editor) { Editor.new(output) }

  describe '#start' do
    before(:each) {editor.stub(:listen)}
    it "should send welcome message" do
      output.should_receive(:puts).with('Welcome to Image Editor!')
      editor.start
    end
    it "should start listening" do
      editor.should_receive(:listen)
      editor.start
    end
  end

  describe "#execute" do
    it "should terminate program when 'X' cmd received" do
      lambda { editor.execute('x') }.should raise_error(SystemExit)
    end
    it "should create new image when 'I m n' command received" do
      Image.should_receive(:new).with(50, 20)
      editor.execute('i 50 20')
    end

    context "with initialized image 10x10" do
      let(:image) { double(Image.new(10, 10)) }
      before(:each) {editor.instance_variable_set :@image, image}

      it "should send :clear message to image when 'c' command received" do
        image.should_receive(:clear)
        editor.execute('c')
      end
      it "should send :colorize message to image with 5, 2 and 'C' when 'L 5 2 C' command received" do
        image.should_receive(:colorize).with(5,2,'C')
        editor.execute('L 5 2 C')
      end
      it "should send :draw_vertical_segment with 3, 2, 5 and 'C' to image when 'V 3 2 5 C' command received" do
        image.should_receive(:draw_vertical_segment).with(3,2,5,'C')
        editor.execute('V 3 2 5 C')
      end
      it "should send :draw_horizontal_segment with 2, 1, 6 and 'C' to image when 'H 2 1 6 C' command received" do
        image.should_receive(:draw_horizontal_segment).with(2,1,6,'C')
        editor.execute('H 2 1 6 C')
      end
      it "should send :fill with 2, 3 and 'C' to image when 'F 2 3 C' command received" do
        image.should_receive(:fill).with(2, 3, 'C')
        editor.execute('F 2 3 C')
      end
      it "should show the contents of the current image when 'S' command received" do
        image.stub :to_s
        output.should_receive(:puts)
        editor.execute('s')
      end
    end
  end

end
