import type { Config } from "tailwindcss";

export default {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        background: "var(--background)",
        foreground: "var(--foreground)",
        primary: {
          DEFAULT: "#4B1E91",
          50: "#F3F0F7",
          100: "#E7E1F0",
          200: "#CFC3E1",
          300: "#B7A5D2",
          400: "#9F87C3",
          500: "#8769B4",
          600: "#6F4BA5",
          700: "#573D84",
          800: "#3F2E63",
          900: "#271F42"
        },
        accent: {
          DEFAULT: "#FF622D",
          50: "#FFF3EE",
          100: "#FFE7DD",
          200: "#FFCFBB",
          300: "#FFB799",
          400: "#FF9F77",
          500: "#FF8755",
          600: "#FF6F33",
          700: "#FF5711",
          800: "#EE4400",
          900: "#CC3A00"
        }
      },
      fontFamily: {
        sans: ['var(--font-inter)', 'system-ui', 'sans-serif'],
        display: ['var(--font-lexend)', 'system-ui', 'sans-serif']
      },
      boxShadow: {
        'glow': '0 0 50px -12px rgba(75, 30, 145, 0.25)',
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms')
  ],
} satisfies Config;
