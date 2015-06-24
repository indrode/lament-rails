require 'rails_helper'

RSpec.describe Feature, type: :model do
  describe 'class methods' do
    before do
      stub_const('Feature::FEATURES', { search: false, authentication: true })
      Feature.reload_features!
    end

    describe '.features' do
      it 'returns all defined features' do
        expect(Feature.features).to be_a(Hash)
        expect(Feature.features).to eq({ search: false, authentication: true })
      end
    end

    describe '.defined_features' do
      it 'returns an array of defined feature keys' do
        expect(Feature.defined_features).to eq(%w(search authentication))
      end
    end

    describe '.reload_features!' do
      it 'stores defined features' do
        expect(Feature.count).to eq(2)
        expect(Feature.last.key).to eq('authentication')
      end
    end

    describe '.remove_old_features!' do
      it 'destroys old features in database but not defined anymore' do
        create(:feature)
        expect { Feature.remove_old_features! }.to change{ Feature.count }.from(3).to(2)
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

      it 'works with symbols or strings' do
        Feature.enable! 'search'
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

      it 'works with symbols or strings' do
        Feature.disable! 'search'
        expect(Feature.search_enabled?).to be_falsey
      end
    end
  end
end
