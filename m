Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4UHf5X07904
	for linux-mips-outgoing; Wed, 30 May 2001 10:41:05 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4UHf1h07897
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 10:41:01 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4UHef022710;
	Wed, 30 May 2001 10:40:41 -0700
Message-ID: <3B15306A.3AACAF3E@mvista.com>
Date: Wed, 30 May 2001 10:39:54 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@uni-koblenz.de>, Joe deBlaquiere <jadb@redhat.com>,
   "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Surprise! (Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010530141109.9456B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Tue, 29 May 2001, Jun Sun wrote:
> 
> > >  What about 3) -- a new syscall with a different semantics and no need to
> > > care about limitations of current implementations (especially the
> > > sysmips() bag).
> >
> > Having a new syscall is fine with me, although seems a little more instrusive
> > than adding a subcall to sysmips().
> 
>  Actually whole sysmips() looks like a crazy hack, much like ioctl(), but
> even worse (passing a pointer in an integer argument, even if it works...
> yuck!).  And it is weird, to say at least, to have different
> interpretations of the return value -- sometimes it's errno and sometimes
> it's something different.
> 

Agree.  Having dual semantics for the return value is bad.

I was actually suggesting to have a new subcall in sysmips (e.g.,
MIPS_NEW_ATOMIC_SET) and still working within the sysmips() call framework.

Is there any concern as for adding a new syscall?

Jun
