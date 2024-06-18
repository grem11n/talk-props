# DevOps FW Days 2024

* [Website](https://fwdays.com/en/event/devops-fwdays-2024)
* [Talk on YouTube](https://youtu.be/BtciJTqJvQ8?si=U4qmKoOgFMvLC4KL) (in Ukrainian)
* [Demo files](fwfw-days-devops-2024/)

---

This demo contains two simple Helm charts:

1. A chart for a demo app
2. A chart that applies some Prometheus monitoring rules for the demo app

These charts are not meant to be installed anywhere, they are here to demonstrate the approach to the testing of Helm charts locally (or on CI) without the need for a Kubernetes cluster.

The whole setup is automated using `make` and runs the following scenarios:

1. Run `helm template` command to validate that the chart can be rendered
2. Run `helm lint` command to ensure that the chart follows the good practices
3. Run [`kubeconform`](https://github.com/yannh/kubeconform) to check that rendered manifests comply with the current Kubernetes spec
4. Run policy a check with [Kyverno](https://kyverno.io/)
5. Run [`helm-unittest`](https://github.com/helm-unittest/helm-unittest) to validate the custom logic in the chart

There are only some basic checks implemented for the demonstration purposes. Feel free to play with these tools on your own!
