Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 17:17:33 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:52742 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225283AbULORR1>; Wed, 15 Dec 2004 17:17:27 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E586CF5973; Wed, 15 Dec 2004 18:17:11 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11083-05; Wed, 15 Dec 2004 18:17:11 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id AB5F6F5970; Wed, 15 Dec 2004 18:17:11 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iBFHHOb2008822;
	Wed, 15 Dec 2004 18:17:24 +0100
Date: Wed, 15 Dec 2004 17:17:14 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: wlacey <wlacey@goldenhindresearch.com>, linux-mips@linux-mips.org
Subject: Re: No PCI_AUTO in 2.6...
In-Reply-To: <20041215164036.GC30130@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0412151648460.2706@blysk.ds.pg.gda.pl>
References: <20041211134305.22769.qmail@server212.com> <20041215135656.GA28665@linux-mips.org>
 <Pine.LNX.4.58L.0412151456050.2706@blysk.ds.pg.gda.pl>
 <20041215164036.GC30130@linux-mips.org>
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
X-archive-position: 6679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 15 Dec 2004, Ralf Baechle wrote:

> >  Also for most PCI systems I/O port space should really start at 0 (for
> > "legacy" devices being decoded by the PCI-ISA bridge if there's one in the
> > system), but generic code braindamage prevents it currently.  I think
> > there was only about a single PCI chipset that had a "reversed"
> > architecture and sort-of bridged PCI over ISA -- the Intel i82420EX for
> > the i486 processor.  It would need a separate ISA I/O resource for a
> > correct view of the system.
> 
> In the above case, the I/O port resource is starting at 0x1000 because
> the range of 0x0 - 0xfff contains a few legacy devices.  The way the SNI
> code is initializing sni_io_resource ensures all the legacy devices
> are properly listed in the iomem_resource and /proc/ioports and the kernel
> will never place any I/O resource for a PCI card in the legacy port range.

 I know and I consider it a bug.  The correct way would be setting the 
start at 0 and if avoiding the first kB of space was necessary, setting 
PCIBIOS_MIN_IO to 0x1000.

> As the result we'll get:
> 
> [root@tbird root]# cat /proc/ioports
> 00000000-0000001f : dma1
> 00000020-0000003f : pic1
> 00000040-0000005f : timer
> 00000060-0000006f : keyboard
> 00000070-00000077 : rtc
> 00000080-0000008f : dma page reg
> 000000a0-000000bf : pic2
> 000000c0-000000df : dma2
> 000002f8-000002ff : serial
> 000003c0-000003df : vga+
> 000003f8-000003ff : serial
> 00000cfc-00000cff : PCI config data
> 00001000-03bfffff : PCIMT IO MEM
>   00001000-000010ff : 0000:00:01.0
>     00001000-000010ff : sym53c8xx
>   00001400-0000141f : 0000:00:02.0
>     00001400-0000141f : pcnet32_probe_pci
> [root@tbird root]#
> 
> This makes it look like the legacy ports are not behind the PCI bus
> which actually they are but that's a minor nit, it gets the address
> space allocation to work right.

 I think it's going to matter if a PCI-ISA bridge is behind one or more
PCI-PCI bridges.  I have an idea of a fix, but my initial approach haven't
worked particularly well and I've had no time to dig into it further.  
Actually, on systems with PCI I think reserving legacy resources should
happen only after they have been discovered (you don't need any PC/AT or
ISA devices for a PCI configuration space scan), but that may be tough, so
I've thought of an alternative.

 Also the map of legacy resources reserved is actually incomplete -- PIC's
ELCR is missing for example.

> >  Things start being tricky once you have to use such an offset for DMA
> > transfers as well...
> 
> True, but that's dealt with elsewhere.  And I never claimed the mess that
> PCI used to be in 2.4 has yet been fully cleaned up yet, more work to do.

 Sure, I'm more or less happy about the new code.  I'm just warning about 
possible pitfalls.

 There is one more problem with the PCI resource manager -- it messes with
BARs of host bridges without asking for permission (which is often a
no-no, as any messing with host bridges in general).  I have a patch for
it I'm currently trying to push to the PCI maintainer.  See the thread at
"http://www.uwsg.iu.edu/hypermail/linux/kernel/0412.1/0484.html" if
interested.  It's already being done correctly for i386 (some would
probably argue that's what's most important) and ppc which use their own
resource managers instead of the generic one.

  Maciej
