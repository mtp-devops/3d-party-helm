**This is a template to use helm_values project to deploy a specific chart**

# Why using a different project instead helm_values?

helm_values is great - however this it have 1 big issues - the CICD is all over the place - if you want to deploy a specific chart again you might have too many other pipelines and you need to change files before you can deploy again - this create usless commits and complex CICD we can't return too - So this project come to fix that and generate clean changes.

The only caviat to this approach is when we change the main CICD we need to invoke any project instead getting everything the same time.

# How to configure

## Save Chart

* Clone the [3d-party-helm](https://mtp-devops.github.io/3d-party-helm) project
* Use the helm command to download the (we will use the `mysql` chart for example):
  ```
  helm repo add mysql-operator https://mysql.github.io/mysql-operator/
  helm repo update
  helm pull mysql-operator/mysql-operator
  ```
  > :information_source: This will result in a file called chart-name-X.Y.Z.tgz

  > :information_source: If you want to pull specific version us: `helm pull --version X.Y.Z`

  > :information_source: To search stuff use: `helm search repo REPO/ --versions`
* Copy the file from last step to `docs` directory
* Navigate to `docs` directory
* Run:
  ```
  helm repo index . --url https://mtp-devops.github.io/3d-party-helm/
  ```
* Commit change and push

## Build Chart directory

* Rename `CHART_NAME` directory to the correct chart name
* Edit [.gitlab-ci.yml](.gitlab-ci.yml) and Rename every place where you see `CHART_NAME` to the correct chart name
* Navigate to the new directory and edit [CHART_NAME/.gitlab-ci.yml](CHART_NAME/.gitlab-ci.yml) - Edit every recurance of `CHART_NAME`