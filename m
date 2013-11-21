Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2013 20:52:07 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34152 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817128Ab3KUTwEsbuAN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Nov 2013 20:52:04 +0100
Date:   Thu, 21 Nov 2013 19:52:04 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: R2300 (not the hay baler)
In-Reply-To: <528B60B3.6030406@imgtec.com>
Message-ID: <alpine.LFD.2.03.1311211934420.3267@linux-mips.org>
References: <528B466A.3050906@imgtec.com> <alpine.LFD.2.03.1311191156570.3267@linux-mips.org> <528B60B3.6030406@imgtec.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 19 Nov 2013, Paul Burton wrote:

> >   Well, it worked the last time I tried (a couple of weeks ago) with actual
> > hardware (an R3400 integrated CPU/FPU), though maybe I missed something.
> > There hasn't been a lot of R2000/R3000-class hardware development recently
> > so no surprise our code didn't need any changes to match hardware updates.
> > At this point I see no reason to retire this code, there's nothing wrong
> > with it.  If there's an actual bug, then it should be fixed.  A test case
> > should be easy to make, and then we can start from there.
> > 
> 
> Yup that's fine, I'm not trying to scrap working code I just didn't
> realise this code was still in use (which is why I asked about it). I
> saw that the r2300_switch.S code seems to differ from the r4k_switch.S
> code in its storage of 32 bit FP context & assumed that the older code
> was less used & thus likely the incorrect one. It seems that assumption
> was incorrect given the ABI expected by userland which you point out
> below.
> 
> This does differ from the context layout the FPU emulator expects, but
> I suppose that's not an issue.

 I reckon the emulator had similar appropriate conditionals (in helper 
macros or suchlike) to handle both cases, I hope they haven't gone by 
accident (or I haven't got MIPS FP emulators mixed up in my memory, there 
are so many of them...).

> >   If you are concerned about register layout in ptrace packets, then please
> > see mips_read_fp_register_single and mips_read_fp_register_double in GDB
> > sources and the comment above them; notice the register buffer offset of 4
> > applied in the big-endian case -- what r2300_switch.S does is exactly what
> > the userland expects (of course it might be that r4k_switch.S is wrong in
> > some cases; actually I remember a discussion with Ralf where we came to
> > this very conclusion and rather than converting r4k_switch.S to use
> > LWC1/SWC1 -- that would degrade performance a bit for FP context switches
> > -- considered a helper to convert between the internal and the ptrace
> > format).
> 
> Do you know what happened to that or have a link to that discussion? I
> don't see that conversion being done at the moment, which makes me
> suspect that the kernel might handle ptrace incorrectly (arguably
> more nicely, but still incorrectly) for mips32 tasks with FR=0 on an
> R4K class CPU. I'll have a look.

 I think the discussion was off-list (Ralf, would you mind if I digged up 
any clues from there?).  The format has been set long ago, and is also odd 
enough to have 32 64-bit slots in the PTRACE_GETFPREGS/PTRACE_SETFPREGS 
structure even for o32 processes (that now should be unexpectedly helpful 
for FP64 o32 processes though), so there's little sense discussing its 
prettiness or ugliness at this point in the game.

 Also I'm not sure what the core file format is for the FP context, it may 
be worth double-checking too.

 Please feel free to poke me directly if you have any further issues about 
MIPS I ISA compatibility.

  Maciej
