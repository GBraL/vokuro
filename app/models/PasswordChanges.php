<?php
namespace Vokuro\Models;

use Phalcon\Mvc\Model;

/**
 * PasswordChanges
 * Register when a user changes his/her password
 */
class PasswordChanges extends Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var integer
     */
    public $usersId;

    /**
     *
     * @var string
     */
    public $ipAddress;

    /**
     *
     * @var string
     */
    public $userAgent;

    /**
     *
     * @var integer
     */
    public $createdAt;

    /**
     * Before create the user assign a password
     */
    public function beforeValidationOnCreate()
    {
        // Timestamp the confirmaton
        // $this->createdAt = time();
        $this->createdAt = $this->config->database->adapter == 'Postgresql' ? date('Y-m-d H:i:s') : time();
    }

    public function initialize()
    {
        $this->belongsTo('usersId', 'Vokuro\Models\Users', 'id', array(
            'alias' => 'user'
        ));
    }

	public function columnMap()
	{
		return array(
			'id'		=> 'id',
			'usersid'	=> 'usersId',
			'ipaddress'	=> 'ipAddress',
			'useragent'	=> 'userAgent',
			'createdat'	=> 'createdAt',
		);
	}
}
