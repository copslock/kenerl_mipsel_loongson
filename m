Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UJZxM18297
	for linux-mips-outgoing; Wed, 30 Jan 2002 11:35:59 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UJZld18293
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 11:35:48 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA14232;
	Wed, 30 Jan 2002 19:35:15 +0100 (MET)
Date: Wed, 30 Jan 2002 19:35:13 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geoffrey Espin <espin@idiom.com>
cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] Compiler warnings and remove unused code....
In-Reply-To: <20020130102340.A37609@idiom.com>
Message-ID: <Pine.GSO.3.96.1020130193233.8443D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 30 Jan 2002, Geoffrey Espin wrote:

> drivers/char/char.o(.data+0x3958): undefined reference to `local symbols in discarded section .text.exit'
> drivers/net/net.o(.data+0x17c): undefined reference to `local symbols in discarded section .text.exit'
> drivers/usb/usbdrv.o(.data+0x4b0): undefined reference to `local symbols in discarded section .text.exit'
> make: *** [vmlinux] Error 1
> 
> 
> This is linux.2.4.16 + sourceforge/mipslinux (a few weeks old).

 These errors are not MIPS-specific.  They were introduced by a stricter
symbol checking in recent binutils.  Many of them (but possibly not all)
are removed in Linux 2.4.17.  Please try the current version and see if
they persist.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
