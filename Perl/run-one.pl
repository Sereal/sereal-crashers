use warnings;
use strict;

use Sereal::Decoder qw(decode_sereal);

my $ret = sysread(STDIN, my $buf, 5120);
if ($ret <= 0 || $buf eq "") {
    last;
}
eval { decode_sereal($buf); };
