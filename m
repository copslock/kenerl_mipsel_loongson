Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 22:16:48 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:18393 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225223AbTCMWQr>;
	Thu, 13 Mar 2003 22:16:47 +0000
Received: (qmail 21301 invoked by uid 6180); 13 Mar 2003 22:16:46 -0000
Date: Thu, 13 Mar 2003 14:16:46 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: IRQ warnings during boot on Au1500/DB1500
Message-ID: <20030313141645.A20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <3E70EACF.8F6629E4@ekner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E70EACF.8F6629E4@ekner.info>; from hartvig@ekner.info on Thu, Mar 13, 2003 at 09:32:15PM +0100
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Hartvig:

I get the same messages when I try to use a PCI CardBus bridge in polling mode
(INTA disabled).

Regards,
Jeff


On Thu, Mar 13, 2003 at 09:32:15PM +0100, Hartvig Ekner wrote:
> Hi,
> 
> with current 2.4 CVS, I get these messages during boot on a DB1500:
> 
> ...
> eth0: Using AMD 79C874 10/100 BaseT PHY as default
> eth1: Au1xxx ethernet found at 0xb1510000, irq 29
> eth1: AMD 79C874 10/100 BaseT PHY at phy address 31
> eth1: Using AMD 79C874 10/100 BaseT PHY as default
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PDC20268: IDE controller at PCI slot 00:0d.0
> PDC20268: chipset revision 2
> PDC20268: not 100% native mode: will probe irqs later
> PDC20268: ROM enabled at 0x000dc000
>     ide0: BM-DMA at 0x0520-0x0527, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x0528-0x052f, BIOS settings: hdc:pio, hdd:pio
> hda: IBM-DTLA-307030, ATA DISK drive
> blk: queue 802d01e0, I/O limit 4095Mb (mask 0xffffffff)
> warning: end_irq 62 did not enable (6)
> warning: end_irq 60 did not enable (6)
> warning: end_irq 59 did not enable (6)
> warning: end_irq 58 did not enable (6)
> warning: end_irq 57 did not enable (6)
> warning: end_irq 55 did not enable (6)
> warning: end_irq 54 did not enable (6)
> warning: end_irq 52 did not enable (6)
> warning: end_irq 51 did not enable (6)
> warning: end_irq 50 did not enable (6)
> warning: end_irq 49 did not enable (6)
> warning: end_irq 48 did not enable (6)
> warning: end_irq 46 did not enable (6)
> warning: end_irq 45 did not enable (6)
> warning: end_irq 44 did not enable (6)
> warning: end_irq 43 did not enable (6)
> warning: end_irq 42 did not enable (6)
> warning: end_irq 41 did not enable (6)
> warning: end_irq 40 did not enable (6)
> warning: end_irq 39 did not enable (6)
> warning: end_irq 38 did not enable (6)
> warning: end_irq 18 did not enable (6)
> warning: end_irq 14 did not enable (6)
> warning: end_irq 62 did not enable (16)
> warning: end_irq 60 did not enable (16)
> warning: end_irq 59 did not enable (16)
> warning: end_irq 58 did not enable (16)
> warning: end_irq 57 did not enable (16)
> warning: end_irq 55 did not enable (16)
> warning: end_irq 54 did not enable (16)
> warning: end_irq 52 did not enable (16)
> warning: end_irq 51 did not enable (16)
> warning: end_irq 50 did not enable (16)
> warning: end_irq 49 did not enable (16)
> warning: end_irq 48 did not enable (16)
> warning: end_irq 46 did not enable (16)
> warning: end_irq 45 did not enable (16)
> warning: end_irq 44 did not enable (16)
> warning: end_irq 43 did not enable (16)
> warning: end_irq 42 did not enable (16)
> warning: end_irq 41 did not enable (16)
> warning: end_irq 40 did not enable (16)
> warning: end_irq 39 did not enable (16)
> warning: end_irq 38 did not enable (16)
> warning: end_irq 18 did not enable (16)
> hde: IRQ probe failed (0xfffbfffe)
> warning: end_irq 62 did not enable (6)
> warning: end_irq 60 did not enable (6)
> warning: end_irq 59 did not enable (6)
> warning: end_irq 58 did not enable (6)
> warning: end_irq 57 did not enable (6)
> warning: end_irq 55 did not enable (6)
> warning: end_irq 54 did not enable (6)
> warning: end_irq 52 did not enable (6)
> warning: end_irq 51 did not enable (6)
> warning: end_irq 50 did not enable (6)
> warning: end_irq 49 did not enable (6)
> 
> Once the IDE probing is done, these messages don't seem to appear any more, and the kernel runs ok. Anybody seeing similar messages?
> 
> /Hartvig
> 
> 
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
