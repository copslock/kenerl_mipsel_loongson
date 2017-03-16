Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 21:50:25 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48530 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993009AbdCPUuR2BV2v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Mar 2017 21:50:17 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2GKoDDc025160;
        Thu, 16 Mar 2017 21:50:13 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2GKo6gw025159;
        Thu, 16 Mar 2017 21:50:06 +0100
Date:   Thu, 16 Mar 2017 21:50:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: ARCS can't load CONFIG_DEBUG_LOCK_ALLOC kernel
Message-ID: <20170316205006.GE10914@linux-mips.org>
References: <8b2d7473-ba4d-f2c9-27e7-b1a30b95c4f8@gentoo.org>
 <a639551b-4338-e1fb-0cc7-e6ea34b94c2c@gentoo.org>
 <20170316140918.GH5512@linux-mips.org>
 <86da6dd2-7b02-cd0d-f152-00dfb134a3ec@gentoo.org>
 <20170316190629.GP5512@linux-mips.org>
 <13b0221d-c17a-7e5b-6bb5-702ee7d896c1@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b0221d-c17a-7e5b-6bb5-702ee7d896c1@gentoo.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57379
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

On Thu, Mar 16, 2017 at 04:02:48PM -0400, Joshua Kinard wrote:

> On 03/16/2017 15:06, Ralf Baechle wrote:
> > On Thu, Mar 16, 2017 at 01:50:42PM -0400, Joshua Kinard wrote:
> > 
> >> On 03/16/2017 10:09, Ralf Baechle wrote:
> >>> On Wed, Mar 15, 2017 at 11:50:44PM -0400, Joshua Kinard wrote:
> >>>
> >>>> On 03/15/2017 16:11, Joshua Kinard wrote:
> >>>>> I've reported in the past that turning on CONFIG_DEBUG_LOCK_ALLOC produces a
> >>>>> kernel that can't boot on several SGI platforms.  It turns out that using
> >>>>> arcload (Stan's bootloader originally written for IP30), I can get some
> >>>>> debugging out on why.  I am still puzzled, but maybe this information can be
> >>>>> interpreted by someone else into something meaningful?
> >>>>>
> >>>>> All addresses printed out of arcload are physical address.
> >>>>>
> >>>>> ARCS Memory Map as printed by some debugging I added to the arcload binary:
> >>>>>
> >>>>> 0x00000000 - 0x00001000 ExceptionBlock
> >>>>> 0x00001000 - 0x00002000 SystemParameterBlock
> >>>>> 0x00002000 - 0x00004000 FirmwarePermanent
> >>>>> 0x20004000 - 0x20f00000 FreeMemory***
> >>>>> 0x20f00000 - 0x21000000 FirmwareTemporary
> >>>>> 0x21000000 - 0x5fff0000 FreeMemory
> >>>>> 0x5fff0000 - 0x5ffff000 LoadedProgram
> >>>>> 0x5ffff000 - 0x60000000 FreeMemory
> >>>>> 0x60000000 - 0xa0000000 FirmwarePermanent
> >>>>
> >>>> So it turns out I can get away, on Octane at least, by changing the load
> >>>> address from 0x20004000 to an arbitrary value in the other FreeMemory segment
> >>>> from 0x21000000 - 0x5fff0000.  Specifically, using 0x21004000 appears to work
> >>>> without any ill effects.
> >>>>
> >>>> The 0x20004000 value is the address used by IRIX to load (with symon, it
> >>>> becomes 0x200800000 instead).  I'll have to try this on the IP27 later on as
> >>>> well.  On Octane, CONFIG_DEBUG_LOCK_ALLOC didn't toss up any major locking
> >>>> issues yet.  Probably need to hammer the disks with bonnie++ or such.  At least
> >>>> I can get back to the BRIDGE/PCI mess now...
> >>>
> >>> I'm wondering where the ARC stack is on kernel entry if maybe the
> >>> ARC stack has corrupted the kernel?  If possible, can you get your
> >>> kernel or a test program to compute a checksum over itself to see
> >>> if it has been corrupted?
> >>
> >> As far as I can tell, it really does seem that it is a sizing issue.  I don't
> >> have the time to dive into what CONFIG_DEBUG_LOCK_ALLOC is exactly doing, but I
> >> found one hit on LKML (lost the URL) that indicates it fluffs up a particular
> >> struct that is very common and so introduces a fair bit of bloat, and it seems
> >> possible that the 0x20004000-0x20f00000 really is too small.  I wouldn't rule
> >> out the possibility that SGI designed ARCS on the Octane to allow only IRIX to
> >> load at this particular address and Linux has just gotten lucky thus far.
> >>
> >> As for whether loading at the next FreeMemory segment in 0x21000000-0x5fff0000
> >> smashes any ARCS segments, that I am not sure about.  A kernel booting in that
> >> segment does boot, and seems to behave no differently than a kernel booting in
> >> the other segment, including exhibiting the same bugs.  Like IP27, Octane
> >> doesn't have a need for ARCS after the kernel boots, as resetting the system
> >> can be done by flipping a bit in HEART, and power down is handled by the RTC
> >> driver (this feature broke, though, and I haven't chased down why yet).  So if
> >> we're clobbering ARCS using this load address...well, it can't be all that bad
> >> </famous-last-words>
> >>
> >> I'll see what IP27 does, assuming it even has a large enough FreeMemory segment
> >> to work with.
> >>
> >>
> >>> Let me repeat my ARC(S) mantra again, ARC(S) is broken, ARC(S) lies.
> >>> Trust is futile.  Even if ARC(S) claims something is free I'd rather
> >>> not rely on it.
> >>
> >> Apparently, and only on Octane, ARCS detects and maps out only the first 1GB of
> >> RAM.  All remaining RAM installed in the system is marked as FirmwarePermanent
> >> and mapped into 0x60000000 on up.
> > 
> > I think on IP27 it was only the first 32MB that are somehow used by
> > ARCS.  Everything else is entirely ignored and the OS is supposed to
> > use klconfig to query the hardware configuration.  That said, klconfig
> > is an infinitely better than ARCS, it actually works and is easy to
> > use.  What it does not provide is information on how firmware or
> > other loaded programs are using memory - it's really just a hardware
> > inventory.
> 
> IIRC, the first 32MB is reserved for use as directory memory on systems with
> less than 32 CPUs.  For 32 or more CPUs, I believe you have to start populating
> the special directory memory DIMM slots.

Completly wrong.  IP27's special memory modules contain the directory for
each 128 byte S-cache line.  This is similar to how other memory controllers
include an ECC for each line of memory.  The directory size and format of
standard memory modules is sufficient for up to 16 nodes.  Note the limit
is about nodes, not processors.

For larger systems IP27 node boards need to be populated with with
``premium directory DIMMs'' which extend the number of directory bits to
cover systems up to 64 nodes (which would be 128 CPUs).  For the few
systems that exceed even that size (we're talking about > 9 full size
racks!) each of the 64 directory bits represents a node in a particular
128 part of the system or coarse mode where each bit represents eight
nodes, thus allowing for 8 * 64 = 512 nodes = 1024 CPUs.

> This does remind me, though, when I installed a router board I found for cheap,
> the kernel, regardless of configuration, wouldn't load at the address defined
> in IP27's Platform file, as ARCS said it was too large.  If I can find a larger
> ARCS segment to load into, I'll have to test that again as well...

The load address used for the IP27 vmlinux was mindlessly copied from
either sash or vmunix itself.  I'd not call that a scientific method
and I never had access to ARC(S) source.

Your system is large enough to require a router board?  I hope you
got cheap power :)

  Ralf
