Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Mar 2003 20:33:15 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:9468 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225072AbTC3TdN>;
	Sun, 30 Mar 2003 20:33:13 +0100
Received: from [10.2.2.20] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA01684;
	Sun, 30 Mar 2003 11:33:05 -0800
Subject: Re: IDE initialization on AU1500?
From: Pete Popov <ppopov@mvista.com>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <3E873DA0.A8B9B807@ekner.info>
References: <3E873DA0.A8B9B807@ekner.info>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1049052911.1919.11.camel@adsl.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 30 Mar 2003 11:35:11 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Hartvig,

I added the mailing list to the CC because someone else might have a
better answer.

On Sun, 2003-03-30 at 10:55, Hartvig Ekner wrote:
> Hi Pete,
> 
> I upgraded to the latest 2.4, and all the end_irq warnings which were there a few
> weeks back are gone. 

Yep, I got rid of the debug print :). I had put that print in irq.c a
long time ago, and it never caused any problems. But back then, the irq
probing routines were null in MIPS, so we never saw the print.

> Now it looks like this:
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PDC20268: IDE controller at PCI slot 00:0d.0
> PDC20268: chipset revision 2
> PDC20268: not 100% native mode: will probe irqs later
> PDC20268: ROM enabled at 0x000dc000
>     ide0: BM-DMA at 0x0520-0x0527, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x0528-0x052f, BIOS settings: hdc:pio, hdd:pio
> hdc: IBM-DTLA-307030, ATA DISK drive
> blk: queue 802f7a58, I/O limit 4095Mb (mask 0xffffffff)
> hdg: IRQ probe failed (0xfffbfffe)
> hdg: IRQ probe failed (0xfffbbffe)
> hdi: probing with STATUS(0x24) instead of ALTSTATUS(0x00)
> hdi: IRQ probe failed (0xfffbfffe)
> hdi: IRQ probe failed (0xfffbbffe)
> hdk: probing with STATUS(0x24) instead of ALTSTATUS(0x00)
> ide1 at 0x510-0x517,0x51a on irq 1
> hdc: host protected area => 1
> hdc: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
> Partition check:
>  hdc: hdc1 hdc2 hdc3 hdc4
> 
> Are the "IRQ probe failed" and "probing with ..." messages expected and ok?  

Well, since the ide subsystem is probing all the drives, and there are
no drives to be found, I would have to say that the failures are to be
expected.

> Is there something platform
> specific which tells the IDE driver to look for 11 drives (hda-hdk) or what is 
> going on here? 

include/asm-mips/ide.h defines MAX_HWIFS 10, if not already defined.

> As you can probably tell, I don't have any specific knowledge about
> how the IDE initialization works and how it interacts with the
> platform specific code (if at all), but I would somehow imagine that
> unless the IDE drivers detect an IDE controller (as done above: ide0,
> ide1) no probing should be performed for drives outside the possible
> range of the detected IDE controllers (hda-hdd in this case).

That's a good point. I don't know what's going on, which is why I added
the mailing list to the CC. Something seems not quite right.

Pete
