
run: istio_init
	kubectl create namespace monolith | true
	kubectl create namespace hello-service | true
	kubectl label namespace monolith istio-injection=enabled | true
	kubectl label namespace hello-service istio-injection=enabled | true

	sh cmd/monolith/k8s/deploy.sh
	sh cmd/hello-service/k8s/deploy.sh
	kubectl apply -f cmd/istio/auth.yaml

istio_init:
	kubectl create namespace istio-system | true
	helm upgrade --install istio-base istio/manifests/charts/base -n istio-system
	helm upgrade --install istiod istio/manifests/charts/istio-control/istio-discovery \
        -n istio-system --set global.jwtPolicy=first-party-jwt
	helm upgrade --install istio-ingress istio/manifests/charts/gateways/istio-ingress \
        -n istio-system --set global.jwtPolicy=first-party-jwt
	helm upgrade --install istio-egress istio/manifests/charts/gateways/istio-egress \
        -n istio-system --set global.jwtPolicy=first-party-jwt
	kubectl apply -f istio/samples/addons -n istio-system
