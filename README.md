# Generating pet names - creating an R Keras model and deploying it in a Docker container

This repository creates a docker image that uses R and the [keras](https://keras.rstudio.com/) and [plumber](https://github.com/trestletech/plumber) R packages to create a neural network powered RESTful API. The package keras provides the ability to create neural networks, while plumber allows it to run R as a web service.

This is an introductory repository to help R users learn about keras, plumber, and Docker. A more featureful version of this code can be found at the [T-Mobile open-source r-tensorflow-api project](https://github.com/tmobile/r-tensorflow-api).

The Docker container is currently being hosted on the Nolis, LLC website, and can be queried by visiting [http://pets.nolisllc.com/names](http://pets.nolisllc.com/names).

This code was used in talks by [Jacqueline Nolis](https://twitter.com/skyetetra) and [Heather Nolis](https://twitter.com/heatherklus) at the New York R Conference in May of 2019.

## How to use this repository

This repository has four different parts to it:

1. __Training a neural network on pet names__ - Running the R script `train_model.R` will:
   1. load up the pet names csv,
   2. format them into X and Y matrices that a neural network can be trained on, 
   3. defines the keras neural network model,
   4. trains the neural network on the data,
   5. saves the trained model to `model.h5`.
2. __Defines a function to generate new pet names__ - Running the R script `runtime_functions.R` loads the neural network model and parameters, then creates functions to generate the pet names. There are two functions in the code:
   1.  `generate_name` - Uses the model to generate a single pet name
   2.  `generate_many_names` - calls the previous function a specified number of times to get a vector of names.
3. __Create a RESTful API around the pet name generator function__ - The R scripts `rest_controller.R` and `main.R` together allow you to run the generate as an API, so that you can get pet names via HTTP requests. Running `main.R` starts the web service.
4. __Building a Docker image for the API__ - The file `Dockerfile` specifies how the Docker image should be built. To build and run the Docker container, download and install [Docker](https://www.docker.com/get-started), then in a terminal run `docker build -t pet-names .` and `docker run --rm -p 80:80 pet-names`

## Thanks to

* T-Mobile, since much of this code comes from a [T-Mobile open-source project](https://github.com/tmobile/r-tensorflow-api)
* The [Rocker project](https://www.rocker-project.org/) for maintaining the R docker images these build from.
* The [plumber](https://github.com/trestletech/plumber) maintainers for creating a way to use R as a web service.
* The [RStudio](https://www.rstudio.com/) developers for creating the keras interface to python keras.
* The City of Seattle for making the pet license data available for public use.

## Terms and conditions

From the City of Seattle on the pet license data:

> The data made available here has been modified for use from its original source, which is the City of Seattle. Neither the City of Seattle nor the Office of the Chief Technology Officer (OCTO) makes any claims as to the completeness, timeliness, accuracy or content of any data contained in this application; makes any representation of any kind, including, but not limited to, warranty of the accuracy or fitness for a particular use; nor are any such warranties to be implied or inferred with respect to the information or data furnished herein. The data is subject to change as modifications and updates are complete. It is understood that the information contained in the web feed is being used at one's own risk.

From RStudio for using some of the R Keras example code as a framework for our model:

> the keras library is copyright 2017: RStudio, Inc; Google, Inc; François Chollet; Yuan Tang
