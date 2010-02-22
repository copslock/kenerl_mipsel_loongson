Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2010 06:14:34 +0100 (CET)
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:47609 "EHLO
        g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490959Ab0BVFO2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2010 06:14:28 +0100
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
        by g5t0007.atlanta.hp.com (Postfix) with ESMTP id 71909140B3;
        Mon, 22 Feb 2010 05:14:20 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g5t0030.atlanta.hp.com (Postfix) with ESMTP id 52DF014125;
        Mon, 22 Feb 2010 05:14:19 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id 29401CF0013;
        Sun, 21 Feb 2010 22:14:19 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aMTsDgq2vZld; Sun, 21 Feb 2010 22:14:19 -0700 (MST)
Received: from [192.168.1.2] (squirrel.fc.hp.com [15.11.146.57])
        by ldl (Postfix) with ESMTP id 4DDABCF0007;
        Sun, 21 Feb 2010 22:14:18 -0700 (MST)
Subject: Re: Reverting old hack
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20100220211805.6a33e9e2.yuasa@linux-mips.org>
References: <20100220113134.GA27194@linux-mips.org>
         <20100220211805.6a33e9e2.yuasa@linux-mips.org>
Content-Type: text/plain
Date:   Sun, 21 Feb 2010 22:07:37 -0700
Message-Id: <1266815257.1959.23.camel@dc7800.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Content-Transfer-Encoding: 7bit
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

On Sat, 2010-02-20 at 21:18 +0900, Yoichi Yuasa wrote:
> Hi Ralf,
> 
> On Sat, 20 Feb 2010 12:31:34 +0100
> Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> > Below 9f7670e4ddd940d95e48997c2da51614e5fde2cf, an old hack which I
> > committed in December '07 I think mostly for Cobalt machines.  This is
> > now getting in the way - in fact the whole loop in
> > pcibios_fixup_device_resources() may have to go.  So I wonder if this
> > old hack is still necessary.  Only testing can answer so I'm going to
> > put a patch to revert this into the -queue tree for 2.6.34.
> 
> It is still necessary for Cobalt.
> I got the following IDE resource errors.
> 
> pata_via 0000:00:09.1: BAR 0: can't reserve [io  0xf00001f0-0xf00001f7]         
> pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)      
> pata_via 0000:00:09.1: BAR 2: can't reserve [io  0xf0000170-0xf0000177]         
> pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)      
> pata_via 0000:00:09.1: no available native port 

I think Cobalt needs something like the patch below, because I think in
your working system, pata_via is using I/O port 0x1f0, not 0xf00001f0.
That means the the port the driver sees in the pci_dev resource is
identical to the port number that appears on the PCI bus, so there is no
io_offset.

There are a few other places that may set non-zero io_offset values:
bcm1480, bcm1480ht. txx9_alloc_pci_controller(), bridge_probe(), and
octeon_pcie_setup().  I don't know whether they have similar issues.



commit 7378269220d477118257d898bec9173743675f5e
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Sat Feb 20 07:52:29 2010 -0700

    [MIPS] remove Cobalt I/O space offset
    
    On Cobalt, "inb(x)" produces an I/O port access to port "x" on the PCI
    bus, which means the io_offset is zero and CPU (resource) addresses are
    identical to PCI bus addresses.  Correcting this means we can remove
    the IORESOURCE_PCI_FIXED check from pcibios_fixup_device_resources().
    
    The io_map_base is used internally by pci_iomap(), inb(), and other I/O
    port access functions to generate an MMIO access to the address that
    produces the desired I/O port PCI transaction.
    
    [Cobalt plat_mem_setup() does this:
      set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
    rather than using cobalt_pci_controller.io_map_base, but the value's
    the same, and I don't know enough to clean that up.]
    
    See http://lkml.org/lkml/2007/7/29/27
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff --git a/arch/mips/cobalt/pci.c b/arch/mips/cobalt/pci.c
index cfce7af..84aa205 100644
--- a/arch/mips/cobalt/pci.c
+++ b/arch/mips/cobalt/pci.c
@@ -34,7 +34,6 @@ static struct pci_controller cobalt_pci_controller = {
 	.pci_ops	= &gt64xxx_pci0_ops,
 	.mem_resource	= &cobalt_mem_resource,
 	.io_resource	= &cobalt_io_resource,
-	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
 	.io_map_base	= CKSEG1ADDR(GT_DEF_PCI0_IO_BASE),
 };
 
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index f87f5e1..38bc280 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -251,8 +251,6 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev,
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		if (!dev->resource[i].start)
 			continue;
-		if (dev->resource[i].flags & IORESOURCE_PCI_FIXED)
-			continue;
 		if (dev->resource[i].flags & IORESOURCE_IO)
 			offset = hose->io_offset;
 		else if (dev->resource[i].flags & IORESOURCE_MEM)
