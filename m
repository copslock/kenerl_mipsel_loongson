Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2016 14:32:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41359 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010028AbcA2NcqqGkjr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2016 14:32:46 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 60CC297D8449C;
        Fri, 29 Jan 2016 13:32:37 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.235.1; Fri, 29 Jan 2016
 13:32:39 +0000
Date:   Fri, 29 Jan 2016 13:32:38 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, <benh@kernel.crashing.org>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <markos.chandras@imgtec.com>, <Steven.Hill@imgtec.com>,
        <alexander.h.duyck@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
In-Reply-To: <56A97CE1.5090004@gentoo.org>
Message-ID: <alpine.LFD.2.20.1601291006420.18566@eddie.linux-mips.org>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin> <20150602000934.6668.43645.stgit@ubuntu-yegoshin> <20150605131046.GD26432@linux-mips.org> <56A97CE1.5090004@gentoo.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 27 Jan 2016, Joshua Kinard wrote:

> On 06/05/2015 09:10, Ralf Baechle wrote:
> > 
> > Maciej,
> > 
> > do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to
> > test this?  I think we don't need to test that SYNC actually works as
> > intended but the simpler test that SYNC <stype != 0> is not causing a
> > illegal instruction exception is sufficient, that is if something like
> > 
> > int main(int argc, charg *argv[])
> > {
> > 	asm("	.set	mips2		\n"
> > 	"	sync	0x10		\n"
> > 	"	sync	0x13		\n"
> > 	"	sync	0x04		\n"
> > 	"	.set	mips 0		\n");
> > 
> > 	return 0;
> > }
> > 
> > doesn't crash we should be ok.

 No anomalies observed with these processors:

CPU0 revision is: 00000440 (R4400SC)
CPU0 revision is: 01040102 (SiByte SB1)

> I tried just compiling this on my SGI O2, which has an RM7000 CPU, and it is
> refusing to even compile (after fixing typos):
> 
> # gcc -O2 -pipe sync_test.c -o sync_test
> {standard input}: Assembler messages:
> {standard input}:19: Error: invalid operands `sync 0x10'
> {standard input}:20: Error: invalid operands `sync 0x13'
> {standard input}:21: Error: invalid operands `sync 0x04'

 Yeah, there is another typo there: you need to use `.set mips32' or 
suchlike rather than `.set mips2' to be able to specify an operand.  That 
probably counts as a bug in binutils, as -- according to what I have 
observed in the other thread -- the `stype' field has been defined at 
least since the MIPS IV ISA.

> And the program compiles successfully and executes with no noticeable oddities
> or errors.  Nothing in dmesg, no crashes, booms, or disappearance of small

 You did disable SYNC emulation in the kernel though with a change like 
below, did you?

> kittens.  I did a quick disassembly to make sure all three got emitted:
> 
> 004005e0 <main>:
>   4005e0:       27bdfff8        addiu   sp,sp,-8
>   4005e4:       afbe0004        sw      s8,4(sp)
>   4005e8:       03a0f021        move    s8,sp
>   4005ec:       afc40008        sw      a0,8(s8)
>   4005f0:       afc5000c        sw      a1,12(s8)
> > 4005f4:       0000040f        sync.p
> > 4005f8:       0000050f        0x50f
> > 4005fc:       0000010f        0x10f
>   400600:       00001021        move    v0,zero

 You could have used the -m switch to override the architecture embedded 
with the ELF file, to have the instructions disassembled correctly, e.g.:

$ objdump -m mips:isa64 -d sync
[...]
00000001200008f0 <main>:
   1200008f0:	0000040f 	sync	0x10
   1200008f4:	000004cf 	sync	0x13
   1200008f8:	0000010f 	sync	0x4
   1200008fc:	03e00008 	jr	ra
   120000900:	0000102d 	move	v0,zero
	...
[...]

 What's interesting to note is that rev. 2.60 of the architecture did 
actually change the semantics of plain SYNC (aka SYNC 0) from an ordering 
barrier to a completion barrier.  Previous architectural requirements for 
plain SYNC were equivalent to rev. 2.60's SYNC_MB, and to implement a 
completion barrier a dummy load had to follow.

 Some implementers of the old plain SYNC did actually make it a completion 
rather than ordering barrier and people even argued this was an 
architectural requirement, as I recall from discussions in early 2000s.  
On the other hand the implementations affected were UP-only processors 
where about the only use for SYNC was to drain any write buffers of data 
intended for MMIO accesses and such an implementation did conform even if 
it was too heavyweight for architectural requirements.  So I think it was 
a reasonable implementation decision, saving 1-2 instructions where a 
completion barrier was required.  The only downside of this decision was 
some programmers assumed such semantics was universally guaranteed, while 
indeed it was not (before rev. 2.60).

 Overall where backwards compatibility is required it looks to me like we 
need to keep the implementation of any completion barriers (e.g. `iob') as 
a SYNC followed by a dummy load.

  Maciej

linux-mips-no-sync.diff
Index: linux/arch/mips/kernel/traps.c
===================================================================
--- linux.orig/arch/mips/kernel/traps.c
+++ linux/arch/mips/kernel/traps.c
@@ -672,6 +672,7 @@ static int simulate_rdhwr_mm(struct pt_r
 	return -1;
 }
 
+#if 0
 static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
 {
 	if ((opcode & OPCODE) == SPEC0 && (opcode & FUNC) == SYNC) {
@@ -682,6 +683,7 @@ static int simulate_sync(struct pt_regs 
 
 	return -1;			/* Must be something else ... */
 }
+#endif
 
 asmlinkage void do_ov(struct pt_regs *regs)
 {
@@ -1117,8 +1119,10 @@ asmlinkage void do_ri(struct pt_regs *re
 		if (status < 0)
 			status = simulate_rdhwr_normal(regs, opcode);
 
+#if 0
 		if (status < 0)
 			status = simulate_sync(regs, opcode);
+#endif
 
 		if (status < 0)
 			status = simulate_fp(regs, opcode, old_epc, old31);
