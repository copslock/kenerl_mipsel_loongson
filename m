Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 14:01:08 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:47464 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827303Ab3KSNA7PEszW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Nov 2013 14:00:59 +0100
Message-ID: <528B60B3.6030406@imgtec.com>
Date:   Tue, 19 Nov 2013 12:59:31 +0000
From:   Paul Burton <paul.burton@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: R2300 (not the hay baler)
References: <528B466A.3050906@imgtec.com> <alpine.LFD.2.03.1311191156570.3267@linux-mips.org>
In-Reply-To: <alpine.LFD.2.03.1311191156570.3267@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2013_11_19_13_00_53
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On 19/11/13 12:27, Maciej W. Rozycki wrote:
> On Tue, 19 Nov 2013, Paul Burton wrote:
>
>> Does anyone still care about the R2300? I ask because I'm working on
>> the FP context switching code & noticed that I'm pretty sure the
>> fpu_save_single & fpu_restore_single macros used only from
>> r2300_switch.S are broken. They store each 32 bit value at the start
>> of the location of the 64 bit FP registers context in memory, which I
>> believe:
>>
>> 1) Won't work for odd indexed FP registers with the FPU emulator,
>>     ptrace or other code which assumes that 32 bit FP data is held in
>>     the even-indexed 64 bit FP register context.
>>
>> 2) On big endian systems the 32 bit values will get saved to the most
>>     significant bits of the 64 bit context which I imagine will cause
>>     yet more problems.
>>
>> It seems like the only changes to r2300_switch.S for a *long* time have
>> been to keep it in sync with r4k_switch.S & the CPU is old enough that
>> all I get when I google for it is information about some hay baler.
>>
>> In short: does anyone care if I just submit a patch removing the R2300
>> code instead of blindly attempting to fix it up?
>
>   Well, it worked the last time I tried (a couple of weeks ago) with actual
> hardware (an R3400 integrated CPU/FPU), though maybe I missed something.
> There hasn't been a lot of R2000/R3000-class hardware development recently
> so no surprise our code didn't need any changes to match hardware updates.
> At this point I see no reason to retire this code, there's nothing wrong
> with it.  If there's an actual bug, then it should be fixed.  A test case
> should be easy to make, and then we can start from there.
>

Yup that's fine, I'm not trying to scrap working code I just didn't
realise this code was still in use (which is why I asked about it). I
saw that the r2300_switch.S code seems to differ from the r4k_switch.S
code in its storage of 32 bit FP context & assumed that the older code
was less used & thus likely the incorrect one. It seems that assumption
was incorrect given the ABI expected by userland which you point out
below.

This does differ from the context layout the FPU emulator expects, but
I suppose that's not an issue.

>   If you are concerned about register layout in ptrace packets, then please
> see mips_read_fp_register_single and mips_read_fp_register_double in GDB
> sources and the comment above them; notice the register buffer offset of 4
> applied in the big-endian case -- what r2300_switch.S does is exactly what
> the userland expects (of course it might be that r4k_switch.S is wrong in
> some cases; actually I remember a discussion with Ralf where we came to
> this very conclusion and rather than converting r4k_switch.S to use
> LWC1/SWC1 -- that would degrade performance a bit for FP context switches
> -- considered a helper to convert between the internal and the ptrace
> format).
>
>    Maciej
>

Do you know what happened to that or have a link to that discussion? I
don't see that conversion being done at the moment, which makes me
suspect that the kernel might handle ptrace incorrectly (arguably
more nicely, but still incorrectly) for mips32 tasks with FR=0 on an
R4K class CPU. I'll have a look.

Thanks,
     Paul
