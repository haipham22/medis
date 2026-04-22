declare global {
  interface Window {
    $: JQueryStatic;
    jQuery: JQueryStatic;
  }

  const $: JQueryStatic;
  const jQuery: JQueryStatic;
}

export {};
