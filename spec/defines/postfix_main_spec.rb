require 'spec_helper'

describe 'postfix::main' do
  let(:title) do
    'dovecot_destination_recipient_limit'
  end

  let(:params) do
    {
      :value => '1',
    }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'without postfix class included' do
        it { expect { is_expected.to compile }.to raise_error(/must include the postfix base class/) }
      end

      context 'with postfix class included' do
        let(:pre_condition) do
          'include ::postfix'
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_postfix_main('dovecot_destination_recipient_limit') }
        it { is_expected.to contain_postfix__main('dovecot_destination_recipient_limit') }
      end
    end
  end
end
