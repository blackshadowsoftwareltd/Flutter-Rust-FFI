#[no_mangle] //? Derivative attribute

//? pub extern "C" is used to make the function available to C
pub extern "C" fn print_something() {
    println!("Print Rust Function")
}
