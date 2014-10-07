Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 06:32:56 +0200 (CEST)
Received: from mail-yh0-f42.google.com ([209.85.213.42]:35521 "EHLO
        mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008645AbaJGEcyGCChw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 06:32:54 +0200
Received: by mail-yh0-f42.google.com with SMTP id t59so2669779yho.1
        for <linux-mips@linux-mips.org>; Mon, 06 Oct 2014 21:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=n/Sx+sNgvWhzLz6/ISrkZ47BmexlowSdq7hkWDG50/Q=;
        b=yYaI3K5wryFscTvtgPwwoLP6JuY2ZGVJLRbGMphiRlyBdDDfFXyTuQ0fmxZuJMypbn
         uFFTpusudqcwSzZuvuxmQEQFjbzzASBEJ8J2LOLaNtmwe6Fe29oP2RGwxMwTdbwV235I
         DW94tDZaav9hskknUXHGcpsDO3vFL/JBGpltKVS11uL7wQLpgbbV1EjjMxoSkWJCB1ss
         SR35kocaA/P8B3OGUqryT+V7q1FcVkItaBLTErSgCG+l77npqbx021tyICXyhxuiKBML
         nQ+rGWs0hG5KQbS+QJyN5RNNjyrKvFFdt7QsYsPaxhpIsZMfwW8JOIBt7kFpnPdlFW1I
         Q/6w==
X-Received: by 10.236.150.138 with SMTP id z10mr972167yhj.138.1412656367790;
        Mon, 06 Oct 2014 21:32:47 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-124-149-144.dsl.pltn13.pacbell.net. [67.124.149.144])
        by mx.google.com with ESMTPSA id a26sm7974861yhb.6.2014.10.06.21.32.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Oct 2014 21:32:47 -0700 (PDT)
Message-ID: <54336CED.3040106@gmail.com>
Date:   Mon, 06 Oct 2014 21:32:45 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@paralogos.com>,
        David Daney <ddaney.cavm@gmail.com>, libc-alpha@sourceware.org
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com> <54333B9C.2040302@paralogos.com>
In-Reply-To: <54333B9C.2040302@paralogos.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
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

On 10/06/2014 06:02 PM, Kevin D. Kissell wrote:
> On 10/06/2014 01:23 PM, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> In order for MIPS to be able to support a non-executable stack, we
>> need to supply a method to specify a userspace area that can be used
>> for executing emulated branch delay slot instructions.
>>
>> We add a new system call, sys_set_fpuemul_xol_area so that userspace
>> threads that are using the FPU can specify the location of the FPU
>> emulation out of line execution area.
>>
>> Background:
>>
>> MIPS floating point support requires that any instruction that cannot
>> be directly executed by the FPU, be emulated by the kernel. Part of
>> this emulation involves executing non-FPU instructions that fall in
>> the delay slots of FP branch instructions.  Since the beginning of
>> MIPS/Linux time, this has been done by placing the instructions on the
>> userspace thread stack, and executing them there, as the instructions
>> must be executed in the MM context of the thread receiving the
>> emulation.
> Well, actually it doesn't go back to the beginning of MIPS/Linux time 
> - I was the b*astard who took the user-mode functional emulator from 
> Algorithmics and got it to work in the MIPS Linux kernel context, some 
> time in the early 2000s.  It was all pretty straightforward, except 
> for the delay-slot-of-an-emulated-FP-conditional-branch problem. As 
> you note, it may be a load or store (though not a branch), so it needs 
> to be done in the user's MM context, and the user stack has nice 
> properties of being intrinsically per-thread and re-entrancy tolerant.
>> Because of this, the de facto MIPS Linux userspace ABI requires that
>> the userspace thread have an executable stack.  It is de facto,
>> because it is not written anywhere that this must be the case, but it
>> is never the less a requirement.
> IIRC, when I first did the code, we already needed this for signal 
> trampolines.  I just extended it.  Is it no longer required for signal 
> support?  If not, how are signal trampolines now done, and could this 
> not be re-extended to the FP branch delay slot emulation problem?

