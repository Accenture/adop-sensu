#Supported tags and respective Dockerfile links

- [`0.1.0`, `0.1.0` (*0.1.0/Dockerfile*)](Dockerfile)

# What is adop-sensu?

adop-sensu is a wrapper for the sstarcher/sensu image. It has primarily been built to perform extended configuration and include certain checks and plugins.
Sensu is an infrastructure and application monitoring and telemetry solution. Sensu provides a framework for monitoring infrastructure, service & application health, and business KPIs.

# How to use this image

The easiest way to run the adop-sensu image is as follows, where VERSION is the release version of the Docker container.

      docker run --name <your-container-name> -d -p 22:22 -p 3000:3000 accenture/adop-sensu:VERSION

# License
Please view [licence information](LICENSE.md) and [licences information](LICENSES.md)  for the software contained on this image.

# Supported Docker versions

This image is officially supported on Docker version 1.9.1.
Support for older versions (down to 1.6) is provided on a best-effort basis.

# User feedback

## Documentation
Documentation for this image is available in the [Sensu documentation page](https://sensuapp.org/docs).
Additional documentaion can be found under the [`docker-library/docs` GitHub repo](https://github.com/docker-library/docs). Be sure to familiarize yourself with the [repository's `README.md` file](https://github.com/docker-library/docs/blob/master/README.md) before attempting a pull request.

## Issues
If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/Accenture/adop-sensu/issues).

## Contribute
You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.
