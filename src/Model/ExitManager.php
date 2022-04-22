<?php

/* creation of the ExitManager class to manage the connection to the database */
namespace App\Model;

use App\Model\AbstractManager;

class ExitManager extends AbstractManager
{
    public const TABLE = '`exit`';


        /**
     * Insert new item in database
     */
    public function insert(array $exits): int
    {
        $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE . " 
        (`name`, `department`, `country`, `height`, `access_duration`, `gps_coordinates`, `acces`,
        `remark`, `video`, `image`) 
        VALUES 
        (:name, :department, :country, :height, :access_duration, :gps_coordinates, :acces, :remark, :video, :image)");
        $statement->bindValue('name', $exits['name'], \PDO::PARAM_STR);
        $statement->bindValue('department', $exits['department'], \PDO::PARAM_STR);
        $statement->bindValue('country', $exits['country'], \PDO::PARAM_STR);
        $statement->bindValue('height', $exits['height'], \PDO::PARAM_INT);
        $statement->bindValue('access_duration', $exits['access_duration'], \PDO::PARAM_INT);
        $statement->bindValue('gps_coordinates', $exits['gps_coordinates'], \PDO::PARAM_STR);
        $statement->bindValue('acces', $exits['acces'], \PDO::PARAM_STR);
        $statement->bindValue('remark', $exits['remark'], \PDO::PARAM_STR);
        $statement->bindValue('video', $exits['video'], \PDO::PARAM_STR);
        $statement->bindValue('image', $exits['image'], \PDO::PARAM_STR);
        $statement->execute();
        return (int)$this->pdo->lastInsertId();
    }
}
