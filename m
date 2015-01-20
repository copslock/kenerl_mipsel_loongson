Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 12:47:12 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13940 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011153AbbATLrJwtTHF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 12:47:09 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 94C2B9B2B39F4;
        Tue, 20 Jan 2015 11:47:01 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 20 Jan 2015 11:47:03 +0000
Received: from LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9]) by
 LEMAIL01.le.imgtec.org ([fe80::5ae:ee16:f4b9:cda9%17]) with mapi id
 14.03.0210.002; Tue, 20 Jan 2015 11:47:02 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH RFC v2 24/70] MIPS: asm: spinlock: Replace sub
 instruction with addiu
Thread-Topic: [PATCH RFC v2 24/70] MIPS: asm: spinlock: Replace sub
 instruction with addiu
Thread-Index: AQHQNKRKd1+VIXuDZkeBZlHpnZJoEJzI4Oig
Date:   Tue, 20 Jan 2015 11:47:01 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235320FAC458@LEMAIL01.le.imgtec.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
 <1421405389-15512-25-git-send-email-markos.chandras@imgtec.com>
 <alpine.LFD.2.11.1501200028390.28301@eddie.linux-mips.org>
 <54BE3BFD.5070108@imgtec.com>
In-Reply-To: <54BE3BFD.5070108@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.76]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Markos Chandras <Markos.Chandras@imgtec.com> writes:
> On 01/20/2015 01:04 AM, Maciej W. Rozycki wrote:
> > On Fri, 16 Jan 2015, Markos Chandras wrote:
> >
> >> sub $reg, imm is not a real MIPS instruction. The assembler replaces
> >> that with 'addi $reg, -imm'. However, addi has been removed from R6,
> >> so we replace the 'sub' instruction with 'addiu' instead.
> >>
> >> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> >> ---
> >>  arch/mips/include/asm/spinlock.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/mips/include/asm/spinlock.h
> b/arch/mips/include/asm/spinlock.h
> >> index c6d06d383ef9..500050d3bda6 100644
> >> --- a/arch/mips/include/asm/spinlock.h
> >> +++ b/arch/mips/include/asm/spinlock.h
> >> @@ -276,7 +276,7 @@ static inline void arch_read_unlock(arch_rwlock_t
> *rw)
> >>  		do {
> >>  			__asm__ __volatile__(
> >>  			"1:	ll	%1, %2	# arch_read_unlock	\n"
> >> -			"	sub	%1, 1				\n"
> >> +			"	addiu	%1, -1				\n"
> >>  			"	sc	%1, %0				\n"
> >>  			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
> >>  			: GCC_OFF12_ASM() (rw->lock)
> >
> >  This integer overflow trap is deliberate here -- have you seen the note
> > just above:
> >
> > /* Note the use of sub, not subu which will make the kernel die with an
> >    overflow exception if we ever try to unlock an rwlock that is already
> >    unlocked or is being held by a writer.  */
> >
> > ?
> >
> >  What this shows really is a GAS bug fix for the SUB macro is needed
> > similar to what I suggested in 12/70 for ADDI (from the situation I
> infer
> > there is some real work to do in GAS in this area; adding Matthew as a
> > recipient to raise his awareness) so that it does not expand to ADDI
> where
> > the architecture or processor selected do not support it.  Instead a
> > longer sequence involving SUB has to be produced.

The assembler is at least consistent at the moment as the 'sub' macro is
disabled for R6. I am very keen to stop carrying around historic baggage
where it is not necessary. R6 is one place we can do that and deal with
any code changes that are required.

> >  However, regardless, I suggest code like:
> >
> > /* There's no R6 ADDI instruction so use the ADD register version
> instead. */
> > #ifdef CONFIG_CPU_MIPSR6
> > #define GCC_ADDI_ASM() "r"
> > #else
> > #define GCC_ADDI_ASM() "I"
> > #endif
> >
> > 			__asm__ __volatile__(
> > 			"1:	ll	%1, %2	# arch_read_unlock	\n"
> > 			"	sub	%1, %3				\n"
> > 			"	sc	%1, %0				\n"
> > 			: "=" GCC_OFF12_ASM() (rw->lock), "=&r" (tmp)
> > 			: GCC_OFF12_ASM() (rw->lock), GCC_ADDI_ASM() (1)
> > 			: "memory");
> >
> > (untested, but should work) so that there's still a single instruction
> > only in the LL/SC loop and consequently no increased lock contention
> risk.

I'm afraid I don't like this. The obfuscation of the underlying ISA is
very confusing. In this case it is 100% clear that the asm instruction
is going to get an immediate operand so the instruction is 'addi' with
a negated immediate. However, it costs nothing (in the loop) to use
'add' and an 'r' constraint in all cases. Yes, there will be an extra
setup instruction and register used but the assembly code is clear and
maps 1:1 to real instructions for all ISAs.

(Note this asm block does not appear to need to clobber memory either as
the effects on memory are correctly stated in the constraints).

> >  As a side note, this could be cleaned up to use a "+" input/output
> > constraint; such a clean-up will be welcome -- although to be complete,
> a
> > review of all the asms will be required (this may bump up the GCC
> version
> > requirement though, ISTR bugs in this area).

I believe some of these asm blocks using ll/sc already have '+' in the
constraints for the memory location so perhaps that is either already
a problem or not an issue.

Matthew
