# MoneyVerse

MoneyVerse is an iOS / iPadOS app I built to teach young people the basics of personal finance. Instead of reading a boring textbook, you fly through a small universe where every planet is one money topic. You land on a planet, pick a level, read a few short cards and then answer questions to check if you actually got it.

I started working on it in December 2025. Most people my age never learn how inflation, debt or investing works until it's already a problem, so I wanted to make something short and fun enough that you'd actually finish it.

## What's in the app

### Intro
The first time you open the app, a 3D rocket flies across the screen (with sound) and then you get a short welcome screen explaining how things work. After that it's saved, so next time you go straight to the main menu.

### Main menu
The menu is a 3D scene with three rotating planets. You tap a planet to fly to it. There's also a **Future Self** button in the top right corner (more on that below). Background music plays in a loop.

### The planets
Every planet has its own 3D surface and 3 levels on it:

| Planet | Level 1 | Level 2 | Level 3 |
| --- | --- | --- | --- |
| Compound Giant | What is Compound Interest? | Let Time Do Its Work | Tackle Financial Stress |
| Inflation Nebula | What is Inflation? | Stocks, Bonds & ETFs | Sustainable Investing (ESG) |
| The Gravity of Debt | Good vs Bad Debt | Credit Scores | Fight Housing Crisis |

So in total there are 9 levels. They cover things like the difference between simple and compound interest, why starting to invest early matters, how inflation is measured, what ETFs and bonds are, ESG investing, credit utilization, emergency funds, and renting vs. buying a home.

### How a level works
Each level is a swipeable set of pages. There are 4 types of pages:

- **Info cards** - short explanations with an icon, not too much text
- **Quizzes** - multiple choice, you get feedback if you're right or wrong
- **Slider questions** - you guess a number (e.g. "what's the average credit card interest rate?") by moving a slider, and the app tells you how close you were
- **Calculators** - interactive ones, like a compound interest calculator where you can play with the amount, rate and years

When you finish a level, it gets a green checkmark on the planet so you can see your progress.

### Future Self
This is a separate tool, not tied to any planet. You put in your age, how much you already have, how much you save per month and what return you expect (there's a hint that the S&P 500 did around 10% historically). The app then calculates how much money you would have 40 years later.

You can also add your own goals (for example "Apartment, $80,000, by age 35"). For every goal it tells you whether you'll make it in time, and if not, how much more per month you'd need to save. There's also a "what if you saved $100 more per month" comparison, because the difference is usually surprisingly big.

## Technologies

- **Swift** and **SwiftUI** for the whole app and UI
- **RealityKit** for all the 3D stuff - the rotating planets in the menu, the planet surfaces, the rocket in the intro and the 3D text labels (`RealityView`, `Entity`, `MeshResource.generateText`, `SpatialTapGesture` for tapping on planets)
- **USDZ** 3D models for the planets, planet surfaces and the rocket
- **AVFoundation** (`AVQueuePlayer` + `AVPlayerLooper`) for background music and sound effects
- **Swift Concurrency** (`async let`) to load all 3D models in parallel at app start, so switching between screens doesn't lag
- **UserDefaults / @AppStorage** to save level progress, whether you've seen the intro, and your Future Self goals (goals are encoded as JSON with `Codable`)
- **Xcode** as the IDE

No backend, no accounts, no tracking. Everything is stored locally on the device.

## Project structure

```
MoneyVerse/
├── Intro/              rocket intro + welcome screen
├── Managers/           AudioManager, LevelManager (progress), SceneLoader (preloads 3D models)
├── Planets/
│   ├── CompoundGiant/      surface + 3 levels
│   ├── InflationNebula/    surface + 3 levels
│   ├── TheGravityOfDebt/   surface + 3 levels
│   ├── LevelViews/         reusable page types (quiz, slider, calculator, info) and Future Self
│   └── PlanetModels/       .usdz models used in the menu
├── RocketModel/        rocket .usdz for the intro
├── Sounds/             background music and rocket sound
└── MenuView.swift      main 3D menu
```

Levels are built from a simple `LevelContent` enum (`info`, `quiz`, `slider`, `calculator`), so adding a new level is mostly just writing the content as a list. `LevelContainerView` takes care of the paging, progress dots and saving when you finish.

## How to run it

1. Clone the repo
2. Open `MoneyVerse.xcodeproj` in Xcode
3. Pick an iPhone or iPad simulator (or a real device) and press Run

It needs iOS 26.2 or newer. It works on iPhone too, but I mainly designed it for iPad, where the 3D scenes look best.
