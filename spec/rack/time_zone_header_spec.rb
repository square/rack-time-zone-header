require 'spec_helper'

describe Rack::TimeZoneHeader do
  before :each do
    @app = lambda { |env| [200, {"Content-Type" => "text/plain"}, [""]] }
  end

  ["HTTP_TIME_ZONE", "HTTP_X_TIME_ZONE", "HTTP_TIMEZONE"].each do |header_name|
    [
      nil,
      "",
      ";;;",
      "*",
      "US/Mint_Plaza",
      "PONIES",
    ].each do |header_value|
      describe "with invalid header #{header_name}: #{header_value}" do
        before :each do
          @request = Rack::MockRequest.env_for("/", header_name => header_value, :lint => true, :fatal => true)
          @status, @headers, @response = described_class.new(@app).call(@request)
        end

        it "does not assign a TZInfo::Timezone instance to env['time.zone']" do
          @request['time.zone'].should be_nil
        end
      end
    end

    [
      "America/Los_Angeles",
      "US/Pacific",
      ";;US/Eastern",
      "2010-05-13T16:00:05-7:00;;US/Pacific",
      "2010-05-12T18:42:20+7:00;;Asia/Bangkok",
      "2010-05-13T18:20:21-4:00;;US/Eastern",
      "2010-05-13T19:17:59-3:00;;America/Sao_Paulo",
    ].each do |header_value|
      describe "with valid header #{header_name}: #{header_value}" do
        before :each do
          @request = Rack::MockRequest.env_for("/", header_name => header_value, :lint => true, :fatal => true)
          @time_zone_name = header_value.split(";").last
          @zime_zone = TZInfo::Timezone.get(@time_zone_name)
          @status, @headers, @response = described_class.new(@app).call(@request)
        end

        it "assigns a TZInfo::Timezone instance to env['time.zone']" do
          @request['time.zone'].should be_a_kind_of(TZInfo::Timezone)
        end

        it "the TZInfo::Timezone instance should reflect the header value" do
          @request['time.zone'].should == @zime_zone
        end
      end
    end
  end
end
