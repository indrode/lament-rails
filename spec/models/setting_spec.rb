require 'rails_helper'

RSpec.describe Setting, type: :model do
  describe 'class methods' do
    before do
      stub_const('Setting::SETTINGS', { author: 'Indro De', version: '0.1.0' })
      Setting.reload_settings!
    end

    describe '.settings' do
      it 'returns all defined settings' do
        expect(Setting.settings).to be_a(Hash)
        expect(Setting.settings).to eq({ author: 'Indro De', version: '0.1.0' })
      end
    end

    describe '.defined_settings' do
      it 'returns an array of defined setting keys' do
        expect(Setting.defined_settings).to eq(%w(author version))
      end
    end

    describe '.reload_settings!' do
      it 'stores defined settings' do
        expect(Setting.count).to eq(2)
        expect(Setting.last.key).to eq('version')
      end
    end

    describe '.remove_old_settings!' do
      it 'destroys old settings in database but not defined anymore' do
        create(:setting)
        expect { Setting.remove_old_settings! }.to change{ Setting.count }.from(3).to(2)
      end
    end

    describe '.key' do
      it 'creates class methods' do
          expect(Setting.author).to eq('Indro De')
      end
    end

    describe '.set!' do
      it 'sets a setting' do
        expect(Setting.author).to eq('Indro De')
        Setting.set!(:author, 'Erlich Bachman')
        expect(Setting.author).to eq('Erlich Bachman')
      end

      it 'works with symbols or strings' do
        Setting.set!('author', 'Erlich Bachman')
        expect(Setting.author).to eq('Erlich Bachman')
      end

      it 'works when using just a hash' do
        Setting.set!(author: 'Erlich Bachman')
        expect(Setting.author).to eq('Erlich Bachman')
      end
    end

    describe '.key_exists?(key, hash)' do
      it 'returns the key' do
        allow(Setting).to receive(:settings).and_return({ key1: '10', key2: '20' })
        expect(Setting.key_exists?('key1')).to eq(:key1)
      end
      it 'returns the key if hash is passed' do
        allow(Setting).to receive(:settings).and_return({ key1: '10', key2: '20' })
        expect(Setting.key_exists?(nil, { key1: '10'})).to eq(:key1)
      end
    end
  end
end
