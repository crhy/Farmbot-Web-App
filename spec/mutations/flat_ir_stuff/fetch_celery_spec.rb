require          "spec_helper"

describe FetchCelery do
  let(:user) { FactoryBot.create(:user) }
  let(:device) { user.device }

  it "Makes JSON that is identical to the legacy implementation" do
    Sequence.destroy_all
    expect(Sequence.count).to eq(0)
    expect(PrimaryNode.count).to eq(0)
    expect(EdgeNode.count).to eq(0)
    known_good = Sequences::Create.run!({
      name: "New Sequence",
      color: "gray",
      device: device,
      kind: "sequence",
      args: {},
      body: [
        { kind: "send_message",
          args: { message: "Hello, world!", message_type: "warn" },
          body: [{ kind: "channel", args: { channel_name: "toast" } }] }
      ]
    })
    result = FetchCelery.run!(sequences: [known_good.reload])
    binding.pry
  end
end
