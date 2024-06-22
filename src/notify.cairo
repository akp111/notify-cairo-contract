#[starknet::contract]
mod notify {
    use core::starknet::event::EventEmitter;
    #[storage]
    struct Storage {
    }

    #[derive(Drop, starknet::Event)]
    struct AddEmitterEvent {
        #[key]
        address: ByteArray,
        name: ByteArray,
        desc: ByteArray,
        icon: ByteArray,
    }

    #[derive(Drop, starknet::Event)]
    struct AddReceiverEvent {
        #[key]
        receiver: ByteArray,
        emitter: ByteArray,
    }

    #[derive(Drop, starknet::Event)]
    struct SendNotification {
        #[key]
        receivers: ByteArray,
        emitter: ByteArray,
        payload: ByteArray,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        AddEmitterEvent: AddEmitterEvent,
        AddReceiverEvent: AddReceiverEvent,
        SendNotification: SendNotification,
    }


    #[external(v0)]
    fn addEmitter(
        ref self: ContractState,
        name: ByteArray,
        desc: ByteArray,
        address: ByteArray,
        icon: ByteArray
    ) {
        self.emit(AddEmitterEvent { address: address, name: name, desc: desc, icon: icon, });
    }

    #[external(v0)]
    fn addReceiver(ref self: ContractState, emitter: ByteArray, receiver: ByteArray,) {
        self.emit(AddReceiverEvent { receiver: receiver, emitter: emitter, });
    }

    #[external(v0)]
    fn sendNotification(
        ref self: ContractState, emitter: ByteArray, receivers: ByteArray, payload: ByteArray,
    ) {
        self.emit(SendNotification { receivers: receivers, emitter: emitter, payload: payload, });
    }
}
