Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2007 08:59:43 +0100 (BST)
Received: from lizzard.sbs.de ([194.138.37.39]:64089 "EHLO lizzard.sbs.de")
	by ftp.linux-mips.org with ESMTP id S20021611AbXD0H7j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Apr 2007 08:59:39 +0100
Received: from mail2.sbs.de (localhost [127.0.0.1])
	by lizzard.sbs.de (8.12.6/8.12.6) with ESMTP id l3R7xT4K015403;
	Fri, 27 Apr 2007 09:59:29 +0200
Received: from fthw9xoa.ww002.siemens.net (fthw9xoa.ww002.siemens.net [157.163.133.201])
	by mail2.sbs.de (8.12.6/8.12.6) with ESMTP id l3R7xMW2006598;
	Fri, 27 Apr 2007 09:59:28 +0200
Received: from stgw002a.ww002.siemens.net ([141.73.158.150]) by fthw9xoa.ww002.siemens.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 27 Apr 2007 09:59:24 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: pcmcia - failed to initialize IDE interface
Date:	Fri, 27 Apr 2007 10:00:06 +0200
Message-ID: <D7810733513F4840B4EBAAFA64D9C6A401307A69@stgw002a.ww002.siemens.net>
In-Reply-To: <20070425190753.fb8c272d.akpm@linux-foundation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pcmcia - failed to initialize IDE interface
Thread-Index: AceHqEmPYMhqH9+RSm+Ie3xgpMcxxgA9vZhw
From:	"Aeschbacher, Fabrice" <Fabrice.Aeschbacher@siemens.com>
To:	<linux-mips@linux-mips.org>
Cc:	"lkml" <linux-kernel@vger.kernel.org>,
	<linux-pcmcia@lists.infradead.org>
X-OriginalArrivalTime: 27 Apr 2007 07:59:24.0197 (UTC) FILETIME=[F8672550:01C788A1]
Return-Path: <Fabrice.Aeschbacher@siemens.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Fabrice.Aeschbacher@siemens.com
Precedence: bulk
X-list: linux-mips

I think I isolated the problem: in ide-cs.c, ide_config() is calling
pcmcia_request_irq(), and this function happens to set irq=35. This irq
was not rejected later in ide_probe.c, hwif_init():

  ide0: Disabled unable to get IRQ 35

I noticed that the old kernel 2.4.26 used irq=40 here. So I tried to
force pcmcia_request_irq() to set irq=40, like follows:

--- linux-2.6.20.7-orig/drivers/pcmcia/pcmcia_resource.c
2007-04-15 21:08:02.000000000 +0200
+++ linux-2.6.20.7/drivers/pcmcia/pcmcia_resource.c	2007-04-27
09:20:41.000000000 +0200
@@ -867,6 +867,7 @@
 		printk(KERN_WARNING "pcmcia: request for exclusive IRQ
could not be fulfilled.\n");
 		printk(KERN_WARNING "pcmcia: the driver needs updating
to supported shared IRQ lines.\n");
 	}
+	irq = 40;
 	c->irq.Attributes = req->Attributes;
 	s->irq.AssignedIRQ = req->AssignedIRQ = irq;
 	s->irq.Config++;

and this happens to work: ide_config() succeeds, and finally I can mount
the CF and use it.

Other values for irq (i tried 39, 41) won't work either.

Which would be the correct way to make pcmcia_request_irq() use the
correct value of 40?

Fabrice


> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org] 
> Sent: Donnerstag, 26. April 2007 04:08
> To: Aeschbacher, Fabrice
> Cc: lkml; linux-mips@linux-mips.org
> Subject: Re: pcmcia - failed to initialize IDE interface
> 
> On Wed, 25 Apr 2007 15:27:26 +0200 "Aeschbacher, Fabrice" 
> <Fabrice.Aeschbacher@siemens.com> wrote:
> 
> > Hi,
> > 
> > [kernel 2.6.20.7, arch=mips, processor=amd au1550]
> > 
> > I'm trying to install a 2.6 kernel on an Alchemy au1550, and having 
> > problem with the pcmcia socket, where I plugged a 
> CompactFlash card. 
> > The card seems to be recognized by the kernel, appears in 
> > /sys/bus/pcmcia/devices, but not in /proc/bus/pccard, and I can't 
> > access the device (/dev/hda).
> > 
> > The relevant console messages:
> > ----------------------------------------------------------------
> > pccard: PCMCIA card inserted into slot 0
> > pcmcia: registering new device pcmcia0.0
> > hda: SanDisk SDCFB-64, CFA DISK drive
> > ide0: Disabled unable to get IRQ 35.
> > ide0: failed to initialize IDE interface
> > ide0: I/O resource 0x10200E-0x10200E not free.
> > ide0: ports already in use, skipping probe
> > ide0: I/O resource 0x10200E-0x10200E not free.
> > ide0: ports already in use, skipping probe
> > ide0: I/O resource 0x10200E-0x10200E not free.
> > ide0: ports already in use, skipping probe
> > ide0: I/O resource 0x10200E-0x10200E not free.
> > ide0: ports already in use, skipping probe
> > ide0: I/O resource 0x10200E-0x10200E not free.
> > ide0: ports already in use, skipping probe
> > ide0: I/O resource 0x10200E-0x10200E not free.
> > ide0: ports already in use, skipping probe
> > ide0: I/O resource 0x10200E-0x10200E not free.
> > ide0: ports already in use, skipping probe
> > ide0: I/O resource 0x10200E-0x10200E not free.
> > ide0: ports already in use, skipping probe
> > ide0: I/O resource 0x10200E-0x10200E not free.
> > ide0: ports already in use, skipping probe
> > ide-cs: ide_register() at 0x102000 & 0x10200e, irq 35 failed
> > ----------------------------------------------------------------
> > 
> > Here is the relevant part of the kernel config:
> > CONFIG_IDE=y
> > CONFIG_IDE_GENERIC=y
> > CONFIG_BLK_DEV_IDE=y
> > CONFIG_BLK_DEV_IDECS=y
> > CONFIG_PCCARD=y
> > CONFIG_PCMCIA_DEBUG=y
> > CONFIG_PCMCIA=y
> > CONFIG_PCMCIA_AU1X00=y
> > 
> 
> (cc'ed linux-mips)
> 
> Perhaps /proc/ioports will tell us where the conflict lies.
> 
> The output of `dmesg -s 1000000' might also be needed.
> 
