Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2004 16:23:51 +0000 (GMT)
Received: from p508B75D8.dip.t-dialin.net ([IPv6:::ffff:80.139.117.216]:31321
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225687AbUBIQXu>; Mon, 9 Feb 2004 16:23:50 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i19GNoex001652
	for <linux-mips@linux-mips.org>; Mon, 9 Feb 2004 17:23:50 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i19GNo6H001651
	for linux-mips@linux-mips.org; Mon, 9 Feb 2004 17:23:50 +0100
Resent-Message-Id: <200402091623.i19GNo6H001651@fluff.linux-mips.net>
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i19GFvex001539;
	Mon, 9 Feb 2004 17:15:57 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i19GFhn9001538;
	Mon, 9 Feb 2004 17:15:43 +0100
Date: Mon, 9 Feb 2004 17:15:43 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Peter Horton <pdh@colonel-panic.org>
Cc: linux-mips@linux-mips.org
Subject: Re: PCI resources on 2.6 [Cobalt Qube]
Message-ID: <20040209161543.GA496@linux-mips.org>
References: <20040208131629.GA7276@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208131629.GA7276@skeleton-jack>
User-Agent: Mutt/1.4.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Mon, 9 Feb 2004 17:23:50 +0100
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 08, 2004 at 01:16:29PM +0000, Peter Horton wrote:

> causing a page fault.
> 
> If I set the I/O port base to 00000000 to overcome this then accesses to
> the peripherals on the VIA south bridge don't get Galileo's PCI I/O base
> added and they land up accessing RAM.
> 
> I effectively have two I/O ranges that need to map to the same addresses
> 
> 	00000000 - 0000ffff --> b0000000 - b000ffff (for VIA)
> 	10000000 - 1000ffff --> b0000000 - b000ffff (for PCI)
> 
> I was hopefull that the 'io_offset' field in 'struct pci_controller'
> would do this for me, but I can't work out what it does :-|

In general io_offset should be left 0 unless you already register ioport
resources elsewhere in the kernel, which typically is needed for platforms
with legacy peripherals - that is the Cobalt, too.

Two examples you could take a look at:

 - Siemens-Nixdorf RM200

   In arch/mips/sni/setup.c it statically initializes sni_controller.
   io_address range:

    static struct pci_controller sni_controller = {
            .pci_ops        = &sni_pci_ops,
            .mem_resource   = &sni_mem_resource,
            .mem_offset     = 0x10000000UL,
            .io_resource    = &sni_io_resource,
            .io_offset      = 0x00000000UL
    };

    A few legacy PC style I/O port resources are registered first using
    repeated calls to request_resource:

      request_resource(&ioport_resource, pcimt_io_resources + i);

    Note we're allocating resources from ioport_resource, the kernel's
    "master" I/O port resource.  It means later the kernel won't try to
    assign PCI cards to the same place even though all legacy resources
    actually exist on the PCI bus or more exactly on a SuperIO chip behind
    the PCI-EISA bridge.

 - MIPS Malta

   The Malta board takes an exchangable processor card which also contains
   one of several different possible system controllers, among those the
   GT-64120 which is rather similar to the GT-64111 used on Cobalts.

   static struct resource gt64120_mem_resource = {
           .name   = "GT64120 PCI MEM",
           .start  = 0x10000000UL,
           .end    = 0x1fffffffUL,
           .flags  = IORESOURCE_MEM,
   };
                                                                                
   static struct resource gt64120_io_resource = {
           .name   = "GT64120 IO MEM",
           .start  = 0x00002000UL,
           .end    = 0x007fffffUL,
           .flags  = IORESOURCE_IO,
   };

   Aside of supporting several different system controllers this also fairly
   simple.  The complexity here which (afair ...) you'll also have to handle
   on the GT64111 is that the system controller itself shows up on the PCI
   bus as a PCI device, so when the kernel configures the PCI bus it'll
   accendidentally move the system controller including all PCI devices
   around.  I wonder if that's what you just ran into?

  Ralf
