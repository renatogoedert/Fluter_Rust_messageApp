pub mod api;
mod frb_generated;

use argon2::{Argon2, PasswordHasher};
use chrono::Utc;
use once_cell::sync::Lazy;
use password_hash::{PasswordHash, PasswordVerifier, SaltString};
use rand_core::OsRng;
use serde::{Deserialize, Serialize};
use std::fs::OpenOptions;
use std::io::{self, Read, Write};
use std::sync::Mutex;

static MESSAGES: Lazy<Mutex<Vec<Message>>> = Lazy::new(|| Mutex::new(Vec::new()));

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Message {
    pub sender: String,
    pub text: String,
    pub time: String,
    pub is_me: bool,
}

/* Deprecated
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
*/

/* Deprecated
fn save_messages(file_path: &str, messages: &Vec<Message>) -> io::Result<()> {
    let file = OpenOptions::new().write(true).create(true).truncate(true).open(file_path)?;
    let mut f = std::io::BufWriter::new(file);
    let data = serde_json::to_string(messages).unwrap();
    f.write_all(data.as_bytes())?;
    Ok(())
}
*/

/* Deprecated
#[flutter_rust_bridge::frb]
pub fn add_message(file_path: String, sender: String, text: String, is_me: bool) {
    let time = Utc::now().to_rfc3339();
    let mut messages = MESSAGES.lock().unwrap();
    messages.push(Message { sender, text, time, is_me });
    save_messages(&file_path, &messages).expect("Failed to save messages");
}
*/

/* Deprecated
#[flutter_rust_bridge::frb]
pub fn get_messages(file_path: String) -> Vec<Message> {
    let messages = load_messages(&file_path).unwrap_or_else(|_| Vec::new());
    let mut msgs = MESSAGES.lock().unwrap();
    *msgs = messages.clone();
    messages
}
*/

#[flutter_rust_bridge::frb]
pub fn add_message_to_conversation(
    file_path: String,
    conversation_id: String,
    sender: String,
    text: String,
    is_me: bool,
) {
    let time = Utc::now().to_rfc3339();
    let new_message = Message {
        sender,
        text,
        time,
        is_me,
    };

    let mut conversations = load_conversations(&file_path).unwrap_or_default();

    if let Some(conv) = conversations.iter_mut().find(|c| c.id == conversation_id) {
        conv.messages.push(new_message);
    }

    let mut convs = CONVERSATIONS.lock().unwrap();
    *convs = conversations.clone();

    save_conversations(&file_path, &conversations).expect("Failed to add Message to conversation")
}

#[flutter_rust_bridge::frb]
pub fn get_messages_for_conversation(file_path: String, conversation_id: String) -> Vec<Message> {
    let conversations = load_conversations(&file_path).unwrap_or_default();
    conversations
        .into_iter()
        .find(|c| c.id == conversation_id)
        .map(|c| c.messages)
        .unwrap_or_default()
}

static CONVERSATIONS: Lazy<Mutex<Vec<Conversation>>> = Lazy::new(|| Mutex::new(Vec::new()));

// #[frb(json_serializable)]
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Conversation {
    pub id: String,
    pub title: String,
    pub avatar_url: Option<String>,
    pub messages: Vec<Message>,
}

fn save_conversations(file_path: &str, conversations: &Vec<Conversation>) -> io::Result<()> {
    let file = OpenOptions::new()
        .write(true)
        .create(true)
        .truncate(true)
        .open(file_path)?;
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
            let conversations: Vec<Conversation> =
                serde_json::from_str(&contents).unwrap_or_else(|_| Vec::new());
            Ok(conversations)
        }
        Err(_) => Ok(Vec::new()),
    }
}

#[flutter_rust_bridge::frb]
pub fn add_conversation(file_path: String, title: String, avatar_url: Option<String>) {
    let id = Utc::now().to_rfc3339();
    let messages = Vec::new();
    let mut conversations = CONVERSATIONS.lock().unwrap();
    conversations.push(Conversation {
        id,
        title,
        messages,
        avatar_url: Some(avatar_url.expect("REASON")),
    });
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

    save_conversations(&file_path, &conversations)
        .expect("Failed to save conversations after delete");
}

