Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9GMnaQ10988
	for linux-mips-outgoing; Tue, 16 Oct 2001 15:49:36 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9GMnYD10984;
	Tue, 16 Oct 2001 15:49:34 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9GMptB16440;
	Tue, 16 Oct 2001 15:51:55 -0700
Message-ID: <3BCCB979.FFBFE85B@mvista.com>
Date: Tue, 16 Oct 2001 15:49:29 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.9: Bad code in xchg_u32()
References: <Pine.GSO.3.96.1011016161735.19676E-100000@delta.ds2.pg.gda.pl> <20011017002947.A19789@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Tue, Oct 16, 2001 at 07:06:40PM +0200, Maciej W. Rozycki wrote:
> 
> >
> >  Unfortunately, gcc 2.95.3 doesn't want to accept a "=R" output constraint
> > here so I had to use "=m".  It looks like a bug in gcc.  Until it is fixed
> > the "R" input constraint here is sufficient for gcc to know it has m
> > already available in one of registers.  I added ".set nomacro" to make
> > sure the second ll fits in the BDS as well.
> 
> I've added the "memory" clobber back; xchg() is expected to imply a memory
> barrier.
> 
> "R" indeed seems to be fishy; I can't compile the kernel if I remove
> the volatile from the first argument of xchg_u32().  I'd feel safer if
> we could use "m" until we can be sure "R" works fine.

Is there any reason to think "R" *should* be better than "m"?

Jun
