Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6G4aHq24039
	for linux-mips-outgoing; Sun, 15 Jul 2001 21:36:17 -0700
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6G4aDV24029;
	Sun, 15 Jul 2001 21:36:13 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id VAA19673;
	Sun, 15 Jul 2001 21:32:24 -0700
Date: Sun, 15 Jul 2001 21:32:24 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
Message-ID: <20010715213224.A19636@mvista.com>
References: <20010712224520.C23062@bacchus.dhis.org> <Pine.GSO.3.96.1010713124802.3193B-100000@delta.ds2.pg.gda.pl> <20010714125312.A6713@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010714125312.A6713@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Jul 14, 2001 at 12:53:12PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 14, 2001 at 12:53:12PM +0200, Ralf Baechle wrote:
> On Fri, Jul 13, 2001 at 12:52:55PM +0200, Maciej W. Rozycki wrote:
> 
> > > There is a bunch of patches for ll/sc and MIPS_ATOMIC_SET floating around.
> > > I came to the conclusion that I don't like any of them so I'm just working
> > > on fixing the thing once and for all.
> > 
> >  What about the _test_and_set syscall?  Having it implemented we could get
> > rid of the MIPS_ATOMIC_SET hack for post-2.4.  Glibc may be made ready for
> > the transition any time now.
> 
> I'm just making an attempt to re-implement the ll/sc emulation as light
> as possible.  I hope to get the overhead down to the point were we don't
> need _test_and_set anymore - in any case below the overhead of a syscall.
>

That is really cool.  

For compatibility reasons, I assume we still keep sysmips() around
for a while, right?  And if that is yes, we better take either flo's or
my fix (derived from Maceij's new syscall) to get rid of the illegal 
instruction bug, which really becomes an untolerable FAQ now.

Jun
