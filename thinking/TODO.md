# TODO - Migration OroCommerce vers Kubernetes

## 1. Préparation du projet
- [ ] Analyser la stack Docker Compose existante d’OroCommerce
    - [ ] Lister tous les services, ports, volumes et variables d’environnement
    - [ ] Identifier les dépendances entre services
    - [ ] Documenter la configuration actuelle
    - [ ] Vérifier la version des images utilisées
    - [ ] Identifier les fichiers de configuration personnalisés
- [ ] Définir l’architecture cible Kubernetes (diagramme, choix des ressources)
    - [ ] Réaliser un schéma d’architecture (Mermaid, draw.io, etc.)
    - [ ] Choisir les types de ressources Kubernetes (Deployment, StatefulSet, Service, PVC, etc.)
    - [ ] Définir les namespaces à utiliser
    - [ ] Lister les besoins en stockage (taille, type, performance)
- [ ] Préparer le cluster Kubernetes (local ou cloud)
    - [ ] Créer le cluster (Minikube, Kind, GKE, etc.)
    - [ ] Vérifier l’accès kubectl et les droits
    - [ ] Créer les namespaces nécessaires
    - [ ] Tester la persistance des volumes (ex: PVC test)
- [ ] Installer Helm sur le poste de travail et sur le cluster
    - [ ] Vérifier la version de Helm
    - [ ] Ajouter les repositories Helm nécessaires (bitnami, prometheus-community, etc.)
    - [ ] Tester l’installation d’un chart de test (ex: nginx)

## 2. Migration des composants applicatifs
### 2.1 Frontend (Nginx)
- [ ] Créer un chart Helm pour Nginx
    - [ ] Initialiser la structure du chart
    - [ ] Ajouter un values.yaml par défaut
    - [ ] Ajouter un README au chart
- [ ] Définir le Deployment et le Service
    - [ ] Choisir le type de Service (ClusterIP/NodePort/Ingress)
    - [ ] Définir les labels et annotations
    - [ ] Ajouter les resource requests/limits
- [ ] Configurer les probes (readiness/liveness)
    - [ ] Définir les endpoints de test
    - [ ] Tester les probes en conditions réelles
- [ ] Gérer la configuration Nginx via ConfigMap
    - [ ] Ajouter un template de config Nginx personnalisable
    - [ ] Monter le ConfigMap dans le pod
    - [ ] Documenter les variables de configuration
- [ ] Tester le déploiement Nginx seul
    - [ ] Vérifier l’accès HTTP depuis le cluster
    - [ ] Vérifier les logs Nginx

### 2.2 Backend (PHP-FPM)
- [ ] Créer un chart Helm pour PHP-FPM
    - [ ] Initialiser la structure du chart
    - [ ] Ajouter un values.yaml par défaut
    - [ ] Ajouter un README au chart
- [ ] Définir le Deployment et le Service
    - [ ] Définir les labels et annotations
    - [ ] Ajouter les resource requests/limits
- [ ] Ajouter le support HPA (Horizontal Pod Autoscaler)
    - [ ] Définir les métriques de scaling (CPU/mémoire)
    - [ ] Tester le scaling automatique
- [ ] Configurer les variables d’environnement (ConfigMap/Secret)
    - [ ] Lister toutes les variables nécessaires
    - [ ] Séparer les secrets des configs publiques
- [ ] Définir les probes
    - [ ] Définir les endpoints de test
    - [ ] Tester les probes en conditions réelles
- [ ] Tester la connexion Nginx <-> PHP-FPM
    - [ ] Vérifier le reverse proxy
    - [ ] Vérifier les logs d’erreur PHP

### 2.3 Base de données (MySQL)
- [ ] Créer un chart Helm pour MySQL
    - [ ] Initialiser la structure du chart
    - [ ] Ajouter un values.yaml par défaut
    - [ ] Ajouter un README au chart
- [ ] Définir le StatefulSet et le PVC
    - [ ] Choisir la classe de stockage
    - [ ] Définir la taille du volume
    - [ ] Tester la persistance après redémarrage
- [ ] Gérer les secrets pour les mots de passe
    - [ ] Générer les secrets via kubectl ou Helm
    - [ ] Vérifier l’accès restreint aux secrets
- [ ] Mettre en place la sauvegarde/restauration
    - [ ] Ajouter un Job de backup (ex: cronjob)
    - [ ] Stocker les backups dans un volume dédié ou un bucket
    - [ ] Documenter la procédure de restauration
    - [ ] Tester une restauration complète
- [ ] Configurer la persistance des données
    - [ ] Vérifier la rétention des données après suppression de pod
- [ ] Tester la connexion PHP-FPM <-> MySQL
    - [ ] Vérifier la création de la base et des tables
    - [ ] Vérifier les logs de connexion

### 2.4 Cache (Redis)
- [ ] Créer un chart Helm pour Redis
    - [ ] Initialiser la structure du chart
    - [ ] Ajouter un values.yaml par défaut
    - [ ] Ajouter un README au chart
- [ ] Définir le StatefulSet et le Service
    - [ ] Définir les labels et annotations
    - [ ] Ajouter les resource requests/limits
- [ ] Configurer la persistance
    - [ ] Définir le volume de persistance
    - [ ] Tester la persistance après redémarrage
- [ ] Définir les ressources
    - [ ] Ajuster les limites selon la charge
- [ ] Tester la connexion PHP-FPM <-> Redis
    - [ ] Vérifier le cache applicatif
    - [ ] Vérifier les logs Redis

