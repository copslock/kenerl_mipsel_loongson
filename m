Received:  by oss.sgi.com id <S553867AbQLKTG1>;
	Mon, 11 Dec 2000 11:06:27 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:60057 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553863AbQLKTGV>;
	Mon, 11 Dec 2000 11:06:21 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA10251;
	Mon, 11 Dec 2000 20:05:45 +0100 (MET)
Date:   Mon, 11 Dec 2000 20:05:45 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
In-Reply-To: <3A358CEB.1B986EB7@mvista.com>
Message-ID: <Pine.GSO.3.96.1001211192843.18945O-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 11 Dec 2000, Jun Sun wrote:

> I am surprised.  I thought /dev/mem is for accessing SYSTEM RAM.  (do a 'man'

 You access the memory space.  Whatever is found at the address you
specify, be it RAM, an MMIO area or unoccupied space.  You may receive a
bus error in the latter case (depending on a system configuration). 

> on /dev/mem)  It is also confirmed by the code in drivers/char/mem.c.  If you
> want to access anything beyond 'high_memory", nothing is read.  

 Yep, you may only use read()/write() for system RAM.  For other areas you
have to mmap() the interesting part of /dev/mem and then access it
directly (which is easier and better anyway, as you may control the width
of bus transfers -- not all MMIO devices support all widths). 

> Note that drivers/char/mem.c is cross-platform code.  I am not sure how X
> would access video memory through /dev/mem on either MIPS or other platforms.

 It mmap()s the areas it's interested in.  Read the code!

> That reason I want to fix /dev/kmem is that in some cases before a driver is
> written people want to play with the hardware directly from the userland
> (especially for demo purpose. :-0)  Very useful for embedded systems.

 I'm not sure how to use /dev/kmem for this purpose -- it's kernel's
*virtual* memory...
 
> Potentially fixing /dev/mem can do the same job.  However /dev/mem cannot
> differentiate cached or uncached accesses.  With /dev/kmem, we just specify
> 0x8.. or 0xa....

 Yep, /dev/mem for non system RAM areas is always uncached which is what
is almost always desired (for system RAM areas you may request
uncacheability by passing O_SYNC when opening the file).

 Anyway, /dev/mem works great -- I've successfully used it to access APICs
(at 0xfec00000 and 0xfee00000) in my i386 system and various stuff (an
NVRAM at 0x1c000000, a graphics accelerator at 0x1e000000, a FDDI network
controller at 0x1f000000, onboard I/O stuff at 0x1f800000 and a system ROM
at 0x1fc00000) in my DECstation. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
