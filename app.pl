use lib <lib>;
use Ticket::Trakr::Tickets;
use Config::From;
use Mojolicious::Lite:from<Perl5>;
use Mojolicious::Plugin::AssetPack:from<Perl5>;

constant $rt-user is from-config;
constant $rt-pass is from-config;
constant $db-file is from-config;

helper 'tickets' => &tickets;

plugin AssetPack => { pipes => [qw/Sass JavaScript Combine/] }
app.asset.process: 'app.css' => 'sass/main.scss';


get '/' => *.stash: test => 'magic', template => 'index';

post '/update' => {
    $^c
}

app.start;

sub tickets {
    Ticket::Trakr::Tickets.new: :$db-file, :$rt-user, :$rt-pass;
}
