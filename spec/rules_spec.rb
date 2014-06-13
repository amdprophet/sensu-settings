require File.join(File.dirname(__FILE__), "helpers")
require "sensu/settings/rules"

describe "Sensu::Settings::Rules" do
  include Helpers
  include Sensu::Settings::Rules

  it "can provide validation rules" do
    expect(must_be_a_hash({})).to be(true)
    expect(must_be_a_hash("")).to be(false)
    expect(must_be_a_hash_if_set({})).to be(true)
    expect(must_be_a_hash_if_set(nil)).to be(true)
    expect(must_be_a_hash_if_set("")).to be(false)
    expect(must_be_an_array([])).to be(true)
    expect(must_be_an_array("")).to be(false)
    expect(must_be_an_array_if_set([])).to be(true)
    expect(must_be_an_array_if_set(nil)).to be(true)
    expect(must_be_an_array_if_set("")).to be(false)
    expect(must_be_a_string("")).to be(true)
    expect(must_be_a_string(1)).to be(false)
    expect(must_be_a_string_if_set("")).to be(true)
    expect(must_be_a_string_if_set(nil)).to be(true)
    expect(must_be_a_string_if_set(1)).to be(false)
    expect(must_be_an_integer(1)).to be(true)
    expect(must_be_an_integer("")).to be(false)
    expect(must_be_a_numeric(1.5)).to be(true)
    expect(must_be_a_numeric("")).to be(false)
    expect(must_match_regex(/^foo$/, "foo")).to be(true)
    expect(must_match_regex(/^foo$/, "bar")).to be(false)
    expect(must_match_regex(/^\w+$/, "baz$")).to be(false)
    expect(must_be_boolean_if_set(true)).to be(true)
    expect(must_be_boolean_if_set(false)).to be(true)
    expect(must_be_boolean_if_set(nil)).to be(true)
    expect(must_be_boolean_if_set("")).to be(false)
    expect(items_must_be_strings([])).to be(true)
    expect(items_must_be_strings(["test"])).to be(true)
    expect(items_must_be_strings([1])).to be(false)
    expect(items_must_be_strings([""])).to be(false)
    expect(either_are_set?(1)).to be(true)
    expect(either_are_set?(1, nil)).to be(true)
    expect(either_are_set?(nil, nil, 1)).to be(true)
    expect(either_are_set?(1, 1)).to be(true)
    expect(either_are_set?).to be(false)
    expect(either_are_set?(nil)).to be(false)
    expect(either_are_set?(nil, nil)).to be(false)
    expect(must_be_time("16:30")).to be(true)
    expect(must_be_time("16:30", "21:00")).to be(true)
    expect(must_be_time(false)).to be(false)
    expect(must_be_time(false, "21:00")).to be(false)
    unless RUBY_VERSION < "1.9"
      expect(must_be_time("false")).to be(false)
      expect(must_be_time("false", "21:00")).to be(false)
    end
    expect(must_be_time(1)).to be(false)
    expect(must_be_either(%w[foo bar], "foo")).to be(true)
    expect(must_be_either(%w[foo bar], "bar")).to be(true)
    expect(must_be_either(%w[foo bar], ["foo", "bar"])).to be(true)
    expect(must_be_either(%w[foo bar], "baz")).to be(false)
    expect(must_be_either(%w[foo bar], 1)).to be(false)
    expect(must_be_either(%w[foo bar], nil)).to be(false)
    expect(must_be_either(%w[foo bar], ["foo", nil])).to be(false)
    expect(must_be_either_if_set(%w[foo bar], "foo")).to be(true)
    expect(must_be_either_if_set(%w[foo bar], nil)).to be(true)
    expect(must_be_either_if_set(%w[foo bar], "baz")).to be(false)
  end
end
