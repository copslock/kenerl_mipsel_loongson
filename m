Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4UHum109881
	for linux-mips-outgoing; Wed, 30 May 2001 10:56:48 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4UHuih09871
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 10:56:44 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4UHtc023885;
	Wed, 30 May 2001 10:55:38 -0700
Message-ID: <3B1533EB.924ACA05@mvista.com>
Date: Wed, 30 May 2001 10:54:51 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
References: <Pine.GSO.3.96.1010530135109.9456A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:
> 
> On Tue, 29 May 2001, Jun Sun wrote:
> 
> > I think system V requires _test_and_set() being included in the libsys dynamic
> > library.  Does Linux want to be sysv compatible?  If so, we should removed the
> > inlined _test_and_set().
> 
>  Why should we remove the inlined _test_and_set()?  We do have a number of
> other inlined functions in glibc, e.g. memcpy() and friends in
> <bits/string.h> (not for MIPS, actually, but for other hosts), yet it does
> not make glibc SVR4 incompatible.  Of course we always provide non-inlined
> versions of such functions as well -- check with objdump if unsure.
> 

Hmm, I think to write SYSV compatible code one should not used inlined ABI
calls. Otherwise the binary would bypass libsys and becomes not portable among
SYSV machines.

On the other hand, what other MIPS SYSV platforms are there for us to be
compatible?  IRIX? :-)

>  Note they are *extern* inline.
> 

I don't think "extern" changes the picture here because once the call is
inlined the code will bypass libsys - unless my previous understanding is
wrong.


Jun
