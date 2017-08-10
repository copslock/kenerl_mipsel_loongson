Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 10:24:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2792 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992400AbdHJIYpwyv3I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Aug 2017 10:24:45 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 01E153BF804BA;
        Thu, 10 Aug 2017 09:24:37 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 10 Aug
 2017 09:24:38 +0100
Subject: Re: [PATCH] MIPS: usercopy: Implement stack frame object validation
To:     Kees Cook <keescook@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <1502195022-18161-1-git-send-email-matt.redfearn@imgtec.com>
 <CAGXu5j+nF5sAO=NMLq2Oh2aHJRxGVED93oCH0GK28yU0SXQ=MA@mail.gmail.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <28ab1c38-f8a7-3fca-7a5a-e44248bec69f@imgtec.com>
Date:   Thu, 10 Aug 2017 09:24:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+nF5sAO=NMLq2Oh2aHJRxGVED93oCH0GK28yU0SXQ=MA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Kees,


On 08/08/17 20:11, Kees Cook wrote:
> On Tue, Aug 8, 2017 at 5:23 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>> This implements arch_within_stack_frames() for MIPS that validates if an
>> object is wholly contained by a kernel stack frame.
>>
>> With CONFIG_HARDENED_USERCOPY enabled, MIPS now passes the LKDTM tests
>> USERCOPY_STACK_FRAME_TO, USERCOPY_STACK_FRAME_FROM and
>> USERCOPY_STACK_BEYOND on a Creator Ci40.
>>
>> Since the MIPS kernel does not use frame pointers, we re-use the MIPS
>> kernels stack frame unwinder which uses instruction inspection to deduce
>> the stack frame size. As such it introduces a larger performance penalty
>> than on arches which use the frame pointer.
> Hmm, given x86's plans to drop the frame pointer, I wonder if the
> inter-frame checking code should be gated by a CONFIG. This (3%) is a
> rather high performance hit to take for a relatively small protection
> (it's mainly about catching too-large-reads, since most
> too-large-writes will be caught by the stack canary).
>
> What do you think?

If x86 is going to move to a more expensive stack unwinding method than 
the frame pointer then I guess it may end up seeing a similar 
performance hit to what we see on MIPS. In that case it might make sense 
to add a CONFIG for this such that only those who wish to make the trade 
off of performance for the added protection need enable it.

Thanks,
Matt

