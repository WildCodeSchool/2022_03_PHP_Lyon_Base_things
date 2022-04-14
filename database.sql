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


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `item`
--

INSERT INTO `item` (`id`, `title`) VALUES
(1, 'Stuff'),
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
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

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
  `comment` TEXT,
  `video` TEXT,
  PRIMARY KEY (`id`));


-- --------------------------------------------
-- Création de la table type_jump
-- --------------------------------------------
CREATE TABLE `type_jump` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`));


-- --------------------------------------------
-- Création de la table exit_has_type_jump
-- --------------------------------------------
CREATE TABLE `exit_has_type_jump` (
  `id_exit` INT NOT NULL,
  `id_type_jump` INT NOT NULL,
  PRIMARY KEY (`id_exit`,`id_type_jump`),
  CONSTRAINT fk_exit_has_type_jump_exit
  FOREIGN KEY (id_exit)             
  REFERENCES `exit`(id),
  CONSTRAINT fk_exit_has_type_jump_type_jump
  FOREIGN KEY (id_type_jump)             
  REFERENCES type_jump(id));


-- --------------------------------------------
-- Création de la table role
-- --------------------------------------------
CREATE TABLE `role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `read` BOOL NOT NULL,
  `write` BOOL NOT NULL,
  `delete` BOOL NOT NULL,
  PRIMARY KEY (`id`));


-- --------------------------------------------
-- Création de la table user
-- --------------------------------------------
CREATE TABLE `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pseudo` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(150) NOT NULL,
  `first_name` VARCHAR(150) NOT NULL,
  `date_of_birth` DATE,
  `email` VARCHAR(320) NOT NULL,
  `postal_adress` TEXT,
  `id_role` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT fk_user_role
  FOREIGN KEY (id_role)             
  REFERENCES role(id));


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
  CONSTRAINT fk_jump_log_user
  FOREIGN KEY (id_user)         
  REFERENCES `user`(id),
  CONSTRAINT fk_jump_log_exit
  FOREIGN KEY (id_exit)             
  REFERENCES `exit`(id),
  CONSTRAINT fk_jump_log_type_jump
  FOREIGN KEY (id_type_jump)             
  REFERENCES `type_jump`(id));

-- --------------------------------------------
-- FIN DE CREATION DES TABLES
-- --------------------------------------------


-- --------------------------------------------
-- JEU DE DONNEES POUR BASE THINGS
-- --------------------------------------------

