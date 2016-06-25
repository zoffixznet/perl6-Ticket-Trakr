use lib <lib>;
use Ticket::Trakr::Tickets;
use Config::From;
use Mojolicious::Lite:from<Perl5>;
use Mojolicious::Plugin::AssetPack:from<Perl5>;

my $rt-user is from-config;
my $rt-pass is from-config;
my $db-file is from-config;

helper 'tickets' => &tickets;

plugin AssetPack => { pipes => [qw/Sass JavaScript Combine/] }
app.asset.process: 'app.css' => 'sass/main.scss';


get '/' => *.stash: template => 'index';

get '/update' => {
    $^c.stash: template => 'update';
}

app.start;

sub tickets {
    Ticket::Trakr::Tickets.new: :$db-file, :$rt-user, :$rt-pass;
}