### 2.5 Recherche (Elasticsearch)
- [ ] Créer un chart Helm pour Elasticsearch
    - [ ] Initialiser la structure du chart
    - [ ] Ajouter un values.yaml par défaut
    - [ ] Ajouter un README au chart
- [ ] Définir le StatefulSet et le Service
    - [ ] Définir les labels et annotations
    - [ ] Ajouter les resource requests/limits
- [ ] Configurer les ressources et la persistance
    - [ ] Définir le volume de persistance
    - [ ] Tester la persistance après redémarrage
- [ ] Tester la connexion PHP-FPM <-> Elasticsearch
    - [ ] Vérifier l’indexation et la recherche
    - [ ] Vérifier les logs Elasticsearch

## 3. Monitoring et supervision
- [ ] Déployer Prometheus via Helm
    - [ ] Configurer le scraping des métriques pour tous les pods
    - [ ] Ajouter des ServiceMonitors si besoin
    - [ ] Vérifier la collecte des métriques custom
- [ ] Déployer Grafana via Helm
    - [ ] Importer des dashboards adaptés à OroCommerce
    - [ ] Créer des dashboards personnalisés
    - [ ] Configurer l’authentification Grafana
- [ ] Créer/importer des dashboards Grafana adaptés
    - [ ] Ajouter des panels pour chaque composant
    - [ ] Documenter les dashboards
- [ ] Mettre en place des alertes (CPU, mémoire, disponibilité)
    - [ ] Définir les règles d’alerte dans Prometheus
    - [ ] Configurer les notifications (email, Slack, etc.)
    - [ ] Tester la réception des alertes
- [ ] Tester la visualisation des métriques
    - [ ] Vérifier l’actualisation en temps réel
    - [ ] Simuler une panne pour vérifier les alertes

## 4. Sécurité et bonnes pratiques
- [ ] Gérer tous les mots de passe via Kubernetes Secrets
    - [ ] Vérifier qu’aucun mot de passe n’est en clair dans les charts
    - [ ] Restreindre l’accès aux secrets par RBAC
- [ ] Activer TLS/SSL sur les accès externes (Ingress)
    - [ ] Générer ou importer un certificat TLS
    - [ ] Configurer l’Ingress pour le HTTPS
    - [ ] Tester l’accès HTTPS depuis l’extérieur
- [ ] Définir les resource limits/requests pour chaque pod
    - [ ] Ajuster selon les tests de charge
    - [ ] Documenter les choix de ressources
- [ ] Configurer RBAC pour limiter les droits
    - [ ] Créer des ServiceAccounts dédiés
    - [ ] Définir les rôles et bindings nécessaires
    - [ ] Tester les restrictions d’accès

## 5. Documentation
- [ ] Rédiger le guide d’installation détaillé
    - [ ] Inclure des exemples de commandes
    - [ ] Ajouter des captures d’écran si besoin
- [ ] Documenter l’architecture (diagrammes, explications)
    - [ ] Ajouter le diagramme dans le README
    - [ ] Expliquer chaque flux de données
- [ ] Expliquer la procédure de rollback et de mise à jour
    - [ ] Ajouter des exemples Helm (rollback, upgrade)
    - [ ] Documenter les cas d’erreur fréquents
- [ ] Ajouter une FAQ et un glossaire
    - [ ] Lister les questions fréquentes
    - [ ] Définir les termes techniques
- [ ] Documenter les bonnes pratiques et pièges à éviter
    - [ ] Lister les erreurs courantes
    - [ ] Proposer des solutions

## 6. Tests et validation
- [ ] Vérifier le bon fonctionnement de chaque composant
    - [ ] Accès frontend, backend, base, cache, recherche
    - [ ] Vérifier les logs de chaque pod
- [ ] Tester la scalabilité (HPA)
    - [ ] Générer de la charge et observer l’autoscaling
    - [ ] Vérifier la stabilité après scaling
- [ ] Tester la persistance des données (MySQL, Redis)
    - [ ] Redémarrer les pods et vérifier la conservation des données
    - [ ] Restaurer un backup et vérifier l’intégrité
- [ ] Vérifier la collecte des métriques et l’affichage dans Grafana
    - [ ] Vérifier la cohérence des données affichées
- [ ] Simuler une panne et vérifier la tolérance aux pannes
    - [ ] Supprimer un pod et observer le redémarrage automatique
    - [ ] Tester la perte d’un nœud du cluster

## 7. Analyse comparative
- [ ] Comparer les performances avant/après migration
    - [ ] Mesurer les temps de réponse, la charge supportée
    - [ ] Documenter les résultats
- [ ] Évaluer la facilité de maintenance et de déploiement
    - [ ] Lister les points d’amélioration
- [ ] Rédiger une synthèse comparative
    - [ ] Présenter les avantages/inconvénients

## 8. Livraison
- [ ] Préparer les livrables (charts, documentation, diagrammes)
    - [ ] Vérifier la complétude des charts
    - [ ] Relire la documentation
    - [ ] Vérifier la lisibilité des diagrammes
- [ ] Nettoyer le dépôt et vérifier la conformité
    - [ ] Supprimer les fichiers inutiles ou sensibles
    - [ ] Vérifier la présence d’un .gitignore adapté
- [ ] Présenter le projet (soutenance, démonstration)
    - [ ] Préparer une démo live ou une vidéo
    - [ ] Préparer un support de présentation (slides)
    - [ ] Répartir les rôles pour la soutenance 