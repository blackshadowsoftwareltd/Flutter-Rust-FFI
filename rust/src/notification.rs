use std::{
    ffi::{c_char, CStr},
    time::Duration,
};

use notify_rust::{Hint, Notification, Timeout};

#[no_mangle] //? Derivative attribute. Every func needs to be marked with this attribute
pub extern "C" fn show_notification(title: *const u8, message: *const u8) {
    unsafe {
        let title: &str = CStr::from_ptr(title as *const c_char).to_str().unwrap();
        let message: &str = CStr::from_ptr(message as *const c_char).to_str().unwrap();
        match Notification::new()
            .summary(title)
            .body(message)
            .icon("/home/remon/Flutter/Flutter-Rust-FFI/assets/image/text-x-rust.png")
            .show()
        {
            Ok(_) => println!("Notification Shown!"),
            Err(e) => println!("Error sending notification : {:?}", e),
        }
    }
}
#[no_mangle] //? Derivative attribute. Every func needs to be marked with this attribute
pub extern "C" fn show_persistent_notification(
    app_name: *const u8,
    title: *const u8,
    message: *const u8,
    timeout: i32,
) {
    unsafe {
        let app_name: &str = CStr::from_ptr(app_name as *const c_char).to_str().unwrap();
        let title: &str = CStr::from_ptr(title as *const c_char).to_str().unwrap();
        let message: &str = CStr::from_ptr(message as *const c_char).to_str().unwrap();
        let duration = Duration::from_millis(timeout as u64);
        let time = Timeout::from(duration.clone());

        let message = format!("{:?}. Duration : {:?}", message, duration);
        let message = message.as_str();

        match Notification::new()
            .summary(title)
            .body(message)
            .icon("/home/remon/Flutter/Flutter-Rust-FFI/assets/image/text-x-rust.png")
            .appname(app_name)
            .hint(Hint::ActionIcons(true))
            .timeout(time) // this however is
            .action("identifier", "label")
            .show()
        {
            Ok(_) => println!("Notification Shown!"),
            Err(e) => println!("Error sending notification : {:?}", e),
        }
    }
}