>
> -Kees
>
>> On qemu, before this patch, hackbench gives:
>> Running with 10*40 (== 400) tasks.
>> Time: 5.484
>> Running with 10*40 (== 400) tasks.
>> Time: 4.039
>> Running with 10*40 (== 400) tasks.
>> Time: 3.908
>> Running with 10*40 (== 400) tasks.
>> Time: 3.955
>> Running with 10*40 (== 400) tasks.
>> Time: 4.185
>> Running with 10*40 (== 400) tasks.
>> Time: 4.497
>> Running with 10*40 (== 400) tasks.
>> Time: 3.980
>> Running with 10*40 (== 400) tasks.
>> Time: 4.078
>> Running with 10*40 (== 400) tasks.
>> Time: 4.219
>> Running with 10*40 (== 400) tasks.
>> Time: 4.026
>>
>> Giving an average of 4.2371
>>
>> With this patch, hackbench gives:
>> Running with 10*40 (== 400) tasks.
>> Time: 5.671
>> Running with 10*40 (== 400) tasks.
>> Time: 4.282
>> Running with 10*40 (== 400) tasks.
>> Time: 4.101
>> Running with 10*40 (== 400) tasks.
>> Time: 4.040
>> Running with 10*40 (== 400) tasks.
>> Time: 4.683
>> Running with 10*40 (== 400) tasks.
>> Time: 4.387
>> Running with 10*40 (== 400) tasks.
>> Time: 4.289
>> Running with 10*40 (== 400) tasks.
>> Time: 4.027
>> Running with 10*40 (== 400) tasks.
>> Time: 4.048
>> Running with 10*40 (== 400) tasks.
>> Time: 4.079
>>
>> Giving an average of 4.3607
>>
>> This indicates an additional 3% overhead for inspecting the kernel stack
>> when CONFIG_HARDENED_USERCOPY is enabled.
>>
>> This patch is based on Linux v4.13-rc4, and for correct operation on
>> microMIPS depends on my series "MIPS: Further microMIPS stack unwinding
>> fixes"
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>> Reviewed-by: James Hogan <james.hogan@imgtec.com>
>> ---
>>
>>   arch/mips/Kconfig                   |  1 +
>>   arch/mips/include/asm/thread_info.h | 74 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 75 insertions(+)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 8dd20358464f..6cbf2d525c8d 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -35,6 +35,7 @@ config MIPS
>>          select HAVE_ARCH_SECCOMP_FILTER
>>          select HAVE_ARCH_TRACEHOOK
>>          select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
>> +       select HAVE_ARCH_WITHIN_STACK_FRAMES if KALLSYMS
>>          select HAVE_CBPF_JIT if (!64BIT && !CPU_MICROMIPS)
>>          select HAVE_EBPF_JIT if (64BIT && !CPU_MICROMIPS)
>>          select HAVE_CC_STACKPROTECTOR
>> diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
>> index b439e512792b..931652460393 100644
>> --- a/arch/mips/include/asm/thread_info.h
>> +++ b/arch/mips/include/asm/thread_info.h
>> @@ -14,6 +14,80 @@
>>
>>   #include <asm/processor.h>
>>
>> +#ifdef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
>> +
>> +/*
>> + * Walks up the stack frames to make sure that the specified object is
>> + * entirely contained by a single stack frame.
>> + *
>> + * Returns:
>> + *     GOOD_FRAME      if within a frame
>> + *     BAD_STACK       if placed across a frame boundary (or outside stack)
>> + *     NOT_STACK       unable to determine
>> + */
>> +static inline int arch_within_stack_frames(const void *const stack,
>> +                                          const void *const stackend,
>> +                                          const void *obj, unsigned long len)
>> +{
>> +       /* Avoid header recursion by just declaring this here */
>> +       extern unsigned long unwind_stack_by_address(
>> +                                               unsigned long stack_page,
>> +                                               unsigned long *sp,
>> +                                               unsigned long pc,
>> +                                               unsigned long *ra);
>> +       unsigned long sp, lastsp, ra, pc;
>> +       int skip_frames;
>> +
>> +       /* Get this frame's details */
>> +       sp = (unsigned long)__builtin_frame_address(0);
>> +       pc = (unsigned long)current_text_addr();
>> +
>> +       /*
>> +        * Skip initial frames to get back the function requesting the copy.
>> +        * Unwind the frames of:
>> +        *   arch_within_stack_frames (inlined into check_stack_object)
>> +        *   __check_object_size
>> +        * This leaves sp & pc in the frame associated with
>> +        *   copy_{to,from}_user() (inlined into do_usercopy_stack)
>> +        */
>> +       for (skip_frames = 0; skip_frames < 2; skip_frames++) {
>> +               pc = unwind_stack_by_address((unsigned long)stack, &sp, pc, &ra);
>> +               if (!pc)
>> +                       return BAD_STACK;
>> +       }
>> +
>> +       if ((unsigned long)obj < sp) {
>> +               /* obj is not in the frame of the requestor or it's callers */
>> +               return BAD_STACK;
>> +       }
>> +
>> +       /*
>> +        * low ---------------------------------------> high
>> +        * [local vars][saved regs][ra][local vars']
>> +        * ^                           ^
>> +        * lastsp                      sp
>> +        * ^----------------------^
>> +        *  allow copies only within here
>> +        */
>> +       do {
>> +               lastsp = sp;
>> +               pc = unwind_stack_by_address((unsigned long)stack, &sp, pc, &ra);
>> +               if ((((unsigned long)obj) >= lastsp) &&
>> +                   (((unsigned long)obj + len) <= (sp - sizeof(void *)))) {
>> +                       /* obj is entirely within this stack frame */
>> +                       return GOOD_FRAME;
>> +               }
>> +       } while (pc);
>> +
>> +       /*
>> +        * We can't unwind any further. If we haven't found the object entirely
>> +        * within one of our callers frames, it must be a bad object.
>> +        */
>> +       return BAD_STACK;
>> +}
>> +
>> +#endif /* CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES */
>> +
>>   /*
>>    * low level task data that entry.S needs immediate access to
>>    * - this struct should fit entirely inside of one cache line
>> --
>> 2.7.4
>>
>
>
