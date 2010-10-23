Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Oct 2010 07:51:55 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:39307 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490985Ab0JWFvv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Oct 2010 07:51:51 +0200
Received: by wwb39 with SMTP id 39so993831wwb.24
        for <multiple recipients>; Fri, 22 Oct 2010 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aiFivPdI+X0v5GiY68y/0nQ+/SuoPFZh2TupVsMH1qc=;
        b=Q4nNfOWTOAAMT/png4eQ5yuP5J5Xqf7amF1rJQIP2SjPRVradTilfWfko+l+NDb0SN
         0/4fbjjStFDLZbny6ud1DHU2QOo6pC93gZU1EXr1+vKIR8Qch2sfLehRQQOdfPFP0Jvx
         GQ8w2ilO7gN/QNK+2VkfI1qKh9xvQ8if65a6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DUdNxy7dB4ye4jP58ppHgRM7827bDjsEoYAIGtk1icecjgSkX8chGl8Meh/D84kBcl
         bZ4HdoALe+cqNQSGbkPckl4GilimScpJtXdJxu3P9Hm3GcDF01tIAxrKFXKbxEt79ZV+
         800ZPdceNxvObgU2veQLIAcTnjUPwa/Db7u5I=
MIME-Version: 1.0
Received: by 10.216.65.70 with SMTP id e48mr359810wed.44.1287813105392; Fri,
 22 Oct 2010 22:51:45 -0700 (PDT)
Received: by 10.216.176.203 with HTTP; Fri, 22 Oct 2010 22:51:45 -0700 (PDT)
In-Reply-To: <4CC202BF.2030402@caviumnetworks.com>
References: <cover.1287779153.git.wuzhangjin@gmail.com>
        <ed5f624f16b4b8ff1ee9fa688b3a5b715a0b913d.1287779153.git.wuzhangjin@gmail.com>
        <4CC202BF.2030402@caviumnetworks.com>
Date:   Sat, 23 Oct 2010 13:51:45 +0800
Message-ID: <AANLkTina04u1Qi12n6L0Dx8X1U9JmtFYjjZ5S290o=oo@mail.gmail.com>
Subject: Re: [RFC 1/2] MIPS: tracing/ftrace: Replace in_module() with a
 generic in_kernel_space()
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org, rostedt@goodmis.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Oct 23, 2010 at 5:31 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 10/22/2010 01:58 PM, Wu Zhangjin wrote:
>>
>> From: Wu Zhangjin<wuzhangjin@gmail.com>
>>
>> The module space may be the same as the kernel space sometimes(with
>> related kernel config and gcc options), but the current in_module()
>> assume they are always different, so, it should be fixed.
>>
>> As we know, for the limitation of the fixed 32bit long instruction of
>> MIPS, the "jal target" can only jump to an address whose offset from the
>> jal instruction is smaller than 2^28=256M, which means if the address is
>> in kernel space(the kernel image should be always smaller than 256M), no
>> long call is needed to jump from the address to _mcount, and further, if
>> the module use the same space as kernel space, the situation for module
>> will be the same as the kernel. but currently for MIPS, in most of the
>> situations, module has different space(0xc0000000) from the kernel
>> space(0x80000000) and the offset is bigger than 256M, a register is
>> needed to load the address of _mcount and another instruction "jal
>> <register>" is needed to jump from an address to _mcount.
>>
>> The above can be explained as:
>>
>> if (in_kernel_space(addr)) {
>>        jal _mcount;
>> } else {
>>        load the address of _mcount to a register
>>        jalr<register>
>> }
>>
>
> Why can't we just do code examination to determine which case we are
> patching? There is a very limited and fixed set of instruction sequences
> that GCC will emit for _mcount calls.  We can easily check for all of them.
>
> The mcount call sequence unconditionally emits:
>
>        MOVE $1,$31
>
> In the JALR case (for -mlong-call), the instruction immediately before this
> will have the target register be '$3'.
>

Yes, we can, but we care about the performance here:

The current in_kernel_space() only need to check the address itself
but checking the code at (address-4) need an extra memory access .
Because ftrace_make_{nop,call} may be called to cope with a large
number of _mcount calling sites, considering the low frequency of the
MIPS, using a working and light-weight method here is more important,
so ... why not checking the address directly and the point is it works
well.

> I would rather directly check which case we are patching rather than trying
> to infer it from the address.
>
> Is there any case where a 'stock' kernel currently fails?  If not, this
> patch seems like unneeded code churn.

Hmm, not found such a failure yet, but theoretically the failure may
happen for the old implementation(The in_module() in
arch/mips/kernel/ftrace.c) had the assumption of module would always
be compiled with -mlong-calls, but the method(in_kernel_space) used in
this patch discards the assumption and therefore it is more generic.

Thanks,
Wu Zhangjin