#[flutter_rust_bridge::frb]
pub fn update_avatar_for_conversation(
    file_path: String,
    conversation_id: String,
    avatar_url: String,
) {
    let mut conversations = load_conversations(&file_path).unwrap_or_default();

    for conversation in &mut conversations {
        if conversation.id == conversation_id {
            conversation.avatar_url = Some(avatar_url.clone());
            break;
        }
    }

    let mut convs = CONVERSATIONS.lock().unwrap();
    *convs = conversations.clone();

    save_conversations(&file_path, &conversations)
        .expect("Failed to save conversations after update");
}

static USERS: Lazy<Mutex<Vec<User>>> = Lazy::new(|| Mutex::new(Vec::new()));

// #[frb(json_serializable)]
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct User {
    pub id: String,
    pub email: String,
    pub name: String,
    pub password: String,
    pub avatar_url: String,
    pub conversations: Vec<Conversation>,
}

fn hash_password(password: &str) -> String {
    let salt = SaltString::generate(&mut OsRng);
    let argon2 = Argon2::default();
    let password_hash = argon2
        .hash_password(password.as_bytes(), &salt)
        .unwrap()
        .to_string();

    password_hash
}

fn verify_password(hash: &str, password: &str) -> bool {
    let parsed_hash = PasswordHash::new(hash).unwrap();
    Argon2::default()
        .verify_password(password.as_bytes(), &parsed_hash)
        .is_ok()
}

fn save_users(file_path: &str, users: &Vec<User>) -> io::Result<()> {
    let file = OpenOptions::new()
        .write(true)
        .create(true)
        .truncate(true)
        .open(file_path)?;
    let mut f = std::io::BufWriter::new(file);
    let data = serde_json::to_string(users).unwrap();
    f.write_all(data.as_bytes())?;
    Ok(())
}

fn load_users(file_path: &str) -> io::Result<Vec<User>> {
    let file = OpenOptions::new().read(true).open(file_path);
    match file {
        Ok(mut f) => {
            let mut contents = String::new();
            f.read_to_string(&mut contents)?;
            let users: Vec<User> = serde_json::from_str(&contents).unwrap_or_else(|_| Vec::new());
            Ok(users)
        }
        Err(_) => Ok(Vec::new()),
    }
}

#[flutter_rust_bridge::frb]
pub fn add_user(
    file_path: String,
    email: String,
    name: String,
    password: String,
    avatar_url: String,
) {
    let id = Utc::now().to_rfc3339();
    let conversations = Vec::new();
    let hashed_password = hash_password(&password);

    let mut users = USERS.lock().unwrap();
    users.push(User {
        id,
        email,
        name,
        password: hashed_password,
        avatar_url,
        conversations,
    });
    save_users(&file_path, &users).expect("Failed to save users");
}

#[flutter_rust_bridge::frb]
pub fn validate_user(file_path: String, email: String, password: String) -> Option<User> {
    let users = load_users(&file_path).unwrap_or_else(|_| Vec::new());

    users
        .into_iter()
        .find(|user| user.email == email && verify_password(&user.password, &password))
}

#[flutter_rust_bridge::frb]
pub fn delete_user(file_path: String, id: String) {
    let mut users = load_users(&file_path).unwrap_or_default();
    users.retain(|c| c.id != id);

    let mut convs = USERS.lock().unwrap();
    *convs = users.clone();

    save_users(&file_path, &users).expect("Failed to save users after delete");
}

#[flutter_rust_bridge::frb]
pub fn update_avatar_for_user(file_path: String, user_id: String, avatar_url: String) {
    let mut users = load_users(&file_path).unwrap_or_default();

    for user in &mut users {
        if user.id == user_id {
            user.avatar_url = avatar_url;
            break;
        }
    }

    let mut usrs = USERS.lock().unwrap();
    *usrs = users.clone();

    save_users(&file_path, &users).expect("Failed to save users after update");
}
