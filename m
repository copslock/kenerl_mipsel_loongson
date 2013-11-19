Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 12:32:00 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:45718 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822444Ab3KSLb4wLSf6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Nov 2013 12:31:56 +0100
Message-ID: <528B4C26.2030706@imgtec.com>
Date:   Tue, 19 Nov 2013 11:31:50 +0000
From:   Paul Burton <paul.burton@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: R2300 (not the hay baler)
References: <528B466A.3050906@imgtec.com> <20131119112143.GB13331@linux-mips.org>
In-Reply-To: <20131119112143.GB13331@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2013_11_19_11_31_51
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38542
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

On 19/11/13 11:21, Ralf Baechle wrote:
> On Tue, Nov 19, 2013 at 11:07:22AM +0000, Paul Burton wrote:
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
>
> Note that much of that code has changed for 3.13 and the new code may or
> may not have inherited this bug.
>

May I ask which code you mean? Is there some FP work not in mips-for-
linux-next or on the mailing list?

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
> Linux/MIPS is a product of the post-R3000 era - but Maciej (on cc) is doing
> his best to keep it alive and going on DECstations, including R2000 and
> R3000 based ones.  DECstations are little endian and all of them have a
> R2010 rsp R3010, that is have hardware floating point.
>
> I myself have an R3000-based workstation, a clone of a MIPS RS3230 (I think)
> sitting on my floor and waiting to be reactivated.  It's still running
> RISC/os.
>
>    Ralf
>

Fair enough, I'll leave the r2300_switch.S & fpu_{save,restore}_single
code alone (apart from changes which will leave the bug as-is).

Thanks,
     Paul
