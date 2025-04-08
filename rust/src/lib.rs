pub mod api;
mod frb_generated;

use std::fs::{OpenOptions};
use std::io::{self, Write, Read};
use std::sync::Mutex;
use once_cell::sync::Lazy;
use serde::{Serialize, Deserialize};
use chrono::Utc;

static MESSAGES: Lazy<Mutex<Vec<Message>>> = Lazy::new(|| Mutex::new(Vec::new()));

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Message {
    pub sender: String,
    pub text: String,
    pub time: String,
    pub is_me: bool,
}

fn load_messages(file_path: &str) -> io::Result<Vec<Message>> {
    let file = OpenOptions::new().read(true).open(file_path);
    match file {
        Ok(mut f) => {
            let mut contents = String::new();
            f.read_to_string(&mut contents)?;
            let messages: Vec<Message> = serde_json::from_str(&contents).unwrap_or_else(|_| Vec::new());
            Ok(messages)
        }
        Err(_) => Ok(Vec::new()),
    }
}

fn save_messages(file_path: &str, messages: &Vec<Message>) -> io::Result<()> {
    let file = OpenOptions::new().write(true).create(true).truncate(true).open(file_path)?;
    let mut f = std::io::BufWriter::new(file);
    let data = serde_json::to_string(messages).unwrap();
    f.write_all(data.as_bytes())?;
    Ok(())
}

#[flutter_rust_bridge::frb]
pub fn add_message(file_path: String, sender: String, text: String, is_me: bool) {
    let time = Utc::now().to_rfc3339();
    let mut messages = MESSAGES.lock().unwrap();
    messages.push(Message { sender, text, time, is_me });
    save_messages(&file_path, &messages).expect("Failed to save messages");
}

#[flutter_rust_bridge::frb]
pub fn get_messages(file_path: String) -> Vec<Message> {
    let messages = load_messages(&file_path).unwrap_or_else(|_| Vec::new());
    let mut msgs = MESSAGES.lock().unwrap();
    *msgs = messages.clone();
    messages
}

static CONVERSATIONS: Lazy<Mutex<Vec<Conversation>>> = Lazy::new(|| Mutex::new(Vec::new()));

// #[frb(json_serializable)]
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Conversation {
    pub id: String,
    pub title: String,
    pub messages: Vec<Message>,
}

fn save_conversations(file_path: &str, conversations: &Vec<Conversation>) -> io::Result<()> {
    let file = OpenOptions::new().write(true).create(true).truncate(true).open(file_path)?;
    let mut f = std::io::BufWriter::new(file);
    let data = serde_json::to_string(conversations).unwrap();
    f.write_all(data.as_bytes())?;
    Ok(())
}

fn load_conversations(file_path: &str) -> io::Result<Vec<Conversation>> {
    let file = OpenOptions::new().read(true).open(file_path);
    match file {
        Ok(mut f) => {
            let mut contents = String::new();
            f.read_to_string(&mut contents)?;
            let conversations: Vec<Conversation> = serde_json::from_str(&contents).unwrap_or_else(|_| Vec::new());
            Ok(conversations)
        }
        Err(_) => Ok(Vec::new()),
    }
}

#[flutter_rust_bridge::frb]
pub fn add_conversation(file_path: String, title: String) {
    let id = Utc::now().to_rfc3339();
    let messages =  Vec::new();
    let mut conversations = CONVERSATIONS.lock().unwrap();
    conversations.push(Conversation { id, title, messages });
    save_conversations(&file_path, &conversations).expect("Failed to save conversations");
}

#[flutter_rust_bridge::frb]
pub fn get_conversations(file_path: String) -> Vec<Conversation> {
    let conversations = load_conversations(&file_path).unwrap_or_else(|_| Vec::new());
    let mut convs = CONVERSATIONS.lock().unwrap();
    *convs = conversations.clone();
    conversations
}

#[flutter_rust_bridge::frb]
pub fn delete_conversation(file_path: String, id: String) {
    let mut conversations = load_conversations(&file_path).unwrap_or_default();
    conversations.retain(|c| c.id != id);
    
    let mut convs = CONVERSATIONS.lock().unwrap();
    *convs = conversations.clone();
    
    save_conversations(&file_path, &conversations).expect("Failed to save conversations after delete");
}