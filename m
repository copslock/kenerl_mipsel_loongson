Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4ODjnk16056
	for linux-mips-outgoing; Thu, 24 May 2001 06:45:49 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4ODiIF16017
	for <linux-mips@oss.sgi.com>; Thu, 24 May 2001 06:44:31 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA15307;
	Thu, 24 May 2001 15:42:56 +0200 (MET DST)
Date: Thu, 24 May 2001 15:42:56 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] incorrect asm constraints for ll/sc constructs
In-Reply-To: <20010523145257.A13013@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1010524134521.6990F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 23 May 2001, Daniel Jacobowitz wrote:

> The ll/sc constructs in the kernel use ".set noat" to inhibit use of $at,
> and proceed to use it themselves.  This is fine, except for one problem: the
> constraints on memory operands are "o" and "=o", which means offsettable
> memory references.  If I'm not mistaken, the assembler will (always?)
> turn these into uses of $at if the offset is not 0 - at least, it certainly
> seems to do that here (gcc 2.95.3, binutils 2.10.91.0.2).  Just being honest
> with the compiler and asking for a real memory reference does the trick. 

 Both "m" and "o" seem to be incorrect here as both are the same for MIPS; 
"R" seems to be appropriate, OTOH.  Still gcc 2.95.3 doesn't handle "R" 
fine for all cases, but it works most of the time and emits a warning
otherwise.  I can't comment on 3.0.

 Note that if noat is in effect and at is to be used, gas should bail out
with an error.  There is a bug, if it doesn't.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