-- --------------------------------------------
-- Ajout de données dans la table exit
-- --------------------------------------------
INSERT INTO `exit` (name,department,country,height,access_duration,gps_coordinates,comment,video) VALUES
   ('Barre de la Clue','Alpes Maritimes','France','150m +','00:20:00','43.974205,6.998488','Se rendre au village de Rigaud dans les gorges du Cians et se garer au cimetière.

Monter par la route qui part le plus à gauche de celui-ci. Arrivé sur le plateau, passer la maisons qui élève des chiens, après la fontaine d''eau potable un chemin privé part sur la gauche.

Le suivre en restant discret. Environ en 43.974205 , 6.998488 quitter le sentier vers l''Est et traverser la végétation dense vers l''exit, environ en 43.975625 , 7.003191 (progression pas facile).','https://www.base-jump.org/topo/images/thumb/c/cf/Clue.png/400px-Clue.png'),
   ('Bambi','Alpes Maritimes','France','65m','00:30:00','44.126244,6.872327','De Guillaumes, prendre à droite à la sortie Nord du village après la gendarmerie afin de monter au hameau de Bouchanières via la D75 et ce garer au centre de ce dernier.

Marcher vers l''Est sur 150m et prendre la sente à droite dans le virage avant les maisons (44.121121 , 6.868792).

La sente arrive sur une piste, prendre à droite et marcher jusqu''à une grande ferme (Geyrard sur l''IGN).

Avant la ferme, prendre le sentier balisé à gauche et le suivre jusqu''à ce qu''il passe dans un grand découvert en haut(44.126244 , 6.872327).

Traverser le découvert plein Ouest et rentrer dans la forêt.

Il suffit maintenant de marcher dans la forêt vers le Sud jusqu''au vide.

Le saut se trouve juste à droite du "V" qui coupe la face, sur une vire.','https://www.base-jump.org/topo/images/thumb/f/f5/Bambi.jpg/400px-Bambi.jpg'),
   ('Cascade de Clars','Alpes Maritimes','France','60m','00:10:00','43.743690,6.753011','De Séranon, rouler sur la D6085 vers Escragnolles pendant 6.5km et s''arrêter sur la droite de la route en 43.74369 , 6.753011.

De la, prendre le petit sentier qui descend vers le Sud sur 100m et prendre à droite sur une petite sente quand le sentier passe Est et dans un petit bois (voir photo).

Ensuite, marcher plein Sud jusqu''à la cascade. L''exit est facile à trouver, juste à gauche de la cascade sur une petite pointe.

Retour en contournant la cascade par la droite (sentier).','https://www.base-jump.org/topo/images/thumb/3/34/Clars.jpg/400px-Clars.jpg'),
   ('Castel Tournou','Alpes Maritimes','France','70m','01:00:00','44.115727,7.617391','De Tende, prendre la route allant aux Granges de la Pia par le Vallon du Réfrei et se garer environ en 44.115727 , 7.617391 avant le hameau.

Marcher en suivant la piste principale allant aux Granges de la Pia puis trouver le sentier de rando montant au Castel Tournou.

Arriver sous le saut, on monte par la droite et on rejoint facilement le bord où plusieurs exit sont possibles.','https://www.base-jump.org/topo/images/thumb/d/d6/Castel_Tournou.jpg/400px-Castel_Tournou.jpg'),
   ('Chanabasse','Alpes Maritimes','France','de 70m à 90m','01:00:00','44.146421,6.833376','Dans le grand virage à gauche avant d''arriver à Chateauneuf d''Entraunes, tourner à droite et prendre la route partant vers le Nord, qui se transforme ensuite en piste après la chapelle.

Rouler sur la piste sur environ 1.5km et se garer dans le virage en 44.13944 , 6.836861.

Continuer la piste en marchant et prendre le sentier de rando à gauche 100m plus loin.

Lorsque celui-ci arrive sur un autre sentier (à flanc d''une paroie, en 44.13944 , 6.836861), prendre à droite et continuer jusqu''au prochain carrefour de sentier, sur le replat dans la forêt en 44.146421 , 6.833376.

Prendre à gauche ici et vers l''Ouest puis le Sud jusqu''au sommet du rocher (Chanabasse sur la carte IGN).

Plusieurs exits possibles, l''original se trouve en descendant sur la gauche pour trouver une vire confortable. Ici le rockdrop est d''environ 75m et il y a 3 pas d''élan possibles.

D''autres départs sont envisageables, mais attention la paroi n''est pas régulière, surtout vers les hauteur d''ouverture.','https://www.base-jump.org/topo/images/thumb/d/d2/Chanabasse.jpg/400px-Chanabasse.jpg'),
   ('Chaudan','Alpes Maritimes','France','60m','00:30:00','44.033201,6.825770','De Daluis, rouler 1.5km en direction de Guillaumes (vers le nord) et se garer sur le bord de la route (44.033201 , 6.82577 par exemple).

On a ici un bon visuel du saut.

Marcher maintenant sur la route vers le sud afin de rejoindre l''autre côté de la crête où se trouve le saut et proche d''un petit parking, monter dans le talus afin de rejoindre l''exit à vue.','https://www.base-jump.org/topo/images/thumb/5/55/Chaudan.jpg/400px-Chaudan.jpg'),
   ('Amphibolite Brumeuse','Belledonne','France','Entre 220m et 2000m!!','04:00:00','45.142400,5.988160','4 heures de montée et 1h30 pour redescendre dans la vallée.

Départ de Pré Conté (906m) au-dessus de St Mury, ou de Pré Marcel (1290m) au dessus de St Agnès. Possibilité de dormir au refuge Jean Collet (1970m). Rejoindre le lac Blanc, puis monter vers le glacier de Freydane puis par les rochers ou un névé, atteindre le col de la Balmette au Nord. Le col de la Balmette 2650m est le col situé au pied de l''arête N du Grand Pic. Emprunter la voie normale jusqu’au sommet (nombreux itinéraires possibles, se redescend également sans corde, un seul passage «délicat»). De la croix sommitale, parcourir l’arête 15m au Nord pour descendre de 20m en désescalade (facile mais rochers instables) pour atteindre une dalle où l’on s’équipe: exit. Spit sortie de voie+corde en place qui permet tout juste de voir la pierre taper à 7s dans le névé supérieur de la face N (pas de bruit!!) bien visible sur les photos.  Monter un brin de 15m en plus pour pouvoir voir la face.

Départ Versant Allemont depuis le lieu dit Le Mollard conseillé pour le saut en WS. 4h en quasi autonavette.','https://youtu.be/AG_3-KLHpM0'),
   ('Aiguillette Saint Michel','Chartreuse','France','Une static line (flèche verte) 80m maxi, Un saut d''aile (flèche rouge)','01:25:00',NULL,'Depuis le col de Marcieu, monter sur le plateau par le pas du ragris ou le pas de l''aulp du seuil. Monter à la station au sommet, le glisseur bas est évident.

Pour atteindre le saut de wingsuit descendre sur le gros pilier plein sud, 2 pas équipés de cordes à descendre un peu expos.','https://www.base-jump.org/topo/images/thumb/e/ef/Aiguillette.png/400px-Aiguillette.png'),
   ('Fou Allier !','Haute Loire','France','75 mètres de verticale, 100 jusqu’au posé','00:10:00',NULL,'Bien vérifier l’axe de départ, en cas de grosse orientation à gauche les réflexes doivent être au rendez vous! ',NULL),
   ('Bon dieu de Bon Dieu','Vaucluse','France','50m','00:20:00','43.769291,5.347224','De Lourmarin centre, rouler en direction de Apt et, à la sortie du village, tourner à gauche sur Chemin du Pierrouret.

On passe devant la station d''épuration et des containers à ordures.

Environ 1km après ces derniers, se garer au bord de la route (en 43.769291 , 5.347224).

Suivre le GR 97 vers le nord et, arrivé dans le talweg derrière le saut (environ 43.769291 , 5.347224), monter le talus à travers la végétation jusqu''au vide.

Il est ensuite facile de trouver un exit convenable. Cordelette présente pour indiquer l''exit original.','https://www.base-jump.org/topo/images/thumb/8/86/Bondieu.jpg/400px-Bondieu.jpg');


-- --------------------------------------------
-- Ajout de données dans la table role
-- --------------------------------------------
INSERT INTO `role` (name,`read`,`write`,`delete`) VALUES
   ('Administrateur',1,1,1),
   ('Utilisateur',1,0,0),
   ('Invité',0,0,0);


-- --------------------------------------------
-- Ajout de données dans la table type_jump
-- --------------------------------------------
INSERT INTO type_jump (name) VALUES
   ('Static-line'),
   ('Sans Glisseur'),
   ('Lisse'),
   ('Track Pantz'),
   ('Track Pantz Monopièce'),
   ('Wingsuit');


-- --------------------------------------------
-- Ajout de données dans la table user
-- --------------------------------------------
INSERT INTO `user` (pseudo,last_name,first_name,date_of_birth,email,postal_adress,id_role) VALUES
   ('Cécé de la voile','Russier','Célie','1986-04-15','celie.russier@gmail.com','17 Rue Delandine, 69002 Lyon',1),
   ('Chris du grand saut','Cuzin','Christopher','1991-01-01','ed.ed1009@hotmail.fr','17 Rue Delandine, 69002 Lyon',1),
   ('Gautier le Sans Glisseur','Fondevila','Gautier','1870-12-24','fondevila.gautier@gmail.com','17 Rue Delandine, 69002 Lyon',1),
   ('Antho reste en bas','Gouton','Anthony','1988-07-20','anthony.gouton.wcs@gmail.com','17 Rue Delandine, 69002 Lyon',1),
   ('Max la menace','Robert','Maxime','1985-04-22','maxlamenace@gmail.com','2-14 Rue du Sénat de Savoie, 73000 Chambéry',2),
   ('Hortense la balance','Louïson','Hortense','1990-06-05','labalance@outlook.com','1 Pl. aux Herbes, 38000 Grenoble',2),
   ('Le caskouyeu','Rodriguez','Benjamin','1986-01-16','benjadu74@live.fr','26 Rue Royale, 74000 Annecy',2);


-- --------------------------------------------
-- Ajout de données dans la table exit_has_type_jump
-- --------------------------------------------
INSERT INTO exit_has_type_jump (id_exit,id_type_jump) VALUES
   (2,1),
   (3,1),
   (6,1),
   (8,1),
   (10,1),
   (1,2),
   (4,2),
   (5,2),
   (6,2),
   (9,2);
INSERT INTO exit_has_type_jump (id_exit,id_type_jump) VALUES
   (10,2),
   (7,4),
   (7,6),
   (8,6);


-- --------------------------------------------
-- Ajout de données dans la table jump_log
-- --------------------------------------------
INSERT INTO jump_log (id_user,date_of_jump,id_exit,id_type_jump,container,canopy,suit,weather,wind,video,image,comment) VALUES
   (5,'2022-03-13',4,1,'non','oui','oui','Ensoleillé','5 km/h','https://www.youtube.com/watch?v=mVzEf03SRZM','https://cdn.radiofrance.fr/s3/cruiser-production/2018/06/db6e5b18-96ae-4985-a3e8-7a31d276c43a/870x489_maxnewsworldfour116523.jpg','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
   (7,'2022-03-15',6,3,'oui','oui','oui','Nuageux','10 km/h','https://www.youtube.com/watch?v=yP87mNNsc04','https://img.redbull.com/images/c_crop,w_5373,h_2687,x_0,y_749,f_auto,q_auto/c_scale,w_1200/redbullcom/2018/07/17/3f339a63-f019-4f4d-9b27-261e9333e20f/base-jumping-collection','But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?'),
   (7,'2022-03-17',3,2,'non','non','non','Ensoleillé','Pas de vent','https://www.youtube.com/watch?v=nEDg0QaniU8','https://i2.wp.com/dicodusport.fr/wp-content/uploads/2016/01/base-jump.jpg?fit=1000%2C600&ssl=1','At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.'),
   (6,'2022-04-02',3,5,'oui','non','non','Neige','15 km/h','https://www.youtube.com/watch?v=FNdzA_UUdIc','https://img.redbull.com/images/c_limit,w_1500,h_1000,f_auto,q_auto/redbullcom/2014/02/03/1331631564233_13/base-jump-super-photos','On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains.'),
   (6,'2022-04-10',8,2,'non','oui','non','Ensoleillé','20 km/h','https://www.youtube.com/watch?v=TcWMZq8-3wI','https://resize-europe1.lanmedia.fr/r/622,311,forcex,center-middle/img/var/europe1/storage/images/europe1/faits-divers/savoie-une-americaine-se-tue-lors-dun-saut-en-base-jump-2818612/28394182-1-fre-FR/Savoie-une-Americaine-se-tue-lors-d-un-saut-en-base-jump.jpg','Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?'),
   (5,'2022-04-11',5,3,'oui','oui','oui','Nuageux','10 km/h','https://www.youtube.com/watch?v=JQy_ZhYkn_Q','http://p9.storage.canalblog.com/90/85/752510/108253189_o.jpg','2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.'),
   (5,'2022-04-12',5,1,'oui','oui','oui','Ensoleillé','Pas de vents','https://www.youtube.com/watch?v=1f6vgfJJrtY','https://res.cloudinary.com/serdy-m-dia-inc/image/upload/w_800,c_limit/legacy_espaces//var/data/gallery/photo/49/75/46/66/15/63433.jpg','going to use a passage of Lorem Ipsum, you need to be sure there isn''t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined c'),
   (6,'2022-04-12',7,1,'non','non','oui','Nuageux','15 km/h','https://www.youtube.com/watch?v=dnjHm6WyaAc','https://photos.tf1.fr/1200/720/base-jump-les-coulisses-du-saut-vertigineux-de-fred-fugen-f3e741-0@1x.jpg','Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through'),
   (6,'2022-04-13',1,3,'oui','oui','non','Mitigé','5 km/h','https://www.youtube.com/watch?v=F1fJRz4iWqs','https://www.abahanavillas.com/documents/20182/60624/Campeonato+del+Mundo+de+salto+base+en+el+hotel+Bali+de+Benidorm.jpg/eccfc160-2b61-4b32-9d22-c1c9ab2a8445?version=1.0&t=1503412687759&download=true','If you are going to use a passage of Lorem Ipsum, you need to be sure there isn''t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary'),
   (1,'2022-04-13',2,4,'oui','oui','oui','Ensoleillé','Pas de vents','https://www.youtube.com/watch?v=ta1S1XUofr8','https://leparisien.fr/resizer/kobCPgWZdbhDqbaNq1njS6wbG-w=/1200x675/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/NMIAISVEX7H6P6MDUPNS23O3JI.jpg','consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences');
