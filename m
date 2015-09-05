Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Sep 2015 05:30:20 +0200 (CEST)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35876 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007390AbbIEDaSQXbMd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Sep 2015 05:30:18 +0200
Received: by obqa2 with SMTP id a2so30546757obq.3;
        Fri, 04 Sep 2015 20:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C7194q30ntpcvMC7yySjOlEpdwV/aShq4qO3oLiCBcc=;
        b=N+3546CVvkpojCuZ8Yt9QFLEYp+io5Cs6VdcrUtu6xedOVGBhqi1wqdmv/ibDitwgY
         RLhnOcEMw4mGW8ZwN3Kqhw7WB6MwNQxYbwyaezvGxH30sJLsbw94OVUNXafq8IXeer/v
         9DNfvRjpyQ77I8G3aVJNTfHTBxPFRmdzA/IlrzADmJkbanKCnKVS6r7tcky0vX5DnHEr
         spbQ8EPauABfIqXT2Rk7q1UHQC3GAXeO1G0tOkM0D8c3AV/HTUec5P7JXvJiAil0fhN/
         xDWZDYOxrHIK3O+LO0keV53zgBYiqlUkJE7y1JEfdTIQITyQzP5BXN1NtG0L6frdlvq2
         +OBg==
X-Received: by 10.60.178.99 with SMTP id cx3mr6361959oec.50.1441423812353;
 Fri, 04 Sep 2015 20:30:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.198.12 with HTTP; Fri, 4 Sep 2015 20:29:53 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.20.1509041924220.10227@eddie.linux-mips.org>
References: <1441273665-15601-1-git-send-email-yszhou4tech@gmail.com> <alpine.LFD.2.20.1509041924220.10227@eddie.linux-mips.org>
From:   Yousong Zhou <yszhou4tech@gmail.com>
Date:   Sat, 5 Sep 2015 11:29:53 +0800
Message-ID: <CAECwjAihV86pXqCA1tAthZKd5WoSm0-yO6++Gj7pff4K2qGJzQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: UAPI: Fix unrecognized opcode WSBH/DSBH/DSHD when
 using MIPS16.
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Chen Jie <chenj@lemote.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yszhou4tech@gmail.com
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

On 5 September 2015 at 02:52, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Thu, 3 Sep 2015, Yousong Zhou wrote:
>
>> The nomips16 has to be added both as function attribute and assembler
>> directive.
>>
>> When only function attribute is specified, the compiler will inline the
>> function with -Os optimization.  The generated assembly code cannot be
>> correctly assembled because ISA mode switch has to be done through jump
>> instruction.
>
>  This can't be true.  The compiler does not intepret the contents of an
> inline asm and therefore cannot decide whether to inline a function
> containing one or not based on the lone presence or the absence of an
> assembly directive within.
>

Most of the time I trust my compiler and never meddle with the
toolchain.  Anyway I made a patch because it really did not work for
me.   No big deal.  It's not the end of world.  It started with a
comment from OpenWrt packages feeds [1].  Actually this "unrecognized
opcode" problem have occurred within OpenWrt quite a few times before.

 [1] https://github.com/openwrt/packages/commit/1e29676a8ac74f797f8ca799364681cec575ae6f#commitcomment-12901931

