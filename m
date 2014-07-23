Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 18:20:58 +0200 (CEST)
Received: from mail-we0-f170.google.com ([74.125.82.170]:53821 "EHLO
        mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818465AbaGWQU4HRD1h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 18:20:56 +0200
Received: by mail-we0-f170.google.com with SMTP id w62so1473012wes.15
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 09:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HLIetgCbJfjLQdGh5YeGjMvpR/1rZieEWEmSGyXtdxA=;
        b=BnksCKnyxvLBwW/imqxGp3JDg8tLeXx0zswD5szvQ1O6QxU4yDcx/3T/E9mWYeSeHr
         8SFKYGVSt77rar85nyu1GLapulWOCuQ1lWpp7l9DfbaF+mfh8swUqTbAHjSvPAq9OBOU
         mLFSeVaYVEJB6uVAyQEHkfeDqsoAZdPi/lJTsY8TScIVh31HA1qNLKEbo18MIuqknAzF
         uNHsRMLBNk+hJ0CAiyQ/8Fhae4cwZtQ1ext1R222mv4jmrCargJGwGaJfT1iWKVXtweR
         tKa4gGuRFNYPsXD3lB0u924B/NYz7DyFc06rEd+gegsm8EWtLHlHQmyus8FKvXQjputL
         z5fg==
X-Gm-Message-State: ALoCoQkVvaSIiBXLYqaYmX268FU2G4Hi2OOmCA9PceuiLlOl195T/0fPvyTNUn1tTd3/r1KJ2N/d
MIME-Version: 1.0
X-Received: by 10.180.80.133 with SMTP id r5mr25788546wix.62.1406132450594;
 Wed, 23 Jul 2014 09:20:50 -0700 (PDT)
Received: by 10.194.122.170 with HTTP; Wed, 23 Jul 2014 09:20:50 -0700 (PDT)
In-Reply-To: <20140723141203.GM30558@pburton-laptop>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
        <1406122816-2424-6-git-send-email-alex@alex-smith.me.uk>
        <20140723141203.GM30558@pburton-laptop>
Date:   Wed, 23 Jul 2014 17:20:50 +0100
Message-ID: <CAOFt0_DpB1foU2XKROLuvHuY5uzSytqnKY_bv_seid8zj5NedA@mail.gmail.com>
Subject: Re: [PATCH 05/11] MIPS: ptrace: Always copy FCSR in FP regset
From:   Alex Smith <alex@alex-smith.me.uk>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

On 23 July 2014 15:12, Paul Burton <paul.burton@imgtec.com> wrote:
> On Wed, Jul 23, 2014 at 02:40:10PM +0100, Alex Smith wrote:
>> Copy FCSR in the FP regset to match the original pre-regset core dumper.
>> The code paths for where sizeof(union fpureg) == sizeof(elf_fpreg_t)
>> already do so, but they actually copy 4 bytes more than they should do
>> as FCSR is only 32 bits. The not equal code paths do not copy it at all.
>> Therefore change the copy to be done explicitly (with the correct size)
>> for both paths.
>
> Ah, I hadn't realised that ELF_NFPREG == 33, sneaky! That together with
> the "XXX fcr31" comment led me to believe the FP regset didn't include
> FCSR which is why I hadn't fixed the oops there or taken it into account
> for the case where FPR size != sizeof(elf_fpreg_t) (ie. when MSA support
> is enabled).
>
>> Additionally, clear the cause bits from FCSR when setting the FP regset
>> to avoid the possibility of causing an FP exception (and an oops) in the
>> kernel.
>>
>> Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
>> Cc: Paul Burton <paul.burton@imgtec.com>
>> Cc: <stable@vger.kernel.org> # v3.13+
>> ---
>> This patch incorporates a fix for another instance of the bug fixed by
>> Paul Burton's patch "MIPS: prevent user from setting FCSR cause bits" -
>> the code path in fpr_set for sizeof(fpureg) == sizeof(elf_fpreg_t)
>> copied fcr31 without clearing cause bits. I've incorporated a fix for
>> it into this patch to so that it's easier to apply both patches without
>> conflicts.
>> ---
>>  arch/mips/kernel/ptrace.c | 61 +++++++++++++++++++++++++++++------------------
>>  1 file changed, 38 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
>> index 8bd13ed..ffc2e37 100644
>> --- a/arch/mips/kernel/ptrace.c
>> +++ b/arch/mips/kernel/ptrace.c
>> @@ -409,23 +409,28 @@ static int fpr_get(struct task_struct *target,
>>       int err;
>>       u64 fpr_val;
>>
>> -     /* XXX fcr31  */
>> -
>> -     if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
>> -             return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>> -                                        &target->thread.fpu,
>> -                                        0, sizeof(elf_fpregset_t));
>> -
>> -     for (i = 0; i < NUM_FPU_REGS; i++) {
>> -             fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
>> +     if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t)) {
>>               err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>> -                                       &fpr_val, i * sizeof(elf_fpreg_t),
>> -                                       (i + 1) * sizeof(elf_fpreg_t));
>> +                                       &target->thread.fpu.fpr,
>> +                                       0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
>>               if (err)
>>                       return err;
>> +     } else {
>> +             for (i = 0; i < NUM_FPU_REGS; i++) {
>> +                     fpr_val = get_fpr64(&target->thread.fpu.fpr[i], 0);
>> +                     err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>> +                                               &fpr_val,
>> +                                               i * sizeof(elf_fpreg_t),
>> +                                               (i + 1) * sizeof(elf_fpreg_t));
>> +                     if (err)
>> +                             return err;
>> +             }
>>       }
>>
>> -     return 0;
>> +     return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>> +                         &target->thread.fpu.fcr31,
>> +                         NUM_FPU_REGS * sizeof(elf_fpreg_t),
>> +                         (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32));
>
> The only problem I can think of is that the final register in the regset
> will still be treated as 64b (regset->size) as far as ptrace is
> concerned, so I'm not sure how best to handle this. I presume the pre
> regset core dump format placed the 32b FCSR value immediately after
> the 64b $f31, as you have here? In which case we should probably at
> least zero out the other 4 bytes of this final "register", assuming
> the extra 4 bytes compared to the pre-regset version isn't a problem?

