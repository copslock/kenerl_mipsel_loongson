Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9GMbdf10248
	for linux-mips-outgoing; Tue, 16 Oct 2001 15:37:39 -0700
Received: from dea.linux-mips.net (a1as11-p81.stg.tli.de [195.252.190.81])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9GMb4D10243
	for <linux-mips@oss.sgi.com>; Tue, 16 Oct 2001 15:37:11 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9GMTlx21841;
	Wed, 17 Oct 2001 00:29:47 +0200
Date: Wed, 17 Oct 2001 00:29:47 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.9: Bad code in xchg_u32()
Message-ID: <20011017002947.A19789@dea.linux-mips.net>
References: <Pine.GSO.3.96.1011016161735.19676E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011016161735.19676E-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Oct 16, 2001 at 07:06:40PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Oct 16, 2001 at 07:06:40PM +0200, Maciej W. Rozycki wrote:

> 
>  Unfortunately, gcc 2.95.3 doesn't want to accept a "=R" output constraint
> here so I had to use "=m".  It looks like a bug in gcc.  Until it is fixed
> the "R" input constraint here is sufficient for gcc to know it has m
> already available in one of registers.  I added ".set nomacro" to make
> sure the second ll fits in the BDS as well.

I've added the "memory" clobber back; xchg() is expected to imply a memory
barrier.

"R" indeed seems to be fishy; I can't compile the kernel if I remove
the volatile from the first argument of xchg_u32().  I'd feel safer if
we could use "m" until we can be sure "R" works fine.

  Ralf
