Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2003 13:13:17 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:48632 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224847AbTDBMNQ>; Wed, 2 Apr 2003 13:13:16 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA02820;
	Wed, 2 Apr 2003 14:13:21 +0200 (MET DST)
Date: Wed, 2 Apr 2003 14:13:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pete Popov <ppopov@mvista.com>
cc: Hartvig Ekner <hartvig@ekner.info>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: IDE initialization on AU1500?
In-Reply-To: <1049052911.1919.11.camel@adsl.pacbell.net>
Message-ID: <Pine.GSO.3.96.1030402140446.1177E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 30 Mar 2003, Pete Popov wrote:

> > Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > PDC20268: IDE controller at PCI slot 00:0d.0
> > PDC20268: chipset revision 2
> > PDC20268: not 100% native mode: will probe irqs later
> > PDC20268: ROM enabled at 0x000dc000
> >     ide0: BM-DMA at 0x0520-0x0527, BIOS settings: hda:pio, hdb:pio
> >     ide1: BM-DMA at 0x0528-0x052f, BIOS settings: hdc:pio, hdd:pio
> > hdc: IBM-DTLA-307030, ATA DISK drive
> > blk: queue 802f7a58, I/O limit 4095Mb (mask 0xffffffff)
> > hdg: IRQ probe failed (0xfffbfffe)
> > hdg: IRQ probe failed (0xfffbbffe)
> > hdi: probing with STATUS(0x24) instead of ALTSTATUS(0x00)
> > hdi: IRQ probe failed (0xfffbfffe)
> > hdi: IRQ probe failed (0xfffbbffe)
> > hdk: probing with STATUS(0x24) instead of ALTSTATUS(0x00)
> > ide1 at 0x510-0x517,0x51a on irq 1
> > hdc: host protected area => 1
> > hdc: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
> > Partition check:
> >  hdc: hdc1 hdc2 hdc3 hdc4
> > 
> > Are the "IRQ probe failed" and "probing with ..." messages expected and ok?  
> 
> Well, since the ide subsystem is probing all the drives, and there are
> no drives to be found, I would have to say that the failures are to be
> expected.

 The IRQ probes shouldn't happen for hdg and hdi (the shift of names
resulting in hdk is probably another bug), just like they don't happen for
hda.  There is no point from probing inexistent drives for IRQs as it
won't work.  And probing for drives themselves uses polled I/O. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
