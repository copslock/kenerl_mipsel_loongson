Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 16:22:18 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37130 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014019AbaKSPWQSClg0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Nov 2014 16:22:16 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAJFMC8j013594;
        Wed, 19 Nov 2014 16:22:12 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAJFMCAk013593;
        Wed, 19 Nov 2014 16:22:12 +0100
Date:   Wed, 19 Nov 2014 16:22:11 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Joshua Kinard <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: IP30: SMP Help
Message-ID: <20141119152211.GH24165@linux-mips.org>
References: <5457187D.6030708@gentoo.org>
 <54607499.2070806@gentoo.org>
 <546B11C0.90805@gentoo.org>
 <alpine.LFD.2.11.1411180946130.4773@eddie.linux-mips.org>
 <546B3D9C.6000104@gentoo.org>
 <alpine.LFD.2.11.1411181255420.4773@eddie.linux-mips.org>
 <546C77F6.4030101@gentoo.org>
 <alpine.LFD.2.11.1411191139300.4773@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1411191139300.4773@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, Nov 19, 2014 at 12:06:59PM +0000, Maciej W. Rozycki wrote:
> Date:   Wed, 19 Nov 2014 12:06:59 +0000 (GMT)
> From: "Maciej W. Rozycki" <macro@linux-mips.org>
> To: Joshua Kinard <kumba@gentoo.org>
> cc: linux-mips@linux-mips.org
> Subject: Re: IP30: SMP Help
> Content-Type: TEXT/PLAIN; charset=US-ASCII
> 
> On Wed, 19 Nov 2014, Joshua Kinard wrote:
> 
> > >  No, user registers have to be treated as 32-bit, that is sign-extended 
> > > from bit #31 (bits 63:32 are a copy of bit #31).  Using 32-bit operations 
> > > only guarantees that, e.g. when you load a register from its stack slot 
> > > using the 32-bit LW instruction, then on a 64-bit processor it will get 
> > > sign-extended in the hardware register from bit #31 through to bit #63.  
> > 
> > I've been aware of the sign-extending bit for some time.  Hence the
> > 0xffffffffxxxxxxxx-style addresses.  Regardless if the stack contains
> > 77abcdef77f00ba7, an LW insn loading that value will actually store
> > ffffffff77f00ba7 into the hardware register, right?
> 
>  Nope, it'll be either 0x0000000077f00ba7 or 0x0000000077abcdef, depending 
> on the endianness.  Bit #31 is clear here and so will be bits #63:32.  
> All user software must have these bits clear in addresses as KUSEG spans 
> 0x00000000-0x7fffffff.
> 
> > It just seemed odd that from the 64-bit stack addresses, it looked like there
> > were two 32-bit virtual addresses (77abcdef and 77f00ba7).  I wasn't sure if
> > that was normal behavior or not for 64-bit Linux/MIPS.  Or a symptom of
> > whatever bug is present in the IP30 code I've yet to find.
> 
>  This is 32-bit user code, it's (approximately) unaware it's running on a 
> 64-bit OS.
> 
> > >  Of course an o32 bit program does not see it, it sees the environment as 
> > > it would on a 32-bit processor as it is supposed to run the same on a true 
> > > 32-bit processor.  Well, strictly speaking this is not completely true on 
> > > Linux, for that to be the case the UX bit you see set in the Status 
> > > register dumped above would have to be cleared, but this is a historical 
> > > artefact and nobody has had the incentive to clean this up yet (in a 
> > > reference environment you want UX clear for o32, UX set for n64 and PX set 
> > > for n32 where available, otherwise UX set).  Clearing the UX bit disables 
> > > all the 64-bit instructions in the user mode making a user program unable 
> > > to see or modify the upper 32 bits of any general register (they're still 
> > > sign-extended automatically).
> > 
> > A lot of the binaries on the Octane's filesystem are compiled w/ MIPS-IV.
> > Under o32, I know that doesn't allow for use of 64bit instructions, but I do
> > believe that o32 can still make use of newer instructions that were added in
> > the MIPS-III or MIPS-IV ISA (iirc, conditional move was one of those).
> 
>  Nope, not exactly right.  You can indeed make use of MIPS IV ISA 
> additions, that are address size agnostic, however you cannot make use of 
> any MIPS III additions as all of these depend on the 64-bit mode: integer 
> operations require CP0.Status.UX to be set that is supposed not to be for 
> o32 user software and floating-point additions require CP0.Status.FR to be 
> set that is likewise supposed not to be for o32 user software.
> 
>  Additionally on some processors, including the R10k family you are 
> concerned about, CP0.Status.XX has to be set for MIPS IV ISA additions to 
> be enabled, but I believe it is under Linux.

Yes.  The XX bit is primarily about the additional FPU condition bits.  An OS
needs to be aware of those or branch emulation won't work right.  Linux
supports that - always has - even on 32 bit kernels.

> > The problem seems to be, though, that there's some kind of subtle memory
> > corruption happening when I compile an IP30 kernel w/ CONFIG_SMP.  Without
> > CONFIG_SMP, it runs fine.  I was focusing on the spinlocks because I know that
> > without CONFIG_SMP, they compile away into nothing, but with CONFIG_SMP, even
> > on a uniprocessor machine, they'll convert to instructions and can still
> > highlight locking problems in the code.
> 
>  I highly doubt spinlocks have any significance here, they're used and 
> work just fine across many systems.  If anything this will probably be 
> either a bug in platform code somewhere or a critical part of hardware 
> having not been correctly initialised.

For testing purposes one could disable the secondary CPU - I believe that's
possible on IP30, too?  Then build an SMP kernel with NR_CPUS set to 1.
That's basically a glorified uniprocessor kernel on glorified uniprocessor
hardware then.

>  Does the system have any standard bus like PCI?  If so then you could get 
> an NVRAM card then and log some activity there like CPU status on entry to 
> exception handlers.  Once a crash has happened you could boot with that 
> logging disabled and retrieve your data.  Accessing hardware is easy on 
> MIPS, you can do it via XKPHYS without a need to have the MMU working, IOW 
> you'll be able to poke at hardware even if your TLB/page tables got 
> botched for some reason.  And you can bypass the cache too, which is 
> another possible place for breakage.

IP27 reserves a part of its FLASH memory for logging.  However Linux doesn't
support that.

>  Of course if you have PCI then you can add an ordinary serial port card 
> there as well if the onboard port is difficult to access for some reason, 
> but serial port logging has its limitations, mainly the complexity to 
> access it and throughput.

While the system has 16550 UARTs a PCI card might indeed make things
slightly sinpler - the setup of the IOC3 + SuperIO combo is complex,
even for a simple PIO driver.  However I think he shouldn't have to go
to such an extreme!

> > I've had a copy of the 2nd edition for a few years now.  It's an excellent
> > general reference, though I admit I've skipped over the TLB chapter a few
> > times.  Hopefully a third edition comes out at some point and has more in-depth
> > coverage of Linux running on MIPS, in addition to the general MIPS overview.
> 
>  I don't think it will, by now Dominic has retired.  But I don't think you 
> need anything beyond that, there's nothing specific about the MIPS port of 
> Linux that wouldn't be covered by a generic Linux book, except from the 
> processor architecture itself -- and you've got it covered there.  For the 
> rest, like newer stuff, just study the sources.

See MIPS Run is actually one of the few CS books that are fun to read.
And as a new Britton at the time I also learned a lot about fish & chips
shops!

  Ralf
