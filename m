Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6MGI9Rw026643
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 22 Jul 2002 09:18:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6MGI9Pb026642
	for linux-mips-outgoing; Mon, 22 Jul 2002 09:18:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6MGHrRw026633
	for <linux-mips@oss.sgi.com>; Mon, 22 Jul 2002 09:17:54 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA07719;
	Mon, 22 Jul 2002 18:19:14 +0200 (MET DST)
Date: Mon, 22 Jul 2002 18:19:13 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@oss.sgi.com
Subject: Re: [uHOWTO] Booting a DECstation via MOP
In-Reply-To: <20020722144115.GW8891@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020722164338.2373I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 22 Jul 2002, Jan-Benedict Glaw wrote:

> Are you still maintaining it? I see that *one* (really useful) mopd gets
> more and more important (DECstations, VAXen, ...), but there are so
> many of them.

 Yes, I am maintaining it as my time permits it.  It mostly works for what
it was designed, so it's not high priority and not much happens these
days.  But it still needs some work -- I have a few comments with proposed
fixes from a *BSD user, COFF support changes and also FDDI support is on
my to-do list.

> 	- One is from you (which is nicely working)
> 	- One is on linux-vax.sourceforge.net (IIRC)
> 	- One is 'apt-get install'able
> 	- One is referenced on decstation.unix-ag.org (IIRC)

 This one is a completely different implementation.

> 	- Mayby others (smells like Lance implementations...)

 The PMAX/NetBSD port has one, also derived from mopd 2.5.3, actively
maintained.

> Some of them seem to be forked off each other, so it would be a nice
> thing to unify them again. Anybody interested in having _one_ mopd?

 Well, I started with the original 2.5.3 release, then I added fixes and
updates I found useful from the sources you quote (plus NetBSD).  I
filtered out questionable changes and whitespace rearrangements, the
latter not to obfuscate the code until a real release happens.  So as of
the date of the patches I consider the version a synthesis of all
available implementations. 

> Anybody willing to do the job? I'll have to ask the VAX people also...

 I was considering undertaking a real maintenance but I'm still unsure I
can fullfill any timeline.  The future maintainer would have to get an
official statement from Mats as well.

 I already talked to VAX/Linux people.  They didn't seem much interested
in ELF support as it would require changes to their kernel, mostly to the
ld script (I even wrote an appropriate patch for them; though the syntax
seems unfriendly and should probably be revised in binutils) as the VAX
console seems to use physical addressing for loading images and the kernel
is linked at virtual addresses (naturally).  They seem to exploit a trick
with faking a DEC proprietary image, by prepending 512 null bytes to a
kernel image.  It works because the virtual start address of the VAX/Linux
kernel maps to the physical address zero and the entry point is zero as
well (some head code takes care of remapping addresses) so the values
fetched by mopd from the artifical header just work.

 BTW, while talking to both NetBSD and VAX/Linux people I was surprised by
responses like: "MOP-boot an ELF image?  That's impossible, MOP
specification much predates ELF -- how could an implementation handle
it?", as if there was any relevance between ELF and MOP...  It looked like
hardly anyone had an idea of how MOP and mopd work, yet they questioned
the facts.

> Except VAX and DECstations - who does also use MOP for booting?

 I don't know if anyone uses it, but essentially all DEC devices capable
of network-booting are able to use MOP for it.  A subset of them may be
able to use other protocols, e.g. BOOTP/TFTP.  Apart from host systems,
examples of such devices are terminal servers.

 BTW, I use this mopd exclusively to boot my DECstations, even though one
of them supports BOOTP/TFTP just fine and I could swap ROMs to make the
other work, too.  I just find MOP more suitable for the task and I don't
need to route BOOTP/TFTP packets across networks (which would exclude MOP
from possible choices).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
