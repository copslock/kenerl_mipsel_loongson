Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 18:50:34 +0200 (CEST)
Received: from mail-qg0-f48.google.com ([209.85.192.48]:49432 "EHLO
        mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861334AbaGQQubG0d64 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 18:50:31 +0200
Received: by mail-qg0-f48.google.com with SMTP id i50so2232088qgf.35
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 09:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TwtDAHS85ExFm/hdjHvqiTjc/v3wPR5NaYKK0/aWGcI=;
        b=MK60aEc8TqIsX2+H1pjhcv4UWYDSmz4fo17V/dOfumsW/G4PHAR3a3Ok3Jng5SeUSP
         u49CKysB0xf9fNOIZadQK+HGUfsbA+RCE+/Z/BqpUYY7wGvZZcXWy7Vc1ZrnxG1Oexdj
         QWcCg5ub8js/RLT5DqU9FS0xGEeeSCkz+HvgeBktAQSs3S4TzATHuY7qGA7I4zPG93MO
         hahMp7FgIS2rBe+GDFLiejYVLGnyDmo4z7GU0dMG9gSq0G/Y00LeYcihhLZ5lZyfpmBm
         F79vmWh6dqo/v+msr5raPnvVQFHeTDq5lPyUWmKiY7fD6vn/bpju2sjLHd7NXCYBx6XC
         /zZQ==
X-Gm-Message-State: ALoCoQlMeMBDbTCvtgy28+TRZr38FO38ks9bggEu4IxdHpum52APAYEagdxpwepDO6gJm6qP+9A8
MIME-Version: 1.0
X-Received: by 10.224.2.70 with SMTP id 6mr61696480qai.18.1405615825175; Thu,
 17 Jul 2014 09:50:25 -0700 (PDT)
Received: by 10.229.70.201 with HTTP; Thu, 17 Jul 2014 09:50:25 -0700 (PDT)
In-Reply-To: <53C7B846.6040803@imgtec.com>
References: <1392648557-7174-1-git-send-email-alex.smith@imgtec.com>
        <53C7B846.6040803@imgtec.com>
Date:   Thu, 17 Jul 2014 17:50:25 +0100
Message-ID: <CAOFt0_Cc=csLpqtFrhJzyk5QkRoNB=cu720nYuqb_HvP7kj3yg@mail.gmail.com>
Subject: Re: MIPS: O32/32-bit: Fix bug which can cause incorrect system call restarts
From:   Alex Smith <alex@alex-smith.me.uk>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Alex Smith <alex.smith@imgtec.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41281
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

On 17 July 2014 12:49, Zubair Lutfullah Kakakhel
<Zubair.Kakakhel@imgtec.com> wrote:
> On 17/02/14 14:49, Alex Smith wrote:
>> On 32-bit/O32, pt_regs has a padding area at the beginning into which the
>> syscall arguments passed via the user stack are copied. 4 arguments
>> totalling 16 bytes are copied to offset 16 bytes into this area, however
>> the area is only 24 bytes long. This means the last 2 arguments overwrite
>> pt_regs->regs[{0,1}].
>>
>> If a syscall function returns an error, handle_sys stores the original
>> syscall number in pt_regs->regs[0] for syscall restart. signal.c checks
>> whether regs[0] is non-zero, if it is it will check whether the syscall
>> return value is one of the ERESTART* codes to see if it must be
>> restarted.
>>
>> Should a syscall be made that results in a non-zero value being copied
>> off the user stack into regs[0], and then returns a positive (non-error)
>> value that matches one of the ERESTART* error codes, this can be mistaken
>> for requiring a syscall restart.
>>
>> While the possibility for this to occur has always existed, it is made
>> much more likely to occur by commit 46e12c07b3b9 ("MIPS: O32 / 32-bit:
>> Always copy 4 stack arguments."), since now every syscall will copy 4
>> arguments and overwrite regs[0], rather than just those with 7 or 8
>> arguments.
>>
>> Since that commit, booting Debian under a 32-bit MIPS kernel almost
>> always results in a hang early in boot, due to a wait4 syscall returning
>> a PID that matches one of the ERESTART* codes, which then causes an
>> incorrect restart of the syscall.
>>
>> The problem is fixed by increasing the size of the padding area so that
>> arguments copied off the stack will not overwrite pt_regs->regs[{0,1}].
>> Also removed a comment in handle_sys which is no longer relevant after
>> the aforementioned commit.
>>
>> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
>> Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
>
> Tested-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

When I first submitted this Ralf expressed concern that changing the
layout of pt_regs would be an ABI break.

At the time I couldn't find any places where pt_regs is directly
copied to userspace - ptrace_{get,set}regs copy elements from it
invidually into the correct userspace format, and core dumps appeared
to do the same (elf_dump_regs in arch/mips/kernel/process.c).

However I've now noticed that the regset functions in ptrace.c do copy
pt_regs directly to userspace, and commit 6a9c001b changed the core
dumper to use regsets. That was actually an ABI break because the
kernel's pt_regs layout is not the same as the core dump register
layout (defined in asm/reg.h) and can also be changed based on various
Kconfig options. Core dumps look to have been broken since that commit
- reverting it fixes them.

So what's needed is to change the regset code to follow the original
core dump layout. I'll do that when I get a chance. This patch can
probably be applied even without fixing that up though, because it
doesn't really break things any further than they already are.

>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> Cc: stable@vger.kernel.org [3.13]
>>
>> ---
>> arch/mips/include/asm/ptrace.h | 2 +-
>>  arch/mips/kernel/scall32-o32.S | 2 --
>>  arch/mips/kernel/smtc-asm.S    | 4 ++--
>>  3 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
>> index 7bba9da..6d019ca 100644
>> --- a/arch/mips/include/asm/ptrace.h
>> +++ b/arch/mips/include/asm/ptrace.h
>> @@ -23,7 +23,7 @@
>>  struct pt_regs {
>>  #ifdef CONFIG_32BIT
>>       /* Pad bytes for argument save space on the stack. */
>> -     unsigned long pad0[6];
>> +     unsigned long pad0[8];
>>  #endif
>>
>>       /* Saved main processor registers. */
>> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
>> index a5b14f4..4220c2d 100644
>> --- a/arch/mips/kernel/scall32-o32.S
>> +++ b/arch/mips/kernel/scall32-o32.S
>> @@ -66,8 +66,6 @@ NESTED(handle_sys, PT_SIZE, sp)
>>
>>       /*
>>        * Ok, copy the args from the luser stack to the kernel stack.
>> -      * t3 is the precomputed number of instruction bytes needed to
>> -      * load or store arguments 6-8.
>>        */
>>
>>       .set    push
>> diff --git a/arch/mips/kernel/smtc-asm.S b/arch/mips/kernel/smtc-asm.S
>> index 2866863..c4f0cd9 100644
>> --- a/arch/mips/kernel/smtc-asm.S
>> +++ b/arch/mips/kernel/smtc-asm.S
>> @@ -43,8 +43,8 @@ CAN WE PROVE THAT WE WON'T DO THIS IF INTS DISABLED??
>>   * to invoke the scheduler and return as appropriate.
>>   */
>>
>> -#define PT_PADSLOT4 (PT_R0-8)
>> -#define PT_PADSLOT5 (PT_R0-4)
>> +#define PT_PADSLOT4 (PT_R0-16)
>> +#define PT_PADSLOT5 (PT_R0-12)

This change needs to be dropped for this patch to apply against head
of tree since SMTC support is now gone, but should be kept in if this
patch is applied to stable. How should that be handled?

Alex

>>
>>       .text
>>       .align 5
>>
