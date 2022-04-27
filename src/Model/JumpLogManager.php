<?php


namespace App\Model;

class JumpLogManager extends AbstractManager
{
    public const TABLE = 'jump_log';

    /**
     * Get all row exit with type_jump from database.
     */
    public function selectTypeJumpByExitId(int $id): array|false
    {
        // prepared request
        $statement = $this->pdo->prepare("SELECT tj.name FROM " . self::TABLE . " e 
        INNER JOIN exit_has_type_jump ehtj ON ehtj.id_exit = e.id
        INNER JOIN type_jump tj ON tj.id = ehtj.id_type_jump
        WHERE e.id=:id");
        $statement->bindValue('id', $id, \PDO::PARAM_INT);
        $statement->execute();

        return $statement->fetchAll();
    }

}
