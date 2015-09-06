Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Sep 2015 04:42:28 +0200 (CEST)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36508 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006509AbbIFCm0BFOu6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Sep 2015 04:42:26 +0200
Received: by obqa2 with SMTP id a2so41922177obq.3;
        Sat, 05 Sep 2015 19:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6txZB7ADYtNcHS2kCzzy5NrpX4jIBSGi37k04Nlp680=;
        b=hm8oNSVb4UhyLFm0ZUC0uv40E1hmOFmAE4/mZXYmnQXeF3AJcw2lisImWArXNBizxC
         dGuLXAQWNO9ADVWcaNyNSN6GREPZTa7Ebo8cjguR+QpuaUx9Px6FOqfUUpq6f7FXJ41A
         MXwR9XLnbnWqr+pV+/ytGVBUFQac4pU/tEelHmNIqwDl6WsBmt4/eJXJ3r2cAcgTXolF
         FvnXSHhMDnLcX3wZKwsy5r/xLEnch71ujdFMeTzy/qtYV8oKpX0gChj+8ZZRV12IvVns
         p6dsq4ASVx2dk9AgL8twgmtOFhkD/eGPfRkpKaQcv/5t6W/FUrMI4Nlwj3vd4z1sXbnE
         okVQ==
X-Received: by 10.60.69.200 with SMTP id g8mr9401478oeu.40.1441507339934; Sat,
 05 Sep 2015 19:42:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.198.12 with HTTP; Sat, 5 Sep 2015 19:42:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.20.1509051421020.10227@eddie.linux-mips.org>
References: <1441273665-15601-1-git-send-email-yszhou4tech@gmail.com>
 <alpine.LFD.2.20.1509041924220.10227@eddie.linux-mips.org>
 <CAECwjAihV86pXqCA1tAthZKd5WoSm0-yO6++Gj7pff4K2qGJzQ@mail.gmail.com> <alpine.LFD.2.20.1509051421020.10227@eddie.linux-mips.org>
From:   Yousong Zhou <yszhou4tech@gmail.com>
Date:   Sun, 6 Sep 2015 10:42:00 +0800
Message-ID: <CAECwjAiyaWMeh32SOWPi8k=Zb4bQW3mNkbC6drnyy3Wtn924Ng@mail.gmail.com>
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
X-archive-position: 49116
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

Hi, Maciej, first of all, thank you for your time on this,
appreciate it.

Comments inline

On 5 September 2015 at 22:25, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Sat, 5 Sep 2015, Yousong Zhou wrote:
>
>> >  This can't be true.  The compiler does not intepret the contents of an
>> > inline asm and therefore cannot decide whether to inline a function
>> > containing one or not based on the lone presence or the absence of an
>> > assembly directive within.
>> >
>>
>> Most of the time I trust my compiler and never meddle with the
>> toolchain.  Anyway I made a patch because it really did not work for
>> me.   No big deal.  It's not the end of world.  It started with a
>> comment from OpenWrt packages feeds [1].  Actually this "unrecognized
>> opcode" problem have occurred within OpenWrt quite a few times before.
>>
>>  [1] https://github.com/openwrt/packages/commit/1e29676a8ac74f797f8ca799364681cec575ae6f#commitcomment-12901931
>
>  The bug certainly was there, it's just your analysis and consequently the
> fix that are wrong in the general case for some reason, maybe a buggy
> compiler.
>

This is the compiler "--version",

    mips-openwrt-linux-gcc (OpenWrt/Linaro GCC 4.8-2014.04 r46763) 4.8.3

