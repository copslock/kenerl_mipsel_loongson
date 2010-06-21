Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jun 2010 07:55:46 +0200 (CEST)
Received: from mail1.adax.com ([208.201.231.104]:17584 "EHLO mail1.adax.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491013Ab0FUFzm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Jun 2010 07:55:42 +0200
Received: from static-151-204-189-187.pskn.east.verizon.net (static-151-204-189-187.pskn.east.verizon.net [151.204.189.187])
        by mail1.adax.com (Postfix) with ESMTP id BD66E120991;
        Sun, 20 Jun 2010 22:55:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 999C2201C4;
        Mon, 21 Jun 2010 01:55:33 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at
        static-151-204-189-187.pskn.east.verizon.net
Received: from static-151-204-189-187.pskn.east.verizon.net ([127.0.0.1])
        by localhost (static-151-204-189-187.pskn.east.verizon.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qJZANsMI26aS; Mon, 21 Jun 2010 01:55:29 -0400 (EDT)
Received: from ZuniBear (unknown [192.168.1.200])
        by static-151-204-189-187.pskn.east.verizon.net (Postfix) with ESMTP id 80901201AE;
        Mon, 21 Jun 2010 01:55:27 -0400 (EDT)
From:   "Jan Rovins" <janr@adax.com>
To:     "'Jan Rovins'" <janr@adax.com>,
        "'David Daney'" <ddaney@caviumnetworks.com>
Cc:     "'Kevin D. Kissell'" <kevink@paralogos.com>,
        <linux-mips@linux-mips.org>
References: <4C1A8D86.60005@adax.com> <4C1A9319.1020202@paralogos.com> <4C1A98EC.1030708@caviumnetworks.com> <4C1D16F0.2090102@adax.com>
Subject: RE: Help with decoding a NMI Watchdog interrupt on an Octeon
Date:   Mon, 21 Jun 2010 01:55:21 -0400
Message-ID: <438633685C664132B53157C81BE355DD@ZuniBear>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcsP45twbbFbg/5LQl6WB7ECGK8lYgBHtGkg
In-Reply-To: <4C1D16F0.2090102@adax.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
X-archive-position: 27237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: janr@adax.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14102

Some additions & corrections to the previous:

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-
> mips.org] On Behalf Of Jan Rovins
> Sent: Saturday, June 19, 2010 3:14 PM
> To: David Daney
> Cc: Kevin D. Kissell; linux-mips@linux-mips.org
> Subject: Re: Help with decoding a NMI Watchdog interrupt on an Octeon
> 
> David Daney wrote:
> > On 06/17/2010 02:26 PM, Kevin D. Kissell wrote:
> >> NMI is just an input pin, so you'd really need to know what it's
> >> connected to in the system you're working on.
> >
> > In this case, the NMI is likely being asserted by the watchdog.  So if
> > you are stuck in a loop with interrupts disabled, the register dump
> > might help you figure out where things are stuck.  But as you say
> > below, knowing the value of the ErrorEPC register is critical.
> Thank you David & Kevin for the detailed information.
> 
> Yes, in my case it's the watchdog, when I turn the watchdog off, the
> machine just hangs, with no NMI dump.
> 
> Ok, I added the code to Print out the ErrorEPC, and got:
> ErrorEpc        0xc0000000023c5004
> This address is not in vmlinux, but is the address of a loaded module.
> 
> So, I poked around in /sys/module/ until I found one that had that
> address range:
> cat /sys/module/linux_bcm_core/sections/.text :0xc000000001c4e000
> 
> And then did an objdump on this module. Since the module dump did not
> contain the actual addresses that it was running from, I doctored up the
> offsets by using the .text address from /sys/module/ of where the module
> actually loaded.
> objdump.cavium -d --adjust-vma 0xc000000001c4e000  linux-bcm-core.ko
> 
> Just want to check if all this sounds correct so far? is my objdump
> valid with the .text offset?
> 
> I got a hit on the ErrorEPC value in my dump:
> c0000000023c5004:       08000000        j       c000000000000000
> <sal_dma_alloc-0x1c4e000>


This line of code was inside a function called _default_assert, which on
assertion failure, did a printk() and went into an intentional infinite
loop, which explains the NMI dump. The only thing that puzzles me now, is
that the assert failure printk rarely displayed. Could that be because it
was called while interrupts were turned off? I suppose that would stop it
from showing up in /var/log/messages.

The assembly still does not make sense to me (first time with MIPS assembly)
but on examining the C code I think I understand what's going on here.

> Does this mean that the lockup happened at the jump, or after the jump?
> I am also a little confused about the jump location,  I am used to
> seeing <symbol+offset> but this has <symbol-offset>. is that valid?
> 
> I have a feeling that is referring to a symbol in a different module,
> since sal_dma_alloc is the first symbol of the module that I am looking
> at. and that module is tightly coupled to 2 other modules.
> 
> Is the c000000000000000  the actual address of the jump? can I  then
> just  look it up the same way that I found the ErrorEPC  address in a
> module, or do I have to work backwards from <sal_dma_alloc-0x1c4e000> to
> find the offset into the previous module that it is referring to?
> 
> Jan
> 
> > David Daney
> >
> >> Typically, it's tied to
> >> some kind of memory bus time-out, but it could be other things.
> >> Depending on what it's hooked up to, knowing what code was executing
> >> when it came in may be completely useless. *If* it's hooked up to a bus
> >> time-out, *and* the instruction that caused the time-out was a load,
> >> *and* the time-out and NMI occurred *after* the processor got to the
> >> instruction that consumes the load value (pretty likely if the first
> two
> >> conditions are met), *then* looking at disassembled kernel code
> >> (mips-linux-objdump --disassemble vmlinux) at the ErrorEPC address,
> >> *not* the address in EPC, which will have latched the address of the
> >> last recoverable exception (which NMI is not, strictly speaking). That
> >> instruction should be the consumer of the bad load, so one of its input
> >> registers should be the target of that load. If it's a two-input
> >> instruction, e.g. add r1,r2,r3, then it could be either r2 or r3, and
> >> you have to work your way backwords up the code flow to find out where
> >> the r2 and r3 values came from, respectively. *Usually* it's possible
> to
> >> identify the load, thus the register used as a base address, and see
> >> that the base address register was trashed, at which point you can
> start
> >> forming hypotheses as to how that could have happened.
> >>
> >> Of course, in the dump below, we don't see ErrorEPC. I've never been
> >> able to figure out why so many kernel register dumps skip that
> register,
> >> especially for NMI reporting. But unless you're able to reproduce this
> >> with a kernel that you build yourself, so that you can fix the
> >> instrumentation, it's going to be tough. So "Plan B" would be to make
> >> sure that any removable memory DIMMs have been properly seated, and
> >> double-check that the actual memory capacity corresponds to whatever
> >> boot parameters are being passed to the kernel. In otherwords, if you
> >> can't debug the kernel, pray that it's a hardware or operator error.
> ;o)
> >>
> >> Regards,
> >>
> >> Kevin K.
> >>
> >> Jan Rovins wrote:
> >>> Hi, I need some tips on how to go about deciphering the following NMI
> >>> dump.
> >>>
> >>> This is from a 2.6.21.7 kernel that came with the Cavium Networks
> >>> 1.8.1 toolchain.
> >>> Is there any way to get some kind of back trace from this, or just
> >>> find out which function it was in?
> >>>
> >>> I have been playing around with objdump -x vmlinux but I cant zero in
> >>> on anything this way.
> >>>
> >>> Thanks in advance,
> >>>
> >>> Jan
> >>> *** NMI Watchdog interrupt on Core 0x6 ***
> >>> $0 0x0000000000000000 at 0x000000001010cce0
> >>> v0 0x000000000000003d v1 0x000000000000024a
> >>> a0 0xffffffff807d7b70 a1 0x0000000000000000
> >>> a2 0x000000000000024a a3 0x0000000000000000
> >>> a4 0xffffffff807d7b60 a5 0x0000000000000080
> >>> a6 0x0000000000000001 a7 0xa800000411c62578
> >>> t0 0x0000000000000001 t1 0xa80000048ef3e880
> >>> t2 0xffffffff82d40000 t3 0xa80000041f48c000
> >>> s0 0xc0000000000d9640 s1 0xc000000000088028
> >>> s2 0x0000000000000000 s3 0x0000000000000180
> >>> s4 0x0000000000000000 s5 0x0000000000000000
> >>> s6 0xb7a89c196f513832 s7 0x0000000000000000
> >>> t8 0xffffffff807d0000 t9 0xffffffff807d0000
> >>> k0 0x0000000000000000 k1 0x00000000104dbcbf
> >>> gp 0xa80000041f48c000 sp 0xa80000041f48fcf0
> >>> s8 0x0000000000000000 ra 0xc0000000023c5004
> >>> epc 0xffffffff802b10b8
> >>> status 0x000000001058cce4 cause 0x0000000040008c08
> >>> sum0 0x0000002100000000 en0 0x0000009300008000
> >>> Code around epc
> >>> 0xffffffff802b10a8 000000002406ffff
> >>> 0xffffffff802b10ac 0000000064a5ffff
> >>> 0xffffffff802b10b0 0000000010a60005
> >>> 0xffffffff802b10b4 0000000000000000
> >>> 0xffffffff802b10b8 0000000080620000
> >>> 0xffffffff802b10bc 000000001440fffb
> >>> 0xffffffff802b10c0 0000000064630001
> >>> 0xffffffff802b10c4 000000006463ffff
> >>> 0xffffffff802b10c8 0000000003e00008
> >>>
> >>>
> >>
> >>
> >>
> >
