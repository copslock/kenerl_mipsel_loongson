Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id PAA01145
	for <pstadt@stud.fh-heilbronn.de>; Mon, 9 Aug 1999 15:41:37 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA19829; Mon, 9 Aug 1999 06:36:15 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA40476
	for linux-list;
	Mon, 9 Aug 1999 06:28:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA08111
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 9 Aug 1999 06:27:57 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA04718
	for <linux@cthulhu.engr.sgi.com>; Mon, 9 Aug 1999 06:27:56 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id IAA06914;
	Mon, 9 Aug 1999 08:27:46 -0500
Date: Mon, 9 Aug 1999 16:24:19 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
Reply-To: "Andrew R. Baker" <andrewb@uab.edu>
To: Mike Hill <mikehill@hgeng.com>
cc: "'Ulf Carlsson'" <ulfc@thepuffingroup.com>, linux@cthulhu.engr.sgi.com
Subject: RE: Floptical Drive
In-Reply-To: <E138DB347D10D3119C630008C79F5DEC07EB93@BART>
Message-ID: <Pine.LNX.3.96.990809161906.24132A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


This patch should fix the error you are seing below, but probably won't do
much for your original complaint.

--- sgiseeq.c~	Fri Aug  6 08:25:29 1999
+++ sgiseeq.c	Mon Aug  9 16:18:16 1999
@@ -32,6 +32,7 @@
 #include <linux/skbuff.h>
 
 #include <asm/sgihpc.h>
+#include <asm/sgint23.h>
 #include <asm/sgialib.h>
 
 #include "sgiseeq.h"



On Fri, 6 Aug 1999, Mike Hill wrote:
> Same problem with 2.2, just a different error:
> 
> make[3]: Entering directory `/usr/src/mips/linux/drivers/net'
> mips-linux-gcc -D__KERNEL__ -I/usr/src/mips/linux/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
> -mcpu=r4600 -mips2 -pipe   -c -o sgiseeq.o sgiseeq.c
> sgiseeq.c: In function `sgiseeq_probe':
> sgiseeq.c:741: `SGI_ENET_IRQ' undeclared (first use this function)
> sgiseeq.c:741: (Each undeclared identifier is reported only once
> sgiseeq.c:741: for each function it appears in.)
> make[3]: *** [sgiseeq.o] Error 1
> make[3]: Leaving directory `/usr/src/mips/linux/drivers/net'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/mips/linux/drivers/net'
> make[1]: *** [_subdir_net] Error 2
> make[1]: Leaving directory `/usr/src/mips/linux/drivers'
> make: *** [_dir_drivers] Error 2
> 
> 
> > -----Original Message-----
> > From:	Ulf Carlsson [SMTP:ulfc@thepuffingroup.com]
> > Sent:	Wednesday, August 04, 1999 2:30 PM
> > To:	Mike Hill
> > Cc:	linux@cthulhu.engr.sgi.com
> > Subject:	Re: Floptical Drive
> > 
> > > When I try to add msdos or vfat filesystem support to the kernel (latest
> > > CVS) I get the following failure:
> > 
> > Linus broke all filesystems some time ago, this is not MIPS specific.
> > 
> > Try the 2.2 kernel instead, I think they should be ok.
> > 
> > Ulf
> 
