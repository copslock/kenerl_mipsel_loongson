Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JGhunC031113
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 09:43:56 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JGhuE0031112
	for linux-mips-outgoing; Wed, 19 Jun 2002 09:43:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JGhnnC031108
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 09:43:50 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA25063;
	Wed, 19 Jun 2002 18:47:05 +0200 (MET DST)
Date: Wed, 19 Jun 2002 18:47:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@psi.cz>
cc: linux-mips@oss.sgi.com
Subject: Re: DBE/IBE handling incompatibility
In-Reply-To: <20020617113311.GA839@kopretinka>
Message-ID: <Pine.GSO.3.96.1020619182253.15094Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 17 Jun 2002, Ladislav Michl wrote:

> i'd like to release GIO64 bus support. Before doing so DBE/IBE handling
> should be done in the same fashion for both mips and mips64 (*). Currently
> mips is using handler in handler via dbe_board_handler and ibe_board_handler 
> which are not used anywhere while mips64 is using BUILD_HANDLER macro defined
> in include/asm-mips64/exception.h (see arch/mips64/sgi-ip27/ip27-dbe-glue.S)
> Unfortunately I have nearly zero knowledge of MIPS assembler, so I'm
> unable to code mips way same as mips64 is... Help from someone more
> experienced will be greatly appreciated :-)

 I'm going to work on unifying and extending the code a bit once I have my
64-bit world running, so don't worry about the divergence between the
ports. 

 Don't rely in dbe_board_handler and ibe_board_handler -- they are
system-specific backends that shouldn't be touched unless you want to
handle the exceptions in a system-specific way (e.g. to report ECC errors
from a memory controller).  Also expect the handlers to get rewritten so
that search_dbe_table() gets invoked unconditionally, before a
system-specific backend.

> (*) How GIO device detection works? each IP22 machine contains three GIO bus
> slots. GIO device provides information about itself in first (three) word(s)
> of address space it occupies. The only way how to detect GIO card is
> trying to read word from it's base address. If DBE exception is generated 
> then there is definitely no card present, otherwise read value encodes 
> information about device.

 Use get_dbe() from <asm/paccess.h> for reading data with an additional
DBE status.  For a simple example see drivers/mtd/devices/ms02-nv.c.  The
macro is used in a somewhat more complex way in drivers/tc/tc.c as well --
this bit of code fits your situation quite closely (here probing
TURBOchannel bus slots).  The macro works in modules as well. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
