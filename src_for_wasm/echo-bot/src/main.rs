use iced::{text_input, Align, Column, Element, Sandbox, Settings, Text, TextInput};

pub fn main() -> iced::Result {
    Echo::run(Settings::default())
}

#[derive(Debug, Default)]
struct Echo {
    input: text_input::State,
    input_value: String,
}

#[derive(Debug, Clone)]
enum Message {
    Changed(String),
    Clear,
}

impl Sandbox for Echo {
    type Message = Message;

    fn new() -> Self {
        Self::default()
    }

    fn title(&self) -> String {
        String::from("Echo")
    }

    fn update(&mut self, message: Message) {
        match message {
            Message::Changed(value) => {
                self.input_value = value;
            }
            Message::Clear => {
                if !self.input_value.is_empty() {
                    self.input_value.clear();
                }
            }
        }
    }

    fn view(&mut self) -> Element<Message> {
        let input = TextInput::new(
            &mut self.input,
            "Type anything you want",
            &mut self.input_value,
            Message::Changed,
        )
        .padding(10)
        .size(30)
        .on_submit(Message::Clear);

        Column::new()
            .padding(10)
            .align_items(Align::Center)
            .push(input)
            .push(Text::new(self.input_value.to_string()).size(30))
            .into()
    }
}
