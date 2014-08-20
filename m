Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 23:36:28 +0200 (CEST)
Received: from mail-qc0-f176.google.com ([209.85.216.176]:54651 "EHLO
        mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbaHVVg1GsOET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 23:36:27 +0200
Received: by mail-qc0-f176.google.com with SMTP id m20so11634427qcx.35
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 14:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cRBdJARUIYs/+IWZ9DjaOC9YXZn2n8aY+nf5p9wMZIA=;
        b=W29M02iYFTmpP7eb7NsjPRu/4y0vYVuJ5QWy6MstrvU1aEKei0pIV78Gl5qOmUXHmr
         oFQFlKDFgkzKT1Fe+QuRXCTAZIMqjABTiE7SoMUUQXRPyzR385z37lS4aH+QvUwIZ4yO
         2+x0Oc+J/2TA5Uc1R2YVWLMydhFWYj4ihhiKKAB0mC2ij5/fIjt6W+RXICuPWAQ9B9bv
         6r1wzcA/0URYoycpKUd8FaG3/ldomaU9o5o9jdSxbqw2KQLRlG1Cw6KOwVh5oNcSgnIV
         ylbhS8Lg2L7n2UbDGvh/vynZ2y9DnSlg8+veLzB/LmanrbxWH+O2229GJ8d0QgmcwLuN
         5Aug==
X-Gm-Message-State: ALoCoQm01E0deR4uUABMSR0bhATjeOHdfbQFFrgOfBeNTVfVJGKilyIplXSQqFmYBSCRLKUWqQqd
MIME-Version: 1.0
X-Received: by 10.140.93.161 with SMTP id d30mr74288668qge.53.1408547720494;
 Wed, 20 Aug 2014 08:15:20 -0700 (PDT)
Received: by 10.229.82.209 with HTTP; Wed, 20 Aug 2014 08:15:20 -0700 (PDT)
In-Reply-To: <53F4ABA2.3030008@imgtec.com>
References: <1406122816-2424-6-git-send-email-alex@alex-smith.me.uk>
        <1406206238-28512-1-git-send-email-alex@alex-smith.me.uk>
        <53F4ABA2.3030008@imgtec.com>
Date:   Wed, 20 Aug 2014 16:15:20 +0100
Message-ID: <CAOFt0_DrQbXa8=N4=BRN9iZu9P6p=8cLcsbjWwS9Ngz23zvqcw@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] MIPS: ptrace: Always copy FCSR in FP regset
From:   Alex Smith <alex@alex-smith.me.uk>
To:     James Hogan <james.hogan@imgtec.com>, Ralf <ralf@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42181
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

Hi James,

On 20 August 2014 15:07, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Ralf,
>
> On 24/07/14 13:50, Alex Smith wrote:
>> Copy FCSR in the FP regset to match the original pre-regset core dumper.
>> The code paths for where sizeof(union fpureg) == sizeof(elf_fpreg_t)
>> already do so, but they actually copy 4 bytes more than they should do
>> as FCSR is only 32 bits. The not equal code paths do not copy it at all.
>> Therefore change the copy to be done explicitly (with the correct size)
>> for both paths.
>>
>> Additionally, clear the cause bits from FCSR when setting the FP regset
>> to avoid the possibility of causing an FP exception (and an oops) in the
>> kernel.
>>
>> Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
>> Cc: Paul Burton <paul.burton@imgtec.com>
>> Cc: <stable@vger.kernel.org> # v3.13+
>
> This patch seems to have been missed, although all the others in the
> series were included in the main v3.17 merge. Was that intentional?

Ralf emailed me saying he'd dropped the patch because it was causing
warnings, and he didn't respond when I asked what the warnings were
(I'm unable to reproduce any).

Ralf: if you can let me know what warnings you were getting I can send
an updated patch.

Thanks,
Alex

>
> Cheers
> James
>
>> ---
>> Changes in v2:
>>  - Zero fill the last 4 bytes in the FP regset.
>> ---
>>  arch/mips/kernel/ptrace.c | 73 +++++++++++++++++++++++++++++++----------------
>>  1 file changed, 49 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
>> index 8bd13ed..e082079 100644
>> --- a/arch/mips/kernel/ptrace.c
>> +++ b/arch/mips/kernel/ptrace.c
>> @@ -409,23 +409,35 @@ static int fpr_get(struct task_struct *target,
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
>> +     err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>> +                        &target->thread.fpu.fcr31,
>> +                        NUM_FPU_REGS * sizeof(elf_fpreg_t),
>> +                        (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32));
>> +     if (err)
>> +             return err;
>> +
>> +     /* Zero fill the remaining 4 bytes. */
>> +     return user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
>> +                         (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32),
>> +                         sizeof(elf_fpregset_t));
>>  }
>>
>>  static int fpr_set(struct task_struct *target,
>> @@ -436,24 +448,37 @@ static int fpr_set(struct task_struct *target,
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
>> -     return 0;
>> +     err = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fcr31,
>> +                         NUM_FPU_REGS * sizeof(elf_fpreg_t),
>> +                         (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32));
>> +     if (err)
>> +             return err;
>> +
>> +     target->thread.fpu.fcr31 = fcr31 & ~FPU_CSR_ALL_X;
>> +
>> +     return user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
>> +                         (NUM_FPU_REGS * sizeof(elf_fpreg_t)) + sizeof(u32),
>> +                         sizeof(elf_fpregset_t));
>>  }
>>
>>  enum mips_regset {
>>
