Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 13:57:21 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:26643
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225005AbULON5R>; Wed, 15 Dec 2004 13:57:17 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBFDv1d0028949;
	Wed, 15 Dec 2004 14:57:01 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBFDuusG028948;
	Wed, 15 Dec 2004 14:56:56 +0100
Date: Wed, 15 Dec 2004 14:56:56 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: wlacey <wlacey@goldenhindresearch.com>
Cc: linux-mips@linux-mips.org
Subject: Re: No PCI_AUTO in 2.6...
Message-ID: <20041215135656.GA28665@linux-mips.org>
References: <20041211134305.22769.qmail@server212.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041211134305.22769.qmail@server212.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 11, 2004 at 01:43:05PM +0000, wlacey wrote:

> Might someone be willing to share a bit knowledge with me?
> 
> I've transitioned to the 2.6.10 kernel and I'm having a difficult time understanding what things I must do different to get my pci slots probed as before in 2.4. At this point I'm well aware the 2.6 is not a drop in replacement for 2.4 but what is the a general approach to getting something like PCI_AUTO capability in 2.6 what steps must I take and is there document describing them.

PCI_AUTO was really, really broken code.  It only works for some subset
of systems, won't handle hot plugging (Cardbus!), PCI-PCI bridges and many
other cases.  The world became a better place on the day when it got
removed.

> I call register_pci_controller() but the bus is never scanned becasue pcibios_init() fails out with...
> "Skipping PCI bus scan due to resource conflict"

The new PCI code by default will fully configure a PCI bus hierarchy.  For
this to work it needs to know which memory address range and which I/O
port address range are available for assignment.  This information is
passed in the struct pci_controller argument of register_pci_controller().
Here's a simplified example from arch/mips/sni/setup.c:

static struct resource sni_io_resource = {
        "PCIMT IO MEM", 0x00001000UL, 0x03bfffffUL, IORESOURCE_IO,
};

static struct resource sni_mem_resource = {
        "PCIMT PCI MEM", 0x10000000UL, 0xffffffffUL, IORESOURCE_MEM
};

extern struct pci_ops sni_pci_ops;

static struct pci_controller sni_controller = {
        .pci_ops        = &sni_pci_ops,
        .mem_resource   = &sni_mem_resource,
        .mem_offset     = 0x10000000UL,
        .io_resource    = &sni_io_resource,
        .io_offset      = 0x00000000UL
};

That is PCI memory is in the address range of 0x10000000UL - 0xffffffffUL
and I/O ports in the range 0x00001000UL - 0x03bfffffUL.  The io_offset
rsp. mem_offset values say how much needs to be added rsp. subtracted
when converting a PCI bus address into a physical address.  Often these
values are either the same a the resource's start address or zero.

I hope that explains things a little ...

  Ralf
