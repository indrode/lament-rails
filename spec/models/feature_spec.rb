require 'rails_helper'

RSpec.describe Feature, type: :model do
  describe 'class methods' do
    before do
      stub_const('Feature::FEATURES', { search: false, authentication: true })
      Feature.reload_features!
    end

    describe '.reload_features!' do
      it 'stores defined features' do
        expect(Feature.count).to eq(2)
        expect(Feature.last.key).to eq('authentication')
      end
    end

    describe '.key_enabled?' do
      it 'creates enabled? methods' do
        expect(Feature.search_enabled?).to be_falsey
      end
    end

    describe '.enable!' do
      it 'enables a feature' do
        expect(Feature.search_enabled?).to be_falsey
        Feature.enable!(:search)
        expect(Feature.search_enabled?).to be_truthy
      end
    end

    describe '.disable!' do
      it 'disables a feature' do
        Feature.enable!(:search)
        expect(Feature.search_enabled?).to be_truthy
        Feature.disable!(:search)
        expect(Feature.search_enabled?).to be_falsey
      end
    end
  end
end
