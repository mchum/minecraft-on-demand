# minecraft-on-demand
Personal Fabric server running on GCP.

The idea is to take advantage of GCP free tier to run this as low cost as possible, while still
delivering a decent gaming experience.

The idea is to start a container to set up a Fabric server with carpet mod installed. The container
itself should be lightweight (so it's cheap to store), and will download the binaries as
necessary on startup. Ideally it will shut itself off once it detects no users connected, as well
as a mechanism to start up automatically when a connection request is detected.
