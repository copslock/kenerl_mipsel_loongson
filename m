Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5PDKaH30628
	for linux-mips-outgoing; Mon, 25 Jun 2001 06:20:36 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5PDKVV30625
	for <linux-mips@oss.sgi.com>; Mon, 25 Jun 2001 06:20:31 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA23892;
	Mon, 25 Jun 2001 15:22:11 +0200 (MET DST)
Date: Mon, 25 Jun 2001 15:22:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS_UNCACHED
In-Reply-To: <3B34D6AC.9EACA819@mvista.com>
Message-ID: <Pine.GSO.3.96.1010625144529.20469G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 23 Jun 2001, Jun Sun wrote:

> I think you just proposed a fix: check current config register when we turn
> off cache.  Thanks. :-)

 Note that many MIPS CPUs do not have the config register that could be
used to turn the cache off.  That's not a problem for the userland as it's
controlled on a page-by-page basis, but the kernel runs unmapped (except
from modules) and user vs kernel memory coherency problems arise.  I have
a patch that makes the kernel run in the KSEG1 space (which is uncached by
default even on processors that have the config register).  It needs a
minor clean-up for exception handlers, though, as they start in KSEG0 with
no possibility to override.  So they should jump to KSEG1 ASAP --
hopefully two icache lines are OK; if cache in non-functional then we are
screwed as using bootstrap exception vectors is not an option, usually.
Cacheability of KSEG0 may be further disabled if possible. 

 I'll send the patch soon, when I clean it up.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