I moved signal trampolines off the stack quite a few years ago. This is 
the only thing blocking non-executable stack.

The problem with the FP branch delay slot emulation is that the code 
that needs to be executed varies.  The signal trampoline code is known 
at kernel build time.

>> Problem:
>>
>> How do we get MIPS Linux to use a non-executable stack in the face of
>> the FPU emulation problem?
>>
>> Since userspace desires to change the ABI, put some of the onus on the
>> userspace code.  Any userspace thread desiring a non-executable stack,
>> must allocate a 4-byte aligned area at least 8 bytes long with that
>> has read/write/execute permissions and pass the address of that area
>> to the kernel with the new sys_set_fpuemul_xol_area system call.
>>
>> This is similar to how we require userspace to notify the kernel of
>> the value of the thread local pointer.
> It's easy for me to criticise, since I'm no longer responsible for 
> maintenance, but I hope you'll excuse me for commenting that, while 
> this seems like a small enough and neat enough patch per se,  I find 
> it disagreeable to break legacy binaries

It doesn't break legacy binaries.  They continue to use a executable 
stack and the emulation is done there.

This only would change new binaries that explicitly asked for a 
non-executable stack.

> and to see a mechanism whose name and implementation is so strictly 
> tied to the one purpose.  Even if it's only used for the FP delay slot 
> emulation today, shouldn't it be designed/coded/documented as a sort 
> of generic trampoline scratchpad?  And shouldn't we try to design 
> things so that legacy code with FP but no new magic system call "just 
> works"?  e.g. auto-allocate and initialize the space for a thread the 
> first time it actually needs to emulate an FP branch?

The binaries have to be tagged as non-executable stack, this is because 
GCC can, and does, generate trampolines on the stack as part of its 
normal code generation strategy.

That said, there are many problems with both the current code, and my 
proposal.

The main issue, as mentioned by another commenter, is the problem of 
signals and nested emulations.

If the emulated instruction raises a synchronous exception that is 
converted to a signal, what is the EPC in the register state on the 
stack?  Should it be the original location of the instruction, or the 
out-of-line location used by emulation?  Are there userspace runtime 
systems that care about this?

If we are emulating on the stack, a signal stack state could clobber the 
emulation location.

If the kernel automatically allocated the emulation locations, what 
would happen if there were a signal that interrupted the emulation, and 
the signal handler did a longjump to somewhere else?  How would we clean 
up the now unused emulation memory allocations?

