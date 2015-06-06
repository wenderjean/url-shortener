require 'rails_helper'

describe Url do
  it { expect(subject).to belong_to(:user) }

  context 'when a origin URL has given' do
    before { subject.origin = 'www.google.com' }

    describe '.base_url' do
      it { expect(Url.base_url).to eq('ly.com/') }
    end

    describe '#hash' do
      it 'should short to 0a137b3' do
        expect(subject.hash).to eq('0a137b3')
      end
    end

    describe '#shorted' do
      it 'should return ly.com/0a137b3' do
        expect(subject.shorted).to eq('ly.com/0a137b3')
      end
    end
  end
end
