# Running Containers on Google Cloud Platform with Cloud Run

[Cloud Run][run_docs] runs stateless containers in a fully managed environment.
This sample will demonstrate how to use [Cloud Build][run_build] to build your container
and [Cloud Run][run_deploy] to deploy your container.

## Set up

Set up your local environment for [Cloud Run development](https://cloud.google.com/run/docs/setup)
or use the [Cloud Run Button](https://github.com/GoogleCloudPlatform/cloud-run-button)
to deploy with a single click.

[<img src="https://storage.googleapis.com/cloudrun/button.svg" alt="Run on Google Cloud" height="30">][run_button]

## Deploy Manually

1. Set an environment variable with your GCP Project ID:
```
export PROJECT_ID=<PROJECT_ID>
```

1. Build your container image using Cloud Build:
```
gcloud builds submit -t gcr.io/$PROJECT_ID/pet-names --timeout=900
```

1. Deploy the container to Cloud Run:
```
gcloud run deploy pet-names --image gcr.io/$PROJECT_ID/pet-names --platform managed --allow-unauthenticated
```
  * `pet-names` is the name of your Cloud Run service.
  * `--image gcr.io/$PROJECT_ID/pet-names` specifies the container to deploy.
  * `--platform managed` specifies the Cloud Run fully managed platform.
  * `--allow-unauthenticated` allows anyone to make a request.

## Deploy using a Build Config

Build and deploy to Cloud Run using the [`cloudbuild.yaml`](./cloudbuild.yaml)
config file:
```
gcloud builds submit
```

## Set up Continuous Deployment

You can automate the deployment of your software to Cloud Run by creating Cloud
Build triggers. You can configure your triggers to build and deploy images
whenever you update your source code. Learn how to set up a
[Continuous Deployment Pipeline](https://cloud.google.com/cloud-build/docs/deploying-builds/deploy-cloud-run#continuous_deployment).


[run_docs]: https://cloud.google.com/run/docs/
[run_build]: https://cloud.google.com/run/docs/building/containers
[run_deploy]: https://cloud.google.com/run/docs/deploying
[run_button]: https://deploy.cloud.run/?git_repo=https://github.com/nolis-llc/pet-names
