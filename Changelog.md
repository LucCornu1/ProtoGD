# Changelog
All notable changes to this project will be documented in this file.

## [0.1.0] - 18-06-2022
### Added
- Ajout d'un menu avec ses boutons.
- Connection des divers scènes entre elles.

### TO-DO
- Animations de transition de scène.
- Faire perdre le joueur lorsque celui-ci sort trop longtemps du tableau (aka le niveau).

## [0.0.9] - 17-06-2022
### Added
- Un nouvel obstacle : l'étoile.
- Quatre premiers niveaux.

## [0.0.8] - 16-06-2022
### Added
- Ajout de boutons pour :
	- Mettre le jeu en pause.
	- Couper le son.
	- Renvoyer au menu principal (TO-DO).
- Le vaisseau ne se propulse pas lorsque que le joueur clique sur un bouton.

### Changed
- Changement de texture du portail de fin de niveau.

## [0.0.7] - 15-06-2022
### Added
- Un bouton reset pour recommencer un niveau.

### Changed
- Correction d'un bug permettant au joueur d'échapper à la gravité d'un trou noir.

## [0.0.6] - 14-06-2022
### Added
- Un gestionnaire de particule qui suit le joueur (en raison de l'impossibilité de déplacer un RigidBody2D avec une node Particle2D en enfant).
- Une trainée de particules dû au réacteur lorsque le vaisseau-joueur est lancé.
- La possibilité de diriger le vaisseau avant son lancement, afin de choisir une trajectoire.
- Ajout d'un trou noir avec les effets de Shaders.

### TO-DO
- Un bouton pour reset le niveau. -- DONE
- Faire perdre le joueur lorsque celui-ci sort trop longtemps du tableau (aka le niveau).
- Ajouter des animations lorsque le joueur complète un niveau.
- Ajouter une animation de transition différente lorsque le joueur passe au niveau supérieur.

## [0.0.5] - 13-06-2022
### Added
- Un contour blanc autour du sprite du vaisseau-joueur.
- Ajout d'une barre de chargement lorsque le joueur appuie sur espace pour charger le propulseur.

### Changed
- Changement de la mécanique de propulsion. Le joueur décide d'une propulsion initiale et ne peux plus modifier sa vitesse par la suite (A TERMINER).

### TO-DO
- Corriger le bug de taille de l'image de transition.

## [0.0.4] - 12-06-2022
### Added
- Sprite du vaisseau.
- Sprite du fond.
- Sprite d'une planète.
- Ajout d'une planète 'morte'.
- Ajout d'une animation de défaite sur le vaisseau-joueur. La scène se relance peu de temps après.
- Transition lorsqu'une scène se relance.

### Changed
- La propulsion a été modifiée. Elle s'incrémente ou se décrémente lorsqu'elle entre en orbite (en fonction de l'orientation du vaisseau-joueur).
- La propulsion est recalculée en fonction des changements externes.
- Le sprite du vaisseau-joueur a été mis à jour avec la ressource appropriée.

### TO-DO
- Modifier la gestion de rotation du vaisseau-joueur. -- CANCELED

## [0.0.3] - 11-06-2022
### Added
- Le carburant a été ajouté au vaisseau-joueur. Celui-ci doit désormais gérer sa ressource de carburant ou sinon il tombera à court et ne pourra plus utiliser les moteurs.

### Changed
- Correction d'un bug octroyant la capacité au joueur d'appuyer plusieurs fois sur la touche pour propulser le vaisseau, et ainsi lui conférer une plus grande vitesse.
- Changement de la gravité. Celle-ci s'effectue désormais avec la force, et non plus les impulsions pour un rendu plus réaliste.
- Correction d'un bug qui causait un sursaut lorsque le vaisseau-joueur était en orbite autour d'un corps céleste.
- Changement de la gestion de la poussée en avant du vaisseau-joueur. Le joueur peut rester appuyer pour propulser son vaisseau quand il le souhaite, et ainsi gérer sa vitesse.

## [0.0.2] - 10-06-2022
### Added
- Le vaisseau-joueur est désormais détruit lorsqu'il entre en collision avec un corps céleste.

### Changed
- Correction d'un bug où le vaisseau perdait de la vitesse lorsqu'il était attiré par un corps céleste.

## [0.0.1] - 09-06-2022
### Added
- Début du changelog.
- Les corps célestes sont attirés par les corps massifs par la force de gravité.
- Le vaisseau-joueur peut avancer en ligne droite sur un appuie de la touche 'espace'.
- Détection de la collision du joueur avec un PhysicsBody2D.