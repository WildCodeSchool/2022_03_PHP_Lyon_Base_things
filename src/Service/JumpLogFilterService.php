<?php

/* creation of the ExitController class to pass requests to the database */

namespace App\Service;

use App\Model\JumpLogManager;
use App\Controller\JumpLogController;

class JumpLogFilterService extends JumpLogController
{
    /**
     * Retrieve pseudo for filter
     */
    public static function retrievePseudoForFilters(array $jumpLogs): array
    {
        $pseudo = [];
        foreach ($jumpLogs as $jumpLog) {
            $pseudo[] = $jumpLog['u_pseudo'];
        }
        return array_unique($pseudo);
    }
}
