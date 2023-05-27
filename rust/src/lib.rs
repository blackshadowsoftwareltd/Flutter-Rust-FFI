#[no_mangle] //? Derivative attribute

//? pub extern "C" is used to make the function available to C
pub extern "C" fn print_something() {
    let mut x: i128 = 0;
    for i in 0..1000000000 {
        x = x + i;
    }
    println!("Sum : {}", x)
}

#[no_mangle]
pub extern "C" fn sum_two_numbers(a: f64, b: f64) -> f64 {
    a + b
}

#[no_mangle]
pub extern "C" fn profile_concat(name: *const u8, age: i32) -> *mut u8 {
    use std::ffi::CStr;
    use std::ffi::CString;

    unsafe {
        let name_str = CStr::from_ptr(name as *const i8).to_str().unwrap();
        let result = format!("I am {} and I am {} years old.", name_str, age);
        let result_cstring = CString::new(result).unwrap();
        result_cstring.into_raw() as *mut u8
    }
}
