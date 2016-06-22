use lib <lib>;
use Test;
use Ticket::Trakr::Tickets;
use Config::From;

my $rt-user is from-config;
my $rt-pass is from-config;
my $db-file = "test-{now}.db";
END { $db-file.say; $db-file.IO.unlink };

my $rt = Ticket::Trakr::Tickets.new: :$db-file, :$rt-user, :$rt-pass;

dd $rt.update;
#
ok 1;
done-testing;
