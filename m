Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0HGWCX20929
	for linux-mips-outgoing; Thu, 17 Jan 2002 08:32:12 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0HGVuP20926;
	Thu, 17 Jan 2002 08:31:57 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA17873;
	Thu, 17 Jan 2002 16:31:03 +0100 (MET)
Date: Thu, 17 Jan 2002 16:31:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: IDE driver broken in bigendian 2.4.17 kernel
In-Reply-To: <3C46D248.931FB659@mips.com>
Message-ID: <Pine.GSO.3.96.1020117155914.16712A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 17 Jan 2002, Carsten Langgaard wrote:

> One could argue that the IDE driver should use it's own special functions
> (like ide_insl, etc ...) and not use the generic functions (insl, etc ...).

 If it's due to a problem with an IDE host adapter then it should be fixed
within the IDE driver (or not at all and kept privately as needed).  In no
case the order of header inclusions may determine function or macro
definitions. 

> But all other architectures does it this way, so I'm just trying to follow
> the trend.

 It does not mean other architectures are right here.  Possibly they have
not hit the problem so far.

 If the problem is generic to a chipset, then you indeed need to redefine
I/O macros, but then in <asm/io.h>.  If that's PCI-specific, for example,
then you should probably make the redefinition conditional on CONFIG_PCI. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