>
>
>
>> As we can see, the above explanation covers all of the situations well
>> and reflect the reality, so, we decide to add a new in_kernel_space()
>> instead of the old in_module().
>>
>> Based on core_kernel_text() from kernel/extable.c, in_kernel_space() is
>> easily to be added. Because all of the functions in the init sections is
>> anotated with notrace, so, differ from core_kernel_text(),
>> in_kernel_space() doesn't care about init section.
>>
>> With this new in_kernel_space(), the ftrace_make_{nop,call} can be
>> explained as following.
>>
>> ftrace_make_call()                                      ftrace_make_nop()
>>
>> if (in_kernel_space(addr)) {
>>        jal _mcount;    (jal ftrace_caller)     <-->    nop
>> } else {
>>        load the address of _mcount to a register<-->   b label
>>        jalr<register>
>>        label:
>> }
>>
>> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
>> ---
>>  arch/mips/kernel/ftrace.c |   66
>> ++++++++++++++++++++++++--------------------
>>  1 files changed, 36 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
>> index 65f1949..6ff5a54 100644
>> --- a/arch/mips/kernel/ftrace.c
>> +++ b/arch/mips/kernel/ftrace.c
>> @@ -17,21 +17,7 @@
>>  #include<asm/cacheflush.h>
>>  #include<asm/uasm.h>
>>
>> -/*
>> - * If the Instruction Pointer is in module space (0xc0000000), return
>> true;
>> - * otherwise, it is in kernel space (0x80000000), return false.
>> - *
>> - * FIXME: This will not work when the kernel space and module space are
>> the
>> - * same. If they are the same, we need to modify scripts/recordmcount.pl,
>> - * ftrace_make_nop/call() and the other related parts to ensure the
>> - * enabling/disabling of the calling site to _mcount is right for both
>> kernel
>> - * and module.
>> - */
>> -
>> -static inline int in_module(unsigned long ip)
>> -{
>> -       return ip&  0x40000000;
>> -}
>> +#include<asm-generic/sections.h>
>>
>>  #ifdef CONFIG_DYNAMIC_FTRACE
>>
>> @@ -69,6 +55,20 @@ static inline void ftrace_dyn_arch_init_insns(void)
>>  #endif
>>  }
>>
>> +/*
>> + * Check if the address is in kernel space
>> + *
>> + * Clone core_kernel_text() from kernel/extable.c, but don't call
>> + * init_kernel_text() for Ftrace don't trace functions in init sections.
>> + */
>> +static inline int in_kernel_space(unsigned long ip)
>> +{
>> +       if (ip>= (unsigned long)_stext&&
>> +           ip<= (unsigned long)_etext)
>> +               return 1;
>> +       return 0;
>> +}
>> +
>>  static int ftrace_modify_code(unsigned long ip, unsigned int new_code)
>>  {
>>        int faulted;
>> @@ -91,10 +91,16 @@ int ftrace_make_nop(struct module *mod,
>>        unsigned long ip = rec->ip;
>>
>>        /*
>> -        * We have compiled module with -mlong-calls, but compiled the
>> kernel
>> -        * without it, we need to cope with them respectively.
>> +        * If ip is in kernel space, long call is not needed, otherwise,
>> it is
>> +        * needed.
>>         */
>> -       if (in_module(ip)) {
>> +       if (in_kernel_space(ip)) {
>> +               /*
>> +                * move at, ra
>> +                * jal _mcount          -->  nop
>> +                */
>> +               new = INSN_NOP;
>> +       } else {
>>  #if defined(KBUILD_MCOUNT_RA_ADDRESS)&&  defined(CONFIG_32BIT)
>>                /*
>>                 * lui v1, hi_16bit_of_mcount        -->  b 1f (0x10000005)
>> @@ -117,12 +123,6 @@ int ftrace_make_nop(struct module *mod,
>>                 */
>>                new = INSN_B_1F_4;
>>  #endif
>> -       } else {
>> -               /*
>> -                * move at, ra
>> -                * jal _mcount          -->  nop
>> -                */
>> -               new = INSN_NOP;
>>        }
>>        return ftrace_modify_code(ip, new);
>>  }
>> @@ -132,8 +132,12 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned
>> long addr)
>>        unsigned int new;
>>        unsigned long ip = rec->ip;
>>
>> -       /* ip, module: 0xc0000000, kernel: 0x80000000 */
>> -       new = in_module(ip) ? insn_lui_v1_hi16_mcount :
>> insn_jal_ftrace_caller;
>> +       /*
>> +        * If ip is in kernel space, long call is not needed, otherwise,
>> it is
>> +        * needed.
>> +        */
>> +       new = in_kernel_space(ip) ? insn_jal_ftrace_caller :
>> +               insn_lui_v1_hi16_mcount;
>>
>>        return ftrace_modify_code(ip, new);
>>  }
>> @@ -200,11 +204,13 @@ unsigned long ftrace_get_parent_addr(unsigned long
>> self_addr,
>>        int faulted;
>>
>>        /*
>> -        * For module, move the ip from calling site of mcount after the
>> -        * instruction "lui v1, hi_16bit_of_mcount"(offset is 24), but for
>> -        * kernel, move after the instruction "move ra, at"(offset is 16)
>> +        * If self_addr is in kernel space, long call is not needed, only
>> need
>> +        * to move ip after the instruction "move ra, at"(offset is 16),
>> +        * otherwise, long call is needed, need to move ip from calling
>> site of
>> +        * mcount after the instruction "lui v1,
>> hi_16bit_of_mcount"(offset is
>> +        * 24).
>>         */
>> -       ip = self_addr - (in_module(self_addr) ? 24 : 16);
>> +       ip = self_addr - (in_kernel_space(self_addr) ? 16 : 24);
>>
>>        /*
>>         * search the text until finding the non-store instruction or
>> "s{d,w}
>
>
