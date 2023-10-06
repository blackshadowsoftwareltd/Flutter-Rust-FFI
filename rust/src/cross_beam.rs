use std::{
    sync::{OnceLock, RwLock},
    thread,
    time::Duration,
};

use crossbeam_channel::{unbounded, Receiver, Sender};

#[no_mangle]
pub extern "C" fn cross_beam_sender() {
    init();
    thread::spawn(|| {
        let channel = CHANNEL.get().unwrap().read().unwrap().clone();
        for i in 0..10 {
            thread::sleep(Duration::from_secs(1));

            channel.0.send(i).unwrap();
            println!("Sent : {}", i)
        }
    });
}

#[no_mangle]
pub extern "C" fn cross_beam_receiver() {
    init();
    thread::spawn(|| {
        let channel = CHANNEL.get().unwrap().read().unwrap().clone();
        loop {
            let msg = channel.1.recv().unwrap();
            println!("Received : {}", msg);
        }
    });
    println!("Crossbeam 2 exit");
}

static CHANNEL: OnceLock<RwLock<(Sender<i32>, Receiver<i32>)>> = OnceLock::new();

fn init() {
    if CHANNEL.get().is_none() {
        let (s, r) = unbounded();
        CHANNEL.get_or_init(|| RwLock::new((s, r)));
    }
}
