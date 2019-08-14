require "application_system_test_case"

class QuizzsTest < ApplicationSystemTestCase
  setup do
    @quizz = quizzs(:one)
  end

  test "visiting the index" do
    visit quizzs_url
    assert_selector "h1", text: "Quizzs"
  end

  test "creating a Quizz" do
    visit quizzs_url
    click_on "New Quizz"

    fill_in "Description", with: @quizz.description
    fill_in "Type", with: @quizz.type_id
    click_on "Create Quizz"

    assert_text "Quizz was successfully created"
    click_on "Back"
  end

  test "updating a Quizz" do
    visit quizzs_url
    click_on "Edit", match: :first

    fill_in "Description", with: @quizz.description
    fill_in "Type", with: @quizz.type_id
    click_on "Update Quizz"

    assert_text "Quizz was successfully updated"
    click_on "Back"
  end

  test "destroying a Quizz" do
    visit quizzs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Quizz was successfully destroyed"
  end
end
