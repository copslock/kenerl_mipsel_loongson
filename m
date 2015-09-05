Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Sep 2015 16:26:00 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27013611AbbIEOZ6JIpVm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Sep 2015 16:25:58 +0200
Date:   Sat, 5 Sep 2015 15:25:58 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Yousong Zhou <yszhou4tech@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, Chen Jie <chenj@lemote.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: UAPI: Fix unrecognized opcode WSBH/DSBH/DSHD when
 using MIPS16.
In-Reply-To: <CAECwjAihV86pXqCA1tAthZKd5WoSm0-yO6++Gj7pff4K2qGJzQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1509051421020.10227@eddie.linux-mips.org>
References: <1441273665-15601-1-git-send-email-yszhou4tech@gmail.com> <alpine.LFD.2.20.1509041924220.10227@eddie.linux-mips.org> <CAECwjAihV86pXqCA1tAthZKd5WoSm0-yO6++Gj7pff4K2qGJzQ@mail.gmail.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Sat, 5 Sep 2015, Yousong Zhou wrote:

> >  This can't be true.  The compiler does not intepret the contents of an
> > inline asm and therefore cannot decide whether to inline a function
> > containing one or not based on the lone presence or the absence of an
> > assembly directive within.
> >
> 
> Most of the time I trust my compiler and never meddle with the
> toolchain.  Anyway I made a patch because it really did not work for
> me.   No big deal.  It's not the end of world.  It started with a
> comment from OpenWrt packages feeds [1].  Actually this "unrecognized
> opcode" problem have occurred within OpenWrt quite a few times before.
> 
>  [1] https://github.com/openwrt/packages/commit/1e29676a8ac74f797f8ca799364681cec575ae6f#commitcomment-12901931

 The bug certainly was there, it's just your analysis and consequently the 
fix that are wrong in the general case for some reason, maybe a buggy 
compiler.

> >  It looks to me you're papering something over here -- when you use a
> > `.set nomips16' directive the assembler will happily switch your
> > instruction set in the middle of an instruction stream.  Consequently if
> > this function is (for whatever reason; it should not really) inlined in
> > MIPS16 code, then you'll get a MIPS32 instruction in the middle, which
> > will obviously be interpreted differently in the MIPS16 execution mode and
> > is therefore surely a recipe for disaster.
> 
> If by "papering" you mean "made up", then whatever.  Yeah, it's
> disaster, an "invalid instruction" abort.

 By "papering over" I mean forcing source code to compile successfully at 
the risk of producing incorrect binary code.

> >  How did you test your change and made the conclusion quoted with your
> > patch description?
> >
> 
> Compile the following program with a MIPS 24kc big endian variant compiler with
> flag "-mips32r2 -mips16 -Os".
> 
>     #include <stdio.h>
>     #include <stdint.h>
> 
>     uint16_t __attribute__((noinline)) f(uint16_t v)
>     {
>         v = __cpu_to_le16(v);
>         return v;
>     }
> 
>     int main()
>     {
>         printf("%x\n", f(0xbeef));
> 
>         return 0;
>     }
> 
> When only ".set nomips16" was specified in __arch_swab16(), this was output
> from objdump.
> 
>     242 004003e0 <f>:
>     243   4003e0:       7c0410a0        wsbh    v0,a0
>     244   4003e4:       e820ea31        swc2    $0,-5583(at)
>     245   4003e8:       65006500        0x65006500
>     246   4003ec:       65006500        0x65006500

 Quite obviously.

 For the record: the first instruction has been assembled in the regular 
MIPS mode and that propagated to symbol annotation.  Consequently `f' is 
seen by `objdump' as a regular MIPS function and disassembles it all as 
such.  You can put a global label immediately after the WSBH instruction 
in your source code to have the rest of the function disassembled 
correctly (of course this won't make this code work at the run time).

> __arch_swab16() was indeed inlined.  That swc2 instruction can be got from
> assembler with the following code (it's from the "-S" result of GCC).
> 
>     .set    mips16
>     .set    noreorder
>     .set    nomacro
>     j       $31
>     zeh     $2
> 
> When only nomips16 function attribute was specified, this time GCC failed with
> unrecognized opcode
> 
>     /tmp/ccaGCouL.s: Assembler messages:
>     /tmp/ccaGCouL.s:21: Error: unrecognized opcode `wsbh $2,$4'
> 
> The generated assembly was something in the following form.  Looks like the
> assembler did not automatically switch to MIPS32 mode when ".set arch=mip32r2"

 There's no switch to regular MIPS mode implied with `.set arch=mip32r2', 
