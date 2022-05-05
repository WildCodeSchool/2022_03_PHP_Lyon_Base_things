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
                    unset($_SESSION['filterByJumpTypes']);
                    $filterByJumpTypes = [];
                };
                if (!empty($_POST['department'])) {
                    $filterByDepartment = $_POST['department'];
                    $_SESSION['filterByDepartment'] = $filterByDepartment;
                } else {
                    unset($_SESSION['filterByDepartment']);
                    $filterByDepartment = [];
                };
                $filter = [$filterByDepartment, $filterByJumpTypes];
                return $filter;
            };
        };
    }
    public static function sessionRetrieveFilters()
    {
       // retrieve data from session
        if (!empty($_SESSION['filterByJumpTypes']) || !empty($_SESSION['filterByDepartment'])) {
            if (!empty($_SESSION['filterByJumpTypes'])) {
                $filterByJumpTypes = $_SESSION['filterByJumpTypes'];
            } else {
                $filterByJumpTypes = [];
            };
            if (!empty($_SESSION['filterByDepartment'])) {
                $filterByDepartment = $_SESSION['filterByDepartment'];
            } else {
                $filterByDepartment = [];
            };
            $filter = [$filterByDepartment, $filterByJumpTypes];
            return $filter;
        };
    }

    /**
     * List the active filters as a string in order to be reminded to user
     */
    public static function depFiltersList($filter)
    {
        if (self::isFilterActive() == true) {
            $filterByDepartment = $filter[0];
            if (count($filterByDepartment) == 0) {
                $depFiltersList = "";
            } else {
                $depFiltersList = implode(" / ", $filterByDepartment);
            }
            return $depFiltersList;
        };
    }
    public static function jumpFiltersList($filter)
    {
        if (self::isFilterActive() == true) {
            $filterByJumpTypes = $filter[1];
            if (count($filterByJumpTypes) == 0) {
                $jumpFiltersList = "";
            } else {
                $filterByJumpTypes = self::convertTypeJumpValueInId($filterByJumpTypes);
                $jumpFiltersList = implode(" / ", $filterByJumpTypes);
            }
            return $jumpFiltersList;
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
        if (!empty(self::retrieveFilters()) || self::sessionRetrieveFilters()) {
            return true;
        } else {
            return false;
        };
    }
}
