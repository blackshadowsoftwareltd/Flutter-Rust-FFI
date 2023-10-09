use std::{ffi::CStr, os::raw::c_char};

use sled::{Db, IVec};

#[no_mangle]
pub extern "C" fn open_db(path: *const c_char) {
    println!("Opening DB");
    let path_str = unsafe { CStr::from_ptr(path).to_str().unwrap() };
    let db = sled::open(path_str).unwrap();
    do_something_with_db(&db);
    // Box::into_raw(Box::new(db))
    db.flush().unwrap();
}

fn do_something_with_db(db: &Db) {
    let time = std::time::SystemTime::now();

    match db.get("key") {
        Ok(v) => match v {
            Some(v) => {
                println!("Previous : {:?}", ivect_to_string(v).unwrap())
            }
            None => {
                println!("Previous : None")
            }
        },
        Err(e) => {
            println!("Error : {}", e)
        }
    }
    let time = format!("Time {:?}", time);

    db.insert("key", time.as_bytes()).unwrap();

    match db.get("key") {
        Ok(v) => match v {
            Some(v) => {
                println!("New : {:?}", ivect_to_string(v).unwrap())
            }
            None => {
                println!("New : None")
            }
        },
        Err(e) => {
            println!("Error : {}", e)
        }
    }
}

fn ivect_to_string(iv: IVec) -> Result<String, std::str::Utf8Error> {
    let bytes: &[u8] = iv.as_ref();
    let string = std::str::from_utf8(bytes)?;

    Ok(string.to_string())
}
