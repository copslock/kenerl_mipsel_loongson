Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA12517; Thu, 14 Aug 1997 11:33:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA11320 for linux-list; Thu, 14 Aug 1997 11:32:55 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA11308 for <linux@cthulhu.engr.sgi.com>; Thu, 14 Aug 1997 11:32:53 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA29943; Thu, 14 Aug 1997 11:32:41 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199708141832.LAA29943@oz.engr.sgi.com>
Subject: Re: linus accessible from within SGI
To: mjo@sgi.com (Michael O'Connor)
Date: Thu, 14 Aug 1997 11:32:41 -0700 (PDT)
Cc: eak@detroit.sgi.com, ariel@sgi.com, linux@cthulhu.engr.sgi.com,
        comm-tech@rock.csd.sgi.com
In-Reply-To: <199708141315.JAA20926@dormammu.detroit.sgi.com> from "Michael O'Connor" at Aug 14, 97 09:15:30 am
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:
:|Has anyone been able to get "mirror" work via socks through our
:|firewall?
:
:By 'mirror', I take it you mean the perl mirror program.  :)
:
:The more general question is:  How do you get perl TCP/IP programs
:to work over SOCKS?  It appears that Simon Cooper, sc@sgi.com, is
:working on a perl module to do that.  Suggest you talk with him, or
:use something else to mirror -- some of the nouveau FTP clients
:do this, and could probably be easily SOCKSified.  
:
In the case of perl it is easy to cross the firewall by simply
using a proxy. i.e. you don't need to SOCSify you perl since
the proxy (which is SOCKsified) does the job for you.

Enclosed below is a (http) 'GET' script that uses one possible
SGI proxy when given the -e option. The method uses is the name
of the script so you may symlink it to 'HEAD' for example.

-- 
Peace, Ariel

#!/usr/bin/perl5
#
# perl5+LWP script to fetch a URL
#
# Usage:
#	Get [-e] [-t<timeout>] <URL>
#
# Author:
#	ariel@sgi.com, 1996
#
use HTTP::Status;
use LWP::UserAgent;
use LWP::Protocol;

{
	#
	# Override these methods. Their default behavior is bad for us.
	#
	package LWP::Protocol; sub use_alarm { shift->_elem('use_alarm', 0); }
	package LWP::UserAgent; sub redirect_ok { 0; }
}


require 'getopts.pl';
&Getopts('t:m:e');

$0 =~ s,.*/,,;

unless ($ARGV[0]) {
    die "Usage: $0 [-e -tTIMEOUT -mMETHOD] URL
	-e	Use a proxy for [e]xternal accesses
	default METHOD is program name
	default TIMEOUT is 7 sec for internal, 14 for external\n";
}

if ($opt_t =~ /^\d+$/) {
    $get_timeout = $opt_t;
} else {
    $get_timeout = 7;
    $get_timeout *= 2 if ($opt_e);
}
($method = $opt_m) || ($method = $0);
$method =~ tr,a-z,A-Z,;

# print "get started\n";
&get($method, $ARGV[0], $get_timeout);


# get($method, $from_url, $timeout)
#       Fetches $url into a $get_contents. Gives up after $timeout sec.
#       returns the HTTP get code (200 for OK etc.)
#
sub get {
    my($method, $url, $timeout) = @_;
    my ($ua, $request, $response);    
    my ($key, $get_rc, $lf);

    $ua = new LWP::UserAgent;
    $ua->use_alarm(1);
    $ua->timeout($timeout);
    $ua->agent("Get-perl5/v1.0");
    if ($opt_e) {
	$ua->proxy([ 'http' ], 'http://www-dms.esd.sgi.com:8080/');
    }

    if ($url =~ m,^/,) {
	$url = 'localhost' . $url;
    }
    unless ($url =~ /^[a-z]+:/) {
	$url = 'http://' . $url;
    }
    $get_content = '';
    $Content_length = '';

    $request = new HTTP::Request($method, $url);
    # $request->push_header('If-Modified-Since' => 'Thu, 01-Jan-70 00:00:00 GMT');

    print STDERR $method, ' ', $url, ': ';

    $response = $ua->request($request);

    $get_rc = $response->code;
    $get_content = $response->content if $response->is_success;
    $error_msg = status_message($get_rc);

    if ($get_rc == 200) {                       # 200: OK
	$Content_length = $response->header('Content-length');
    }
    # Some servers do not send the content length...
    if ($Content_length eq '' &&  $get_content) {
	$Content_length = length($get_content);
    }

    print STDERR $error_msg,
        ($Content_length ? " ($Content_length)" : ''), "\n";

    print STDERR $response->headers_as_string;
    print $get_content;

    $get_rc;
}

__END__
