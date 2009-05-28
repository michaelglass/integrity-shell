require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Integrity::Notifier::Shell do
  describe "#deliver!" do
  
    context "a passing commit is pushed" do
      before(:each) do
        @passing = Integrity::Commit.gen(:successful)
      end
      context "if the passing script exist" do
        before(:each) do
          @config = {'passing_script' => File.expand_path(File.dirname(__FILE__)) + '/test_pass', 'failing_script' => ''}          
          @shell = Integrity::Notifier::Shell.new(@passing, @config)
        end
        it "should run the passing script" do
          @shell.deliver!.should == "pass!"
        end
      end
    
      context "if the passing script doesn't exist" do
        context "if the passing script is blank" do
          before(:each) do 
            @config = {'passing_script' => '', 'failing_script' => ''}
          end
          it "should not try to run the script"
        end
  
        context "if the passing script is not blank" do
          before(:each) do 
            @config = {'passing_script' =>  File.expand_path(File.dirname(__FILE__)) +'/test_pass_fake', 'failing_script' => ''}
          end
          it "should log an error"
        end
      end
    end
    
    context "a failing commit is pushed" do
      before(:each) do
        @failing = Integrity::commit.gen(:failed)
      end
      context "if the failing script exists" do
        before(:each) do
          @config = {'failing_script' => File.expand_path(File.dirname(__FILE__)) + '/test_fail', 'passing_script' => ''}
          @shell = Integrity::Notifier::Shell.new(@failing, @config)
        end
        it "should run the failing script"
      end
        
      context "if the failing script does not exist" do
        context "if the failing script is blank" do
          before(:each) do 
            @config = {'passing_script' => '', 'failing_script' => ''}
          end
          it "should not try to run the script"
        end
    
        context "if the failing script is not blank" do
          before(:each) do 
            @config = {'failing_script' => File.expand_path(File.dirname(__FILE__) + '/test_fail_fake'), 'passing_script' => ''}
          end
     
          it "should log an error"
        end
      end
    end
  end
end