Yes, this should now exactly match the old core dump code, which
copies the 32-bit FCSR immediately after f31 (see dump_task_fpu). The
last 4 bytes were still there with the old code, but it never actually
touched them. You're right that this should zero it out. I'll do a v2
with that fixed.

Thanks,
Alex

>
> Thanks,
>     Paul
>
>>  }
>>
>>  static int fpr_set(struct task_struct *target,
>> @@ -436,23 +441,33 @@ static int fpr_set(struct task_struct *target,
>>       unsigned i;
>>       int err;
>>       u64 fpr_val;
>> +     u32 fcr31;
>>
>> -     /* XXX fcr31  */
>> -
>> -     if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t))
>> -             return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> -                                       &target->thread.fpu,
>> -                                       0, sizeof(elf_fpregset_t));
>> -
>> -     for (i = 0; i < NUM_FPU_REGS; i++) {
>> +     if (sizeof(target->thread.fpu.fpr[i]) == sizeof(elf_fpreg_t)) {
>>               err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> -                                      &fpr_val, i * sizeof(elf_fpreg_t),
>> -                                      (i + 1) * sizeof(elf_fpreg_t));
>> +                                      &target->thread.fpu.fpr,
>> +                                      0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
>>               if (err)
>>                       return err;
>> -             set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
>> +     } else {
>> +             for (i = 0; i < NUM_FPU_REGS; i++) {
>> +                     err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> +                                              &fpr_val,
>> +                                              i * sizeof(elf_fpreg_t),
>> +                                              (i + 1) * sizeof(elf_fpreg_t));
>> +                     if (err)
>> +                             return err;
>> +                     set_fpr64(&target->thread.fpu.fpr[i], 0, fpr_val);
>> +             }
>>       }
>>
>> +     err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fcr31,
>> +                         NUM_FPU_REGS * sizeof(elf_fpreg_t),
>> +                         (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32));
>> +     if (err)
>> +             return err;
>> +
>> +     target->thread.fpu.fcr31 = fcr31 & ~FPU_CSR_ALL_X;
>>       return 0;
>>  }
>>
>> --
>> 1.9.1
>>
