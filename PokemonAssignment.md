# Pokemon Assigment

Create an application that contains both a main and a detail screen. The main screen is to be a table view of a list of the first 150 Pokemon (151 if you want to be pedantic) and each cell needs to show the Sprite of the Pokemon, the name of the pokemon, and the element of the pokemon. Upons selecting the cell, navigate to a detail screen displaying the information from before about the pokemon, along with it's list of moves, abilities, and any other information desired. The detail screen is up the FE to decide on how they want to show the data, just that all the information they want to show must be viewable on any device.

## Requirements

### Main Screen
    -Must show the first 150(or 151) Pokemon from the PokeAPI. 
        (https://pokeapi.co/)
    -Each cell must have the Sprite of the Pokemon, the name of the Pokemon, and the type of the Pokemon.
    -You MUST use pagination. Ex: The initial pull should only fetch say the first 30 pokemon, then as you get closer to the bottom, you fetch the next set of 30 until you hit you max of 150(1). Please use the API documentation for how to do this. To help get things started, here can be the base url pull request for the first 30. ("https://pokeapi.co/api/v2/pokemon?offset=0&limit=30")
    -You MUST implement lazy loading as needed
    
    -Extra - Give a commented out implementation of using DispatchGroups for pulling the entire page of images and reloading when finished
    
### Detail Screen
    -Detail screen needs to include all the information from the cell as well as the full list of abilities and moves of the pokemon. You can give any other information you want here as well.
    -All information displayed on the detail screen needs to be visible on all devices. This is up to the FE how they wish to tackle this issue.

### General
    -Navigation is open to how the Consultant wants to navigate around the app
    -The FE is free to choose to write the UI via Storyboards, programmatic, Xib, or any combination
    -Application must be in MVC Architecture
    -FE needs to implement some degree of Error Handling in the network layer and notify the user in some way of what happened.
    -The Networking calls must be done in a separate class.
