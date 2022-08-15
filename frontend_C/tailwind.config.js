module.exports = {
  mode: "jit",
  purge: ["./src/**/*.{ts,tsx,js,jsx}"],
  darkMode: false,
  theme: {
    fontFamily: {
      'EBRIMA': ['EBRIMA']
    },
    extend: {
      spacing: {
        'main': '1280px',
      },
      colors: {
        'blue': '#0012BF',
      },
    },
    colors:{
      'card-true':'#001F9E',
      'card-false':'#D9D9D9',
      'white':"#ffffff"
    }
  },
  variants: {},
  plugins: [],
};
