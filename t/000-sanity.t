use lib ".";

use t::DIY 'no_plan';

run_tests;

__DATA__

=== TEST 1:sanity
--- req
/hello
--- resp
hello world!
--- no_error_log
[error]
--- ONLY
