Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 15:25:41 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:53515 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225005AbULOPZg>; Wed, 15 Dec 2004 15:25:36 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 0116FE1CBC; Wed, 15 Dec 2004 16:25:13 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28756-02; Wed, 15 Dec 2004 16:25:12 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A5DE4E1CB3; Wed, 15 Dec 2004 16:25:12 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iBFFPLSX002443;
	Wed, 15 Dec 2004 16:25:22 +0100
Date: Wed, 15 Dec 2004 15:25:13 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: wlacey <wlacey@goldenhindresearch.com>, linux-mips@linux-mips.org
Subject: Re: No PCI_AUTO in 2.6...
In-Reply-To: <20041215135656.GA28665@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0412151456050.2706@blysk.ds.pg.gda.pl>
References: <20041211134305.22769.qmail@server212.com> <20041215135656.GA28665@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/617/Sun Dec  5 16:25:39 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 15 Dec 2004, Ralf Baechle wrote:

> Here's a simplified example from arch/mips/sni/setup.c:
> 
> static struct resource sni_io_resource = {
>         "PCIMT IO MEM", 0x00001000UL, 0x03bfffffUL, IORESOURCE_IO,
> };
> 
> static struct resource sni_mem_resource = {
>         "PCIMT PCI MEM", 0x10000000UL, 0xffffffffUL, IORESOURCE_MEM
> };

 I think it's more descriptive to call them "<foo> PCI I/O" and "<foo> PCI
MEM", respectively, to make it clearer the former expresses I/O port
addresses (not the associated memory address range for accesses to be
forwarded as PCI I/O cycles) and that both are PCI bus spaces.

 Also for most PCI systems I/O port space should really start at 0 (for
"legacy" devices being decoded by the PCI-ISA bridge if there's one in the
system), but generic code braindamage prevents it currently.  I think
there was only about a single PCI chipset that had a "reversed"
architecture and sort-of bridged PCI over ISA -- the Intel i82420EX for
the i486 processor.  It would need a separate ISA I/O resource for a
correct view of the system.

> That is PCI memory is in the address range of 0x10000000UL - 0xffffffffUL
> and I/O ports in the range 0x00001000UL - 0x03bfffffUL.  The io_offset
> rsp. mem_offset values say how much needs to be added rsp. subtracted
> when converting a PCI bus address into a physical address.  Often these
> values are either the same a the resource's start address or zero.

 Things start being tricky once you have to use such an offset for DMA
transfers as well...

  Maciej
