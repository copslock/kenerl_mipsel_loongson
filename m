Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 20:28:49 +0000 (GMT)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:63504 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225223AbTCMU2s>;
	Thu, 13 Mar 2003 20:28:48 +0000
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id 103DFB51E
	for <linux-mips@linux-mips.org>; Thu, 13 Mar 2003 21:28:47 +0100 (CET)
Message-ID: <3E70EACF.8F6629E4@ekner.info>
Date: Thu, 13 Mar 2003 21:32:15 +0100
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: IRQ warnings during boot on Au1500/DB1500
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

Hi,

with current 2.4 CVS, I get these messages during boot on a DB1500:

...
eth0: Using AMD 79C874 10/100 BaseT PHY as default
eth1: Au1xxx ethernet found at 0xb1510000, irq 29
eth1: AMD 79C874 10/100 BaseT PHY at phy address 31
eth1: Using AMD 79C874 10/100 BaseT PHY as default
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20268: IDE controller at PCI slot 00:0d.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: ROM enabled at 0x000dc000
    ide0: BM-DMA at 0x0520-0x0527, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x0528-0x052f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DTLA-307030, ATA DISK drive
blk: queue 802d01e0, I/O limit 4095Mb (mask 0xffffffff)
warning: end_irq 62 did not enable (6)
warning: end_irq 60 did not enable (6)
warning: end_irq 59 did not enable (6)
warning: end_irq 58 did not enable (6)
warning: end_irq 57 did not enable (6)
warning: end_irq 55 did not enable (6)
warning: end_irq 54 did not enable (6)
warning: end_irq 52 did not enable (6)
warning: end_irq 51 did not enable (6)
warning: end_irq 50 did not enable (6)
warning: end_irq 49 did not enable (6)
warning: end_irq 48 did not enable (6)
warning: end_irq 46 did not enable (6)
warning: end_irq 45 did not enable (6)
warning: end_irq 44 did not enable (6)
warning: end_irq 43 did not enable (6)
warning: end_irq 42 did not enable (6)
warning: end_irq 41 did not enable (6)
warning: end_irq 40 did not enable (6)
warning: end_irq 39 did not enable (6)
warning: end_irq 38 did not enable (6)
warning: end_irq 18 did not enable (6)
warning: end_irq 14 did not enable (6)
warning: end_irq 62 did not enable (16)
warning: end_irq 60 did not enable (16)
warning: end_irq 59 did not enable (16)
warning: end_irq 58 did not enable (16)
warning: end_irq 57 did not enable (16)
warning: end_irq 55 did not enable (16)
warning: end_irq 54 did not enable (16)
warning: end_irq 52 did not enable (16)
warning: end_irq 51 did not enable (16)
warning: end_irq 50 did not enable (16)
warning: end_irq 49 did not enable (16)
warning: end_irq 48 did not enable (16)
warning: end_irq 46 did not enable (16)
warning: end_irq 45 did not enable (16)
warning: end_irq 44 did not enable (16)
warning: end_irq 43 did not enable (16)
warning: end_irq 42 did not enable (16)
warning: end_irq 41 did not enable (16)
warning: end_irq 40 did not enable (16)
warning: end_irq 39 did not enable (16)
warning: end_irq 38 did not enable (16)
warning: end_irq 18 did not enable (16)
hde: IRQ probe failed (0xfffbfffe)
warning: end_irq 62 did not enable (6)
warning: end_irq 60 did not enable (6)
warning: end_irq 59 did not enable (6)
warning: end_irq 58 did not enable (6)
warning: end_irq 57 did not enable (6)
warning: end_irq 55 did not enable (6)
warning: end_irq 54 did not enable (6)
warning: end_irq 52 did not enable (6)
warning: end_irq 51 did not enable (6)
warning: end_irq 50 did not enable (6)
warning: end_irq 49 did not enable (6)

Once the IDE probing is done, these messages don't seem to appear any more, and the kernel runs ok. Anybody seeing similar messages?

/Hartvig