the directive merely switches the ISA level, affecting both the regular 
MIPS and the MIPS16 mode (the MIPS32r2 ISA level adds extra MIPS16 
instructions too, e.g. ZEH is a new addition).

>         .set mips16
> 
>         .ent f
>         .type f, @function
>     f
>         ...
>         .set push
>         .set arch=mips32r2
>         wsbh $2,$4
>         .pop
>         j $31
>         zeh $2
>         .end f
>         ...

 That's exactly the papered-over buggy code scenario I've been referring 
to above.  This is clearly MIPS16 code: ZEH is a MIPS16 instruction only, 
there's no such regular MIPS counterpart.  And it also obviously fails to 
assemble because on the contrary there's no MIPS16 WSBH instruction.

 Now if you stick `.set nomips16' just above WSBH, then this code will 
happily assemble, because this single instruction only (`.set pop' reverts 
any previous `.set' directives; I'm assuming you wrote above by hand and 
`.pop' is a typo) will assemble in the regular MIPS instruction mode.  But 
if this code is ever reached, then the processor will still execute the 
machine code produced by the assembler from the WSBH instruction in the 
MIPS16 mode.

 For example the encoding of:

	wsbh	$2, $4

is (as you've shown in a dump above) 0x7c0410a0, which in the MIPS16 mode 
yields (in the big-endian mode):

00000000 <f>:
   0:	7c04      	sd	s0,32(a0)
   2:	10a0      	b	144 <f+0x144>

-- so this won't do what you might expect, you'll get a Reserved 
Instruction exception on the SD instruction, which is not supported in the 
32-bit mode, and consequently SIGILL.

> The patch was run tested on QEMU Malta and an router with Atheros
> AR9331 SoC.  I didn't test __arch_swab64() though.  I have done many
> other trial-and-error tests while preparing this patch.  It was a mess
> when I was sure I should expect some sensible behaviour from the
> compiler while it actually just did not behave that way.

 I've compiled your example provided and as I stated in the original mail 
`__arch_swab16' is always produced as a separate function, whether `.set 
nomips16' is present in the inline assembly placed there or not.  This is 
with (unreleased) GCC 6.0.0.

 However if you happen to have a buggy compiler that fails to emit 
`__arch_swab16' as a separate function despite the `nomips16' attribute, 
then it's better if the resulting generated assembly code fails to 
assemble rather than if it goes astray at the run time.

> >  So setting aside the correctness issues discussed above, for MIPS16 code
> > this has to be put out of line by the compiler, with all the usual
> > overhead of a function call, causing a performance loss rather than a gain
> > expected here.  Especially as switching the ISA mode requires draining the
> > whole pipeline so that subsequent instructions are interpreted in the new
> > execution mode.  This is expensive in performance terms.
> >
> >  I'm fairly sure simply disabling these asms (#ifndef __mips16) and
> > letting the compiler generate the right mask and shift operations from
> > plain C code will be cheaper in performance terms and possibly cheaper in
> > code size as well, especially in otherwise leaf functions where an extra
> > function call will according to the ABI clobber temporaries.  So I suggest
> > going in that direction instead.
> 
> I agree.  Then you will provide the fix right?  I am just curious
> where that __mips16 should be placed or is it from compiler and
> assembler?

 No, it's your bug after all.  I think the last paragraph I wrote quoted 
above combined with the source code in question make it clear what to do.

 I have also checked what the difference in generated MIPS16 code is 
between a call to `__arch_swab16':

0000000c <f>:
   c:	64c4      	save	32,ra
   e:	1800 0000 	jal	0 <__arch_swab16>
			e: R_MIPS16_26	__arch_swab16
  12:	ec31      	zeh	a0
  14:	6444      	restore	32,ra
  16:	e8a0      	jrc	ra

and equivalent generic code:

0000000c <f>:
   c:	ec31      	zeh	a0
   e:	3280      	sll	v0,a0,8
  10:	3482      	srl	a0,8
  12:	ea8d      	or	v0,a0
  14:	e820      	jr	ra
  16:	ea31      	zeh	v0

so the win is I think clear.

 Finally the MIPS64 `__arch_swab64' case does not matter as we have no 
MIPS16 support for 64-bit code in Linux, the toolchain will simply refuse 
to build it (only bare metal is supported).

  Maciej
