Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 16:40:57 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:52501
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225005AbULOQkw>; Wed, 15 Dec 2004 16:40:52 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBFGebsd031883;
	Wed, 15 Dec 2004 17:40:37 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBFGea8N031882;
	Wed, 15 Dec 2004 17:40:36 +0100
Date: Wed, 15 Dec 2004 17:40:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: wlacey <wlacey@goldenhindresearch.com>, linux-mips@linux-mips.org
Subject: Re: No PCI_AUTO in 2.6...
Message-ID: <20041215164036.GC30130@linux-mips.org>
References: <20041211134305.22769.qmail@server212.com> <20041215135656.GA28665@linux-mips.org> <Pine.LNX.4.58L.0412151456050.2706@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0412151456050.2706@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 15, 2004 at 03:25:13PM +0000, Maciej W. Rozycki wrote:

> > Here's a simplified example from arch/mips/sni/setup.c:
> > 
> > static struct resource sni_io_resource = {
> >         "PCIMT IO MEM", 0x00001000UL, 0x03bfffffUL, IORESOURCE_IO,
> > };
> > 
> > static struct resource sni_mem_resource = {
> >         "PCIMT PCI MEM", 0x10000000UL, 0xffffffffUL, IORESOURCE_MEM
> > };
> 
>  I think it's more descriptive to call them "<foo> PCI I/O" and "<foo> PCI
> MEM", respectively, to make it clearer the former expresses I/O port
> addresses (not the associated memory address range for accesses to be
> forwarded as PCI I/O cycles) and that both are PCI bus spaces.
> 
>  Also for most PCI systems I/O port space should really start at 0 (for
> "legacy" devices being decoded by the PCI-ISA bridge if there's one in the
> system), but generic code braindamage prevents it currently.  I think
> there was only about a single PCI chipset that had a "reversed"
> architecture and sort-of bridged PCI over ISA -- the Intel i82420EX for
> the i486 processor.  It would need a separate ISA I/O resource for a
> correct view of the system.

In the above case, the I/O port resource is starting at 0x1000 because
the range of 0x0 - 0xfff contains a few legacy devices.  The way the SNI
code is initializing sni_io_resource ensures all the legacy devices
are properly listed in the iomem_resource and /proc/ioports and the kernel
will never place any I/O resource for a PCI card in the legacy port range.
As the result we'll get:

[root@tbird root]# cat /proc/ioports
00000000-0000001f : dma1
00000020-0000003f : pic1
00000040-0000005f : timer
00000060-0000006f : keyboard
00000070-00000077 : rtc
00000080-0000008f : dma page reg
000000a0-000000bf : pic2
000000c0-000000df : dma2
000002f8-000002ff : serial
000003c0-000003df : vga+
000003f8-000003ff : serial
00000cfc-00000cff : PCI config data
00001000-03bfffff : PCIMT IO MEM
  00001000-000010ff : 0000:00:01.0
    00001000-000010ff : sym53c8xx
  00001400-0000141f : 0000:00:02.0
    00001400-0000141f : pcnet32_probe_pci
[root@tbird root]#

This makes it look like the legacy ports are not behind the PCI bus
which actually they are but that's a minor nit, it gets the address
space allocation to work right.

> > That is PCI memory is in the address range of 0x10000000UL - 0xffffffffUL
> > and I/O ports in the range 0x00001000UL - 0x03bfffffUL.  The io_offset
> > rsp. mem_offset values say how much needs to be added rsp. subtracted
> > when converting a PCI bus address into a physical address.  Often these
> > values are either the same a the resource's start address or zero.
> 
>  Things start being tricky once you have to use such an offset for DMA
> transfers as well...

True, but that's dealt with elsewhere.  And I never claimed the mess that
PCI used to be in 2.4 has yet been fully cleaned up yet, more work to do.

  Ralf
