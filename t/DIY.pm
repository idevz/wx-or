package t::DIY;
use Test::Base;
# use Test::More qw(is);
use base "Test::Base";

# log_level('debug');
sub run_test($);
sub run_tests();
our @EXPORT = qw( run_tests );
if( -f "logs/error.log") {
system("rm logs/error.log");
}

# system("kill -HUP `cat logs/nginx.pid`") == 0 or die;

if ( -f "logs/nginx.pid") {
system("sudo /usr/local/openresty-1.15.8.1-debug/bin/openresty -sreload -p \$PWD/") == 0 or die;
}else{
system("sudo /usr/local/openresty-1.15.8.1-debug/bin/openresty -p \$PWD/") == 0 or die;
}

sub run_tests(){
    for my $block(blocks()) {
        run_test($block)
    }
}

sub run_test($){
    my $block = shift;
    my $title = $block->name;

    my $req = $block->req;
    chomp $req;
    my $resp = `curl -sS http://127.0.0.1:8089$req`;
    warn "req: $req";
    my $exp_resp=$block->resp;
    is $resp, $exp_resp, "$title ------ response expected";
    warn "resp:---->$resp";
    warn "exp_resp:---->$exp_resp";
    my $no_error_log = $block->no_error_log;
    my @pats = split /\n/, $no_error_log;
    for my $pat(@pats){
        $pat =~ s/\[/\\[/g;
        $pat =~ s/\]/\\]/g;
        my $out = `grep '$pat' logs/error.log`;
        if($? == 0 && $out){
            fail "$title - error log '$pat' -  $out";
        }
    }
}

1;