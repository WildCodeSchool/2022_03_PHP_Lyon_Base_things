<?php

namespace App\Model;

class JumpLogManager extends AbstractManager
{
    public const TABLE = 'jump_log';
    public const TABLE_HAS_TYPE_JUMP = '`exit_has_type_jump`';
    public const TABLE_USER = '`user`';
    public const TABLE_EXIT = '`exit`';

    /**
     * Get all jump with exit from database.
     */
    public function selectJumpExit(string $orderBy = '', string $direction = 'ASC', string $filterActivated = ''): array
    {
        $query = 'SELECT jump_log.*, u.pseudo AS \'u_pseudo\', e.name AS \'e_name\', tj.name AS \'tj_name\',
                    e.image AS \'e_image\'
                    FROM ' . self::TABLE . ' INNER JOIN `user` u ON u.id = jump_log.id_user 
                    INNER JOIN `exit` e ON e.id = jump_log.id_exit 
                    INNER JOIN type_jump tj ON tj.id = jump_log.id_type_jump ';
        if ($filterActivated) {
            $query .= " WHERE u.pseudo IN ('" . $filterActivated . "')";
        }
        if ($orderBy) {
            $query .= ' ORDER BY ' . $orderBy . ' ' . $direction;
        }

        return $this->pdo->query($query)->fetchAll();
    }

    public function selectExits(string $orderBy = '', string $direction = 'ASC'): array
    {
        $query = 'SELECT * FROM ' . static::TABLE_EXIT;
        if ($orderBy) {
            $query .= ' ORDER BY ' . $orderBy . ' ' . $direction;
        }

        return $this->pdo->query($query)->fetchAll();
    }

    public function insertJumpLog(int $idUser, array $jumpLog): void
    {
        $statement = $this->pdo->prepare("INSERT INTO " . self::TABLE . " 
        (`id_user`, `date_of_jump`, `id_exit`, `id_type_jump`, `container`, `canopy`, `suit`,
        `weather`, `wind`, `video`, `image`, `comment`)
        VALUES
        (:id_user, :date_of_jump, :id_exit, :id_type_jump, :container,
         :canopy, :suit, :weather, :wind, :video, :image, :comment)");
        $statement->bindValue('id_user', $idUser, \PDO::PARAM_INT);
        $statement->bindValue('date_of_jump', $jumpLog['date_of_jump'], \PDO::PARAM_STR);
        $statement->bindValue('id_exit', $jumpLog['id_exit'], \PDO::PARAM_STR);
        $statement->bindValue('id_type_jump', $jumpLog['id_type_jump'], \PDO::PARAM_STR);
        $statement->bindValue('container', $jumpLog['container'], \PDO::PARAM_STR);
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
        /**
     * Delete jump from jumplog
     */
    public function deleteJump(int $id): void
    {
        $statement = $this->pdo->prepare("DELETE FROM " . static::TABLE . " WHERE id=:id");
        $statement->bindValue('id', $id, \PDO::PARAM_INT);
        $statement->execute();
    }
}
