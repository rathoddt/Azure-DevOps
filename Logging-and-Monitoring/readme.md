## Logging-and-Monitoring

```
kubectl get nodes
kubectl get all
kubectl get pods
kubectl describe app-deployment-765f89fb58-vvn9q 
kubectl describe pod app-deployment-765f89fb58-vvn9q 
az aks show -n aks-demo1 -g aks-rg --query identityProfile.kubeletidentity.clientId -o tsv
az role assignment create --assignee <client-id>   --role AcrPull \
az role assignment create --assignee a044a30f-1437-4fc0-acfd-b82126d36801   --role AcrPull   --scope $(az acr show -n aksdevopsacr00 --query id -o tsv)
history -w /dev/stdout
history | cut -c 8-
kubectl get pods
kubectl describe pod app-deployment-765f89fb58-vvn9q
kubectl delete pod app-deployment-765f89fb58-vvn9q
kubectl get pods
kubectl logs app-deployment-765f89fb58-gqvbs
kubectl logs pod app-deployment-765f89fb58-gqvbs
kubectl describe pod app-deployment-765f89fb58-gqvbs
kubectl get pods
kubectl logs app-deployment-765f89fb58-gqvbs --previous
kubectl get pods
kuectl get all
kubectl get all
kubectl delete pod/app-deployment-765f89fb58-gqvbs
kubectl get all
kubectl get pods
kubectl describe pods app-deployment-765f89fb58-v6v2m 
kubectl get pods
kubectl delete pod app-deployment-765f89fb58-v6v2m
kubectl get pods
cubectl describe pod app-deployment-765f89fb58-v6v2m
kubectl describe pod app-deployment-765f89fb58-v6v2m
kubectl describe pod app-deployment-765f89fb58-nd*
kubectl describe pod app-deployment-765f89fb58-ndqlz
kubectl logs app-deployment-765f89fb58-ndqlz
az group delete --name "aks-rg2" --yes --no-wait
az group delete --name "aks-rg" --yes --no-wait
ls
cd Azure-DevOps/
ls
cd AKS/
ls
bash aks-setup-v1.sh 
az aks get-credentials --resource-group aks-rg --name aks-demo1 --overwrite-existing
kubectl get nodes
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.*
ls
export PATH=$PWD/bin:$PATH
istioctl version
istioctl install --set profile=demo -y
istioctl install -f samples/bookinfo/demo-profile-no-gateways.yaml -y
kubectl get ns
kubectl get all -n istio-system
kubectl create ns prod
vi sb.yml
kubectl create -f sb.yml ns prod
kubectl create -f sb.yml -ns prod
kubectl create -f sb.yml -n prod
kubectl get all -n prod
vim sb-svc.yml
kubectl create -f sb-svc.yml -n prod
vi node-js.yml
kubectl create -f node-js.yml -n prod
kubectl get all -n prod
vim nodejs-svc.yaml
kubectl create -f nodejs-svc.yaml -n prod
kubectl get all -n prod
curl 10.0.50.229:8080
curl 10.0.50.229:8080/
kubectl logs app-deployment-6cd4c98b7f-985m8
kubectl logs app-deployment-6cd4c98b7f-985m8 -n prod
kubectl label namespace default istio-injection=enabled
kubectl get namespace -L istio-injection
kubectl label namespace prod istio-injection=enabled
kubectl get namespace -L istio-injection
curl 10.0.50.229:8080/
ls
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get pods
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl get svc istio-ingressgateway -n istio-system
kubectl get all -n istio-system
kubectl label namespace default istio-injection=enabled
kubectl get namespace -L istio-injection
kubectl get pods
kubectl get all pods
kubectl get all
kubectl apply -f samples/addons/
kubectl get svc istio-ingressgateway -n istio-system
curl 10.0.50.229:8080/
kubectl get all -n prod
kubectl get svc -A -o wide -n prod | grep 10.0.50.229
kubectl get nodes -o wide
kubectl port-forward svc/my-service 8080:8080 -n prod
kubectl patch svc my-service -n prod -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get svc my-service -n prod
curl 52.189.64.66:8080
curl 52.189.64.66:8080/
curl 52.189.64.66:8080/compare/51
curl 52.189.64.66:8080/compare/45
kubectl describe pod/app-deployment-6cd4c98b7f-985m8 -n prod
kubectl get ns --show-labels
kubectl run nginx -image=nginx -n prod
kubectl run nginx --image=nginx -n prod
kubectl get pods -n prod
kubectl describe pod nginx -n prod
kubectl get deploy -n prod
kubectl rollout restart app-deployment -n prod
kubectl rollout restart deploy app-deployment -n prod
kubectl rollout restart deploy app-node-js -n prod
kubectl get all -n prod
kubectl get all -n istio-system
kubectl port-forward svc/kiali -n istio-system 20001:20001
kubectl patch svc kiali -p '{"spec":{"type":"LoadBalancer"}}'
kubectl patch svc kiali -p '{"spec":{"type":"LoadBalancer"}}' -n istio-system
kubectl get all -n istio-system
kubectl get svc kiali -n istio-system -o wide
kubectl exec -it -n istio-system deploy/kiali -- netstat -tuln | grep 20001
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
sudo ./get_helm.sh
helm version
helm repo ls
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo ls
helm install my-nginx bitnami/inginx --version 22.3.2
helm install my-nginx bitnami/nginx --version 22.3.2
helm ls
kubectl get all
kubectl get all -n default
helm pull --untar bitnami/nginx
ls
cd nginx/
ls
cat Chart.yaml 
helm upgrade my-nginx bitnami/nginx
helm ls
helm history
helm history my-nginx
helm uninstall my-nginx
helm install --set service.type=NodePort web-nginx .
kubectl get akl
kubectl get all
cd ..
pwd
helm create myhelmchart
ls
cd myhelmchart/
ls
cat Chart.yaml 
cat values.yaml 
