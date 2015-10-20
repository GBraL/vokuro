<?php
return new \Phalcon\Config(array(
    'database' => array(
        'adapter' => 'Postgresql',
        'host' => 'localhost',
        'username' => 'vokuro',
        'password' => '123456789',
        'dbname' => 'vokuro'
    ),
    'application' => array(
        'controllersDir' => APP_DIR . '/controllers/',
        'modelsDir' => APP_DIR . '/models/',
        'formsDir' => APP_DIR . '/forms/',
        'viewsDir' => APP_DIR . '/views/',
        'libraryDir' => APP_DIR . '/library/',
        'pluginsDir' => APP_DIR . '/plugins/',
        'cacheDir' => APP_DIR . '/cache/',
        'baseUri' => '/',
        'publicUrl' => 'vokuro.phalconphp.com',
        'cryptSalt' => 'eEAfR|_&G&f,+vU]:jFr!!A&+71w1Ms9~8_4L!<@[N@DyaIP_2My|:+.u>/6m,$D'
    ),
    'mail' => array(
        'fromName' => 'Vokuro',
        'fromEmail' => 'me@gbral.com',
        'smtp' => array(
            'server' => 'smtp.gmail.com',
            'port' => 587,
            'security' => 'tls',
            'username' => 'me@gbral.com',
            'password' => ''
        )
    ),
    'amazon' => array(
        'AWSAccessKeyId' => '',
        'AWSSecretKey' => ''
    ),
    'environment' => array(
        // 'timezone' => 'America/New_York'
        'timezone' => 'America/Sao_Paulo'
    )
));
