module.exports = {
  content: [
    './app/views/**/*.{erb,haml,html,slim}',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        primary: '#2f4daa',
        danger: '#dc3545',
        error: '#dc3545',
        success: '#007b1d',
        warning: '#ffc107',
        info: '#299eb5',
      }
    }
  },
  plugins: [],
} 