>> >  It looks to me you're papering something over here -- when you use a
>> > `.set nomips16' directive the assembler will happily switch your
>> > instruction set in the middle of an instruction stream.  Consequently if
>> > this function is (for whatever reason; it should not really) inlined in
>> > MIPS16 code, then you'll get a MIPS32 instruction in the middle, which
>> > will obviously be interpreted differently in the MIPS16 execution mode and
>> > is therefore surely a recipe for disaster.
>>
>> If by "papering" you mean "made up", then whatever.  Yeah, it's
>> disaster, an "invalid instruction" abort.
>
>  By "papering over" I mean forcing source code to compile successfully at
> the risk of producing incorrect binary code.

Learned a new phrase/idiom :)

>
>> >  How did you test your change and made the conclusion quoted with your
>> > patch description?
>> >
>>
>> Compile the following program with a MIPS 24kc big endian variant compiler with
>> flag "-mips32r2 -mips16 -Os".
>>
>>     #include <stdio.h>
>>     #include <stdint.h>
>>
>>     uint16_t __attribute__((noinline)) f(uint16_t v)
>>     {
>>         v = __cpu_to_le16(v);
>>         return v;
>>     }
>>
>>     int main()
>>     {
>>         printf("%x\n", f(0xbeef));
>>
>>         return 0;
>>     }
>>
>> When only ".set nomips16" was specified in __arch_swab16(), this was output
>> from objdump.
>>
>>     242 004003e0 <f>:
>>     243   4003e0:       7c0410a0        wsbh    v0,a0
>>     244   4003e4:       e820ea31        swc2    $0,-5583(at)
>>     245   4003e8:       65006500        0x65006500
>>     246   4003ec:       65006500        0x65006500
>
>  Quite obviously.
>
>  For the record: the first instruction has been assembled in the regular
> MIPS mode and that propagated to symbol annotation.  Consequently `f' is
> seen by `objdump' as a regular MIPS function and disassembles it all as
> such.  You can put a global label immediately after the WSBH instruction
> in your source code to have the rest of the function disassembled
> correctly (of course this won't make this code work at the run time).

Thanks for the trick.  Objdump really disassembled it
correctly.

>
>> __arch_swab16() was indeed inlined.  That swc2 instruction can be got from
>> assembler with the following code (it's from the "-S" result of GCC).
>>
>>     .set    mips16
>>     .set    noreorder
>>     .set    nomacro
>>     j       $31
>>     zeh     $2
>>
>> When only nomips16 function attribute was specified, this time GCC failed with
>> unrecognized opcode
>>
>>     /tmp/ccaGCouL.s: Assembler messages:
>>     /tmp/ccaGCouL.s:21: Error: unrecognized opcode `wsbh $2,$4'
>>
>> The generated assembly was something in the following form.  Looks like the
>> assembler did not automatically switch to MIPS32 mode when ".set arch=mip32r2"
>
>  There's no switch to regular MIPS mode implied with `.set arch=mip32r2',
> the directive merely switches the ISA level, affecting both the regular
> MIPS and the MIPS16 mode (the MIPS32r2 ISA level adds extra MIPS16
> instructions too, e.g. ZEH is a new addition).

Agreed

>
>>         .set mips16
>>
>>         .ent f
>>         .type f, @function
>>     f
>>         ...
>>         .set push
>>         .set arch=mips32r2
>>         wsbh $2,$4
>>         .pop
>>         j $31
>>         zeh $2
>>         .end f
>>         ...
>
>  That's exactly the papered-over buggy code scenario I've been referring
> to above.  This is clearly MIPS16 code: ZEH is a MIPS16 instruction only,
> there's no such regular MIPS counterpart.  And it also obviously fails to
> assemble because on the contrary there's no MIPS16 WSBH instruction.
>

Yes, it won't assemble.

>  Now if you stick `.set nomips16' just above WSBH, then this code will
> happily assemble, because this single instruction only (`.set pop' reverts
> any previous `.set' directives; I'm assuming you wrote above by hand and
> `.pop' is a typo) will assemble in the regular MIPS instruction mode.  But
> if this code is ever reached, then the processor will still execute the
> machine code produced by the assembler from the WSBH instruction in the
> MIPS16 mode.

