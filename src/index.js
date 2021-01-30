import init from 'echo-bot';

import './styles.css';

const WASM_PATH =
  NODE_ENV && NODE_ENV === 'production'
    ? 'wasm/echo-bot/echo-bot_bg.wasm'
    : null;

init(WASM_PATH)
  .then(() => {
    console.log('WASM is awesome!');
  })
  .catch(err => {
    console.warn(err);
  });

if (typeof module.hot !== 'undefined') {
  module.hot.accept();
}
