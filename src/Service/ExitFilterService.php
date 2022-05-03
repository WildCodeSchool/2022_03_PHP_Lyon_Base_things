<?php

/* creation of the ExitController class to pass requests to the database */
namespace App\Service;

use App\Model\ExitManager;
use App\Controller\ExitController;

class ExitFilterService extends ExitController
{
        /**
    * Retrieve filters from user
    */
    public static function retrieveFilters()
    {
       // retrieve data from user
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            if (!empty($_POST)) {
                if (!empty($_POST['jumpTypes'])) {
                    $filterByJumpTypes = $_POST['jumpTypes'];
                    $_SESSION['filterByJumpTypes'] = $filterByJumpTypes;
                } else {
                    $filterByJumpTypes = [];
                };
                if (!empty($_POST['department'])) {
                    $filterByDepartment = $_POST['department'];
                    $_SESSION['filterByDepartment'] = $filterByDepartment;
                } else {
                    $filterByDepartment = [];
                };
                $filter = [$filterByDepartment, $filterByJumpTypes];
                return $filter;
            };
        };
    }

    /**
    * List the active filters as a string in order to be reminded to user
    */
    public static function listOfActiveFilters($filter)
    {
        if (self::isFilterActive() == true) {
            $filterByDepartment = $filter[0];
            $filterByJumpTypes = $filter[1];
            if (count($filterByDepartment) == 0 && count($filterByJumpTypes) == 0) {
                $listOfActiveFilters = [];
            } elseif (count($filterByDepartment) == 0) {
                $filterByJumpTypes = self::convertTypeJumpValueInId($filterByJumpTypes);
                $listOfActiveFilters = implode(", ", $filterByJumpTypes);
            } elseif (count($filterByJumpTypes) == 0) {
                $listOfActiveFilters = implode(", ", $filterByDepartment);
            } else {
                $filterByJumpTypes = self::convertTypeJumpValueInId($filterByJumpTypes);
                $listOfActiveFilters = implode(", ", $filterByDepartment) . ", " . implode(", ", $filterByJumpTypes);
            };
            return $listOfActiveFilters;
        };
    }

    public static function convertTypeJumpValueInId($filterByJumpTypes): array|string
    {
        $convertTable = ["Static-line", "Sans Glisseur", "Lisse", "Track Pantz", "Track Pantz Monopièce", "Wingsuit"];
        $convertedFilter = [];
        foreach ($filterByJumpTypes as $filterByJumpType) {
            $convertedFilter [] = $convertTable[$filterByJumpType - 1];
        }
        return $convertedFilter;
    }

    /**
    * Indicates if a filter have been done
    */
    public static function isFilterActive(): bool
    {
        if (!empty(self::retrieveFilters())) {
            return true;
        } else {
            return false;
        };
    }
}
