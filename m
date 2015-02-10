Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Feb 2015 17:17:04 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27013184AbbBJQRCwXfj5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Feb 2015 17:17:02 +0100
Date:   Tue, 10 Feb 2015 16:17:02 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        binutils@sourceware.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH RFC v2 24/70] MIPS: asm: spinlock: Replace sub instruction
 with addiu
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320FAC458@LEMAIL01.le.imgtec.org>
Message-ID: <alpine.LFD.2.11.1501201535050.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-25-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501200028390.28301@eddie.linux-mips.org> <54BE3BFD.5070108@imgtec.com>
 <6D39441BF12EF246A7ABCE6654B0235320FAC458@LEMAIL01.le.imgtec.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45800
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

On Tue, 20 Jan 2015, Matthew Fortune wrote:

> > >  What this shows really is a GAS bug fix for the SUB macro is needed
> > > similar to what I suggested in 12/70 for ADDI (from the situation I
> > infer
> > > there is some real work to do in GAS in this area; adding Matthew as a
> > > recipient to raise his awareness) so that it does not expand to ADDI
> > where
> > > the architecture or processor selected do not support it.  Instead a
> > > longer sequence involving SUB has to be produced.
> 
> The assembler is at least consistent at the moment as the 'sub' macro is
> disabled for R6. I am very keen to stop carrying around historic baggage
> where it is not necessary. R6 is one place we can do that and deal with
> any code changes that are required.

 I have yet to be convinced it is merely historic baggage.  Maybe it's a 
matter of habits I got into, but I find the presence of these macros a way 
to make the MIPS assembly language actually usable for handcoding.  There 
are several reasons for this.

 One is the limited range of immediates in machine makes it necessary to 
use different instruction sequences for different immediate input 
arguments.  Given this source code instruction:

	li	$2, foo

for different values of `foo' you'll get different machine code:

    foo		code
    0x1234	addiu $2, $0, 0x1234
    0x89ab	ori $2, $0, 0x89ab
0x89ab0000	lui $2, 0x89ab
0x89ab1234	lui $2, 0x89ab; addiu $2, $2, 0x1234

now if `foo' is some sort of an externally supplied constant (e.g. set 
with a `configure' script or whatever), then without the macros you'd have 
to pessimise code, or clutter it with #ifdef's.

 Another is to abstract ABI dependencies.  Again, given this source code 
instruction:

	lw	$2, foo

for different ABIs you'll get different code:

    ABI		code
o32/non-PIC	lui $2, %hi(foo); lw $2, %lo(foo)($2)
o32/PIC/extern	lw $2, %got(foo)($28); lw $2, 0($2)
o32/PIC/local	lw $2, %got(foo)($28); addiu $2, %lo(foo); lw $2, 0($2)
n64/non-PIC	lui $1, %highest(foo); lui $2, %hi(foo);
		addiu $1, $1, %higher(foo); dsll32 $1, $1, 0;
		daddu $1, $1, $2; lw $2, %lo(foo)($1)
n64/PIC/extern	ld $2, %got_disp(foo)($28); lw $2, 0($2)
[...]

You'd have to conditionalise it all too.

 And there are more cases macros address, e.g. to make the complete set of 
arithmetic conditions available for branches (with the use of SLT and SLTU 
instructions), extra operations (e.g. NOT as a shorthand for NOR), 
three-argument trapping MULOU, DIVU, REMU operations (especially 
interesting to note in the context of r6; why MODU wasn't consequently 
called REMU for portability escapes me), etc.

 All this makes assembly language programming easier and more like with 
CISC assembly languages, e.g. this x86 assembly-language instruction:

	addl	$foo, %eax

will do the right thing for any value of `foo' and the assembler will also 
pick the shortest instruction encoding available.  As a result when 
writing code you can focus on the problem you're trying to solve rather 
than getting distracted by ABI peculiarites or the assymetry of the 
machine instruction set.  It is also easier to follow when studying code 
written by someone else.

 Of course all this does not matter for compiler-generated code.  Which is 
also the reason why the MIPS16 assembly language has never included a 
complementing set of these macros -- it was only meant to be used in 
compiler-generated code and never for handcoding.  And for handcoded 
assembly if you are concerned about source code instructions expanding 
into multiple machine instructions, then you can always stick `.set 
nomacro' at the top of your source code.

> > > 			__asm__ __volatile__(
> > > 			"1:	ll	%1, %2	# arch_read_unlock	\n"
> > > 			"	sub	%1, %3				\n"
> > > 			"	sc	%1, %0				\n"
> > > 			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
> > > 			: GCC_OFF12_ASM() (rw->lock), GCC_ADDI_ASM() (1)
> > > 			: "memory");
> > >
> > > (untested, but should work) so that there's still a single instruction
> > > only in the LL/SC loop and consequently no increased lock contention
> > risk.
[...]
> 
> (Note this asm block does not appear to need to clobber memory either as
> the effects on memory are correctly stated in the constraints).

 The `memory' clobber serves the purpose of an optimisation barrier here, 
it's not about the memory accesses happening within the asm itself.

> > >  As a side note, this could be cleaned up to use a "+" input/output
> > > constraint; such a clean-up will be welcome -- although to be complete,
> > a
> > > review of all the asms will be required (this may bump up the GCC
> > version
> > > requirement though, ISTR bugs in this area).
> 
> I believe some of these asm blocks using ll/sc already have '+' in the
> constraints for the memory location so perhaps that is either already
> a problem or not an issue.

 I just don't remember offhand if the use of `+' was in platform or in 
shared code.  If the latter, then let's just switch, if the former, we 
need to be careful.

 IIRC some versions of GCC complained and failed compilation if the list 
of constraints associated with `+' did not allow a register alternative, 
such by including the `r' constraint.  Which of course would be completely 
pointless here, and actually harmful.  Furthermore IIRC it had been a 
deliberate decision made by GCC maintainers who were unaware of some use 
cases for inline asms.  The decision was then discussed and GCC 
maintainers persuaded to change it; it can likely be tracked down in a 
mailing list archive somewhere.

  Maciej
