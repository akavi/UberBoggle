# Uber Homework

## Installation

In the project directory, first install dependencies and build:

```
$ npm install && gulp build 
```

Then run:

```
$ node server.js
```

And navigate to `http://localhost:3000` in your favorite browser


To run specs, run:

```
$ gulp specs
```

## Architecture

The app is split into two halves: A 'components' layer (whose code can be found in `src/components`) and a 'model' layer (whose code can be found in `src/models`). This split can be thought of as a split between visual behaviour and state: A given component is responsible for managing how a visible subsection of the app looks and behaves, while the model layer is responsible for managing the actual state of the app and informing the component layer of any changes to said state.

The design of the components attempts follow the React philosophy as best as possible given the time constraints: Ie, each one implements a `#render` method that can be called arbitrarily often safely in response to model change events, plus a set of listeners to DOM events that can result in changes to the models. Due to time constraints, I didn't implement a proper diffing algorithm, instead I wrote something called `#subrender`, which allowed me to manually only rerender part of the component when a certain part of the state changes. There ended up being four components, to represent the three "main" visual elements plus a root component of the app as a whole.

The model layer was pretty simple, the base class just implementing a set of methods to change state, and register to listen to changes of said state. I went with two separate model classes, one for the game as a whole, and one for each individual word, which I feel is a fairly self-justifying split. For the purpose of readability, I also did split out the methods involved in the nitty gritty side of determining a word's location on the Boggle board into its own module (`#wordPaths` remains in addition to `#isWordPresent`, as had I the time I would want to display said location as the user types it.)
