require 'spec_helper'

describe 'Postfix::Type::Lookup::Database' do
  it { is_expected.to allow_values('btree', 'cdb', 'dbm', 'sdbm', 'hash', 'lmdb', 'texthash', 'cidr', 'pcre', 'regexp') }
  it { is_expected.not_to allow_value('invalid') }
end
