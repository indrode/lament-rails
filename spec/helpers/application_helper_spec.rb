require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#friendly_date' do
    let!(:date) { Date.new(2015, 12, 17) }

    it 'displays formatted date' do
      expect(friendly_date(date)).to eq('Dec 17, 2015')
    end
  end
end
