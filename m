Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5C24cc21978
	for linux-mips-outgoing; Mon, 11 Jun 2001 19:04:38 -0700
Received: from ocs4.ocs-net (firewall.ocs.com.au [203.34.97.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5C24YV21975
	for <linux-mips@oss.sgi.com>; Mon, 11 Jun 2001 19:04:35 -0700
Received: from ocs4.ocs-net (kaos@localhost)
	by ocs4.ocs-net (8.11.2/8.11.2) with ESMTP id f5C25Jq01119;
	Tue, 12 Jun 2001 12:05:19 +1000
X-Authentication-Warning: ocs4.ocs-net: kaos owned process doing -bs
From: Keith Owens <kaos@ocs.com.au>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Florian Lohoff <flo@rfc822.org>, Keith Owens <kaos@ocs.com.au>,
   linux-mips@oss.sgi.com, kaos@ocs4.ocs-net.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays) 
In-reply-to: Your message of "Tue, 12 Jun 2001 03:01:32 +0200."
             <Pine.GSO.3.96.1010612025658.18298A-100000@delta.ds2.pg.gda.pl> 
Date: Tue, 12 Jun 2001 12:05:19 +1000
Message-ID: <1118.992311519@ocs4.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> On Mon, 11 Jun 2001, Florian Lohoff wrote:
> 
> > Nope - it wont as it strictly uses the /usr/bin/objdump - You have to
> > set the environment var "KSYMOOPS_OBJDUMP"
> 
>  Good it has a way to override the default, but wouldn't looking for
> objdump in the PATH variable (i.e. using execvp()) be more reasonable?
> This way ksymoops would always work in a cross-compilation environment
> (i.e. with $tooldir/bin preceding $bindir in PATH).

I originally designed ksymoops that way but there are so many different
methods of naming the binutils for cross compile environments that I
gave up.  Using the path runs the risk of picking random versions of nm
and objdump and still not being correct.  Anybody running cross compile
has to specify parameters for System.map, ksyms and objects, so adding
paths for binutils is a small change and is the only way to guarantee
that the correct versions are used.
