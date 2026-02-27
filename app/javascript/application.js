// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

const renderLucideIcons = () => {
  if (window.lucide) window.lucide.createIcons()
}

document.addEventListener("turbo:load", renderLucideIcons)
document.addEventListener("DOMContentLoaded", renderLucideIcons)