>
> /K.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>
>> First attempt to libc-alpha@ failed due to anti-spam technology,
>> reattempting to a reduced list of recipients.
>>
>> This patch has only been compile tested, and lacks the userspace
>> component.  It is presented as an alternate approch to the recently
>> proposed MIPS non-executable stack patches posted here:
>>
>> http://www.linux-mips.org/archives/linux-mips/2014-10/msg00024.html
>>
>>   arch/mips/include/asm/thread_info.h |  2 ++
>>   arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
>>   arch/mips/kernel/process.c          |  1 +
>>   arch/mips/kernel/scall32-o32.S      |  1 +
>>   arch/mips/kernel/scall64-64.S       |  1 +
>>   arch/mips/kernel/scall64-n32.S      |  1 +
>>   arch/mips/kernel/scall64-o32.S      |  1 +
>>   arch/mips/kernel/syscall.c          |  8 ++++++++
>>   arch/mips/math-emu/dsemul.c         | 11 +++++++----
>>   9 files changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/thread_info.h 
>> b/arch/mips/include/asm/thread_info.h
>> index 7de8658..20d47f6 100644
>> --- a/arch/mips/include/asm/thread_info.h
>> +++ b/arch/mips/include/asm/thread_info.h
>> @@ -26,6 +26,7 @@ struct thread_info {
>>       struct exec_domain    *exec_domain;    /* execution domain */
>>       unsigned long        flags;        /* low level flags */
>>       unsigned long        tp_value;    /* thread pointer */
>> +    unsigned long        fpu_emul_xol;    /* FPU emul eXecute Out of 
>> Line VA */
>>       __u32            cpu;        /* current CPU */
>>       int            preempt_count;    /* 0 => preemptable, <0 => BUG */
>>   @@ -46,6 +47,7 @@ struct thread_info {
>>       .task        = &tsk,            \
>>       .exec_domain    = &default_exec_domain, \
>>       .flags        = _TIF_FIXADE,        \
>> +    .fpu_emul_xol    = ~0ul,            \
>>       .cpu        = 0,            \
>>       .preempt_count    = INIT_PREEMPT_COUNT,    \
>>       .addr_limit    = KERNEL_DS,        \
>> diff --git a/arch/mips/include/uapi/asm/unistd.h 
>> b/arch/mips/include/uapi/asm/unistd.h
>> index fdb4923..f1270ee 100644
>> --- a/arch/mips/include/uapi/asm/unistd.h
>> +++ b/arch/mips/include/uapi/asm/unistd.h
>> @@ -375,16 +375,17 @@
>>   #define __NR_seccomp            (__NR_Linux + 352)
>>   #define __NR_getrandom            (__NR_Linux + 353)
>>   #define __NR_memfd_create        (__NR_Linux + 354)
>> +#define __NR_set_fpuemul_xol_area    (__NR_Linux + 355)
>>     /*
>>    * Offset of the last Linux o32 flavoured syscall
>>    */
>> -#define __NR_Linux_syscalls        354
>> +#define __NR_Linux_syscalls        355
>>     #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
>>     #define __NR_O32_Linux            4000
>> -#define __NR_O32_Linux_syscalls        354
>> +#define __NR_O32_Linux_syscalls        355
>>     #if _MIPS_SIM == _MIPS_SIM_ABI64
>>   @@ -707,16 +708,17 @@
>>   #define __NR_seccomp            (__NR_Linux + 312)
>>   #define __NR_getrandom            (__NR_Linux + 313)
>>   #define __NR_memfd_create        (__NR_Linux + 314)
>> +#define __NR_set_fpuemul_xol_area    (__NR_Linux + 315)
>>     /*
>>    * Offset of the last Linux 64-bit flavoured syscall
>>    */
>> -#define __NR_Linux_syscalls        314
>> +#define __NR_Linux_syscalls        315
>>     #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
>>     #define __NR_64_Linux            5000
>> -#define __NR_64_Linux_syscalls        314
>> +#define __NR_64_Linux_syscalls        315
>>     #if _MIPS_SIM == _MIPS_SIM_NABI32
>>   @@ -1043,15 +1045,16 @@
>>   #define __NR_seccomp            (__NR_Linux + 316)
>>   #define __NR_getrandom            (__NR_Linux + 317)
>>   #define __NR_memfd_create        (__NR_Linux + 318)
>> +#define __NR_set_fpuemul_xol_area    (__NR_Linux + 319)
>>     /*
>>    * Offset of the last N32 flavoured syscall
>>    */
>> -#define __NR_Linux_syscalls        318
>> +#define __NR_Linux_syscalls        319
>>     #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
>>     #define __NR_N32_Linux            6000
>> -#define __NR_N32_Linux_syscalls        318
>> +#define __NR_N32_Linux_syscalls        319
>>     #endif /* _UAPI_ASM_UNISTD_H */
>> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
>> index 636b074..6dde6bb 100644
>> --- a/arch/mips/kernel/process.c
>> +++ b/arch/mips/kernel/process.c
>> @@ -151,6 +151,7 @@ int copy_thread(unsigned long clone_flags, 
>> unsigned long usp,
>>         if (clone_flags & CLONE_SETTLS)
>>           ti->tp_value = regs->regs[7];
>> +    ti->fpu_emul_xol = ~0ul;
>>         return 0;
>>   }
>> diff --git a/arch/mips/kernel/scall32-o32.S 
>> b/arch/mips/kernel/scall32-o32.S
>> index 744cd10..8c19a39 100644
>> --- a/arch/mips/kernel/scall32-o32.S
>> +++ b/arch/mips/kernel/scall32-o32.S
>> @@ -579,3 +579,4 @@ EXPORT(sys_call_table)
>>       PTR    sys_seccomp
>>       PTR    sys_getrandom
>>       PTR    sys_memfd_create
>> +    PTR    sys_set_fpuemul_xol_area    /* 4355 */
>> diff --git a/arch/mips/kernel/scall64-64.S 
>> b/arch/mips/kernel/scall64-64.S
>> index 002b1bc..0b9f72e 100644
>> --- a/arch/mips/kernel/scall64-64.S
>> +++ b/arch/mips/kernel/scall64-64.S
>> @@ -434,4 +434,5 @@ EXPORT(sys_call_table)
>>       PTR    sys_seccomp
>>       PTR    sys_getrandom
>>       PTR    sys_memfd_create
>> +    PTR    sys_set_fpuemul_xol_area    /* 5315 */
>>       .size    sys_call_table,.-sys_call_table
>> diff --git a/arch/mips/kernel/scall64-n32.S 
>> b/arch/mips/kernel/scall64-n32.S
>> index ca6cbbe..48f1760 100644
>> --- a/arch/mips/kernel/scall64-n32.S
>> +++ b/arch/mips/kernel/scall64-n32.S
>> @@ -427,4 +427,5 @@ EXPORT(sysn32_call_table)
>>       PTR    sys_seccomp
>>       PTR    sys_getrandom
>>       PTR    sys_memfd_create
>> +    PTR    sys_set_fpuemul_xol_area
>>       .size    sysn32_call_table,.-sysn32_call_table
>> diff --git a/arch/mips/kernel/scall64-o32.S 
>> b/arch/mips/kernel/scall64-o32.S
>> index 9e10d11..60def68 100644
>> --- a/arch/mips/kernel/scall64-o32.S
>> +++ b/arch/mips/kernel/scall64-o32.S
>> @@ -564,4 +564,5 @@ EXPORT(sys32_call_table)
>>       PTR    sys_seccomp
>>       PTR    sys_getrandom
>>       PTR    sys_memfd_create
>> +    PTR    sys_set_fpuemul_xol_area    /* 4355 */
>>       .size    sys32_call_table,.-sys32_call_table
>> diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
>> index 4a4f9dd..5f9d9e8 100644
>> --- a/arch/mips/kernel/syscall.c
>> +++ b/arch/mips/kernel/syscall.c
>> @@ -96,6 +96,14 @@ SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
>>       return 0;
>>   }
>>   +SYSCALL_DEFINE1(set_fpuemul_xol_area, unsigned long, addr)
>> +{
>> +    struct thread_info *ti = task_thread_info(current);
>> +
>> +    ti->fpu_emul_xol = addr;
>> +    return 0;
>> +}
>> +
>>   static inline int mips_atomic_set(unsigned long addr, unsigned long 
>> new)
>>   {
>>       unsigned long old, tmp;
>> diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
>> index 4f514f3..bf4ff61 100644
>> --- a/arch/mips/math-emu/dsemul.c
>> +++ b/arch/mips/math-emu/dsemul.c
>> @@ -34,6 +34,7 @@ struct emuframe {
>>   int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned 
>> long cpc)
>>   {
>>       extern asmlinkage void handle_dsemulret(void);
>> +    struct thread_info *ti = task_thread_info(current);
>>       struct emuframe __user *fr;
>>       int err;
>>   @@ -64,10 +65,12 @@ int mips_dsemul(struct pt_regs *regs, 
>> mips_instruction ir, unsigned long cpc)
>>        * branches, but gives us a cleaner interface to the exception
>>        * handler (single entry point).
>>        */
>> -
>> -    /* Ensure that the two instructions are in the same cache line */
>> -    fr = (struct emuframe __user *)
>> -        ((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
>> +    if (ti->fpu_emul_xol != ~0ul)
>> +        fr = (struct emuframe *)ti->fpu_emul_xol;
>> +    else
>> +        /* Ensure that the two instructions are in the same cache 
>> line */
>> +        fr = (struct emuframe __user *)
>> +            ((regs->regs[29] - sizeof(struct emuframe)) & ~0x7);
>>         /* Verify that the stack pointer is not competely insane */
>>       if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct 
>> emuframe))))
>
>
