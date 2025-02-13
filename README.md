# FetchRecipes

App works for any device on iOS 16+ and needs a working internet connection

## App Details

1. The app home screen has a list of recipes
2. The app has a loading state
3. If there are no recipes available, the app will display an empty state with a retry button.
4. Tap on any recipe row to view more details about that recipe.
5. Use the cuisine filter buttons to filter recipes by cuisine type (e.g., Italian, Japanese).

### Summary:
![RecipeApp](https://github.com/user-attachments/assets/f539c86f-e8a1-430c-9e1a-c9b5f746a4e9)

![RecipeApp1](https://github.com/user-attachments/assets/54435634-2959-46d6-b1b1-b28235b3fcff)


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

Caching : With many images to load on the home page and filtered cuisines, caching is crucial to avoid unnecessary network requests.
UI/UX : This is an area of interest and the basics for any app is to be intuitive and easy to use. Having visual representation of the app state helps in keeping the user engaged, so this app has a loading state and an empty state. There is also a rety mechanism in the app if the initial load fails for any reason (mostly due to no network connection)


### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
Spent about 5-6 hours on the project over multiple days, allocating majority of the time on the networking and UX areas of the app. I spent about an hour refacorting the app, working on the search bar and removing it. I spent last hour on test cases.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I opted for a simpler UI instead of adding custom animations to prioritize speed of development.
I chose to not implement the search feature, focusing on MVP. This helped me with faster development and a smoother launch while leaving room for future enhancements.


### Weakest Part of the Project: What do you think is the weakest part of your project?
Considering the data doesn't change much often, providing an offline functionality would be do-able with a well-thought out cache implementation from the start of the project. Not having that feature might be the weakest part of the project.
