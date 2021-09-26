# Goal
Automatically spin up Minecraft server running Fabric mods when requested, and shut down
when no more server connections. Definitely on the cloud because I don't want to deal with
maintaining hardware right now.

# Requirements
* Minecraft Server image (VM? Docker? Another method?)
* Platform
* Connection detection mechanism (request and inactivity)
* Storage (Permanent and Ephemeral) - World Save vs mods (if we want to re-download every time)

## Storage
Considerations:
* Need for speed when server is running
* Cost of long term data storage
* World cleanup (manual process, but need way to download and re-upload world)

## Connection detection
Considerations:
* Simple to use for any client
* Quick and Reliable (as always)

## Platform and Cloud Provider
Considerations:
* Cost of infrastructure
* Free Tier Resources

## Closing
I don't give a crap baout cloud provider, I'm going to use GCP because I want to learn it.
