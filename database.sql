-- --------------------------------------------
-- Suppression de BDD base_things si déjà existante
-- --------------------------------------------
DROP DATABASE IF EXISTS base_things;
-- --------------------------------------------
-- Création de BDD base_things
-- --------------------------------------------
CREATE DATABASE base_things;
-- --------------------------------------------
-- Sélection de BDD base_things
-- --------------------------------------------
USE base_things;
-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Jeu 26 Octobre 2017 à 13:53
-- Version du serveur :  5.7.19-0ubuntu0.16.04.1
-- Version de PHP :  7.0.22-0ubuntu0.16.04.1
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
--
-- Base de données :  `simple-mvc`
--
-- --------------------------------------------------------
--
-- Structure de la table `item`
--
CREATE TABLE `item` (
  `id` int(11) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
--
-- Contenu de la table `item`
--
INSERT INTO `item` (`id`, `title`)
VALUES (1, 'Stuff'),
  (2, 'Doodads');
--
-- Index pour les tables exportées
--
--
-- Index pour la table `item`
--
ALTER TABLE `item`
ADD PRIMARY KEY (`id`);
--
-- AUTO_INCREMENT pour les tables exportées
--
--
-- AUTO_INCREMENT pour la table `item`
--
ALTER TABLE `item`
MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  AUTO_INCREMENT = 3;
-- -----------------------------------------------------------------------------------------
-- --------------------------------------------
-- DUMP DE CREATION DES TABLES POUR BASE THINGS
-- --------------------------------------------
-- --------------------------------------------
-- Création de la table exit
-- --------------------------------------------
CREATE TABLE `exit` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `department` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  `height` VARCHAR(150),
  `access_duration` TIME,
  `gps_coordinates` VARCHAR(50),
  `acces` TEXT,
  `remark` TEXT,
  `video` TEXT,
  `image` TEXT,
  `active` BOOL NOT NULL,
  PRIMARY KEY (`id`)
);
-- --------------------------------------------
-- Création de la table type_jump
-- --------------------------------------------
CREATE TABLE `type_jump` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
);
-- --------------------------------------------
-- Création de la table exit_has_type_jump
-- --------------------------------------------
CREATE TABLE `exit_has_type_jump` (
  `id_exit` INT NOT NULL,
  `id_type_jump` INT NOT NULL,
  PRIMARY KEY (`id_exit`, `id_type_jump`),
  CONSTRAINT fk_exit_has_type_jump_exit FOREIGN KEY (id_exit) REFERENCES `exit`(id),
  CONSTRAINT fk_exit_has_type_jump_type_jump FOREIGN KEY (id_type_jump) REFERENCES type_jump(id)
);
-- --------------------------------------------
-- Création de la table role
-- --------------------------------------------
CREATE TABLE `role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `read` BOOL NOT NULL,
  `write` BOOL NOT NULL,
  `delete` BOOL NOT NULL,
  PRIMARY KEY (`id`)
);
-- --------------------------------------------
-- Création de la table user
-- --------------------------------------------
CREATE TABLE `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pseudo` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50),
  `last_name` VARCHAR(150),
  `first_name` VARCHAR(150),
  `date_of_birth` DATE,
  `email` VARCHAR(320),
  `postal_adress` TEXT,
  `id_role` INT,
  PRIMARY KEY (`id`),
  CONSTRAINT fk_user_role FOREIGN KEY (id_role) REFERENCES role(id)
);
-- --------------------------------------------
-- Création de la table jump_log
-- --------------------------------------------
CREATE TABLE `jump_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_user` INT NOT NULL,
  `date_of_jump` DATE NOT NULL,
  `id_exit` INT NOT NULL,
  `id_type_jump` INT NOT NULL,
  `container` VARCHAR(50),
  `canopy` VARCHAR(50),
  `suit` VARCHAR(50),
  `weather` TEXT,
  `wind` VARCHAR(50),
  `video` TEXT,
  `image` TEXT,
  `comment` TEXT,
  PRIMARY KEY (`id`),
  CONSTRAINT fk_jump_log_user FOREIGN KEY (id_user) REFERENCES `user`(id),
  CONSTRAINT fk_jump_log_exit FOREIGN KEY (id_exit) REFERENCES `exit`(id),
  CONSTRAINT fk_jump_log_type_jump FOREIGN KEY (id_type_jump) REFERENCES `type_jump`(id)
);
-- --------------------------------------------
-- FIN DE CREATION DES TABLES
-- --------------------------------------------
-- --------------------------------------------
-- JEU DE DONNEES POUR BASE THINGS
-- --------------------------------------------
-- --------------------------------------------
-- Ajout de données dans la table exit
-- --------------------------------------------
INSERT INTO base_things.`exit` (
    name,
    department,
    country,
    height,
    access_duration,
    gps_coordinates,
    acces,
    remark,
    video,
    image,
    active
  )
VALUES (
    'Barre de la Clue',
    'Alpes-maritimes',
    'France',
    '150m +',
    '00:20:00',
    '43.974205,6.998488',
    'Se rendre au village de Rigaud dans les gorges du Cians et se garer au cimetière.

Monter par la route qui part le plus à gauche de celui-ci. Arrivé sur le plateau, passer la maisons qui élève des chiens, après la fontaine d''eau potable un chemin privé part sur la gauche.

Le suivre en restant discret. Environ en 43.974205 , 6.998488 quitter le sentier vers l''Est et traverser la végétation dense vers l''exit, environ en 43.975625 , 7.003191 (progression pas facile).',
    'Remarque 1',
    'https://www.youtube.com/watch?v=mVzEf03SRZM',
    'assets/images/400px-Chamane_Et_Enfant-ligne626d7856db4f08.34405753.jpg',
    1
  ),
  (
    'Bambi',
    'Alpes-maritimes',
    'France',
    '65m',
    '00:30:00',
    '44.126244,6.872327',
    'De Guillaumes, prendre à droite à la sortie Nord du village après la gendarmerie afin de monter au hameau de Bouchanières via la D75 et ce garer au centre de ce dernier.

Marcher vers l''Est sur 150m et prendre la sente à droite dans le virage avant les maisons (44.121121 , 6.868792).

La sente arrive sur une piste, prendre à droite et marcher jusqu''à une grande ferme (Geyrard sur l''IGN).

Avant la ferme, prendre le sentier balisé à gauche et le suivre jusqu''à ce qu''il passe dans un grand découvert en haut(44.126244 , 6.872327).

Traverser le découvert plein Ouest et rentrer dans la forêt.

Il suffit maintenant de marcher dans la forêt vers le Sud jusqu''au vide.

Le saut se trouve juste à droite du "V" qui coupe la face, sur une vire.',
    'Remarque 2',
    'https://www.youtube.com/watch?v=hvRrBtc5h3I',
    'assets/images/400px-Archeplan626d783c660718.23336872.jpg',
    1
  ),
  (
    'Cascade de Clars',
    'Alpes-maritimes',
    'France',
    '60m',
    '00:10:00',
    '43.743690,6.753011',
    'De Séranon, rouler sur la D6085 vers Escragnolles pendant 6.5km et s''arrêter sur la droite de la route en 43.74369 , 6.753011.

De la, prendre le petit sentier qui descend vers le Sud sur 100m et prendre à droite sur une petite sente quand le sentier passe Est et dans un petit bois (voir photo).

Ensuite, marcher plein Sud jusqu''à la cascade. L''exit est facile à trouver, juste à gauche de la cascade sur une petite pointe.

Retour en contournant la cascade par la droite (sentier).',
    'Remarque 3',
    'https://www.dailymotion.com/video/x2fu4ds',
    'assets/images/400px-Coca626d7880591ce8.31744037.jpg',
    1
  ),
  (
    'Castel Tournou',
    'Alpes-maritimes',
    'France',
    '70m',
    '01:00:00',
    '44.115727,7.617391',
    'De Tende, prendre la route allant aux Granges de la Pia par le Vallon du Réfrei et se garer environ en 44.115727 , 7.617391 avant le hameau.

Marcher en suivant la piste principale allant aux Granges de la Pia puis trouver le sentier de rando montant au Castel Tournou.

Arriver sous le saut, on monte par la droite et on rejoint facilement le bord où plusieurs exit sont possibles.',
    'Remarque 4',
    'https://www.youtube.com/watch?v=-eC-61OLkEQ',
    'assets/images/400px-Grandmanti626d78a6b6ff52.96256002.jpg',
    1
  ),
  (
    'Chanabasse',
    'Alpes-maritimes',
    'France',
    'de 70m à 90m',
    '01:00:00',
    '44.146421,6.833376',
    'Dans le grand virage à gauche avant d''arriver à Chateauneuf d''Entraunes, tourner à droite et prendre la route partant vers le Nord, qui se transforme ensuite en piste après la chapelle.

Rouler sur la piste sur environ 1.5km et se garer dans le virage en 44.13944 , 6.836861.

Continuer la piste en marchant et prendre le sentier de rando à gauche 100m plus loin.

Lorsque celui-ci arrive sur un autre sentier (à flanc d''une paroie, en 44.13944 , 6.836861), prendre à droite et continuer jusqu''au prochain carrefour de sentier, sur le replat dans la forêt en 44.146421 , 6.833376.

Prendre à gauche ici et vers l''Ouest puis le Sud jusqu''au sommet du rocher (Chanabasse sur la carte IGN).

Plusieurs exits possibles, l''original se trouve en descendant sur la gauche pour trouver une vire confortable. Ici le rockdrop est d''environ 75m et il y a 3 pas d''élan possibles.

D''autres départs sont envisageables, mais attention la paroi n''est pas régulière, surtout vers les hauteur d''ouverture.',
    'Remarque 5',
    'https://www.youtube.com/watch?v=-eC-61OLkEQ',
    'assets/images/400px-Granier626d78ba3bcc69.85485918.jpg',
    1
  ),
  (
    'Chaudan',
    'Alpes-maritimes',
    'France',
    '60m',
    '00:30:00',
    '44.033201,6.825770',
    'De Daluis, rouler 1.5km en direction de Guillaumes (vers le nord) et se garer sur le bord de la route (44.033201 , 6.82577 par exemple).

On a ici un bon visuel du saut.

Marcher maintenant sur la route vers le sud afin de rejoindre l''autre côté de la crête où se trouve le saut et proche d''un petit parking, monter dans le talus afin de rejoindre l''exit à vue.',
    'Remarque 6',
    'https://www.youtube.com/watch?v=S9ErwpqMKbg',
    'assets/images/400px-Penat626d78d4eb9de2.87020175.jpg',
    1
  ),
  (
    'Amphibolite Brumeuse',
    'Isère',
    'France',
    'Entre 220m et 2000m!!',
    '04:00:00',
    '45.142400,5.988160',
    '4 heures de montée et 1h30 pour redescendre dans la vallée.

Départ de Pré Conté (906m) au-dessus de St Mury, ou de Pré Marcel (1290m) au dessus de St Agnès. Possibilité de dormir au refuge Jean Collet (1970m). Rejoindre le lac Blanc, puis monter vers le glacier de Freydane puis par les rochers ou un névé, atteindre le col de la Balmette au Nord. Le col de la Balmette 2650m est le col situé au pied de l''arête N du Grand Pic. Emprunter la voie normale jusqu’au sommet (nombreux itinéraires possibles, se redescend également sans corde, un seul passage «délicat»). De la croix sommitale, parcourir l’arête 15m au Nord pour descendre de 20m en désescalade (facile mais rochers instables) pour atteindre une dalle où l’on s’équipe: exit. Spit sortie de voie+corde en place qui permet tout juste de voir la pierre taper à 7s dans le névé supérieur de la face N (pas de bruit!!) bien visible sur les photos.  Monter un brin de 15m en plus pour pouvoir voir la face.

Départ Versant Allemont depuis le lieu dit Le Mollard conseillé pour le saut en WS. 4h en quasi autonavette.',
    'Remarque 7',
    'https://youtu.be/AG_3-KLHpM0',
    'assets/images/400px-Ansage626d77c0ced749.50863894.jpg',
    1
  ),
  (
    'Aiguillette Saint Michel',
    'Isère',
    'France',
    'Une static line (flèche verte) 80m maxi, Un saut d''aile (flèche rouge)',
    '01:25:00',
    '',
    'Depuis le col de Marcieu, monter sur le plateau par le pas du ragris ou le pas de l''aulp du seuil. Monter à la station au sommet, le glisseur bas est évident.

Pour atteindre le saut de wingsuit descendre sur le gros pilier plein sud, 2 pas équipés de cordes à descendre un peu expos.',
    'Remarque 8',
    'https://www.youtube.com/watch?v=E6-Q2WXgwF0',
    'assets/images/400px-Aiguillette626d77aac246b6.65031505.png',
    1
  ),
  (
    'Fou Allier !',
    'Haute-Loire',
    'France',
    '75 mètres de verticale, 100 jusqu’au posé',
    '00:10:00',
    '',
    'Bien vérifier l’axe de départ, en cas de grosse orientation à gauche les réflexes doivent être au rendez vous!',
    'Remarque 9',
    'https://www.youtube.com/watch?v=3YZGaGYx8HU',
    'assets/images/400px-Souspierre626d78ea4880c2.38420051.jpeg',
    1
  ),
  (
    'Bon dieu de Bon Dieu',
    'Vaucluse',
    'France',
    '50m',
    '00:20:00',
    '43.769291,5.347224',
    'De Lourmarin centre, rouler en direction de Apt et, à la sortie du village, tourner à gauche sur Chemin du Pierrouret.

On passe devant la station d''épuration et des containers à ordures.

Environ 1km après ces derniers, se garer au bord de la route (en 43.769291 , 5.347224).

Suivre le GR 97 vers le nord et, arrivé dans le talweg derrière le saut (environ 43.769291 , 5.347224), monter le talus à travers la végétation jusqu''au vide.

Il est ensuite facile de trouver un exit convenable. Cordelette présente pour indiquer l''exit original.',
    'Remarque 10',
    'https://www.youtube.com/watch?v=l0B-jPHyMY4',
    'assets/images/400px-Chanteloube626d786c261036.57235342.jpeg',
    1
  );
INSERT INTO base_things.`exit` (
    name,
    department,
    country,
    height,
    access_duration,
    gps_coordinates,
    acces,
    remark,
    video,
    image,
    active
  )
VALUES (
    'Combe de Neyreval',
    'Ain',
    'France',
    '110m',
    '00:10:00',
    '',
    'Pour se rendre au posé: de Argis prendre la direction Saint Rambert en Bugey, 1 km après avoir passer le stade de foot de Saint Rambert, prendre à gauche le pont qui passe au dessus de la rivière l’Albarine et du chemin de fer, et prendre encore à gauche en longent les chemin de fer, jusqu’a arriver à une patte d’oie (le parking). Accès au saut: aller en direction d’Argis, tourner à gauche rond point, et encore à gauche pour récupérer la D 104 direction « le Pavaz, Averliaz » après avoir passer Averliaz continuer encore 3km jusqu’a arriver au plateau de Suerme, et se garer à la fin du chemin. Descendre ensuite 5 min dans les bois en direction de la falaise.',
    'Lieu: Combe de Neyreval à l’est de Saint Rambert en Bugey
Hauteur:110m
Matériel:rien
Posé: Dans le champ, proche de la ferme à coter de la ligne de chemin de fer en rive gauche de l’Albarine (rivière)
Premiére: Romain Blanchot, Pierre Lebreton le 29 janvier 2016',
    '',
    'assets/images/',
    1
  ),
  (
    'Hostiaz',
    'Ain',
    'France',
    '160m',
    '00:10:00',
    '',
    'De Saint-Rambert-en-Buggy prendre la D1504 en direction de Chambéry, 2km après avoir passer Tenay prendre la d103a qui monte à gauche en direction de Hostias, (l’éxit se trouve sur la gauche, 100m après avoir quitté la d1504). Une fois arriver à Hostiaz, se garer au bord de la route au niveau de la première maison qui se trouve à gauche, en contrebas de la route, puis prendre le chemin de randonnée qui va en direction de l’ouest vers la crête de la rivoire, le saut se trouve au niveau du L de Cleyseau (carte gin).',
    'Lieu : Falaise de Cleyseau à l’ouest du village d’Hostiaz
Hauteur : 160m
Matériel : éventuellement 10m de corde pour s’aider a descendre à l’éxit.
Posé : Dans le terrain vague entre la ligne de chemin de fer et la route, face à l’éxit.
Première : Pierre Lebreton le 29 janvier 2015',
    '',
    'assets/images/',
    1
  ),
  (
    'La petite gorge',
    'Ain',
    'France',
    '65m',
    '00:20:00',
    '',
    'Ce garer à l’entrée de Saint Sorlin (sud est) sur la d122, sur le parking du lycée, puis prendre le chemin de randonné qui traverse le village et qui monte de façon évidente à l’indication ign « petite gorge » le saut ce trouve en bas du champ dans l’axe du << p >> de petite entre les 2 parcelles de vignes.',
    'Lieu: Falaise à 500m au sud est de Saint Sorlin en Bugey
hauteur: 65m
Matériel: de quoi faire une static line
Posé: dans le champ juste après les vignes
Premiére: Pierre Lebreton 2015',
    '',
    'assets/images/',
    1
  ),
  (
    'Le Dess',
    'Ain',
    'France',
    '100m',
    '00:03:00',
    '',
    'A la sortie de Saint Rambert en Bugey en direction de Chambéry, prendre la direction d’Evosges, dans la commune d’Evosges passer devant l’auberge (très réputée !), continuer la route qui monte sur le plateau et qui se transforme en chemin carrossable. A la première intersection, du chemin, prendre à gauche et continuer jusqu''à que le chemin s’arrête dans le dernier champ. Ensuite prendre à droite à travers bois en se rapprochant de la falaise',
    'Lieu : falaise du Bugey au dessus de la commune d''Argis sur le plateau de la commune d''Evosges dans l’Ain
Hauteur : 100m
Matériel : rien
Posé : un peu étroit sur le seul petit chemin 150m sous les gencives
Première : Gabi Dematte et Denis Verchère en novembre 2001',
    '',
    'assets/images/',
    1
  ),
  (
    'Rochers de la Falconnière',
    'Ain',
    'France',
    '70m',
    '00:30:00',
    '',
    'De Serrières, prendre le chemin de randonnée qui monte au Rochers de la Falconnière, arriver sur le plateau prendre la direction du balcon de la falconnière, le saut ce trouve juste après la fin du champ.',
    'Lieu : Rochers de la Falconnière, au dessus du village de Serrières (commune de Saint-Rambert-en-Bugey)
Hauteur: 70m
Matériel: éventuellement 10m de corde pour trouver l’axe du saut.
Posé: dans les champs les plus proche des maisons, après un long sous voile.
Première: Romain Blanchot, Riquier Vincendeau-Verbraeken, Thomas Viethen, Pierre Lebreton',
    '',
    'assets/images/',
    1
  ),
  (
    'Torcieu',
    'Ain',
    'France',
    '70m',
    '00:30:00',
    '',
    'De Ambérieu en Bugey prendre la direction de Saint Rambert en Bugey, à la bifurcation qui va à Torcieu, continuer encore 900m sur la d1504 puis prendre à droite le chemin qui traverse les vois de chemin de fer, prendre ensuite le chemin qui va à gauche et qui longe la rivière l’Albarine et continuer encore 900m, de la prendre un chemin non marquer sur la carte qui monte au décollage parapente, arriver au décollage parapente, lorsque on regarde vers le fond de vallée, on peut voir sur la droite à 200m de distance à notre hauteur une petite manche à air, l’éxit ce trouve 20m en dessous.',
    'Lieu: Falaise proche du décollage parapente de Torcieu
Hauteur: 70m
Matériel: éventuellement de quoi faire une static line
Posé: dans les champs les plus proche du posé
Première: Pierre Lebreton 2015',
    '',
    'assets/images/',
    1
  ),
  (
    'Tour d''Horizon',
    'Ain',
    'France',
    '120m',
    '00:40:00',
    '',
    'Se garer sur un parking sablé environ 1km après la sortie de Nantua, sur la route longeant le nord du lac. Continuer à pied sur 200 mètres et prendre le chemin à droite qui monte entre deux grillages. Suivre le sentier qui monte en pente douce, en suivant les panneaux indiquant "Tour d''horizon". Arrivé sur le chemin pour 4x4, le suivre en montant sur environ 500 mètre puis tourner à droite sur un sentier partant dans la forêt.

Au bout de 5-10 minutes, sortir du sentier en allant au sud. L''exit est à environ 50 mètres. Plusieurs départ possible, dont un en courant (3-4 pas d''élan) dans une zone un peu dégagée.',
    'Joli spot avec visuel face au lac. Saut relativement facile (falaise un peu déversante, multiples posés dans le talus à gauche). Éviter de sauter avec un vent d''ouest qui pourrait rabattre sur un pilier situé à 30 mètres à gauche de l''exit.',
    '',
    'assets/images/',
    1
  ),
  (
    'Barrage de Castillon',
    'Alpes-de-Haute-Provence',
    'France',
    '120m',
    '00:05:00',
    '',
    'Au barrage de Castillon, contourner la centrale par la gauche via le chemin et grimper jusqu''au vide, un peu avant le deuxième grand pylône. L''exit (une belle dalle) se trouve quelques mètres à droite d''une petite ferraille sellée dans la roche, au dessus de la première vasque bleue turquoise. Pour le retour, grimper droit dans le talus jusqu''à trouver un chemin qui revient au barrage (15min).',
    'Lieu : Falaise en aval du barrage de Castillon, au Nord de Castellane dans les Alpes de Haute Provence
Hauteur : 120m
Matériel : Aucun
Posés : délicat dans le talus en face
Première : Timothée Maurel, et Pierre Lebreton le 25 aout 2017',
    'https://www.youtube.com/watch?v=FT5cZ05jEqc',
    'assets/images/800px-Castillon (1)627a52dcea7af5.78730910.png',
    1
  ),
  (
    'Bessey-en-Chaume',
    'Alpes-de-Haute-Provence',
    'France',
    '45m, 90m pour le posé',
    '00:20:00',
    '',
    'Du hameau de Clavoillon, monter au "Bas de Berfeu" (carte IGN) ne pas prendre à droite à la ferme de Berfeu, continuer encore 100m et prendre le chemin à droite (ça évite de traverser les habitations) traverser le champ en direction du "point de vue", 50m avant la fin du champ, traverser à travers la végétation (dense) pour arriver à la falaise.',
    'Saut absolument inutile, les arbres sont haut, et il est "nécessaire" de les traverser sous voile (sans finir dedans bien sur).',
    '',
    'assets/images/400px-Clavoillon627a53a5b1cd86.65564370.jpg',
    1
  ),
  (
    'Chapelle Saint-Pons',
    'Alpes-de-Haute-Provence',
    'France',
    '100m au total',
    '00:40:00',
    '44.134702 , 5.884476',
    'Du village de Valbelle, marcher vers le Sud-Est sur le sentier pour monter à la chapelle (voir carte).

Dépasser la chapelle et suivre une sente à gauche un peu plus loin, elle rejoint un passage équipé de cordes pour monter sur les falaises.

Une fois en haut, suivre le vide vers le Nord pour trouver l''exit assez évident mais très bien caché. Il faut descendre un peu dans les buissons pour trouver un petit bec qui avance sur le vide. (44.134702 , 5.884476)',
    'Attention, vous êtes ici à la verticale du sentier de la chapelle, possibles randonneurs en dessous. Enfermement à gauche.',
    '',
    'assets/images/600px-Chapellestpons627a541624cbd0.62950099.jpg',
    1
  );
INSERT INTO base_things.`exit` (
    name,
    department,
    country,
    height,
    access_duration,
    gps_coordinates,
    acces,
    remark,
    video,
    image,
    active
  )
VALUES (
    'Chapelle St-Trophisme',
    'Alpes-de-Haute-Provence',
    'France',
    '60m',
    '00:45:00',
    '',
    'Se garer dans Robion ou le petit Robion et emprunter un des sentiers balisés montant à la chapelle et visibles sur la carte IGN.

Arriver en dessous de la chapelle, ne pas y monter et prendre dans le talus à gauche afin de remonter le pierrier et accéder à la vire surplombant la chapelle (crapahute facile).

Une fois sur la vire, l''exit est très évident et confort, sur une avancée légèrement déportée sur la gauche par rapport à la chapelle.',
    'Lieu : Falaise au dessus de la chapelle St-Trophisme, dans le massif dominant le petit village de Robion, au Sud-Ouest de Castellane.
Hauteur : 60m
Matériel : Cordelette et corde à casser
Posé : Champs
Première : Timothée Maurel le 15 août 2019',
    '',
    'assets/images/600px-Trophisme627a55231b3005.02302417.png',
    1
  ),
  (
    'Chinois Vert',
    'Alpes-de-Haute-Provence',
    'France',
    '85m',
    '00:20:00',
    '',
    'De Barcelonnette, prendre la D900 jusqu''à Le Lauzet-Ubaye, prendre ensuite à droite la D954 direction Savines le lac sur 4km jusqu''à l''entrée d''un tunnel de voie ferrée sur la droite (sans voie ferrée!). Soit se garer là, soit emprunter les tunnels en voiture sur environ 1km jusqu''à des ruines. De là, un chemin monte au sommet par la gauche de la face.

Exit évident sur un petit éperon, possibilité aussi de courir. Pousser légèrement à gauche pour être complètement dans le dévers.',
    'Lieu : Roche Rousse, Vallée de l''Ubaye
Hauteur : 85m
Matériel : Aucun
Posé : Champs au pied
Première : Guillaume Bernard le 29 juin 2013',
    '',
    'assets/images/',
    1
  ),
  (
    'Chute de Charognes',
    'Alpes-de-Haute-Provence',
    'France',
    '100m',
    '00:15:00',
    '',
    'Se garer à Rougon et prendre la piste partant à l''Est dans le village sur environ 1.5km.

Une fois arrivé au niveau de la zone protégée des volières, la contourner par la gauche et descendre la barre rocheuse en tirant à gauche afin de rejoindre le vide.

Plusieurs exit sont possibles dans cette face, mais ne remontez pas vers la zone interdite à droite.',
    'Lieu : Barre de l''Aigle, entre le village de Rougon et la Clue de Carajuan, dans les gorges du Verdon.
Hauteur : 100m
Matériel : aucun
Posé : Pierriers proche de la route
Première : Timothée Maurel et Pierre Lebreton le 20 octobre 2018',
    '',
    'assets/images/400px-Charogne627a55f25dc996.44894137.jpg',
    1
  ),
  (
    'Clouet de la cabane',
    'Alpes-de-Haute-Provence',
    'France',
    'au moins assez pour une static-line',
    '01:30:00',
    '44.061111 , 6.315076',
    'De Digne les Bains, rouler vers le village des Dourbes, traverser le village et se garer dans le virage en 44.061111 , 6.315076.

Continuer la route en marchant sur 200m et prendre le sentier à gauche. Suivre les sentiers vers le pas de Labaud, et une fois en haut, prendre vers le nord jusqu''à atteindre la première barre et trouver un exit potable.',
    'Saut d''évacuation réalisé en conditions dégradées. Il y à sûrement mieux à trouver qu''une static-line.',
    '',
    'assets/images/600px-Clouet627a59650135d7.44239526.png',
    1
  ),
  (
    'Clue de Chasteuil',
    'Alpes-de-Haute-Provence',
    'France',
    '100m',
    '01:10:00',
    '43.813565, 6.437970',
    'Se garer (en 43.813565, 6.437970) dans la Clue de Chasteuil (10km après Castellane en allant en direction de La Palud).

Grimper à l''instinct la crête OUEST en passant les différentes barres, pierriers, buissons...jusqu''à l''exit évident en forme de plongeoir très marqué.

Certains passages nécessitent une bonne habileté en escalade.',
    'Lieu : haut Verdon en allant vers Castellane
Hauteur : 100m
Matériel : aucun
Posé : sur l''ilôt au milieur du Verdon
Première : Timothée Maurel et Pierre Lebreton le 21 octobre 2018',
    '',
    'assets/images/600px-Chasteuil627a59cab64835.39615204.png',
    1
  ),
  (
    'Clue de la Peine',
    'Alpes-de-Haute-Provence',
    'France',
    '45m',
    '00:20:00',
    '44.088231 , 6.389261',
    'Du centre de Tartonne, prendre la piste partant direction Nord-Ouest vers la clue de la Peine sur 3km et se garer en 44.088231 , 6.389261 juste avant le petit pont.

A pied, traverser le pont et prendre la piste directement à droite jusqu''à la clue.

Avant de passer la clue, monter le talus à gauche jusqu''à l''exit en 44.096974 , 6.392034 (via une espèce de petite fosse entre deux rochers).',
    'Spot vraiment joli et rapide.

Possibilité de poser sur la piste après avoir voler dans la clue .',
    '',
    'assets/images/600px-Cluedelapeine627a5aaae56f26.23123803.jpg',
    1
  ),
  (
    'Coréen Bleu',
    'Alpes-de-Haute-Provence',
    'France',
    '95m',
    '00:50:00',
    '44.444563 , 6.421808',
    'De Lauzet centre et en allant direction Barcelonette, prendre à gauche 150m avant la gendarmerie et suivre la route (elle traverse l''Ubay puis serpente assez fort) jusqu''en 44.444563 , 6.421808 et se garer sur le bord de la route.

De là, marcher en continuant sur la route jusqu''au hameau de Champ Contier.

Suivre le sentier de randonnée partant vers le Nord-Est en haut du Hameau. Celui va ensuite traverser le cours d''eau et remonter jusqu''au sommet du rocher où se trouve l''exit (Indication "Parual" sur la carte IGN). En haut et face au vide, descendre à droite jusqu''à l''exit, une petite dalle évidente après une zone d''arbres.',
    'Surplomb important en partie supérieur mais on ne peut pas en dire autant de la deuxième moitié.',
    '',
    'assets/images/400px-Coreenbleu627a5bced5e116.57386665.png',
    1
  ),
  (
    'Digne Recto',
    'Alpes-de-Haute-Provence',
    'France',
    '70m',
    '00:15:00',
    '',
    'De Digne les Bains, rouler en direction du "V" et tourner à gauche sur le chemin de Mouiroues (D19) au niveau du pont du Pigeonnier (voir carte IGN). Continuer jusqu''au premier chemin à gauche avec le portail et grimper la ligne de crête en partant directement de celui-ci (ne pas passer dans la propriété). L''exit se trouve au niveau d''un pilier vertical un peu avant le point haut. En se penchant et en regardant à droite on doit voir une via ferrata passer dans la face. (mais plusieurs départs de différentes hauteurs sur toute la barre).',
    'Ouverture synchronisée avec Pierre Lebreton sur Digne Verso, la barre rocheuse Sud du "V" :)',
    'https://www.youtube.com/watch?v=UarabtY97LE',
    'assets/images/600px-Dignerectoexit627a5cd4d8fab9.45496560.png',
    1
  ),
  (
    'Déferlante',
    'Alpes-de-Haute-Provence',
    'France',
    '150m',
    '01:30:00',
    '',
    'Se rendre à la station de la Foux d''Allos, de la place centrale, prendre la route qui monte vers le nord ouest de la station et les residance. Passer le cinéma puis des grand parkings. Se garer au fond de ceux-ci (ne pas monter à gauche vers la dernière résidence).

D''ici, marcher sur la piste reservée aux secours qui démarre du fond du parking et qui part rapidement à gauche. La suivre jusqu''à atteindre une première gare de téléphérique et prendre à droite à son niveau.

Il suffit ensuite de la continuer jusqu''au pied des aiguilles, de gravir le talus entre celle-ci et de monter sur l''aiguille de droite jusqu''au sommet.

L''exit se trouve sous le sommet (au niveau des piquets) sur une petite avancée sur laquelle il faudra descendre prudemment.',
    'Attention au différents câbles de remontées mécaniques.',
    '',
    'assets/images/400px-Foux627a5d785e6a58.67871340.jpeg',
    1
  ),
  (
    'East Coast Pérouré',
    'Alpes-de-Haute-Provence',
    'France',
    '100m',
    '00:40:00',
    '44.217262 , 6.27652',
    'De Digne les Bains, prendre direction Barles sur la D900a et rouler environ 15km jusqu''à la Clue du Pérouré.

Se garer sur le parking avant la Clue et continuer en marchant sur la route vers le nord.

Passer le pont et les tunnels de la Clue, puis un autre pont (celui de West Coast Pérouré), et seulement au pont suivant prendre le sentier à droite de l''entrée de celui-ci.

Suivre sentier de randonnée jusqu''au dessus de la Clue (environ au niveau du premier "é" de Pérouré sur l''IGN).

Traverser la végétation vers le Sud-Est pour rejoindre le vide.

L''exit est au niveau d''un petit "V" légèrement positif (44.217262 , 6.27652) au dessus de la grosse partie déversante. Départ de chaque côté du "V" au choix.',
    'Ambiance très sympa et bon dévers',
    '',
    'assets/images/East627a5e7e6fa6f2.95061275.jpg',
    1
  );
INSERT INTO base_things.`exit` (
    name,
    department,
    country,
    height,
    access_duration,
    gps_coordinates,
    acces,
    remark,
    video,
    image,
    active
  )
VALUES (
    'Educh',
    'Alpes-de-Haute-Provence',
    'France',
    '100m',
    '01:00:00',
    '',
    'Se garer dans les Scaffarels.

Traverser le pont vers le sud et prendre le chemin directement à gauche avec la barrière (qui monte à un entrepôt de matériel agricole).

Un sentier commence au dessus de l''entrepôt (difficile à trouver, s''aider de la carte IGN), une fois trouvé, le suivre jusqu''en haut via le Ravin d''Educh.

Sorti de ce ravin, couper vers le Nord-Ouest pour rejoindre l''extrémité gauche de la face Nord où se trouve les rochers.

L''exit est évident sur le plus gros des deux rochers (celui de gauche quand on est en haut face au vide).

Un cairn matérialise l''endroit exact.',
    'Départ en courant.',
    '',
    'assets/images/400px-Educhrochers627a5eeda4fa69.92101615.jpg',
    1
  ),
  (
    'Entrepierres W',
    'Alpes-de-Haute-Provence',
    'France',
    '75m',
    '00:30:00',
    '44.199896 , 5.984822',
    'De Entrepierres, rouler vers le Nord sur environ 700m et se garer après avoir passé la clue en 44.20263 , 5.986039.

Traverser la route puis monter dans le pierriers afin d''atteindre le point 44.200235 , 5.982732.

De là, tirer à l''Est dans la végétation pour trouver le vide et un exit (vers 44.199896 , 5.984822)',
    'Ligne Haute tension',
    '',
    'assets/images/400px-Entrepierrew627a5f52737240.93560508.png',
    1
  ),
  (
    'Estachon',
    'Alpes-de-Haute-Provence',
    'France',
    '50m',
    '00:30:00',
    '44.228511 , 6.045996',
    'De Saint-Geniez (04), sortir du village vers l''Est et tourner à droite à la patte d''oie en (44.244191 , 6.057117) comme pour rejoindre la zone d''atterrissage parapente Sud. Passer cette dernière et continuer environ 2km sur la même route puis se garer dans le virage en 44.223297 , 6.051551.

Marcher ensuite sur la piste partant Nord-Est juste après le virage. Arrivé au champs en 44.224201 , 6.046153, commencer à couper dans le talus en essayant de retrouver une petite sente qui vous guidera dans une faille de la barre où il est possible de monter sur le haut de la crête (je ne me souviens pas exactement de l''endroit exact de ce passage mais il me semble qu''il est pas loin de 44.225505 , 6.044274).

Une fois en haut, prendre à droite et suivre le vide direction Nord-Est sur environ 400m pour trouver l''exit en descendant une marche, environ en 44.228511 , 6.045996.',
    'Les premiers mètres sont plutôt positifs et pas évidents pour trouver un bon départ en static-line.',
    '',
    'assets/images/400px-Estachon627a60ce59d439.99792025.png',
    1
  ),
  (
    'Gorges de Saint-Pierre',
    'Alpes-de-Haute-Provence',
    'France',
    '120m',
    '01:45:00',
    '44.125999 , 6.618474',
    'De Beauvezer, traverser le Verdon par le pont et rouler vers Villars Heyssier, traverser le village puis aller tout au bout de la piste jusqu''au parking en 44.125402 , 6.613318.

Suivre le GR Tour du Haut Verdon, ne pas emprunter le pont en 44.122386 , 6.636631 et monter jusqu''en haut de la crête du Serre de l''Aï.

Une fois sur la crête, la suivre plein Ouest jusqu''au vide.

Il Faudra descendre plusieurs vires, puis une pente très raide composée de marches afin de pouvoir s''approcher de l''exit (environ en 44.125999 , 6.618474 ).',
    'Mise en place dangereuse, ne pas glisser.',
    '',
    'assets/images/400px-Saintpierre2627a611f059dc4.67703355.jpg',
    1
  ),
  (
    'Gravé dans la roche',
    'Alpes-de-Haute-Provence',
    'France',
    '70m',
    '00:30:00',
    '',
    'De Sisteron, prendre la direction de Saint-Geniez jusqu''aux petites gorges de la montagne de Gache. S''arrêter à la Pierre-écrite. Monter en suivant le sentier de randonnée, arrivé sur le chemin forestier (au niveau d''un gros arbre mort très beau) prendre à gauche et le suivre vers l''ouest. Il faudrat ensuite traverser la végétation pour rejoindre le vide.',
    'Exit évident au niveau d''un surplomb très marqué. Le mieux est de partir du rocher triangulaire à droite de la grosse dalle, et de pousser en direction de l''extrémité gauche du champ. Présence d''une vire 50m en dessous qui avance de 2m sous le saut et de 4-5m de chaque côté, bien tirer profit des 3 pas d''élan possibles.',
    'https://www.youtube.com/watch?v=1xdrrA8acVI',
    'assets/images/400px-Grave627a6194c016f6.98588943.png',
    1
  ),
  (
    'Gâche qui court',
    'Alpes-de-Haute-Provence',
    'France',
    '120m de verticale sur talus',
    '01:00:00',
    '',
    'De Sisteron, prendre la direction de Saint-Geniez, peu avant d''entrer dans le défilé de Pierre-Ecrite, se garer au panneau "Col de Fontebelle 16.9km" (voir photo) et prendre le chemin qui monte vers le Nord à côté. Arriver sur la ligne de crête intermédiaire (au niveau des clairière herbeuses) tirer à droite de façon a longer la clôture électrique par la gauche. Suivre le petit sentier jusqu''en haut (cairns). Au sommet, longer le vide vers l''Est jusqu''à trouver l''exit sur une dalle (voir photo).',
    'Départ en courant!!

En auto-navette, il faudra environ 1h20 pour revenir à la voiture en crapahutant dans les pierrier pour récupérer la ligne de crête intermédiaire et le sentier de l''aller.',
    'https://www.youtube.com/watch?v=jzxzkkhcQc8',
    'assets/images/400px-Gache1627a6386c31d37.51599921.jpg',
    1
  ),
  (
    'Génépi de l''Ubay',
    'Alpes-de-Haute-Provence',
    'France',
    '45m',
    '00:30:00',
    '44.400111 , 6.518102',
    'En arrivant par l''ouest et vers Barcelonnette, tourner à droite à la sortie de La Fresquière vers l''écomusée et emprunter la piste longeant l''Ubay sans la traverser. Se garer en 44.400111 , 6.518102.

Marcher pour remonter vers la Fresquière, traverser la D900 et continuer tout droit sur la petite route qui monte au hameau des Méans.

Dans le hameau, traverser le champs pour rejoindre le gîte le plus haut en lisière de bois et récupérer une sente (qui apparaît sur l''IGN) qui monte au sommet.

Au sommet, rejoindre la partie droite de la face sud où se trouve l''exit matérialisé par un arbre et une corde d''escalade.',
    'Lieu : Rocher de Roche Courbe, au dessus de la D900 et au niveau de Méolans.
Hauteur : 45m
Matériel : Cordelette et corde à casser
Posé : à la voiture
Première : Timothée Maurel et Pierre Lebreton en juin 2019 avec la contribution de Dgé Népi',
    '',
    'assets/images/genepi627a641c6ae242.91294484.png',
    1
  ),
  (
    'Géruen Vuvnir',
    'Alpes-de-Haute-Provence',
    'France',
    '140m',
    '01:20:00',
    '44.218083 , 6.178923',
    'De Authon, prendre la D3 vers le Sud et le col de Font Belle. Une fois au col, se garer sur un des parking.

Prendre la piste partant Nord-Nord-Ouest vers la montagne et la suivre jusqu''au bout où il faudra prendre le sentier à droite (44.223246 , 6.145919 voir IGN) qui mène sur la crête de Géruen.

En haut, longer le vide vers l''Est jusqu''à dépasser le sommet de Géruen (indiqué sur la carte) de environ 200m.

L''exit se trouve en 44.218083 , 6.178923 en descendant sur un pilier, quelques pas d''élan sont possibles dans un environnement caillouteux.

Peu de visuel sur le vide à cause de la partie positive directement sous l''exit. Une fois celle-ci passée, le dévers est très correct.

Retour à la voiture en descendant la petite piste jusqu''à trouver la grande piste forestière à suivre vers l''Ouest pour retourner au col.',
    'Lieu : Montagne de Géruen, grande barre rocheuse 18km à l''Est de Sisteron, à côté du petit village d''Authon
Hauteur : 140m
Matériel : Aucun
Posés : Technique sur une piste la plus proche de l''exit et peut-être d''autres endroits possibles
Première : Timothée Maurel, en avril 2021',
    '',
    'assets/images/geruen627a65e6392d17.89062990.jpg',
    1
  ),
  (
    'High Pérouré',
    'Alpes-de-Haute-Provence',
    'France',
    '100m',
    '01:15:00',
    '',
    'De Digne les Bains, prendre direction Barles sur la D900a et rouler environ 15km jusqu''à la Clue du Pérouré.

Se garer sur le parking avant la Clue et continuer en marchant sur la route vers le nord.

Passer le pont et les tunnels de la Clue, puis un autre pont (celui de West Coast Pérouré), et seulement au pont suivant prendre le sentier à droite de l''entrée de celui-ci.

Suivre sentier de randonnée en enroulant la barre où se trouve le saut par la droite.

Une fois derrière, il faudra quitter le sentier et traverser la végétation vers le Nord-Ouest afin de rejoindre le haut de la crête.

Une fois en haut, longer le vide vers le sud et descendre sur l''exit en dé-escaladant la petite barre rocheuse grâce à un arbre.',
    'Ambiance très sympa et sous voile grandiose!!!',
    '',
    'assets/images/600px-Highclue627a66657370e3.47487335.png',
    1
  ),
  (
    'Issioule Connexion',
    'Alpes-de-Haute-Provence',
    'France',
    '100m',
    '01:15:00',
    '',
    'De l’épingle 853m sur la RD952, prendre le sentier qui remonte le ravin du Brusc pour rejoindre le GR4. Le suivre vers le Nord jusqu’aux « points de vue ».
De l’exit wingsuit, regarder à gauche de l’autre côté du petit cirque se trouve une paroi dont le haut est bombé puis légèrement déversante jusqu’en bas. Un rocher assez caractéristique ressort du bombé (voir la photo), c’est l’exit !',
    'Exit alternatif à Issioule Saint Maurin pour les non-ailés, peut-être plus sur pour un glisseur bas que le classique et qui procure un sous-voile extraordinaire. Première suivie d''un "flyby" d''Adrien Lilamand, parti juste après en aile, de l''exit Wingsuit.',
    'https://www.youtube.com/watch?v=DlAQ6nMxfhM',
    'assets/images/400px-Issioule2627a66e91bcbb5.47333310.png',
    1
  );
INSERT INTO base_things.`exit` (
    name,
    department,
    country,
    height,
    access_duration,
    gps_coordinates,
    acces,
    remark,
    video,
    image,
    active
  )
VALUES (
    'L''ami GN',
    'Alpes-de-Haute-Provence',
    'France',
    '400m (160 de verticale), 1100m en aile',
    '02:00:00',
    '',
    'Depuis St Paul sur Ubaye, suivre sur 8 km la D25. Se garer au départ du sentier PR Vallon des Houerts (à gauche). Le suivre jusqu’au pied de la grande face 1h(non visible depuis la vallée) l’exit se situe au sommet du piler de droite. Contourner la paroi par la droite en bord de crête jusqu''à un col, de là, grimper à gauche jusqu’au point haut. Et redescendre de 50 m pour rejoindre une épaule. Quelques passages d’escalades faciles.

Accès difficile

Escalade Obligatoire

Vire 160m sous l’exit, saut de Pantz possible mais départ parfait et mise en vol rapide indispensable. Le pierrier en pied de face est un peu exploitable mais pas trop.(rp Guillaume Bernard)',
    'D’autres sauts à réaliser certainement.

Long vol à droite pour rejoindre la vallée, bonne finesse, attention au contre en cas de brise montante',
    '',
    'assets/images/',
    1
  ),
  (
    'L''écaille du tripotanus',
    'Alpes-de-Haute-Provence',
    'France',
    '110m',
    '00:30:00',
    '44.273071 , 6.039163',
    'Du village de Châteaufort (44.274591 , 6.017535), rouler vers l''Est et suivre la route jusqu''à une petite intersection avec un chemin avant le prieuré, en 44.268326 , 6.036729 et se garer.

De là, suivre le chemin vers le nord puis remonter le talweg dans la forêt en ayant l''écaille sur la gauche.

L''idée est de rejoindre le pied de face afin d''emprunter la vire (44.273071 , 6.039163) par une escalade facile.

Une fois en haut, des cordes permettent de rejoindre la crête.

Plusieurs exits possibles, l''original étant proche des débris de ce qui semble être une croix en bois (voir photo).',
    'Sous voile absolument magnifique.',
    '',
    'assets/images/600px-Tripo627a68f67484d1.79437582.png',
    1
  ),
  (
    'La chambre du roi',
    'Alpes-de-Haute-Provence',
    'France',
    'environ 100m (120m avec la projection)',
    '00:40:00',
    '',
    'Se garer à la gare d''Annot. Descendre la pente d''entrée de la gare et passer sous la voie à droite. De l''autre côté, prendre à droite puis tout droit jusqu''au départ du sentier de rando. Deux possibilité s''offre à vous, la rouge et la bleue (comme dans Matrix).

J''ai personnellement suivi le sentier bleu vers "La chambre du roi" qui contourne le massif par la droite et passe sous le saut. Une fois en haut, rejoindre le sud pour arriver au bord du vide. L''exit est évident (voir photos). Il y a une petite vire quelques mètres en dessous qui barre la vue mais sans aucune difficulté à franchir dans la projection. Vous aurez également une petite haie d''arbuste sur votre gauche.

Ici vous serez au dessus de la plus haute verticale disponible.',
    'Départ en courant superbe!! (mef, c''est tout de même bosselé)

Saut dévers en partie haute et positif en partie basse, même si 120m sont disponible, garder à l''esprit qu''un rangé ouvrira plus proche du mur qu''un à la main avec petit délais.

Les propriétaires de la maison et du gîte "Les aristochats" en face du posé sont vraiment très sympas et bienveillants quant à notre activité! Ils ont aussi du café :)

N''hésitez pas à leur passer le bonjour et à partager leur gîte!!',
    '',
    'assets/images/400px-Chambreduroiprofil627a695be40184.51056034.jpg',
    1
  ),
  (
    'La Sentinelle (Clue de Barles)',
    'Alpes-de-Haute-Provence',
    'France',
    '150m',
    '01:00:00',
    '44.232709 , 6.251391',
    'De Digne les Bains, prendre direction Barles sur la D900a et rouler environ 20km jusqu''à la Clue de Barles.

Dépasser la clue d''environ 700m et se garer en 44.240786 , 6.261316 sur le parking de la petite cabane publique.

Traverser la route et monter le talus en face pour trouver une piste que l''on prendra à gauche.

La suivre sur environ 2km en passant les fermes avec les vaches et jusqu''à une sorte de petit gîte en 44.242099 , 6.247714.

Continuer à suivre le chemin vers le Sud sur environ 600m et prendre à droite dans le talus en 44.237088 , 6.245965 (sentier présent sur l''IGN mais pas très visible sur le terrain).

Gravir la pente sur le chemin sur 200m et prendre à gauche à la patte d''oie puis suivre le chemin vers le sud.

Il va arriver face à un bois qu''il faudra traverser vers le sud pour rejoindre le vide.

Une fois sur la crête, prendre à gauche pour la longer vers l''Est jusqu''à l''exit environ en 44.232709 , 6.251391.',
    'Lieu : Face jaune bien remarquable, à gauche de l''entrée de la clue de Barles, en arrivant par le Sud.
Hauteur : 150m
Matériel : Aucun
Posés : risqué sur la route
Première : Timothée Maurel et Pierre Lebreton en juin 2019',
    '',
    'assets/images/600px-Sentinelle627a6a4c278377.84645362.png',
    1
  ),
  (
    'Le Duc',
    'Alpes-de-Haute-Provence',
    'France',
    '300 mètres',
    '01:00:00',
    '',
    'Le plus rapide avec une navette est de monter depuis Pont de Soleil à Trigance (rive gauche du Verdon) puis jusqu’à la Bastide Neuve où l’on quitte la D71 pour un chemin carrossable jusqu’à Entreverges. A pied rejoindre la ligne de crête puis la suivre facilement vers le nord jusqu’au sommet du Duc.

Descendre quelques mètres en contrebas du sommet vers le spot évident au-dessus du couloir Samson.',
    'Spot extraordinaire, fantastique visuel en chute et sous voile mais spot très difficile à haut niveau d’engagement et de risque, réservé à des paralpinistes confirmés. Ne pas trop chuter pour pouvoir rejoindre la zone de posé et préférer une orientation à droite à une à gauche ! qui vous enverrait direct dans le défilé (posé impossible et noyade possible). Ne tenter ce saut que lorsque le niveau d’eau est faible.',
    'https://www.youtube.com/watch?v=KXonLi9QNoE',
    'assets/images/400px-Leducexit627a6bd8e3a5d0.31577990.png',
    1
  ),
  (
    'Le Teillon',
    'Alpes-de-Haute-Provence',
    'France',
    '50m',
    '01:00:00',
    '43.829426, 6.563258',
    'De La Garde, prendre vers l''EST et se garer en 43.829426 , 6.563258 en sortant du village. Prendre la piste montant à la Chapelle St-Martin. Arrivé à celle-ci, suivre le sentier montant au pieds de la falaise. Une fois dessous, enrouler la falaise par le sentier à gauche ou les pierriers à droite.

Dans les deux cas, une partie de l''accès se fait à l''instinct à travers la végétation.

Arrivé en haut, chercher un exit dans une des belles cassures très droites.',
    'Lieu : Falaise matérialisant l''extrémité Ouest de la crête du Teillon, à la sortie Est de La Garde (04).
Hauteur : 50m
Matériel : cordelette et corde à casser
Posés : Champs
Première : Timothée Maurel en septembre 2019',
    '',
    'assets/images/400px-Teillon627a6c790bd6a8.88323061.png',
    1
  ),
  (
    'Le Vallonet',
    'Alpes-de-Haute-Provence',
    'France',
    '50m',
    '00:15:00',
    '44.225298, 6.268712',
    'De Digne les Bains, prendre direction Barles sur la D900a et rouler environ 18km jusqu''au pont en 44.225298 , 6.268712. (Du tunnel de la clue du Pérouré, c''est le 3ème pont).

Se garer à gauche avant le pont.

Traverser le pont et monter à travers la végétation pour atteindre la partie haute de la barre où plusieurs exits sont possibles.',
    'Lieu : Petite barre au bord à gauche de la D900a, entre la Clue du Pérouré et celle de Barles
Hauteur : 50m
Matériel : Cordelette et corde à casser
Posés : risqué sur la route
Première : Timothée Maurel et Pierre Lebreton en juin 2019',
    '',
    'assets/images/600px-Vallonet627a6ce9de31d3.68632298.png',
    1
  ),
  (
    'Les Cadières de Brandis',
    'Alpes-de-Haute-Provence',
    'France',
    '90m',
    '02:00:00',
    '',
    'Plusieurs options sont possibles :

- Avec navette : Aller au col des Lèques via Castellane. De là prendre une piste carrossable qui pars plein sud vous amenant jusqu’à la crête de Colle Bernaiche (proche des antennes relais). Laisser votre voiture dans ce cul de sac. Suivre le petit sentier de rando qui part plein ouest. Le chemin vous amène derrière cette falaise en forme de rempart.

- Auto-navette en partant du hameau de Villard-Brandis, où un sentier monte aux antennes etc... rajouter 40-45min.',
    'Un endroit sympa, belle vue sur la vallée; gros départ en courant possible.',
    '',
    'assets/images/cadiere627a75c68769a2.08349097.png',
    1
  );


INSERT INTO base_things.`exit` (
    name,
    department,
    country,
    height,
    access_duration,
    gps_coordinates,
    acces,
    remark,
    video,
    image,
    active
  )
VALUES (
    'y',
    'Ain',
    'France',
    '2',
    '00:00:00',
    '',
    'd',
    '',
    '',
    'assets/images/',
    1
  ),
  (
    'e',
    'Ain',
    'France',
    '1',
    '00:00:00',
    '',
    'd',
    '',
    '',
    'assets/images/',
    0
  ),
  (
    'Le Mollard',
    'Isère',
    'France',
    'entre 160 et 700 mètres',
    '00:10:00',
    '',
    'De Grenoble se diriger vers Seyssins et Pariset. Prendre la D106b vers Saint Nizier. Avant d’y arriver prendre à droite au niveau du mémorial du Vercors vers le Mollard. Se garer au niveau d’une grande antenne. Descendre les champs en contrebas en tirant légèrement à gauche pendant moins de 10 minutes. On rejoint un petit chemin étroit qui longe la falaise. Le suivre à gauche pendant quelques minutes avant de bifurquer à droite au niveau du spot. On repère facilement, sur la droite, l’exit en forme de plongeoir.',
    'AutoNav (Version écolo) : 0h25 aller / 0h25 retour\r\nMême itinéraire que le classique mais s\'arrêter plus bas, 500m après la sortie de Seyssinet Pariset, petit parking avant une épingle à gauche. Le sentier qui part dans l\'épingle monte directement au Mollard. On peut plier quelques minutes après le départ dans un petit près en pente (à la fourche qui suit prendre le chemin de droite).\r\n\r\nDepuis l\'attéro, remonter jusqu\'à la ruine de la \"ferme des visons\", prendre à droite derrière celle-ci en direction des trois pucelles. Après les premières maisons 5/10 minutes plus tard, prendre un chemin dans un virage à droite. On traverse plus loin un pré entre deux clôtures. A la sortie de celui-ci prendre à droite jusqu\'à la voiture.\r\n\r\nPour résumer, la trace GPX\r\n\r\nInfo Aile\r\nDépart court et plat. Finesse 2,5 obligatoire. Posés pas évidents entre pied de montagne et ville. Parking du cimetière ou champs de particuliers.',
    '',
    'assets/images/800px-MollardFace627a6e9166d5b1.67494553.jpg',
    1
  ),
  (
    'La Fesse',
    'Isère',
    'France',
    '250 mètres',
    '00:25:00',
    '',
    'De Grenoble prendre la N532 jusqu\'à St Quentin sur Isère, puis prendre la route de Montaud. Après 4 km, tourner à gauche direction «les maîtres». Se garer à l\'entrée du hameau pour ne pas déranger les habitants, puis aller au bout de la voie sans issue. Continuer par le chemin principal qui longe les prés (C\'est celui de gauche). Entrer dans la forêt et prendre à gauche aux 2 principales bifurcations. Un peu avant que le chemin passe au bord de la falaise, prendre à gauche une sente (flèche rouge) au niveau de 2 arbres présentant des marques. Tirer légérement à gauche, vous allez traverser facilement une énorme faille. Le spot sur la pointe à droite juste après.',
    'Exit\r\nDépart statique ou en courant sur une belle plateforme. A noter qu\'il y a plusieurs départs possibles le long de cette longue falaise.',
    '',
    'assets/images/500px-La_fesse627a6f3e8db178.07185449.jpeg',
    1
  ),
  (
    'Bournillon',
    'Isère',
    'France',
    'entre 400 et 700 mètres',
    '00:10:00',
    '',
    'De Choranche suivre la route des gorges vers Villard de Lans. A l\'entrée de la «Balme de Rencurel» prendre à droite jusqu\'à St Julien en Vercors. A la sortie du village, prendre à droite la direction St Martin en Vercors par le Briac. A la 1ère bifurcation prendre à droite direction «les Alberts» puis à nouveau à droite direction «les Combettes». Au terminus de la route on trouve une ferme. Se garer 50 mètres plus loin à une bifurcation. Prendre le chemin de droite, passer une 1ère bifurcation puis une 2eme. Prendre à gauche à le troisième. On suit ce large chemin jusqu\'à une courte remontée d\'une 10e de mètres. Suivre alors à gauche une petite sente à travers un sous bois. Le spot est quelques dizaines de mètres plus loin sur la gauche.',
    'Info ailes\r\nDénivelé 700m, 0.8km jusqu’au champ à coté de la centrale (attention aux grille pain !)',
    '',
    'assets/images/Bourni627a70928d55a5.49632572.jpg',
    1
  ),
  (
    'Molaire Blues',
    'Isère',
    'France',
    'entre 300 et 800 mètres',
    '00:30:00',
    '',
    'Après le hameau de Charmeil prendre à droite jusqu\'au parking situé au terminus de la route avant le gîte de Bernard Gravier.',
    'Info ailes\r\nDénivelé 800m, finesse 1.8',
    '',
    'assets/images/Molaireblues627a7101a4c168.85428851.jpg',
    1
  ),
  (
    'Courage Malko',
    'Isère',
    'France',
    'entre 260 et 700 mètres',
    '00:30:00',
    '',
    'Ce spot est le meilleur que je connaisse pour débuter en falaise à condition de partir de la vire située 15 mètres sous le départ sommital juste au-dessus des gigantesques toits de la conque. L\'axe de poussée offrant le meilleur dévers est en direction du barrage.\r\n\r\nEdit 2021: le meilleur spot pour débuter le glisseur haut est sans conteste le Brento qui à hauteur d\'ouverture offre le triple de distance de la paroi par rapport à la Conque, si votre choix est la sécurité d\'abord il n\'y a pas d\'autre choix possible.',
    'Attention\r\nZone de posé très sensible !\r\n\r\nLa seule zone de posé autorisée est indiquée sur la photo\r\nNe pas se poser dans la zone où peuvent se trouver des animaux\r\nNe pas se poser sur la route des grottes de Choranche (route privée et passante)\r\nNe pas survoler les différentes maisons\r\nMerci de ne pas crier pour respecter la tranquillité des riverains et des pêcheurs\r\nL\'absence de la manche à air signifie : Interdiction de se poser et donc de sauter (période de fauche)',
    '',
    'assets/images/400px-Molaireblues627a7178da0ac6.01989158.jpg',
    1
  ),
  (
    'Dent de Crolles (Impulsator)',
    'Isère',
    'France',
    'entre 350 et 1800 mètres',
    '01:00:00',
    '',
    'De Grenoble prendre la N90 vers Chambéry puis après Saint Ismier la D30 vers saint Pancrasse. Après 6 km bifurquer à gauche direction en direction du col du Coq. Se garer 300 mètres avant le col et suivre le chemin jusqu’au sommet de la dent de Crolles. Le spot se situe environ 70 mètres à gauche de la croix sur une vire quelques mètres en contrebas de la crête\r\n\r\nEn lisse, bien penser à pousser direction St Pancrasse (village à droite sur le plateau quand on est à l\'exit).',
    'Info ailes\r\nDénivelé 1800m, finesse 2. Ca part du haut sans matos. Pour ceux qui font de la proxi vers les émetteurs et qui enroule le caillou à gauche, pensez à l’inévitable présence de parapentiste sous les émetteurs, surtout entre 11h et 16h. Et pour tous ceux qui partent du départ des ailes, pensez à toujours regarder s’il n\'y a pas un parapentiste dans la face.\r\n\r\nRemarques\r\nATTENTION AUX PARAPENTES!!\r\n\r\nIl y a une grosse vire environ 60 mètres sous le sommet. Elle passe très bien mais réserve ce spot à des paralpinistes confirmés, Attention en lisse le saut se referme beaucoup sur la gauche à hauteur d\'ouverture ! . Spot de grande qualité.',
    '',
    'assets/images/DDC627a722338e988.15002305.jpg',
    1
  ),
  (
    'Purée Vertébrale',
    'Isère',
    'France',
    '300 mètres pour le spot original, 450 mètres sous la croix et 1100 mètres au max',
    '01:45:00',
    '',
    'De Chambéry monter au col du Granier puis à la station du Granier et enfin à la Plagne (terminus voiture). Suivre un bon chemin jusqu’au sommet du Granier. Il est possible de monter plus directement le long de la piste de ski par un raide sentier. Du sommet, pour le spot original suivre la crête vers l’est jusqu’à une partie jaune bien visible du col du Granier. Ce spot n’est actuellement plus pratiqué au profit de la superbe variante ouverte par Franck Konrad juste sous la croix sommitale. Descendre 15 mètres sous cette dernière pour atteindre une vire bien marquée.\r\n\r\nUn nouvel exit, 100 mètres avant la croix, a été réalisé par Nicolas Joubert fin juin 2004. Cela augmente encore un peu la hauteur du saut et la vire passe très bien en dérive.',
    '900m de dénivelé jusqu’au posé classique, 1100m jusqu’au virage dans la route à droite, 2.5 de finesse pour ce dernier saut.\r\n\r\nSuite à l\'éboulement d\'une partie de la falaise, le spot d\'origine est amputé !\r\n\r\nLe Maire de Chapareillan impose des restrictions d\'accès au Granier : http://www.chapareillan.fr/fr/urbanisme-travaux-environnement/environnement/eboulement-du-granier/eboulement-du-granier.htm\r\n\r\nPrudence !',
    '',
    'assets/images/800px-Granier627a72bbbaf320.11808891.jpg',
    1
  ),
  (
    'Roche Cordant',
    'Isère',
    'France',
    'entre 160 et 550 mètres',
    '00:05:00',
    '',
    'De Bourg d’Oisans suivre la D219 en direction de Villard Notre Dame. Se garer dans l’épingle 500 mètres après « Le Creux ». Redescendre 200 mètres sur la route jusqu’à une amorce de chemin à droite. Prendre droit dans les bois, 50 mètres en contrebas, le spot est derrière une butte (corde en place).\r\n\r\nPossible en auto navette (compter environ 2h) : du posé prendre le chemin qui passe à côté de la cascade de la Pisse et qui remonte le vallon jusqu\'à Villard Notre Dame.',
    'Saut positif : départ en courant et bonne dérive utiles !',
    '',
    'assets/images/450px-Roche_Cordant627a73d8ae07b9.06119599.jpg',
    1
  );






-- --------------------------------------------
-- Ajout de données dans la table role
-- --------------------------------------------
INSERT INTO `role` (name, `read`, `write`, `delete`)
VALUES ('Administrateur', 1, 1, 1),
  ('Utilisateur', 1, 0, 0),
  ('Invité', 0, 0, 0);
-- --------------------------------------------
-- Ajout de données dans la table type_jump
-- --------------------------------------------
INSERT INTO type_jump (name)
VALUES ('Static-line'),
  ('Sans Glisseur'),
  ('Lisse'),
  ('Track Pantz'),
  ('Track Pantz Monopièce'),
  ('Wingsuit');
-- --------------------------------------------
-- Ajout de données dans la table user
-- --------------------------------------------
INSERT INTO `user`
VALUES (
    1,
    'Cécé de la voile',
    'Chaton69',
    'Russier',
    'Célie',
    '1986-04-15',
    'celie.russier@gmail.com',
    '17 Rue Delandine, 69002 Lyon',
    1
  ),
  (
    2,
    'Chris du grand saut',
    'Gargamel69',
    'Cuzin',
    'Christopher',
    '1991-01-01',
    'ed.ed1009@hotmail.fr',
    '17 Rue Delandine, 69002 Lyon',
    1
  ),
  (
    3,
    'Gautier le Sans Glisseur',
    'Mistefrizz69',
    'Fondevila',
    'Gautier',
    '1870-12-24',
    'fondevila.gautier@gmail.com',
    '17 Rue Delandine, 69002 Lyon',
    1
  ),
  (
    4,
    'Antho reste en bas',
    'Lola69',
    'Gouton',
    'Anthony',
    '1988-07-20',
    'anthony.gouton.wcs@gmail.com',
    '17 Rue Delandine, 69002 Lyon',
    1
  ),
  (
    5,
    'Max la menace',
    'Lorel73',
    'Robert',
    'Maxime',
    '1985-04-22',
    'maxlamenace@gmail.com',
    '2-14 Rue du Sénat de Savoie, 73000 Chambéry',
    2
  ),
  (
    6,
    'Hortense la balance',
    'LoupBoutin38',
    'Louïson',
    'Hortense',
    '1990-06-05',
    'labalance@outlook.com',
    '1 Pl. aux Herbes, 38000 Grenoble',
    2
  ),
  (
    7,
    'Le caskouyeu',
    'Beton74',
    'Rodriguez',
    'Benjamin',
    '1986-01-16',
    'benjadu74@live.fr',
    '26 Rue Royale, 74000 Annecy',
    2
  ),
  (
    8,
    'a',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    9,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    10,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    11,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    12,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    13,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    14,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    15,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    16,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    17,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    18,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    19,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    20,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    21,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    22,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    23,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    24,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    25,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    26,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    27,
    'Gautier',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  );
-- --------------------------------------------
-- Ajout de données dans la table exit_has_type_jump
-- --------------------------------------------
INSERT INTO exit_has_type_jump (id_exit, id_type_jump)
VALUES (2, 1),
  (3, 1),
  (6, 1),
  (8, 1),
  (10, 1),
  (1, 2),
  (4, 2),
  (5, 2),
  (6, 2),
  (9, 2);
INSERT INTO exit_has_type_jump (id_exit, id_type_jump)
VALUES (10, 2),
  (7, 4),
  (7, 6),
  (8, 6);
-- --------------------------------------------
-- Ajout de données dans la table jump_log
-- --------------------------------------------
INSERT INTO `jump_log`
VALUES (
    1,
    5,
    '2022-03-13',
    4,
    1,
    'non',
    'oui',
    'oui',
    'Ensoleillé',
    '5 km/h',
    'https://www.youtube.com/watch?v=mVzEf03SRZM',
    'https://cdn.radiofrance.fr/s3/cruiser-production/2018/06/db6e5b18-96ae-4985-a3e8-7a31d276c43a/870x489_maxnewsworldfour116523.jpg',
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'
  ),
  (
    2,
    7,
    '2022-03-15',
    6,
    3,
    'oui',
    'oui',
    'oui',
    'Nuageux',
    '10 km/h',
    'https://www.youtube.com/watch?v=yP87mNNsc04',
    'https://img.redbull.com/images/c_crop,w_5373,h_2687,x_0,y_749,f_auto,q_auto/c_scale,w_1200/redbullcom/2018/07/17/3f339a63-f019-4f4d-9b27-261e9333e20f/base-jumping-collection',
    'But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?'
  ),
  (
    3,
    7,
    '2022-03-17',
    3,
    2,
    'non',
    'non',
    'non',
    'Ensoleillé',
    'Pas de vent',
    'https://www.youtube.com/watch?v=nEDg0QaniU8',
    'https://i2.wp.com/dicodusport.fr/wp-content/uploads/2016/01/base-jump.jpg?fit=1000%2C600&ssl=1',
    'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.'
  ),
  (
    4,
    6,
    '2022-04-02',
    3,
    5,
    'oui',
    'non',
    'non',
    'Neige',
    '15 km/h',
    'https://www.youtube.com/watch?v=FNdzA_UUdIc',
    'https://img.redbull.com/images/c_limit,w_1500,h_1000,f_auto,q_auto/redbullcom/2014/02/03/1331631564233_13/base-jump-super-photos',
    'On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.'
  ),
  (
    5,
    6,
    '2022-04-10',
    8,
    2,
    'non',
    'oui',
    'non',
    'Ensoleillé',
    '20 km/h',
    'https://www.youtube.com/watch?v=TcWMZq8-3wI',
    'https://resize-europe1.lanmedia.fr/r/622,311,forcex,center-middle/img/var/europe1/storage/images/europe1/faits-divers/savoie-une-americaine-se-tue-lors-dun-saut-en-base-jump-2818612/28394182-1-fre-FR/Savoie-une-Americaine-se-tue-lors-d-un-saut-en-base-jump.jpg',
    'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?'
  ),
  (
    6,
    5,
    '2022-04-11',
    5,
    3,
    'oui',
    'oui',
    'oui',
    'Nuageux',
    '10 km/h',
    'https://www.youtube.com/watch?v=JQy_ZhYkn_Q',
    'http://p9.storage.canalblog.com/90/85/752510/108253189_o.jpg',
    '2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.'
  ),
  (
    7,
    5,
    '2022-04-12',
    5,
    1,
    'oui',
    'oui',
    'oui',
    'Ensoleillé',
    'Pas de vents',
    'https://www.youtube.com/watch?v=1f6vgfJJrtY',
    'https://res.cloudinary.com/serdy-m-dia-inc/image/upload/w_800,c_limit/legacy_espaces//var/data/gallery/photo/49/75/46/66/15/63433.jpg',
    'going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined c'
  ),
  (
    8,
    6,
    '2022-04-12',
    7,
    1,
    'non',
    'non',
    'oui',
    'Nuageux',
    '15 km/h',
    'https://www.youtube.com/watch?v=dnjHm6WyaAc',
    'https://photos.tf1.fr/1200/720/base-jump-les-coulisses-du-saut-vertigineux-de-fred-fugen-f3e741-0@1x.jpg',
    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through'
  ),
  (
    9,
    6,
    '2022-04-13',
    1,
    3,
    'oui',
    'oui',
    'non',
    'Mitigé',
    '5 km/h',
    'https://www.youtube.com/watch?v=F1fJRz4iWqs',
    'https://assets.letemps.ch/sites/default/files/styles/article_detail_mobile/public/media/2021/09/28/file7hqia0tf3hk48ydagbw.jpg?h=041512b1&itok=P_FXLQG3',
    'If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary'
  ),
  (
    10,
    1,
    '2022-04-13',
    2,
    4,
    '',
    '',
    '',
    'Ensoleillé',
    'Pas de vents',
    'https://www.youtube.com/watch?v=ta1S1XUofr8',
    'https://leparisien.fr/resizer/kobCPgWZdbhDqbaNq1njS6wbG-w=/1200x675/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/NMIAISVEX7H6P6MDUPNS23O3JI.jpg',
    'consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences'
  ),
  (
    12,
    9,
    '2017-04-03',
    51,
    2,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    13,
    10,
    '2017-04-04',
    51,
    2,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    14,
    11,
    '2017-04-08',
    51,
    2,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    15,
    12,
    '2017-04-08',
    55,
    2,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    16,
    13,
    '2017-04-15',
    55,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    17,
    14,
    '2017-04-16',
    55,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    18,
    15,
    '2017-04-19',
    54,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    'Pas bien de faire ce saut en lisse ...'
  ),
  (
    19,
    16,
    '2017-04-19',
    54,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    20,
    17,
    '2017-05-21',
    54,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    21,
    18,
    '2017-05-21',
    54,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    22,
    19,
    '2017-05-26',
    54,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    23,
    20,
    '2017-05-26',
    54,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    24,
    21,
    '2017-05-26',
    54,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    25,
    22,
    '2017-06-10',
    56,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    26,
    23,
    '2017-06-24',
    54,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    27,
    24,
    '2017-06-24',
    53,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    28,
    25,
    '2017-08-27',
    57,
    3,
    'Zak 3',
    'Troll 305',
    '',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    29,
    26,
    '2019-05-10',
    58,
    4,
    'Zak 3',
    'Troll 305',
    'Phoenix-Fly - Regular',
    '',
    '',
    '',
    '',
    ''
  ),
  (
    30,
    27,
    '2019-05-30',
    56,
    4,
    'Zak 3',
    'Troll 305',
    'Phoenix-Fly - Regular',
    '',
    '',
    '',
    '',
    ''
  );
