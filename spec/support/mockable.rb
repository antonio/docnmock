shared_examples 'a mockable thing' do
  it { should respond_to(:mock) }
end
