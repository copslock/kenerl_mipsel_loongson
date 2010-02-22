Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2010 14:28:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39177 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492310Ab0BVN2j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Feb 2010 14:28:39 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1MDSVMQ005506;
        Mon, 22 Feb 2010 14:28:32 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1MDSU4l005504;
        Mon, 22 Feb 2010 14:28:30 +0100
Date:   Mon, 22 Feb 2010 14:28:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:     Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Reverting old hack
Message-ID: <20100222132830.GA5017@linux-mips.org>
References: <20100220113134.GA27194@linux-mips.org>
 <20100220211805.6a33e9e2.yuasa@linux-mips.org>
 <1266815257.1959.23.camel@dc7800.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1266815257.1959.23.camel@dc7800.home>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 21, 2010 at 10:07:37PM -0700, Bjorn Helgaas wrote:

> > > Below 9f7670e4ddd940d95e48997c2da51614e5fde2cf, an old hack which I
> > > committed in December '07 I think mostly for Cobalt machines.  This is
> > > now getting in the way - in fact the whole loop in
> > > pcibios_fixup_device_resources() may have to go.  So I wonder if this
> > > old hack is still necessary.  Only testing can answer so I'm going to
> > > put a patch to revert this into the -queue tree for 2.6.34.
> > 
> > It is still necessary for Cobalt.
> > I got the following IDE resource errors.
> > 
> > pata_via 0000:00:09.1: BAR 0: can't reserve [io  0xf00001f0-0xf00001f7]         
> > pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)      
> > pata_via 0000:00:09.1: BAR 2: can't reserve [io  0xf0000170-0xf0000177]         
> > pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)      
> > pata_via 0000:00:09.1: no available native port 
> 
> I think Cobalt needs something like the patch below, because I think in
> your working system, pata_via is using I/O port 0x1f0, not 0xf00001f0.
> That means the the port the driver sees in the pci_dev resource is
> identical to the port number that appears on the PCI bus, so there is no
> io_offset.
> 
> There are a few other places that may set non-zero io_offset values:
> bcm1480, bcm1480ht. txx9_alloc_pci_controller(), bridge_probe(), and
> octeon_pcie_setup().  I don't know whether they have similar issues.

It's a while since I last looked into this but here's how things afair
are working on a MIPS-based Cobalt system.

The system is based on a MIPS processor and a GT-64111 system controller.
Addresses within a certain CPU address range are passed to the PCI bus as
I/O cycles without address cycles.  Since memory is starting at CPU address
zero (and has to because of the processors used), that address window has
to get mapped somewhere else.  So a CPU access to some virtual address gets
translated to physical address 0xf00001f0.  The GT-64111 passes this to the
PCI bus as I/O port address 0xf00001f0.  Finally the VT82C586 chip which
only decodes the low 16 bits drops treats this as an I/O port space address
0x1f0.

  Ralf
