Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Aug 2005 05:25:34 +0100 (BST)
Received: from loopy.telegraphics.com.au ([IPv6:::ffff:202.45.126.152]:33207
	"EHLO loopy.telegraphics.com.au") by linux-mips.org with ESMTP
	id <S8224808AbVHTEZQ>; Sat, 20 Aug 2005 05:25:16 +0100
Received: by loopy.telegraphics.com.au (Postfix, from userid 1001)
	id 6D36FC989D; Sat, 20 Aug 2005 14:30:12 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by loopy.telegraphics.com.au (Postfix) with ESMTP id 6686EC969E;
	Sat, 20 Aug 2005 14:30:12 +1000 (EST)
Date:	Sat, 20 Aug 2005 14:30:12 +1000 (EST)
From:	Finn Thain <fthain@telegraphics.com.au>
To:	Jeff Garzik <jgarzik@pobox.com>,
	Roman Zippel <zippel@linux-m68k.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@vger.kernel.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux MIPS <linux-mips@linux-mips.org>,
	Linux net <linux-net@vger.kernel.org>
Subject: Re: [PATCH] macsonic/jazzsonic drivers update (part 2)
In-Reply-To: <Pine.LNX.4.61.0507130122220.4355@loopy.telegraphics.com.au>
Message-ID: <Pine.LNX.4.63.0508201406350.3539@loopy.telegraphics.com.au>
References: <200503070210.j272ARii023023@hera.kernel.org>
 <Pine.LNX.4.62.0503221807160.20753@numbat.sonytel.be> <20050323100139.GB8813@linux-mips.org>
 <Pine.LNX.4.61.0506121454410.1470@loopy.telegraphics.com.au>
 <20050615114158.GA9411@linux-mips.org> <Pine.LNX.4.61.0506152220460.22046@loopy.telegraphics.com.au>
 <20050615142717.GD9411@linux-mips.org> <Pine.LNX.4.61.0506160218310.24328@loopy.telegraphics.com.au>
 <Pine.LNX.4.61.0506160336410.24908@loopy.telegraphics.com.au>
 <20050616092257.GE5202@linux-mips.org> <Pine.LNX.4.61.0506162129450.31164@loopy.telegraphics.com.au>
 <Pine.LNX.4.61.0506270227510.1015@loopy.telegraphics.com.au>
 <42BEEC32.7040807@pobox.com> <Pine.LNX.4.61.0507130122220.4355@loopy.telegraphics.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <fthain@telegraphics.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fthain@telegraphics.com.au
Precedence: bulk
X-list: linux-mips



On Wed, 13 Jul 2005, Finn Thain wrote:

> On Sun, 26 Jun 2005, Jeff Garzik wrote:
> 
> > Patch looks OK to me.  Comments:
> > 
> > 1) Either Geert or Ralf can merge this, with my ACK.
> > 
> > 2) Would be nice to get it tested on the machines you list as untested.
> > 
> > 3) [possible problem in driver, not your changes] I wonder if IRQ_HANDLED is
> > ever returned for shared interrupts?  I don't know enough about the platform
> > interrupt architecture to answer this question.
> > 
> > 4) Remove casts to/from void.  This is especially noticable in all the casts
> > of the netdev_priv() return value.
> >
> > 5) If it doesn't cause too much patch noise, consider using enums rather than
> > #defines, for numeric constants.  This gives the compiler more type
> > information and makes the symbols visible in a debugger.  This is a
> > -maintainer preference- issue overall, so don't sweat it if you disagree.
> 
> 
> This patch removes the unecessary void* casts introduced in the first patch.

Update:

The two patches referred to above have been tested on Jazz MIPS and
ack'd off-list by Thomas Bogendorfer. He also added the cosmetic change below.

I think this is ready to be merged (Jeff?)

Roman, is your m68k DMA implementation ready for commit? Thomas will take 
care of the Jazz one.

Thanks

-f


Acked-off: by Thomas Bogendoerfer <tsbogend@alpha.franken.de>


--- jazzsonic.c.orig	2005-08-18 23:15:24.067805832 +0200
+++ jazzsonic.c	2005-08-18 23:18:15.895684024 +0200
@@ -123,7 +123,7 @@
 	if (sonic_debug  &&  version_printed++ == 0)
 		printk(version);
 
-	printk("%s: Sonic ethernet found at 0x%08lx, ", lp->device->bus_id, dev->base_addr);
+	printk(KERN_INFO "%s: Sonic ethernet found at 0x%08lx, ", lp->device->bus_id, dev->base_addr);
 
 	/*
 	 * Put the sonic into software reset, then
@@ -238,7 +238,7 @@
 	if (err)
 		goto out1;
 
-	printk(KERN_INFO "%s: MAC ", dev->name);
+	printk("%s: MAC ", dev->name);
 	for (i = 0; i < 6; i++) {
 		printk("%2.2x", dev->dev_addr[i]);
 		if (i < 5)
