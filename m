Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 00:22:07 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:26361 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225255AbTFKXWE>;
	Thu, 12 Jun 2003 00:22:04 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA26636;
	Wed, 11 Jun 2003 16:22:00 -0700
Subject: Re: FW: Db1500 PCI Auto Scan Question
From: Pete Popov <ppopov@mvista.com>
To: Tom Cernius <tcernius@correlant.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <000201c33066$8623dac0$d452dad1@correlant.com>
References: <000201c33066$8623dac0$d452dad1@correlant.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1055373721.9976.690.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 16:22:01 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2003-06-11 at 15:12, Tom Cernius wrote:
> Hello,
> 
>    I am porting my first PCI driver for a PCI card hosted by the AMD Db1500
> "Zinfandel" development board.
>    This driver had been previously working on another host, where
> CONFIG_PCI_AUTO was not enabled.
> 
>     My PCI card REQUIRES 0xFF000000 and 0x90000000 be programmed into BAR0
> and BAR1 respectively.
>     My PCI card has nothing programmed into BAR0 and BAR1 at power-up.
>     My host Linux kernel was built with CONFIG_PCI, CONFIG_NEW_PCI, and
> CONFIG_PCI_AUTO turned on in the .config file.

Why the 0xFF000000 and, in general, the hardcoded addresses?

Which kernel are you using?

>      I noticed that during boot, the kernel tickles my devices BAR's and
> then writes these BARs with addresses in the range of
>      4000 0000 thru 43FF FFFF

Right.

>      I have tried everything and although I am able to write the proper
> (0xFF00 0000 and 0x9000 0000) addresses into the BAR's,
>      I have been unable to successfully read anything from my PCI cards CPU
> Register/Sdram space.

No, that's not going to work. I'll elaborate below.

>      I suspect that it is NOT possible to use hardcoded PCI BAR addresses
> with the MIPS processor AND CONFIG_PCI_AUTO turned on,
>      as the kernel expects (and configures the PCI BARS of) PCI devices to
> reside in the address space 0x4000 0000 thru 0x43FF FFFF ??

Just to be clear, there's nothing MIPS generic about these addresses.
They are Au1500 specific with a doze of arbitrary chose on my part. The
addresses can be changed, carefully :)

>      I tried disabling the device, updating my BARS, reenabling in the
> driver code (a loadable module).
>      I tried writing the BARS just prior to tickling in the
> linux/arch/mips/kernel/pci_auto.c code.
>      I tried writing the BARS as soon as my device/vendor id are detected
> also in the linux/arch/mips/kernel/pci_auto.c code.

OK, none of that will work the way you're doing it. Here's the problem:

The PCI space on the Au1500 SOC is addresses with 36bit physical
addresses. The PCI noncachable memory space available for PCI devices is
0x4 0000 0000 to 0x5 0000 0000.  But, you can't write those addresses in
a BAR and device drivers read the address and try to do an ioremap on
it.  What I did was this:

- set pci memory start address to 0x4 4000 0000 
- set pci memory end address to   0x4 43FF FFFF

These variables are in include/asm-mips/au1000.h. If you take a look at
arch/mips/au1000/common/pci_ops.c, you'll see that in the
pci_mem_resource structure these addresses are truncated to 32 bit:
- 0x4000 0000 and 0x43FF FFFF. These are the addresses that the pci auto
code sees and programs in the BARs. 

When a device driver reads the resource value, 0x4000 0000 for example,
and calls ioremap on that address, the "fixup_bigphys_addr()" function
will get called in __ioremap() in arch/mips/mm/ioremap.c. That function
will detect that 0x4000 0000 falls within the pci memory window, and
"fix it up" to the proper 36 bit physical address. In other words, it
will return 0x4 4000 0000 so that 0x 4 4000 0000 can be remapped instead
of 0x4000 0000 so you can access the pci memory window.  The actual
physical pci address the SOC will put on the bus will be 0x4000 0000 and
since that's what's programmed in the BAR, the device will respond to
it.

The way you're approaching the problem is bypassing the entire
"fixup_bigphys_addr()" (the function is in setup.c) mechanism and it has
no chance or working.

In theory I think you should be able to do what you need. Suppose you
bypassed pci_auto altogether, for example, and you hardcoded the BARs in
setup.c.  One of your bars will be 0xFF000000 the other 0x90000000 (are
both of these supposed to be pci memory addresses?). You need to fixup
those addresses so that when ioremap is called with such an address, the
32 bit address will be fixed up to a 36 bit address and it's that
address that will get remapped. For example, if a device driver calls
ioremap with 0x9000 0000, you have to detect that address in the
fixup_bigphys_addr() function, and return 0x4 9000 0000. Then when you
use the returned virtual address to access the memory window, the CPU
will understand this virtual address to translate to a PCI mem address
and in turn it will put 0x9000 0000 on the bus. That should give you
access to your device.

Pete
