require 'spec_helper'

describe "records/edit" do
  before(:each) do
    @record = assign(:record, stub_model(Record,
      :user => "",
      :weight => "9.99"
    ))
  end

  it "renders the edit record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", record_path(@record), "post" do
      assert_select "input#record_user[name=?]", "record[user]"
      assert_select "input#record_weight[name=?]", "record[weight]"
    end
  end
end
