#!/bin/bash

# Script de déploiement OroCommerce sur Kubernetes
# Projet EII 5 - Migration Docker Compose vers Kubernetes

set -e

echo "🚀 Déploiement OroCommerce sur Kubernetes - Projet EII 5"
echo "========================================================="

# Configuration
NAMESPACE="orocommerce"
RELEASE_NAME="orocommerce"
TIMEOUT="10m"

# Vérifications prérequis
echo "🔍 Vérification des prérequis..."

if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl n'est pas installé"
    exit 1
fi

if ! command -v helm &> /dev/null; then
    echo "❌ helm n'est pas installé"
    exit 1
fi

# Test connexion Kubernetes
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ Impossible de se connecter au cluster Kubernetes"
    exit 1
fi

echo "✅ Prérequis validés"

# Création du namespace
echo "📦 Création du namespace ${NAMESPACE}..."
kubectl create namespace ${NAMESPACE} --dry-run=client -o yaml | kubectl apply -f -

# Installation des dépendances Helm
echo "📚 Installation des dépendances Helm..."
helm dependency update

# Déploiement
echo "🚀 Déploiement de OroCommerce..."
helm upgrade --install ${RELEASE_NAME} . \
    --namespace ${NAMESPACE} \
    --timeout ${TIMEOUT} \
    --wait \
    --atomic

echo "✅ Déploiement terminé !"

# Vérification du déploiement
echo "🔍 Vérification du déploiement..."
kubectl get pods -n ${NAMESPACE}
kubectl get services -n ${NAMESPACE}
kubectl get ingress -n ${NAMESPACE}

# Informations d'accès
echo ""
echo "🌐 Informations d'accès:"
echo "========================"
echo ""
echo "Application OroCommerce:"
echo "  URL: https://orocommerce.local"
echo "  (Ajoutez '127.0.0.1 orocommerce.local' à /etc/hosts)"
echo ""
echo "Monitoring Prometheus:"
echo "  kubectl port-forward -n ${NAMESPACE} service/${RELEASE_NAME}-monitoring-prometheus 9090:9090"
echo "  URL: http://localhost:9090"
echo ""
echo "Monitoring Grafana:"
echo "  kubectl port-forward -n ${NAMESPACE} service/${RELEASE_NAME}-monitoring-grafana 3000:3000"
echo "  URL: http://localhost:3000"
echo "  Credentials: admin / admin123"
echo ""
echo "🎯 Commandes utiles:"
echo "==================="
echo ""
echo "# Vérifier l'état des pods"
echo "kubectl get pods -n ${NAMESPACE}"
echo ""
echo "# Voir les logs"
echo "kubectl logs -f deployment/${RELEASE_NAME}-backend -n ${NAMESPACE}"
echo ""
echo "# Accéder à l'application via port-forward"
echo "kubectl port-forward -n ${NAMESPACE} service/${RELEASE_NAME}-frontend 8080:80"
echo ""
echo "# Scaler manuellement le backend"
echo "kubectl scale deployment ${RELEASE_NAME}-backend --replicas=5 -n ${NAMESPACE}"
echo ""
echo "🎓 Projet EII 5 déployé avec succès !"
echo "=====================================" 