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
