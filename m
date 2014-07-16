Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 22:54:19 +0200 (CEST)
Received: from mail-la0-f53.google.com ([209.85.215.53]:43353 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861327AbaGPUyCvx0Uc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 22:54:02 +0200
Received: by mail-la0-f53.google.com with SMTP id gl10so1041007lab.26
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 13:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=nOZ4Tt5s4Fn2vGXAZabsoiqF+gqT5YMLOU+O8/bjlPQ=;
        b=WRCBcP95bM3/7+7PZzRiEolvRWDS5tyuQUURIlAtpgmEcUthhZyWgDVDLpkZGAOZkd
         n6fvp1YUNYWR50gcv2rHMtAFzkEb1IyRIavtsgeKV3O2TY60u9S+nGTxgchhQGuTLUWx
         lKcYKGsWQBCHC3yKDycUltgdm6mfat90Vs2ZXh56fCtzWVhaityNl9yGBpV6ExMOVk3O
         p7BcmFSUN1U3h7LHlGhKTb7ApeNZ6my7IQnsSgEHolj4HGaL961c811754PHjZAbMOcj
         jZRocCqPJuuVNKSTJgXrpQmTSZ26Dehis5CqEtNNMz2s32ktVnorsYg9JHowv2zYWRyw
         Rwbw==
X-Gm-Message-State: ALoCoQl9JZze2o2x5jsOQnKWlqfkCV2MH6h563LccRFYyzE2W6GVr0q2Gxc+/MfSw2PRPHfD55gN
X-Received: by 10.112.4.228 with SMTP id n4mr13496385lbn.46.1405544037061;
 Wed, 16 Jul 2014 13:53:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Wed, 16 Jul 2014 13:53:36 -0700 (PDT)
In-Reply-To: <CAMEtUuywjY8habDJJWyDZLBWtXZXDqpmn2hZ9Dts1hrQ7OWXnA@mail.gmail.com>
References: <cover.1405452484.git.luto@amacapital.net> <3bee564fe07150f11d2e5078d457b6aacde43bec.1405452484.git.luto@amacapital.net>
 <CAMEtUuywjY8habDJJWyDZLBWtXZXDqpmn2hZ9Dts1hrQ7OWXnA@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 16 Jul 2014 13:53:36 -0700
Message-ID: <CALCETrWJq67VtgJmHeV+4AGqTeYnX9KvjJMMSb+LLyA7yUZ7Qw@mail.gmail.com>
Subject: Re: [PATCH 6/7] x86_64,entry: Treat regs->ax the same in fastpath and
 slowpath syscalls
To:     Alexei Starovoitov <ast@plumgrid.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Wed, Jul 16, 2014 at 1:08 PM, Alexei Starovoitov <ast@plumgrid.com> wrote:
> On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> For slowpath syscalls, we initialize regs->ax to -ENOSYS and stick
>> the syscall number into regs->orig_ax prior to any possible tracing
>> and syscall execution.  This is user-visible ABI used by ptrace
>> syscall emulation and seccomp.
>>
>> For fastpath syscalls, there's no good reason not to do the same
>> thing.  It's even slightly simpler than what we're currently doing.
>> It probably has no measureable performance impact.  It should have
>> no user-visible effect.
>>
>> The purpose of this patch is to prepare for seccomp-based syscall
>> emulation in the fast path.  This change is just subtle enough that
>> I'm keeping it separate.
>>
>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> ---
>>  arch/x86/include/asm/calling.h |  6 +++++-
>>  arch/x86/kernel/entry_64.S     | 11 +++--------
>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/calling.h b/arch/x86/include/asm/calling.h
>> index cb4c73b..76659b6 100644
>> --- a/arch/x86/include/asm/calling.h
>> +++ b/arch/x86/include/asm/calling.h
>> @@ -85,7 +85,7 @@ For 32-bit we have the following conventions - kernel is built with
>>  #define ARGOFFSET      R11
>>  #define SWFRAME                ORIG_RAX
>>
>> -       .macro SAVE_ARGS addskip=0, save_rcx=1, save_r891011=1
>> +       .macro SAVE_ARGS addskip=0, save_rcx=1, save_r891011=1, rax_enosys=0
>>         subq  $9*8+\addskip, %rsp
>>         CFI_ADJUST_CFA_OFFSET   9*8+\addskip
>>         movq_cfi rdi, 8*8
>> @@ -96,7 +96,11 @@ For 32-bit we have the following conventions - kernel is built with
>>         movq_cfi rcx, 5*8
>>         .endif
>>
>> +       .if \rax_enosys
>> +       movq $-ENOSYS, 4*8(%rsp)
>> +       .else
>>         movq_cfi rax, 4*8
>> +       .endif
>>
>>         .if \save_r891011
>>         movq_cfi r8,  3*8
>> diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
>> index b25ca96..432c190 100644
>> --- a/arch/x86/kernel/entry_64.S
>> +++ b/arch/x86/kernel/entry_64.S
>> @@ -405,8 +405,8 @@ GLOBAL(system_call_after_swapgs)
>>          * and short:
>>          */
>>         ENABLE_INTERRUPTS(CLBR_NONE)
>> -       SAVE_ARGS 8,0
>> -       movq  %rax,ORIG_RAX-ARGOFFSET(%rsp)
>> +       SAVE_ARGS 8, 0, rax_enosys=1
>> +       movq_cfi rax,(ORIG_RAX-ARGOFFSET)
>
> I think changing store rax to macro is unnecessary,
> since it breaks common style of asm with the next line:

I think it's necessary to maintain CFI correctness.  rax is no longer
saved in "ax", so "orig_ax" is now the correct slot.

>>         movq  %rcx,RIP-ARGOFFSET(%rsp)

This, in contrast, is the saved rip, not the saved rcx.  rcx is lost
when syscall happens.

> Also it made the diff harder to grasp.


>
> The change from the next patch 7/7:
>
>> -       ja   int_ret_from_sys_call      /* RAX(%rsp) set to -ENOSYS above */
>> +       ja   int_ret_from_sys_call      /* RAX(%rsp) is already set */
>
> probably belongs in this 6/7 patch as well.

Agreed.  Will do for v3.

--Andy

>
> The rest look good to me. I think it's a big improvement in readability
> comparing to v1.



-- 
Andy Lutomirski
AMA Capital Management, LLC
