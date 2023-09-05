use std::{ffi::CStr, os::raw::c_char};

use sled::Db;

#[no_mangle]
pub extern "C" fn open_db(path: *const c_char) -> *mut Db {
    println!("Opening DB");
    let path_str = unsafe { CStr::from_ptr(path).to_str().unwrap() };
    let db = sled::open(path_str).unwrap();
    Box::into_raw(Box::new(db))
}
