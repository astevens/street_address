require './helper'

class TestStreetAddress < Test::Unit::TestCase

  should "parse addresses in the format of '123 fake st' the same as it parses '123 fake st.'" do
    without_period = StreetAddress.parse('123 fake st')
    with_period = StreetAddress.parse('123 fake st.')
    assert_equal with_period, without_period
    assert_equal without_period, {"number"=>"123", "prefix"=>"", "street"=>"fake", "type"=>"st", "suffix"=>"", "city"=>"", "state"=>"", "zip"=>""}
  end

  should "parse addresses in the format of '123 fake st n' the same as it parses '123 fake st. n'" do
    without_period = StreetAddress.parse('123 noperiod st n')
    with_period = StreetAddress.parse('123 period st. n')
    assert_equal({"number"=>"123", "prefix"=>"", "street"=>"noperiod", "type"=>"st", "suffix"=>"n", "city"=>"", "state"=>"", "zip"=>""}, without_period)
    assert_equal({"number"=>"123", "prefix"=>"", "street"=>"period", "type"=>"st", "suffix"=>"n", "city"=>"", "state"=>"", "zip"=>""}, with_period)
  end

  should "parse addresses of various formats" do
    assert_equal({"number"=>"123", "prefix"=>"e", "street"=>"fake", "type"=>"st", "suffix"=>"n", "city"=>"santa rosa", "state"=>"ca", "zip"=>"94410"}, StreetAddress.parse('123 e fake st n, santa rosa, ca, 94410'))
    assert_equal({"number"=>"123", "prefix"=>"e", "street"=>"fake", "type"=>"st", "suffix"=>"n", "city"=>"santa rosa", "state"=>"CA", "zip"=>"94410"}, StreetAddress.parse('123 e fake st n, santa rosa, CALIFORNIA 94410'))
  end

  should "parse addresses with arbitrary spacing" do
    assert_equal({"number"=>"123", "prefix"=>"e", "street"=>"fake", "type"=>"st", "suffix"=>"n", "city"=>"santa rosa", "state"=>"ca", "zip"=>"94410"}, StreetAddress.parse('123    e.    fake   st.   n.,   santa rosa,    ca     94410'))
  end
end
