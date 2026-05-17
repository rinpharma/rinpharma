document.addEventListener("DOMContentLoaded", function () {
  if (typeof tippy !== "undefined") {
    tippy('.has-tooltip:not([data-tippy-initialized])', {
      theme: 'light',
      allowHTML: true,
      maxWidth: 400,
      delay: [100, 100],
      interactive: true,
      placement: 'top',
      trigger: window.matchMedia("(hover: hover)").matches
        ? 'mouseenter focus click'
        : 'click',
      hideOnClick: true,
      interactiveBorder: 10,
      onCreate(instance) {
        instance.reference.setAttribute('data-tippy-initialized', 'true');
      }
    });
  }
});
