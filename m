Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Feb 2004 13:16:37 +0000 (GMT)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:1921 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8224987AbUBHNQg>; Sun, 8 Feb 2004 13:16:36 +0000
Received: from pdh by skeleton-jack.localnet with local (Exim 3.35 #1 (Debian))
	id 1AponV-0001u9-00
	for <linux-mips@linux-mips.org>; Sun, 08 Feb 2004 13:16:29 +0000
Date: Sun, 8 Feb 2004 13:16:29 +0000
To: linux-mips@linux-mips.org
Subject: PCI resources on 2.6 [Cobalt Qube]
Message-ID: <20040208131629.GA7276@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

Hi.

I'm working to get the 2.6 kernel booting on the Qube/RaQ, but the PCI
resource stuff is giving me a hard time.

I/O accesses using inb() etc are adjusted by Galileo's PCI I/O base
thus

	00000000 - 0000ffff --> b0000000 - b000ffff

The problem is that Galileo passes I/O addresses straight to PCI so that
a read of the RTC translates to a PCI address of 1000007[01]. This works
fine for the stuff on the VIA south bridge as it doesn't seem to decode
all 32 bits of the address for I/O accesses. But this doesn't work for
the Tulip's, they must have the correct addresses written into the I/O
BAR.

If I change the PCI I/O resource range to 10000000 - 1000ffff, then
inb() etc fail because they add Galileo's PCI I/O base again

	10000000 - 1000ffff --> c0000000 - c000ffff !!

causing a page fault.

If I set the I/O port base to 00000000 to overcome this then accesses to
the peripherals on the VIA south bridge don't get Galileo's PCI I/O base
added and they land up accessing RAM.

I effectively have two I/O ranges that need to map to the same addresses

	00000000 - 0000ffff --> b0000000 - b000ffff (for VIA)
	10000000 - 1000ffff --> b0000000 - b000ffff (for PCI)

I was hopefull that the 'io_offset' field in 'struct pci_controller'
would do this for me, but I can't work out what it does :-|

This all worked in 2.4 as it's actually the boot loader that maps the
Tulip's into the I/O address space and the kernel has hardcoded resource
entries to match.

P.
