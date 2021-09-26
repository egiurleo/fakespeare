# frozen_string_literal: true

RSpec.describe Fakespeare do
  it 'has a version number' do
    expect(Fakespeare::VERSION).not_to be nil
  end

  describe '.generate_quote' do
    let(:shakespeare_client) { instance_double(Fakespeare::Shakespeare::Client) }

    before do
      allow(Fakespeare::Shakespeare::Client).to receive(:new).and_return(shakespeare_client)
      allow(Fakespeare::RubyWords).to receive(:generate).with(1).and_return(['gem'])
    end

    context 'when Shakespeare::Client returns a quote' do
      before do
        allow(shakespeare_client)
          .to receive(:generate_quote)
          .and_return('Tempt not a desperate man')
      end

      it 'replaces the noun with a Ruby word' do
        expect(described_class.generate_quote).to eq('Tempt not a desperate gem')
      end
    end

    context 'when Shakespeare::Client errors' do
      before do
        allow(shakespeare_client)
          .to receive(:generate_quote)
          .and_raise(
            Fakespeare::Shakespeare::Error,
            'Error fetching Shakespeare quote'
          )
      end

      it 'raises a Fakespeare::Error' do
        expect do
          described_class.generate_quote
        end.to raise_error(Fakespeare::Error, /Error fetching Shakespeare quote/)
      end
    end
  end
end
