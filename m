Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7HN7Ln15552
	for linux-mips-outgoing; Fri, 17 Aug 2001 16:07:21 -0700
Received: from snfc21.pbi.net (mta5.snfc21.pbi.net [206.13.28.241])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HN7Ij15546
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 16:07:18 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta5.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GI8003UHIW4JX@mta5.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Fri, 17 Aug 2001 16:07:17 -0700 (PDT)
Date: Fri, 17 Aug 2001 16:07:15 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: latest au1000 updates
To: linux-mips-kernel@lists.sourceforge.net
Cc: linux-mips@oss.sgi.com
Reply-to: ppopov@pacbell.net
Message-id: <3B7DA3A3.8010000@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

James,

I pushed the latest au1000 code. I had to add a new vec0 handler for the au1000 
in head.S, much like the other vec0 ones. I also checked in the vr41xx patch. 
Jun indicated that he and/or Ralf reworked some of the 41xx so the 41xx will 
probably have to be updated again, but at least the kernel compiles.


To compile the code right at this moment, you need to make this local change in 
kernel/Makefile:

[ppopov@zeus linux-dev]$ diff ../stock/kernel/Makefile  kernel/Makefile
14c14
< obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
---
 > obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
17a18,21
 >
 > ifndef CONFIG_MIPS_AU1000
 > obj-y	 += dma.o
 > endif

and, this local change in drivers/net/Space.c:

diff ../stock/drivers/net/Space.c drivers/net/Space.c
103a104,105
 > extern int gt96100_probe(struct net_device *);
 > extern int au1000_probe(struct net_device *dev);
382a385,390
 > #endif
 > #ifdef CONFIG_MIPS_GT96100ETH
 > 	{gt96100_probe, 0},
 > #endif
 > #ifdef CONFIG_MIPS_AU1000_ENET
 > 	{au1000_probe, 0},


The Space.c patch really needs to go to Alan. I'll see if he'll take it. The 
kernel/Makefile patch probably needs to be reworked so that we don't have to 
touch kernel/Makefile.

I tested the kernel and it seems to work fine, so I think I got everything. 
However, I haven't tested the fb driver, pcmcia, usb, etc, etc with this kernel. 
Also, note that if anyone needs usb on this board or any other au1000 board, 
we'll need to send a local usb patch for non-pci devices. Steve already had most 
of his work accepted in the usb tree, but the non-pci patch wasn't accepted 
because the usb code is going through some reorg right now. So, without this usb 
patch which is only in the MontaVista tree at the moment, usb is not usable on 
this board.

There are Au1000 customers showing up all over the place, so having the latest 
code in sourceforge is a good thing.  Now I have to find the time to create a 
patch against the oss tree...

Pete
