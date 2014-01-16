require 'spec_helper'

describe ParentPaths do

  before :each do
    @this_path = File.expand_path(__FILE__)
  end

  describe '#scan' do

    it 'should pass path names to the given block' do
      ParentPaths.scan('/foo/bar') do |pathname|
        pathname.should be_an_instance_of(Pathname)
        false
      end
    end

    describe 'when the criteria is never met' do

      it 'should return nil if the criteria never passes' do
        ParentPaths.scan('/foo/bar'){ false }.should be_nil
      end

      it 'should call the block once for each component of the path, as long as the criteria is not met' do
        called = 0
        ParentPaths.scan('/foo/bar') do |pathname|
          called += 1
          false
        end
        called.should == 3
      end

    end # describe 'when the criteria is never met'

    describe 'when the criteria is met' do

      it 'should return the pathname of the first parent path that satisfies the criteria' do
        result = ParentPaths.scan('/foo/bar'){ |pathname| pathname == Pathname.new('/foo') }
        result.should == Pathname.new('/foo')
      end

      it 'should stop calling the block when the criteria is met' do
        called = 0
        ParentPaths.scan('/foo/bar') do |pathname|
          called += 1
          pathname == Pathname.new('/foo')
        end
        called.should == 2
      end

    end # describe 'when the criteria is met'

  end # describe '#scan'

  describe '#scan_for_owner' do

    describe 'when the starting path is explicitly provided' do

      describe 'when the given filename exists in an ancestor' do

        it 'should return the parent directory of the file' do
          ParentPaths.scan_for_owner('LICENSE', @this_path).should == Pathname(@this_path).parent.parent
        end

      end # describe 'when the given filename exists in an ancestor'

      describe 'when the given filename doesn\'t exist in an ancestor' do

        it 'should return nil' do
          ParentPaths.scan_for_owner('xzyxzy123123123_abcabc789789789', @this_path).should be_nil
        end

      end # describe 'when the given filename doesn\'t exist in an ancestor'

    end # describe 'when the starting path is explicitly provided'

    describe 'when the starting path is NOT explicitly provided' do

      describe 'when the given filename exists in an ancestor' do

        it 'should return the parent directory of the file' do
          ParentPaths.scan_for_owner('LICENSE').should == Pathname(@this_path).parent.parent
        end

      end # describe 'when the given filename exists in an ancestor'

      describe 'when the given filename doesn\'t exist in an ancestor' do

        it 'should return nil' do
          ParentPaths.scan_for_owner('xzyxzy123123123_abcabc789789789').should be_nil
        end

      end # describe 'when the given filename doesn\'t exist in an ancestor'

    end # describe 'when the starting path is NOT explicitly provided'

  end # describe '#scan_for_owner'

  describe '#caller_path' do

    it 'should return the pathname of the caller of the method that includes it' do
      SpecHelper.path_of_the_method_calling_this.should == Pathname.new(@this_path)
    end

    it 'should handle levels of indirection correctly' do
      SpecHelper.path_of_this_method_being_called.should == Pathname.new(File.dirname(__FILE__)) + 'spec_helper.rb'
    end

  end # describe '#caller_path'

end