Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 13:27:24 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49640 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823099Ab3KSM1UbHxnU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Nov 2013 13:27:20 +0100
Date:   Tue, 19 Nov 2013 12:27:20 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: R2300 (not the hay baler)
In-Reply-To: <528B466A.3050906@imgtec.com>
Message-ID: <alpine.LFD.2.03.1311191156570.3267@linux-mips.org>
References: <528B466A.3050906@imgtec.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38543
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

> Does anyone still care about the R2300? I ask because I'm working on
> the FP context switching code & noticed that I'm pretty sure the
> fpu_save_single & fpu_restore_single macros used only from
> r2300_switch.S are broken. They store each 32 bit value at the start
> of the location of the 64 bit FP registers context in memory, which I
> believe:
> 
> 1) Won't work for odd indexed FP registers with the FPU emulator,
>    ptrace or other code which assumes that 32 bit FP data is held in
>    the even-indexed 64 bit FP register context.
> 
> 2) On big endian systems the 32 bit values will get saved to the most
>    significant bits of the 64 bit context which I imagine will cause
>    yet more problems.
> 
> It seems like the only changes to r2300_switch.S for a *long* time have
> been to keep it in sync with r4k_switch.S & the CPU is old enough that
> all I get when I google for it is information about some hay baler.
> 
> In short: does anyone care if I just submit a patch removing the R2300
> code instead of blindly attempting to fix it up?

 Well, it worked the last time I tried (a couple of weeks ago) with actual 
hardware (an R3400 integrated CPU/FPU), though maybe I missed something.  
There hasn't been a lot of R2000/R3000-class hardware development recently 
so no surprise our code didn't need any changes to match hardware updates.  
At this point I see no reason to retire this code, there's nothing wrong 
with it.  If there's an actual bug, then it should be fixed.  A test case 
should be easy to make, and then we can start from there.

 If you are concerned about register layout in ptrace packets, then please 
see mips_read_fp_register_single and mips_read_fp_register_double in GDB 
sources and the comment above them; notice the register buffer offset of 4 
applied in the big-endian case -- what r2300_switch.S does is exactly what 
the userland expects (of course it might be that r4k_switch.S is wrong in 
some cases; actually I remember a discussion with Ralf where we came to 
this very conclusion and rather than converting r4k_switch.S to use 
LWC1/SWC1 -- that would degrade performance a bit for FP context switches 
-- considered a helper to convert between the internal and the ptrace 
format).

  Maciej
