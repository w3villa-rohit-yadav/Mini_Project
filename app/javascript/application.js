// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// app/javascript/application.js
// app/javascript/application.js

import "@hotwired/turbo-rails";
import "controllers";
import "bootstrap";

import Rails from "@rails/ujs";
Rails.start();

document.addEventListener('DOMContentLoaded', () => {
  const fileInput = document.getElementById('profile_picture_input');
  const imagePreview = document.getElementById('image_preview');
  const imagePreviewContainer = document.getElementById('image_preview_container');

  // Function to handle image preview
  const previewImage = (file) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      imagePreview.src = e.target.result;
      imagePreview.style.display = 'block';
      imagePreviewContainer.style.display = 'block';
    };
    reader.readAsDataURL(file);
  };

  // Function to reset image preview
  const resetImagePreview = () => {
    imagePreview.src = '#';
    imagePreview.style.display = 'none';
    imagePreviewContainer.style.display = 'none';
  };

  // Event listener for file input change
  if (fileInput && imagePreview && imagePreviewContainer) {
    fileInput.addEventListener('change', (event) => {
      const file = event.target.files[0];
      file ? previewImage(file) : resetImagePreview();
    });
  }
});


