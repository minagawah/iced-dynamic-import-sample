import init from 'echo-bot';

import './styles.css';

// Make sure to explicitly give 'undefined'
// to denote the path is not given.
// When wasm-bindgen generates
// a bootstrap JS, a predicate defined
// in 'init' function strictly checks
// against 'undefined'. If not, then
// the first argument for:
//   WebAssembly.instantiate(bytes, imports)
// becomes empty, and sometimes becomes
// a cause of raising a runtime error.
// (especially when using canvas features)

const WASM_PATH =
  NODE_ENV && NODE_ENV === 'production'
    ? 'wasm/echo-bot/echo-bot_bg.wasm'
    : void 0; // undefined

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
