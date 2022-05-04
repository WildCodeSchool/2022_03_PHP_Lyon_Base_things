<?php

namespace App\Model;

class JumpLogManagerCelie extends AbstractManager
{
    public const TABLE_JUMP_LOG = '`jump_log`';
    public const TABLE_HAS_TYPE_JUMP = '`exit_has_type_jump`';
    public const TABLE_USER = '`user`';

    public function insertJumpLog(int $idUser, array $jumpLog): void
    {
        $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE_JUMP_LOG . " 
        (`id_user`, `date_of_jump`, `id_exit`, `id_type_jump`, `container`, `canopy`, `suit`,
        `weather`, `wind`, `video`, `image`, `comment`)
        VALUES
        (:id_user, :date_of_jump, :id_exit, :id_type_jump, :container,
         :canopy, :suit, :weather, :wind, :video, :image, :comment)");
        $statement->bindValue('id_user', $idUser, \PDO::PARAM_INT);
        $statement->bindValue('date_of_jump', $jumpLog['date_of_jump'], \PDO::PARAM_STR);
        $statement->bindValue('id_exit', $jumpLog['id_exit'], \PDO::PARAM_INT);
        $statement->bindValue('id_type_jump', $jumpLog['id_type_jump'], \PDO::PARAM_STR);
        $statement->bindValue('container', $jumpLog['container'] . ':00', \PDO::PARAM_STR);
        $statement->bindValue('canopy', $jumpLog['canopy'], \PDO::PARAM_STR);
        $statement->bindValue('suit', $jumpLog['suit'], \PDO::PARAM_STR);
        $statement->bindValue('weather', $jumpLog['weather'], \PDO::PARAM_STR);
        $statement->bindValue('wind', $jumpLog['wind'], \PDO::PARAM_STR);
        $statement->bindValue('video', $jumpLog['video'], \PDO::PARAM_STR);
        $statement->bindValue('image', $jumpLog['image'], \PDO::PARAM_STR);
        $statement->bindValue('comment', $jumpLog['comment'], \PDO::PARAM_STR);
        $statement->execute();
    }

    public function insertPseudo(string $pseudo): int
    {
            $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE_USER . "(`pseudo`) 
            values (:pseudo)");
            $statement->bindValue('pseudo', $pseudo, \PDO::PARAM_STR);
            $statement->execute();
        return (int)$this->pdo->lastInsertId();
    }
}
