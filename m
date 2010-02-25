Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 15:05:30 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48031 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492369Ab0BYOF1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2010 15:05:27 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1PE5NxX006433;
        Thu, 25 Feb 2010 15:05:23 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1PE5MxF006431;
        Thu, 25 Feb 2010 15:05:22 +0100
Date:   Thu, 25 Feb 2010 15:05:22 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
Subject: Re: RFC: [MIPS] BCM1480/BCM1480HT remove io_offset
Message-ID: <20100225140522.GA467@linux-mips.org>
References: <201002241338.41501.bjorn.helgaas@hp.com>
 <20100224221053.GB20280@alpha.franken.de>
 <201002241630.42987.bjorn.helgaas@hp.com>
 <1267069502.8811.7.camel@dc7800.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1267069502.8811.7.camel@dc7800.home>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 08:45:02PM -0700, Bjorn Helgaas wrote:

> Actually, you should be able to make this work with CPU I/O resources of
> your choice even if you can't control the translation.  It just requires
> a little more indirection, like most computer science problems :-)  On
> ia64, we map multiple I/O port spaces with arbitrary translations into a
> 0xSPPPPPP scheme (S = space number, PPPPPP = port number).
> 
> But my main concern is just making sure that my IORESOURCE_PCI_FIXED
> change didn't break BCM1480, and I don't think it will.

The whole IORESOURCE_PCI_FIXED thing was created for Cobalt only and is
needed due to the discontinuity of the port address space with legacy I/O
ports in the range of 0..0x1000 and the rest starting off from 0x10000000.
No other system has such a lobotomized system controller.

  Ralf
