Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NIksQ18126
	for linux-mips-outgoing; Wed, 23 May 2001 11:46:54 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NIkoF18122;
	Wed, 23 May 2001 11:46:50 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4NIgI005034;
	Wed, 23 May 2001 11:42:18 -0700
Message-ID: <3B0C0475.B9ACE682@mvista.com>
Date: Wed, 23 May 2001 11:41:57 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe deBlaquiere <jadb@redhat.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Florian Lohoff <flo@rfc822.org>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010523152429.5196A-100000@delta.ds2.pg.gda.pl> <3B0BF7F8.3050306@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Joe deBlaquiere wrote:
> 
 >  Please don't.  The emulation is an overkill here and the overhead is
> > painful for ISA I systems, which are usually not the fastest ones.  This
> > has already been discussed here.
> >
> 
> There's overhead to sysmips also, so neither one is going to give
> stunning performance. All out performance isn't likely an issue on one
> of these systems anyways.
> 

Like I said in the previous email, ll/sc emulation is at least twice as bad as
sysmips().  The likely failure of sc will make the performance even worse.  In
addition, the new glibc starts to pthread massively now (try 'ls' and you will
see). I do think performance is a factor here.

> >  If you want to go for speed and use ll/sc on an ISA II+ system, then
> > compile glibc for ISA II or better.  It will never call sysmips() then.
> 
>         The problem here is that now I have mips, mipsel, and mipselnollsc
> configurations of the cross-tools, the c library and the binary
> applications. It's one extra configuration to maintain.
>

I see the trouble of having extra configurations.  If you were planning to
have separate support for MIPS I and MIPS II systems, you should be covered. 
After all there are only limited number of variants anyway - so far. :-)

Jun
