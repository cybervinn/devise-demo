require 'rails_helper'

describe QuizUpdater do

  let!(:quiz) { create(:quiz) }

  let!(:quiz_params) {
    { id: quiz.id,
      quiz: {
      name: 'New quiz',
      questions_attributes: {
        '0' => {
          id: quiz.questions.first.id,
          body: 'MyText' ,
          answers_attributes: {
            '0' => { body: 'Sure',
                     correct: false }
          }},

        '1' => {
          body: 'To be or nah?' ,
          answers_attributes: {
            '0' => { body: 'Sure',
                     correct: true }}}
      }}}}

  before do
    @updater = QuizUpdater.new(quiz)
  end

  describe '#update' do
    it "adds new questions, based on params that don't match existing ones" do
      changed_quiz = @updater.update(quiz_params)
      expect(changed_quiz.questions.count).to eq(2)
    end

    it "remove questions that are not present in the params" do
      changed_quiz = @updater.update(quiz_params)
      expect(changed_quiz.questions.map(&:body)).to include('To be or nah?')
    end
  end

end
