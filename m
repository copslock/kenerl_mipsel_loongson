Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6EArev09440
	for linux-mips-outgoing; Sat, 14 Jul 2001 03:53:40 -0700
Received: from dea.waldorf-gmbh.de (u-121-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.121])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6EArcV09434
	for <linux-mips@oss.sgi.com>; Sat, 14 Jul 2001 03:53:38 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6EArC906073;
	Sat, 14 Jul 2001 12:53:12 +0200
Date: Sat, 14 Jul 2001 12:53:12 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
Message-ID: <20010714125312.A6713@bacchus.dhis.org>
References: <20010712224520.C23062@bacchus.dhis.org> <Pine.GSO.3.96.1010713124802.3193B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010713124802.3193B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jul 13, 2001 at 12:52:55PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 13, 2001 at 12:52:55PM +0200, Maciej W. Rozycki wrote:

> > There is a bunch of patches for ll/sc and MIPS_ATOMIC_SET floating around.
> > I came to the conclusion that I don't like any of them so I'm just working
> > on fixing the thing once and for all.
> 
>  What about the _test_and_set syscall?  Having it implemented we could get
> rid of the MIPS_ATOMIC_SET hack for post-2.4.  Glibc may be made ready for
> the transition any time now.

I'm just making an attempt to re-implement the ll/sc emulation as light
as possible.  I hope to get the overhead down to the point were we don't
need _test_and_set anymore - in any case below the overhead of a syscall.

Have you ever profiled the number of calls to MIPS_ATOMIC_SET or
_test_and_set?  They'll be the other factor in a decission.

  Ralf