>> When only ".set nomips16" directive is used, the generated assembly code
>> will use MIPS32 code for the inline assembly template and MIPS16 for the
>> function return.  The compiled binary is invalid:
>>
>>     00403100 <__arch_swab16>:
>>       403100:   7c0410a0    wsbh    v0,a0
>>       403104:   e820ea31    swc2    $0,-5583(at)
>>
>> while correct code should be:
>>
>>     00402650 <__arch_swab16>:
>>       402650:   7c0410a0    wsbh    v0,a0
>>       402654:   03e00008    jr  ra
>>       402658:   3042ffff    andi    v0,v0,0xffff
>
>  It looks to me you're papering something over here -- when you use a
> `.set nomips16' directive the assembler will happily switch your
> instruction set in the middle of an instruction stream.  Consequently if
> this function is (for whatever reason; it should not really) inlined in
> MIPS16 code, then you'll get a MIPS32 instruction in the middle, which
> will obviously be interpreted differently in the MIPS16 execution mode and
> is therefore surely a recipe for disaster.

If by "papering" you mean "made up", then whatever.  Yeah, it's
disaster, an "invalid instruction" abort.

>
>  How did you test your change and made the conclusion quoted with your
> patch description?
>

Compile the following program with a MIPS 24kc big endian variant compiler with
flag "-mips32r2 -mips16 -Os".

    #include <stdio.h>
    #include <stdint.h>

    uint16_t __attribute__((noinline)) f(uint16_t v)
    {
        v = __cpu_to_le16(v);
        return v;
    }

    int main()
    {
        printf("%x\n", f(0xbeef));

        return 0;
    }

When only ".set nomips16" was specified in __arch_swab16(), this was output
from objdump.

    242 004003e0 <f>:
    243   4003e0:       7c0410a0        wsbh    v0,a0
    244   4003e4:       e820ea31        swc2    $0,-5583(at)
    245   4003e8:       65006500        0x65006500
    246   4003ec:       65006500        0x65006500

__arch_swab16() was indeed inlined.  That swc2 instruction can be got from
assembler with the following code (it's from the "-S" result of GCC).

    .set    mips16
    .set    noreorder
    .set    nomacro
    j       $31
    zeh     $2

When only nomips16 function attribute was specified, this time GCC failed with
unrecognized opcode

    /tmp/ccaGCouL.s: Assembler messages:
    /tmp/ccaGCouL.s:21: Error: unrecognized opcode `wsbh $2,$4'

The generated assembly was something in the following form.  Looks like the
assembler did not automatically switch to MIPS32 mode when ".set arch=mip32r2"

        .set mips16

        .ent f
        .type f, @function
    f
        ...
        .set push
        .set arch=mips32r2
        wsbh $2,$4
        .pop
        j $31
        zeh $2
        .end f
        ...

The patch was run tested on QEMU Malta and an router with Atheros
AR9331 SoC.  I didn't test __arch_swab64() though.  I have done many
other trial-and-error tests while preparing this patch.  It was a mess
when I was sure I should expect some sensible behaviour from the
compiler while it actually just did not behave that way.

>> Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>
>> ---
>>  arch/mips/include/uapi/asm/swab.h |   12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
>> index 8f2d184..c4ddc4f 100644
>> --- a/arch/mips/include/uapi/asm/swab.h
>> +++ b/arch/mips/include/uapi/asm/swab.h
>> @@ -16,11 +16,13 @@
>>  #if (defined(__mips_isa_rev) && (__mips_isa_rev >= 2)) ||            \
>>      defined(_MIPS_ARCH_LOONGSON3A)
>>
>> -static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
>> +static inline __attribute__((nomips16)) __attribute_const__
>> +             __u16 __arch_swab16(__u16 x)
>>  {
>>       __asm__(
>>       "       .set    push                    \n"
>>       "       .set    arch=mips32r2           \n"
>> +     "       .set    nomips16                \n"
>>       "       wsbh    %0, %1                  \n"
>>       "       .set    pop                     \n"
>>       : "=r" (x)
>
>  So setting aside the correctness issues discussed above, for MIPS16 code
> this has to be put out of line by the compiler, with all the usual
> overhead of a function call, causing a performance loss rather than a gain
> expected here.  Especially as switching the ISA mode requires draining the
> whole pipeline so that subsequent instructions are interpreted in the new
> execution mode.  This is expensive in performance terms.
>
>  I'm fairly sure simply disabling these asms (#ifndef __mips16) and
> letting the compiler generate the right mask and shift operations from
> plain C code will be cheaper in performance terms and possibly cheaper in
> code size as well, especially in otherwise leaf functions where an extra
> function call will according to the ABI clobber temporaries.  So I suggest
> going in that direction instead.

I agree.  Then you will provide the fix right?  I am just curious
where that __mips16 should be placed or is it from compiler and
assembler?

>
>  So this is a NAK really.

okay.

Cheers

                yousong
