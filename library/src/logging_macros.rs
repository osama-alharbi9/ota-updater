// Wrappers around crate::log's logging functions that prepend "[revon]" to the log message.
//
// See https://stackoverflow.com/questions/67087597/is-it-possible-to-use-rusts-log-info-for-tests
// for the rationale behind the use of the #[cfg(test)] attribute.

#[cfg(test)]
#[macro_export]
macro_rules! revon_info {
    ($fmt:expr $(, $($arg:tt)*)?) => {
        println!(concat!("[revon] ", $fmt), $($($arg)*)?)
    };
}

#[cfg(not(test))]
#[macro_export]
macro_rules! revon_info {
    // revon_info!("a {} event", "log")
    ($fmt:expr $(, $($arg:tt)*)?) => {
        log::info!(concat!("[revon] ", $fmt), $($($arg)*)?)
    };
}

#[cfg(test)]
#[macro_export]
macro_rules! revon_debug {
    ($fmt:expr $(, $($arg:tt)*)?) => {
        println!(concat!("[revon] ", $fmt), $($($arg)*)?)
    };
}

#[cfg(not(test))]
#[macro_export]
macro_rules! revon_debug {
    // revon_debug!("a {} event", "log")
    ($fmt:expr $(, $($arg:tt)*)?) => {
        log::debug!(concat!("[revon] ", $fmt), $($($arg)*)?)
    };
}

#[cfg(test)]
#[macro_export]
macro_rules! revon_warn {
    ($fmt:expr $(, $($arg:tt)*)?) => {
        println!(concat!("[revon] ", $fmt), $($($arg)*)?)
    };
}

#[cfg(not(test))]
#[macro_export]
macro_rules! revon_warn {
    // revon_warn!("a {} event", "log")
    ($fmt:expr $(, $($arg:tt)*)?) => {
        log::warn!(concat!("[revon] ", $fmt), $($($arg)*)?)
    };
}

#[cfg(test)]
#[macro_export]
macro_rules! revon_error {
    ($fmt:expr $(, $($arg:tt)*)?) => {
        println!(concat!("[revon] ", $fmt), $($($arg)*)?)
    };
}

#[cfg(not(test))]
#[macro_export]
macro_rules! revon_error {
    // revon_error!("a {} event", "log")
    ($fmt:expr $(, $($arg:tt)*)?) => {
        log::error!(concat!("[revon] ", $fmt), $($($arg)*)?)
    };
}
