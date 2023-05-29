use std::ffi::c_char;
use std::ffi::CStr; //? CStr is used to convert a C string to a Rust string
use std::ffi::CString; //? CString is used to convert a Rust string to a C string

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
