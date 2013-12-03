Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Dec 2013 17:49:22 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:22418 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867265Ab3LCQtSGAsVE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Dec 2013 17:49:18 +0100
Message-ID: <529E0B86.2080607@imgtec.com>
Date:   Tue, 3 Dec 2013 16:49:10 +0000
From:   Paul Burton <paul.burton@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: MASS MAILING:    Re: R2300 (not the hay baler)
References: <528B466A.3050906@imgtec.com> <alpine.LFD.2.03.1311191156570.3267@linux-mips.org> <528B60B3.6030406@imgtec.com> <alpine.LFD.2.03.1311211934420.3267@linux-mips.org> <529627D4.1060204@imgtec.com>
In-Reply-To: <529627D4.1060204@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2013_12_03_16_49_11
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38631
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

On 27/11/13 17:11, Paul Burton wrote:
> On 21/11/13 19:52, Maciej W. Rozycki wrote:
>>  I think the discussion was off-list (Ralf, would you mind if I digged up 
>> any clues from there?).  The format has been set long ago, and is also odd 
>> enough to have 32 64-bit slots in the PTRACE_GETFPREGS/PTRACE_SETFPREGS 
>> structure even for o32 processes (that now should be unexpectedly helpful 
>> for FP64 o32 processes though), so there's little sense discussing its 
>> prettiness or ugliness at this point in the game.
>>
>>  Also I'm not sure what the core file format is for the FP context, it may 
>> be worth double-checking too.
>>
>>  Please feel free to poke me directly if you have any further issues about 
>> MIPS I ISA compatibility.
> 
> Ok I finally had time to look at this. It seems that r2300_switch.S used
> to match the current behaviour of r4k_switch.S. Ralf made it that way by
> saving to the appropriate 32 bits of the even numbered 64 bit values of
> the FP context, taking endianness into account, in the following commit:
> 
> http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=42533948caacb82574ccf91cae84df851d4f0521#patch28
> 
> ...and then you fixed up ptrace to always expect values stored in the
> format now used by r4k_switch.S (& at the time used by r2300_switch.S too):
> 
> http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=849fa7a50dff104cbf6654c421b666eefd6da0c1;hp=364e85467c9c08c803087c5b75ae2e70540e3bb5
> 
> Unfortunately later when Ralf replaced the FPU_SAVE_SINGLE macro with
> the fpu_save_single macro in this commit:
> 
> http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=bf0b3bb876115b1e69b2266477128d8270d0b356;hp=39507fed032849b72552062883d143025be8be36
> 
> ...he effectively reverted r2300_switch.S to its old behaviour, whilst
> ptrace continues to expect the r4k_switch.S-like behaviour. So as far as
> I can tell the original intended FP register layout was that currently
> used by r4k_switch.S. That makes r2300_switch.S the incorrect one -
> fixed 11 years ago & broken again 10 years ago.
> 
> What I'm less sure about right now is what gdb has come to expect in the
> meantime - but from your description it sounds like it expects the
> r2300_switch.S behaviour? In which case I suspect that although it seems
> the original intended ptrace ABI was broken long ago & the easiest fix
> may be for the kernel to just go with the unintended ABI on r4k-class
> cores too? I'll have a read through more gdb code & try to confirm.

Maciej: are you sure this is working correctly with r2300_switch.S? gdb
seems to be working as I'd expect with r4k_switch.S and I have no
r2k/r3k hardware to test on.

Thanks,
    Paul
