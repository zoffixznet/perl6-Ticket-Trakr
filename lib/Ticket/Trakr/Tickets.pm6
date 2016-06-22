unit class Ticket::Trakr::Tickets;

use DBIish;
use Config::From;
use RT::Client::REST:from<Perl5>;

has Str $.db-file;
has Str $.rt-user;
has Str $.rt-pass;

has DBDish::Driver $!dbh = do {
    my $dbh = DBIish.connect: "SQLite", :database($!db-file);
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

method update {
}
