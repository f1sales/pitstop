
RSpec.describe Pitstop::K8SCommands do
  let(:k8s_client){ Object.new }

  before do
    allow(Object).to receive(:puts).and_return(nil)
    allow(K8s::Client).to receive(:config).and_return(k8s_client)
    allow(k8s_client).to receive(:api).and_return(k8s_client)
    allow(k8s_client).to receive(:resource).and_return(k8s_client)
    allow(k8s_client).to receive(:delete_collection).and_return(k8s_client)
  end

  describe 'delete store all stores' do

    after { subject.invoke(:delete_all) }

      it 'calls api v1' do
        expect(k8s_client).to receive(:api).with('v1')
      end

      it 'calls resource with pods and default namespace' do
        expect(k8s_client).to receive(:resource).with('pods', namespace: 'default')
      end

      it 'calls delete all stores' do
        expect(k8s_client).to receive(:delete_collection).with(labelSelector: {app: 'f1sales-api'})
      end
  end

  describe 'delete store with a given name' do
    context 'when store exists' do

      let(:store_name){ 'foobar' }

      after { subject.invoke(:delete, [store_name]) }

      it 'calls api v1' do
        expect(k8s_client).to receive(:api).with('v1')
      end

      it 'calls resource with pods and default namespace' do
        expect(k8s_client).to receive(:resource).with('pods', namespace: 'default')
      end

      it 'calls delete with store name' do
        expect(k8s_client).to receive(:delete_collection).with(labelSelector: {tier: store_name})
      end

      it 'calls delete with store sidekiq name' do
        expect(k8s_client).to receive(:delete_collection).with(labelSelector: {tier: "sidekiq-#{store_name}"})
      end
    end
  end
end

