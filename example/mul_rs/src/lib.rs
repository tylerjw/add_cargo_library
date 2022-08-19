#[cxx::bridge]
mod ffi {
    extern "Rust" {
        fn mul_rs(lhs: i64, rhs: i64) -> i64;
    }
}

pub fn mul_rs(lhs: i64, rhs: i64) -> i64 {
    lhs * rhs
}
