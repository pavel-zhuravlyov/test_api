require 'rails_helper'

describe User do
  describe 'Database' do
    it { is_expected.to have_db_column(:email).of_type(:string)}
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(null: false, default: '') }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:sign_in_count).of_type(:integer).with_options(default: '0') }
    it { is_expected.to have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:current_sign_in_ip).of_type(:string) }
    it { is_expected.to have_db_column(:last_sign_in_ip).of_type(:string) }
    it { is_expected.to have_db_column(:tokens).of_type(:text) }
  end
end
