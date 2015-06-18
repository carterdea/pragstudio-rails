require 'rails_helper'

describe "a user" do
  it "requires a name" do
    user = User.new(name: "")
    user.valid?
    expect(user.errors[:name].any?).to eq(true)
  end

  it "requires an email" do
    user = User.new(email: "")
    user.valid?
    expect(user.errors[:email].any?).to eq(true)
  end

  it "accepts properly formatted email" do
    emails = %w[user@example.com first.last@example.com]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(false)
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[user@ @example.com @example .@ser. @]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(true)
    end
  end

  it "requires a unique, case insensitive email"

  it "is valid with example attributes"

  it "requires a password"

  it "requires the password to matcht he password confirmation"

  it "requires a password and matching password confirmation when creating"

  it "does not require a password when updating"

  it "automatically encrypts the password into the password_digest attribute"
end
