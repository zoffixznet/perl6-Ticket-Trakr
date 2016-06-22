unit class Ticket::Trakr::Tickets;
use Pretty::Topic '♥';
use DBIish;
use RT::Client::REST:from<Perl5>;

constant $server = 'https://rt.perl.org/';

has Str:D $.db-file is required;
has Str:D $.rt-user is required;
has Str:D $.rt-pass is required;

has RT::Client::REST $!rt = do with RT::Client::REST.new: :$server {
    .login: :username($.rt-user) :password($.rt-pass); ♥
};

has DBDish::Connection $!dbh = do {
    my $dbh = DBIish.connect: 'SQLite', :database($!db-file);
    unless $!db-file.IO.s {
        $dbh.do: q:to/END_SQL/;
            CREATE TABLE tickets (
                id     INT UNSIGNED PRIMARY KEY,
                date   DATE,
                status TEXT
            );
        END_SQL
    }
    $dbh;
};

method all {
    given $!dbh.prepare: 'SELECT * FROM tickets ORDER BY date DESC' {
        .execute;
        return .allrows: :hash;
    }
}

method fetch {
    my %tickets = self.all.map: { ♥.<id> => ♥ };

}
