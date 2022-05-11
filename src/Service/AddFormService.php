<?php

namespace App\Service;

abstract class AddFormService
{
    public static function trimPostData(): array
    {
        $datas = [];
        foreach ($_POST as $key => $data) {
            if (is_array($data)) {
                $datas += array($key => $data);
                continue;
            }
            $datas += array( $key => (trim($data)));
        }
        return $datas;
    }

    public static function checkLengthData(array $exit, array $errorMessages): array
    {
        if (strlen($exit['name']) > 150) {
            $errorMessages[] = 'Le champs Nom doit être inferieur a 150 caractères';
        }
        if (strlen($exit['height']) > 150) {
            $errorMessages[] = 'Les champ Hauteur doit être inferieur a 150 caractères';
        }
        if (strlen($exit['department']) > 50) {
            $errorMessages[] = 'Le champ Département doit être inferieur a 50 caractères';
        }
        if (strlen($exit['country']) > 50) {
            $errorMessages[] = 'Le champ Pays doit être inferieur a 50 caractères';
        }
        if (strlen($exit['gps_coordinates']) > 50) {
            $errorMessages[] = 'Le champ Coordonnées GPS doit être inferieur a 50 caractères';
        }
        return $errorMessages;
    }

    public static function checkLengthDataJump(array $jumplog, array $errorMessages): array
    {
        if (
            strlen($jumplog['pseudo']) > 50 ||
            strlen($jumplog['container']) > 50 ||
            strlen($jumplog['canopy']) > 50 ||
            strlen($jumplog['suit']) > 50 ||
            strlen($jumplog['weather']) > 50 ||
            strlen($jumplog['wind']) > 50
        ) {
            $errorMessages[] = 'Les champs Pseudo, Harnais, Voile, Suit, 
            Météo et Vent doivent être inferieurs a 50 caractères';
        }
        if (strlen($jumplog['id_type_jump']) > 1 || strlen($jumplog['id_type_jump']) == 0) {
            $errorMessages[] = 'Veuillez sélectionner le type de saut dans le menu déroulant';
        }
        return $errorMessages;
    }

    public static function validateExtension(array $errorMessages): array
    {
        $extension = strToLower(pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION));
        $authorizedExtensions = ['jpg','jpeg','png'];
        if ((!in_array($extension, $authorizedExtensions))) {
            $errorMessages[] = "Format d'image non supporté !
            Seuls les formats Jpg , Jpeg ou Png sont supportés.";
        }
        return $errorMessages;
    }

    public static function validateMaxFileSize(array $errorMessages): array
    {
        $maxFileSize = 2000000;
        if (
            file_exists($_FILES['image']['tmp_name']) &&
            filesize($_FILES['image']['tmp_name']) > $maxFileSize
        ) {
            $errorMessages[] = 'Votre image doit faire moins de 2M !';
        }
        return $errorMessages;
    }

    public static function isEmpty(array $exit, array $errorMessages): array
    {
        if (
            empty($exit['name']) ||
            empty($exit['department']) ||
            empty($exit['country']) ||
            empty($exit['height']) ||
            empty($exit['acces'])
        ) {
            $errorMessages[] = 'Les champs Nom, Pays, Département, Hauteur, Accès sont obligatoires';
        }
        if (empty($exit['jumpTypes'])) {
            $errorMessages[] = 'Vous devez choisir au moins un Type de saut';
        }
        return $errorMessages;
    }

    public static function isEmptyDataJump(array $jumplog, array $errorMessages): array
    {
        if (
            empty($jumplog['pseudo']) ||
            empty($jumplog['id_exit']) ||
            empty($jumplog['date_of_jump']) ||
            empty($jumplog['id_type_jump'])
        ) {
            $errorMessages[] = "Les champs Pseudo, Nom de l'exit, date du saut et type de saut sont obligatoires";
        }
        return $errorMessages;
    }

    public static function validateUrl(array $jumplog, array $errorMessages): array
    {
        if ($jumplog['video'] != filter_var($jumplog['video'], FILTER_VALIDATE_URL)) {
            $errorMessages[] = "Merci de renseigner un url pour le champ vidéo";
        }
        return $errorMessages;
    }

    public static function checkDate(array $jumplog, array $errorMessages): array
    {
        if ($jumplog['date_of_jump'] < date('Y')) {
            $errorMessages[] = "Vous ne pouvez pas saisir une année inferieur a celle en cours ";
        }
        return $errorMessages;
    }
}
