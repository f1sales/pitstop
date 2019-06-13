
RSpec.describe Pitstop::K8SCommands do
   describe 'delete store with a given name' do
    context 'when store exists' do

      let(:k8s_client){ Object.new }
      let(:store_name){ 'foobar' }

      before do
        allow(K8s::Client).to receive(:config).and_return(k8s_client)
        allow(k8s_client).to receive(:api).and_return(k8s_client)
        allow(k8s_client).to receive(:resource).and_return(k8s_client)
        allow(k8s_client).to receive(:delete_collection).and_return(k8s_client)
      end

      after do
        subject.invoke(:delete, [store_name]) 
      end

      it 'calls api v1' do
        expect(k8s_client).to receive(:api).with('v1')
      end

      it 'calls resource with pods and default namespace' do
        expect(k8s_client).to receive(:resource).with('pods', namespace: 'default')
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

