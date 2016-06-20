# Configuration
* See the secrets.yml file to set your Youtube API key (either edit the file or set the env variable)
* Displays well in Chrome and Firefox (Images overflow in flex items with Safari)
* Poltergeist Installation: https://github.com/teampoltergeist/poltergeist/tree/v1.9.0


# PinTube (Requirements)

A simple rails web app that enables user to add a personal collection of favourite youtube videos. It's a like a Pinterest for YouTube videos.

This application is designed to gauge our applicant's:
- adherence to best practices
- familiarity with code patterns
- ability to write tests, and
- command of Ruby and Rails as a whole

## App Specifications:
 1. Can add/delete a YouTube video in in your collection using a YouTube link.
 2. Can create/edit/delete different boards to group your collection. One video may belong to different boards.
 3. Can fetch YouTube video metadata, like title, description, and tags using YouTube API.
    Implement this functionality without using any existing Youtube gems.
    Although you can use any gems that can consume RESTful web service APIs (e.g. HttpParty, RestClient)
 4. No need to implement user management.
 5. You can use any JS framework (Angular, ReactJS) or just plain Javascript to create/edit/delete items.
    It would be nice if the whole app workflow is done only on one page.
 6. Add test codes. You can use Rails default testing framework or Rspec.
 7. OPTIONAL: You can add one feature of your choice. It can be anything you want that will make this app more awesome and useful.
    You can either add sorting of boards and videos on or across boards, or if you want a more challenging one, integrate with other video API's out there (e.g Vimeo), or add a search functionality directly from Youtube.
    Whatever you want actually, it's up to you.

## Requirements
1. Use Sqlite or MySQL only
2. Provide instructions if you need us to do some additional setup (e.g. rake tasks or libraries to install) before we can run the app
3. Fork this repo, and push your changes to that repo.
4. Create as many commits as possible. We would like to see your work process.
5. Create a pull request once you're ready so we could add comments.

Good luck!
