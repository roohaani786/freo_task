# wikipedia_caching

Use the Wikipedia API to show a list of user search results. The link contains sample API requests and an API sandbox environment to test it out. (For example, click this to see what a sample request/response looks like.)
- Parse JSON from the API response.
- Each list item should contain an image and appropriate data from the API. Show whichever fields you think are necessary.
- Clicking a list item launches the respective Wikipedia page.
- The UI specification is left to you. Use appropriate UX and UI widgets to give the best experience as you see fit.
- Cache responses to give a good offline experience.
- Use proper state management solutions.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Endpoints used

https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&titles=Mushtaq%20Khan&formatversion=2
