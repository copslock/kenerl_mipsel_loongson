Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NIu4t18538
	for linux-mips-outgoing; Wed, 23 May 2001 11:56:04 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NItuF18507;
	Wed, 23 May 2001 11:55:56 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9407E7F4; Wed, 23 May 2001 20:55:54 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 7EA2FEFD5; Wed, 23 May 2001 20:54:12 +0200 (CEST)
Date: Wed, 23 May 2001 20:54:12 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Jun Sun <jsun@mvista.com>
Cc: Joe deBlaquiere <jadb@redhat.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, ralf@oss.sgi.com,
   Pete Popov <ppopov@mvista.com>, George Gensure <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
Message-ID: <20010523205412.A10981@paradigm.rfc822.org>
References: <Pine.GSO.3.96.1010523152429.5196A-100000@delta.ds2.pg.gda.pl> <3B0BF7F8.3050306@redhat.com> <3B0C0475.B9ACE682@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B0C0475.B9ACE682@mvista.com>; from jsun@mvista.com on Wed, May 23, 2001 at 11:41:57AM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 23, 2001 at 11:41:57AM -0700, Jun Sun wrote:
> Like I said in the previous email, ll/sc emulation is at least twice as bad as
> sysmips().  The likely failure of sc will make the performance even worse.  In
> addition, the new glibc starts to pthread massively now (try 'ls' and you will
> see). I do think performance is a factor here.

There are a lot of glibc issues to have a look at - Try issueing a "sleep"
compiled against glibc 2.2 and you'll see at least 20-30 sysmips/shed_yield
calls. As for sleep this is completely unecessary but i guess this
is common glibc startup code and on most architectures atomic test/set
instructions are not as painful as on non ll/sc mips cpus.

> I see the trouble of having extra configurations.  If you were planning to
> have separate support for MIPS I and MIPS II systems, you should be covered. 
> After all there are only limited number of variants anyway - so far. :-)

My favourit would be to let the glibc on runtime decide whether
to use sysmips or ll/sc in the atomic test_and_set stuff. This would
lead to an common atom op in the userspace which is fast on ll/sc 
cpus and gives much lesser performance penaltys in the sysmips case
than emulating ll/sc.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