Yes, I hand-copied it from the output of "gcc -S" just to
show the form/pattern (the original output is too long for
this conversation).  No, that `.pop' is not a typo (I just
did a double-check).

If I stick `.set nomips16` just above WSBH, that's just what
the original patch tries to do, papering over the fact that
it did not compile/assemble without it.

>
>  For example the encoding of:
>
>         wsbh    $2, $4
>
> is (as you've shown in a dump above) 0x7c0410a0, which in the MIPS16 mode
> yields (in the big-endian mode):
>
> 00000000 <f>:
>    0:   7c04            sd      s0,32(a0)
>    2:   10a0            b       144 <f+0x144>
>
> -- so this won't do what you might expect, you'll get a Reserved
> Instruction exception on the SD instruction, which is not supported in the
> 32-bit mode, and consequently SIGILL.

Agreed.

>
>> The patch was run tested on QEMU Malta and an router with Atheros
>> AR9331 SoC.  I didn't test __arch_swab64() though.  I have done many
>> other trial-and-error tests while preparing this patch.  It was a mess
>> when I was sure I should expect some sensible behaviour from the
>> compiler while it actually just did not behave that way.
>
>  I've compiled your example provided and as I stated in the original mail
> `__arch_swab16' is always produced as a separate function, whether `.set
> nomips16' is present in the inline assembly placed there or not.  This is
> with (unreleased) GCC 6.0.0.
>
>  However if you happen to have a buggy compiler that fails to emit
> `__arch_swab16' as a separate function despite the `nomips16' attribute,
> then it's better if the resulting generated assembly code fails to
> assemble rather than if it goes astray at the run time.

Now, my compiler refused to emit `__arch_swab16' as a
separate function even with the `nomips16' function
attribute.  This is the kind of "mess" I just meant above, again.
I expect that it should emit a separate function and call it
with a jump observing that the caller `f' is in MIPS16 mode
yet the `__arch_swab16' is noMIPS16.  sigh~~

>
>> >  So setting aside the correctness issues discussed above, for MIPS16 code
>> > this has to be put out of line by the compiler, with all the usual
>> > overhead of a function call, causing a performance loss rather than a gain
>> > expected here.  Especially as switching the ISA mode requires draining the
>> > whole pipeline so that subsequent instructions are interpreted in the new
>> > execution mode.  This is expensive in performance terms.
>> >
>> >  I'm fairly sure simply disabling these asms (#ifndef __mips16) and
>> > letting the compiler generate the right mask and shift operations from
>> > plain C code will be cheaper in performance terms and possibly cheaper in
>> > code size as well, especially in otherwise leaf functions where an extra
>> > function call will according to the ABI clobber temporaries.  So I suggest
>> > going in that direction instead.
>>
>> I agree.  Then you will provide the fix right?  I am just curious
>> where that __mips16 should be placed or is it from compiler and
>> assembler?
>
>  No, it's your bug after all.  I think the last paragraph I wrote quoted
> above combined with the source code in question make it clear what to do.

Okay, I will try.  Most of the time when textbooks read
clearly/obviously/apparently, things go astray ;)

>
>  I have also checked what the difference in generated MIPS16 code is
> between a call to `__arch_swab16':
>
> 0000000c <f>:
>    c:   64c4            save    32,ra
>    e:   1800 0000       jal     0 <__arch_swab16>
>                         e: R_MIPS16_26  __arch_swab16
>   12:   ec31            zeh     a0
>   14:   6444            restore 32,ra
>   16:   e8a0            jrc     ra
>
> and equivalent generic code:
>
> 0000000c <f>:
>    c:   ec31            zeh     a0
>    e:   3280            sll     v0,a0,8
>   10:   3482            srl     a0,8
>   12:   ea8d            or      v0,a0
>   14:   e820            jr      ra
>   16:   ea31            zeh     v0
>
> so the win is I think clear.
>
>  Finally the MIPS64 `__arch_swab64' case does not matter as we have no
> MIPS16 support for 64-bit code in Linux, the toolchain will simply refuse
> to build it (only bare metal is supported).

Thanks for the information.  Never played with MIPS64
before.

Regards

                yousong
