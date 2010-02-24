Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 00:30:56 +0100 (CET)
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:18395 "EHLO
        g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491073Ab0BXXaw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 00:30:52 +0100
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
        by g6t0184.atlanta.hp.com (Postfix) with ESMTP id 1FF66CF70;
        Wed, 24 Feb 2010 23:30:45 +0000 (UTC)
Received: from ldl (ldl.fc.hp.com [15.11.146.30])
        by g5t0030.atlanta.hp.com (Postfix) with ESMTP id 044D214048;
        Wed, 24 Feb 2010 23:30:43 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
        by ldl (Postfix) with ESMTP id CB2B9CF0097;
        Wed, 24 Feb 2010 16:30:43 -0700 (MST)
Received: from ldl ([127.0.0.1])
        by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IyllT0HK2Pg9; Wed, 24 Feb 2010 16:30:43 -0700 (MST)
Received: from tigger.helgaas (lart.fc.hp.com [15.11.146.31])
        by ldl (Postfix) with ESMTP id B4D02CF0095;
        Wed, 24 Feb 2010 16:30:43 -0700 (MST)
From:   Bjorn Helgaas <bjorn.helgaas@hp.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: RFC: [MIPS] BCM1480/BCM1480HT remove io_offset
Date:   Wed, 24 Feb 2010 16:30:42 -0700
User-Agent: KMail/1.9.10
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <201002241338.41501.bjorn.helgaas@hp.com> <20100224221053.GB20280@alpha.franken.de>
In-Reply-To: <20100224221053.GB20280@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201002241630.42987.bjorn.helgaas@hp.com>
Return-Path: <bjorn.helgaas@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.helgaas@hp.com
Precedence: bulk
X-list: linux-mips

On Wednesday 24 February 2010 03:10:53 pm Thomas Bogendoerfer wrote:
> On Wed, Feb 24, 2010 at 01:38:41PM -0700, Bjorn Helgaas wrote:
> > BCM1480 and BCM1480HT currently offset the Linux ioport space from the
> 
> BCM1480 and BCM1480HT are two hoses on the same chip. Since there is
> only one PCI IO port range, it's probably not a good idea to let
> both busses use the same IO port range. But maybe I'm overlooking
> something.

Oh, I didn't realize these were two parts of the same system.  Guess I
should have realized that from the Makefile, which selects both for
CONFIG_SIBYTE_BCM1x80.  In that case, you definitely don't want the
same I/O port range for both.

Are there registers to control the CPU-to-PCI address translation, or
is it just fixed at:

  PCI ioport = CPU addr - 0x2C000000 (for BCM1480) and
  PCI ioport = CPU addr - 0xDC000000 (for BCM1480HT)?

If you can control the translation, you could define nice CPU-side
I/O port ranges like we do on ia64, e.g.,

  [0x0000000-0x0ffffff] for BCM1480
  [0x1000000-0x1ffffff] for BCM1480HT

That would also allow you to make inb() and friends work on both
hoses by replacing "mips_io_port_base + port" with something like
__ia64_mk_io_addr().

I guess you could do the same thing even if you can't control the
translation, but the ranges would be a little uglier because they
both have to be relative to the same base, e.g.,

  [0x0000000-0x0ffffff] for BCM1480
  [0xb000000-0xbffffff] for BCM1480HT

Bjorn

P.S.  The only reason I even looked at this was because I want to
remove the IORESOURCE_PCI_FIXED check from pcibios_fixup_device_resources(),
and BCM1480 will see a change because it has non-zero io_offset.

However, I *think* that change (independent of this BCM1480xx kibitzing)
will actually improve legacy IDE support.  Before, pci_setup_device()
would leave things like 0x1f0 in legacy-mode IDE device resources, and
pcibios_fixup_device_resources() would leave them alone instead of
converting them to CPU addresses like 0x2c0001f0.

After the IORESOURCE_PCI_FIXED removal, pcibios_fixup_device_resources()
will do the conversion, which I think is the correct thing on BCM1480xx.
