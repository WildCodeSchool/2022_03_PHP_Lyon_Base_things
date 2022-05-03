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
            $errorMessages[] = 'Les champs Nom, Pays, Département, Hauteur, Accès sont obligatoire';
        }
        if (empty($exit['jumpTypes'])) {
            $errorMessages[] = 'Vous devez choisir au moins un Type de saut';
        }
        return $errorMessages;
    }
}
