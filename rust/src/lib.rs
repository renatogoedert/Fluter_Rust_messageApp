pub mod api;
mod frb_generated;

use std::sync::Mutex;
use once_cell::sync::Lazy;
use serde::{Serialize, Deserialize};
use chrono::{Utc};

static MESSAGES: Lazy<Mutex<Vec<Message>>> = Lazy::new(|| Mutex::new(Vec::new()));

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Message {
    pub sender: String,
    pub text: String,
    pub time: String,
    pub is_me: bool,
}

#[flutter_rust_bridge::frb]
pub fn add_message(sender: String, text: String, is_me: bool){
    let time = Utc::now().to_rfc3339();
    let mut messages = MESSAGES.lock().unwrap();
    messages.push(Message {sender, text, time, is_me});
}

#[flutter_rust_bridge::frb]
pub fn get_messages () -> Vec<Message> {
    MESSAGES.lock().unwrap().clone()
}

