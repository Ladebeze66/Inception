<?php
define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('MYSQL_USER'));
define('DB_PASSWORD', getenv('MYSQL_PASSWORD'));
define('DB_HOST', 'mariadb');
define('DB_CHARSET', 'utf8');
define('URL', getenv('DOMAIN_NAME'));
define('TITLE', getenv('WP_TITLE'));
define('ADMIN_USER', getenv('WP_ADMIN_USR'));
define('ADMIN_PASSWORD', getenv('WP_ADMIN_PWD'));
define('ADMIN_EMAIL', getenv('WP_ADMIN_EMAIL'));
define('WP_HOME', 'https://' . getenv('DOMAIN_NAME'));
define('WP_SITEURL', 'https://' . getenv('DOMAIN_NAME'));
define('WP_USR', getenv('fgras'));

define('AUTH_KEY',         'AIE4!9u^Xf93DSe(-Y-=v$CU#f}N5qwR/43{/A_?aX@6{!8Ysk^G];W= DXtN.pV');
define('SECURE_AUTH_KEY',  ';o*Qw7fZg,=2{SpKy8Ic9<=wGJAPt|8s<.yxfTcrSQgvH[/+!/@l20?1nd^C#MS`');
define('LOGGED_IN_KEY',    ')?zr-W7s~RDR5PW|V6Ie`9Heq~T23IeQeD%*Z/U^|b%3 sk+z`3m|)#zyRr2pf=!');
define('NONCE_KEY',        'Gtp-]EJS)-T&4NQP4R$-|2=5w}p|Ac:UFX#+ bU$%1|2[H6xH=;zIvH$)r)q2Y>v');
define('AUTH_SALT',        'P`?.eaIu-G3fZYiN|/X[Sdc!ZVu9Lf<J}0&%/5B0Tp~)<),WqGdpKgC~W>vP>26(');
define('SECURE_AUTH_SALT', 'ZnDGUX{EtppgS7gTLqg|xYcS26(WB-xP3?ldWSs|Ak;UTWpJ<SCoh(]2sE8(jL9a');
define('LOGGED_IN_SALT',   'h}7^=g(R+c#[T3tIu3|wJpBQ{]aheu(+{k>`fGisKDii7agi^P}-@}Gm#m>A6Gb|');
define('NONCE_SALT',       'ZaiFh{H~?Z34?18v[=Wi<T0k&nQMm2%L:l:|:z<f[knH^yz&#oEaR0g6h1Z-MLzH');

$table_prefix = 'wp_';

define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
