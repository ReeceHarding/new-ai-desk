# Design System

## Colors
- Primary: #0F172A (Slate 900)
- Secondary: #3B82F6 (Blue 500)
- Accent: #10B981 (Emerald 500)
- Background: #F8FAFC (Slate 50)
- Text: #1E293B (Slate 800)

## Typography
- Font Family: Inter
- Headings: 
  - H1: 2.25rem/36px
  - H2: 1.875rem/30px
  - H3: 1.5rem/24px
- Body: 1rem/16px
- Small: 0.875rem/14px

## Components

### Buttons
```jsx
<button className="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600">
  Primary Button
</button>
```

### Cards
```jsx
<div className="p-6 bg-white rounded-lg shadow-sm">
  <h3 className="text-lg font-semibold">Card Title</h3>
  <p className="mt-2 text-gray-600">Card content</p>
</div>
```

### Forms
```jsx
<form className="space-y-4">
  <div>
    <label className="block text-sm font-medium text-gray-700">Label</label>
    <input className="mt-1 block w-full rounded-md border-gray-300 shadow-sm" />
  </div>
</form>
```

## Layout
- Max width: 1280px
- Grid: 12 columns
- Gap: 1rem/16px
- Container padding: 1rem/16px

## Spacing
- xs: 0.25rem/4px
- sm: 0.5rem/8px
- md: 1rem/16px
- lg: 1.5rem/24px
- xl: 2rem/32px

## Shadows
- sm: 0 1px 2px rgba(0,0,0,0.05)
- md: 0 4px 6px -1px rgba(0,0,0,0.1)
- lg: 0 10px 15px -3px rgba(0,0,0,0.1)

## Animations
- Transition: 150ms ease-in-out
- Hover scale: 1.02
- Page transitions: fade (150ms) 