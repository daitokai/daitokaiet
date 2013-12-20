# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Home", js: true do
  describe "GET /" do
    it "トップページにアクセス" do
      visit root_path
    end
  end
end
