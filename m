Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Feb 2004 15:52:21 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:41346
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8225343AbUBHPwV>; Sun, 8 Feb 2004 15:52:21 +0000
Received: (qmail 28690 invoked from network); 8 Feb 2004 14:51:03 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (24.6.229.199)
  by alpha.total-knowledge.com with DES-CBC3-SHA encrypted SMTP; 8 Feb 2004 14:51:03 -0000
Received: (qmail 3913 invoked by uid 502); 8 Feb 2004 07:52:16 -0800
Date: Sun, 8 Feb 2004 07:52:16 -0800
From: ilya@theIlya.com
To: Peter Horton <pdh@colonel-panic.org>
Cc: linux-mips@linux-mips.org
Subject: Re: PCI resources on 2.6 [Cobalt Qube]
Message-ID: <20040208155216.GA16130@gateway.total-knowledge.com>
References: <20040208131629.GA7276@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208131629.GA7276@skeleton-jack>
User-Agent: Mutt/1.5.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips

you can do some messing with port addresses by implementing 
include/asm/mach-<your machine>/mangle-port.h

		Ilya.

On Sun, Feb 08, 2004 at 01:16:29PM +0000, Peter Horton wrote:
> Hi.
> 
> I'm working to get the 2.6 kernel booting on the Qube/RaQ, but the PCI
> resource stuff is giving me a hard time.
> 
> I/O accesses using inb() etc are adjusted by Galileo's PCI I/O base
> thus
> 
> 	00000000 - 0000ffff --> b0000000 - b000ffff
> 
> The problem is that Galileo passes I/O addresses straight to PCI so that
> a read of the RTC translates to a PCI address of 1000007[01]. This works
> fine for the stuff on the VIA south bridge as it doesn't seem to decode
> all 32 bits of the address for I/O accesses. But this doesn't work for
> the Tulip's, they must have the correct addresses written into the I/O
> BAR.
> 
> If I change the PCI I/O resource range to 10000000 - 1000ffff, then
> inb() etc fail because they add Galileo's PCI I/O base again
> 
> 	10000000 - 1000ffff --> c0000000 - c000ffff !!
> 
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
> 
> This all worked in 2.4 as it's actually the boot loader that maps the
> Tulip's into the I/O address space and the kernel has hardcoded resource
> entries to match.
> 
> P.
> 
