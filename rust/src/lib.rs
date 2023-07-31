use std::ffi::c_char;
use std::ffi::CStr; //? CStr is used to convert a C string to a Rust string
use std::ffi::CString;
use std::os::raw::c_int;
use std::sync::Mutex;
use std::thread::sleep;
use std::time::Duration; //? CString is used to convert a Rust string to a C string
#[no_mangle] //? Derivative attribute. Every func needs to be marked with this attribute
///? pub extern "C" is used to make the function available to C
pub extern "C" fn print_something() {
    let mut x: i128 = 0;
    for i in 0..1000000000 {
        x = x + i;
    }
    println!("Sum : {}", x)
}

#[no_mangle] //? Derivative attribute. Every func needs to be marked with this attribute
pub extern "C" fn sum_two_numbers(a: f64, b: f64) -> f64 {
    a + b
}

#[no_mangle] //? Derivative attribute. Every func needs to be marked with this attribute
pub extern "C" fn profile_concat(name: *const u8, age: i32) -> *const c_char {
    unsafe {
        let name_str: &str = CStr::from_ptr(name as *const c_char).to_str().unwrap();
        let result: String = format!("I am {} and I am {} years old.", name_str, age);
        let result_cstring: CString = CString::new(result).unwrap();
        result_cstring.into_raw()
    }
}

// Define a callback function type for passing data to Dart
type StreamCallback = extern "C" fn(*const u8, usize);

#[no_mangle]
pub extern "C" fn start_stream(callback: StreamCallback) {
    stream_data(callback);
}

pub fn stream_data(callback: StreamCallback) {
    let data = b"Hello, World!";
    let len = data.len();

    let mut i = 0;
    let mut _byte = 0;
    loop {
        if i >= len {
            break;
        }
        sleep(Duration::from_secs(1));
        _byte = data[i];
        println!("Byte : {}", _byte);
        callback(&_byte as *const u8, 1);
        println!("Byte : {:?}", _byte as *const u8);

        i += 1;
    }
}

static COUNTER: Mutex<c_int> = Mutex::new(0);

#[no_mangle]
pub extern "C" fn stream_to(value: c_int) {
    let mut counter = COUNTER.lock().unwrap();
    *counter += value;
    println!("Event : {:?}, Sum : {:?}", value, *counter);
}
