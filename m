Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 17:42:08 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36078 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492459Ab0BXQmE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 17:42:04 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1OGf19h028541;
        Wed, 24 Feb 2010 17:41:01 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1OGf0GI028538;
        Wed, 24 Feb 2010 17:41:00 +0100
Date:   Wed, 24 Feb 2010 17:41:00 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Reverting old hack
Message-ID: <20100224164100.GD5130@linux-mips.org>
References: <20100220113134.GA27194@linux-mips.org>
 <1266815257.1959.23.camel@dc7800.home>
 <20100222132830.GA5017@linux-mips.org>
 <201002231601.15136.bjorn.helgaas@hp.com>
 <20100224090333.44a16d0a.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100224090333.44a16d0a.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 09:03:33AM +0900, Yoichi Yuasa wrote:

> > approach Ben suggested long ago:
> >     http://marc.info/?l=linux-kernel&m=119733290624544&w=2
> 
> It works fine with 2.6.34 queue tree.
> pci.c change is already committed by Ralf.

Which I just dropped from queue.  To keep the tree bisectable removal of
the old hack and adding the fixup should be done in the same patch so I'd
go for Bjorn's patch.

There is another somewhat theoretical correctness issue.  Because the
VIA SuperIO chip only decodes 24 bits of address space but port address
space currently being configured as 32MB there is the theoretical
possibility of I/O port addresses that alias with legacy addresses getting
allocated.

The complicated solution is to reserve all address range that potencially
could cause such aliases.  But with the PCI spec limiting port allocations
for devices to a maximum of 256 bytes 16MB of port address space already is
way more than one would ever expect to be used so I suggest to just limit
the port address space to 16MB.

Could you test the patch below?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/cobalt/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cobalt/pci.c b/arch/mips/cobalt/pci.c
index cfce7af..85ec9cc 100644
--- a/arch/mips/cobalt/pci.c
+++ b/arch/mips/cobalt/pci.c
@@ -25,7 +25,7 @@ static struct resource cobalt_mem_resource = {
 
 static struct resource cobalt_io_resource = {
 	.start	= 0x1000,
-	.end	= GT_DEF_PCI0_IO_SIZE - 1,
+	.end	= 0xffffffUL,
 	.name	= "PCI I/O",
 	.flags	= IORESOURCE_IO,
 };
