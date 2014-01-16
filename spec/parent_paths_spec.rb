require 'spec_helper'

describe ParentPaths do

  before :each do
    @this_path = File.expand_path(__FILE__)
  end

  describe '::find' do

    describe 'when the criteria is never met' do

      it 'should return nil if the criteria never passes' do
        ParentPaths.find('/foo/bar'){ false }.should be_nil
      end

      it 'should call the block once for each component of the path, as long as the criteria is not met' do
        called = 0
        ParentPaths.find('/foo/bar') do |path|
          called += 1
          false
        end
        called.should == 3
      end

    end # describe 'when the criteria is never met'

    describe 'when the criteria is met' do

      it 'should return the path of the first parent path that satisfies the criteria' do
        result = ParentPaths.find('/foo/bar'){ |path| path == '/foo' }
        result.should == '/foo'
      end

      it 'should stop calling the block when the criteria is met' do
        called = 0
        ParentPaths.find('/foo/bar') do |path|
          called += 1
          path == '/foo'
        end
        called.should == 2
      end

    end # describe 'when the criteria is met'

  end # describe '::find'

  describe '::find_owner' do

    describe 'when the starting path is explicitly provided' do

      describe 'when the given filename exists in an ancestor' do

        it 'should return the parent directory of the file' do
          ParentPaths.find_owner('LICENSE', @this_path).should == Pathname.new(@this_path).parent.parent.to_s
        end

      end # describe 'when the given filename exists in an ancestor'

      describe 'when the given filename doesn\'t exist in an ancestor' do

        it 'should return nil' do
          ParentPaths.find_owner('xzyxzy123123123_abcabc789789789', @this_path).should be_nil
        end

      end # describe 'when the given filename doesn\'t exist in an ancestor'

    end # describe 'when the starting path is explicitly provided'

    describe 'when the starting path is NOT explicitly provided' do

      describe 'when the given filename exists in an ancestor' do

        it 'should return the parent directory of the file' do
          ParentPaths.find_owner('LICENSE').should == Pathname.new(@this_path).parent.parent.to_s
        end

      end # describe 'when the given filename exists in an ancestor'

      describe 'when the given filename doesn\'t exist in an ancestor' do

        it 'should return nil' do
          ParentPaths.find_owner('xzyxzy123123123_abcabc789789789').should be_nil
        end

      end # describe 'when the given filename doesn\'t exist in an ancestor'

    end # describe 'when the starting path is NOT explicitly provided'

  end # describe '::find_owner'

  describe '::caller_path' do

    it 'should return the path of the caller of the method that includes it' do
      SpecHelper.path_of_the_method_calling_this.should == @this_path
    end

    it 'should handle levels of indirection correctly' do
      SpecHelper.path_of_this_method_being_called.should == File.dirname(__FILE__) + '/spec_helper.rb'
    end

  end # describe '::caller_path'

end