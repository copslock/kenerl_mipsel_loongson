Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2007 15:38:54 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:16882 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021820AbXKFPio (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2007 15:38:44 +0000
Received: from localhost (p4065-ipad306funabasi.chiba.ocn.ne.jp [123.217.174.65])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CC6BE9687; Wed,  7 Nov 2007 00:37:21 +0900 (JST)
Date:	Wed, 07 Nov 2007 00:39:25 +0900 (JST)
Message-Id: <20071107.003925.74752709.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: WAIT vs. tickless kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071103.014649.122254137.anemo@mba.ocn.ne.jp>
References: <20071101.013124.108121433.anemo@mba.ocn.ne.jp>
	<20071031163900.GB22871@linux-mips.org>
	<20071103.014649.122254137.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 03 Nov 2007 01:46:49 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > The tickless kernel is very interesting for the low power fraction.  And
> > it's especially those users who would suffer most the loss of the ability
> > to use the WAIT instruction.  For a system running from two AAA cells the
> > tradeoff is clear ...  So I think it's become a must.
> 
> Then, something like this?  Selecting in build-time is not so good,
> but there are some CPUs which do not need this hack at all.
> Synthesizing the ret_from_irq() at runtime might satisfy everyone?

Revised.  

As Ralf said on IRC, the adjustment can be done at beginning of
handler, instead of ret_from_irq.  So we can enable this hack at
runtime.  I introduced BUILD_ROLLBACK_PROLOGUE macro to build prologue
code for handle_int and except_vec_vi.  I'm not sure except_vec4 needs
the prologue or not.

And if the EPC was just after WAIT (i.e. normal wakeup from WAIT) the
rollback is not needed.  So I arranged r4k_wait so that the rollback
region exactly fit to 32 byte.

How about this?

------------------------------------------------------------------------
Subject: Fix potential latency problem due to non-atomic cpu_wait.

If an interrupt happened between checking of NEED_RESCHED and WAIT
instruction, adjust EPC to restart from checking of NEED_RESCHED.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/cpu-probe.c |   16 ++--------------
 arch/mips/kernel/genex.S     |   38 ++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c     |   22 ++++++++++++++++------
 3 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c8c47a2..c745b91 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -45,18 +45,7 @@ static void r39xx_wait(void)
 	local_irq_enable();
 }
 
-/*
- * There is a race when WAIT instruction executed with interrupt
- * enabled.
- * But it is implementation-dependent wheter the pipelie restarts when
- * a non-enabled interrupt is requested.
- */
-static void r4k_wait(void)
-{
-	__asm__("	.set	mips3			\n"
-		"	wait				\n"
-		"	.set	mips0			\n");
-}
+extern void r4k_wait(void);
 
 /*
  * This variant is preferable as it allows testing need_resched and going to
@@ -128,7 +117,7 @@ static int __init wait_disable(char *s)
 
 __setup("nowait", wait_disable);
 
-static inline void check_wait(void)
+void __init check_wait(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 
@@ -239,7 +228,6 @@ static inline void check_errata(void)
 
 void __init check_bugs32(void)
 {
-	check_wait();
 	check_errata();
 }
 
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index c0f19d6..bb72c3a 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -20,6 +20,7 @@
 #include <asm/stackframe.h>
 #include <asm/war.h>
 #include <asm/page.h>
+#include <asm/thread_info.h>
 
 #define PANIC_PIC(msg)					\
 		.set push;				\
@@ -126,7 +127,43 @@ handle_vcei:
 
 	__FINIT
 
+	.align	5	/* 32 byte rollback region */
+LEAF(r4k_wait)
+	.set	push
+	.set	noreorder
+	/* start of rollback region */
+	LONG_L	t0, TI_FLAGS($28)
+	nop
+	andi	t0, _TIF_NEED_RESCHED
+	bnez	t0, 1f
+	 nop
+	nop
+	nop
+	.set	mips3
+	wait
+	.set	mips0
+	/* end of rollback region (the region size must be power of two) */
+	.set	pop
+1:
+	jr	ra
+	END(r4k_wait)
+
+	.macro	BUILD_ROLLBACK_PROLOGUE handler
+	FEXPORT(rollback_\handler)
+	.set	push
+	.set	noat
+	MFC0	k0, CP0_EPC
+	ori	k0, 0x1f	/* 32 byte rollback region */
+	xori	k0, 0x1f
+	PTR_LA	k1, r4k_wait
+	bne	k0, k1, 9f
+	MTC0	k0, CP0_EPC
+9:
+	.set pop
+	.endm
+
 	.align  5
+BUILD_ROLLBACK_PROLOGUE handle_int
 NESTED(handle_int, PT_SIZE, sp)
 #ifdef CONFIG_TRACE_IRQFLAGS
 	/*
@@ -201,6 +238,7 @@ NESTED(except_vec_ejtag_debug, 0, sp)
  * This prototype is copied to ebase + n*IntCtl.VS and patched
  * to invoke the handler
  */
+BUILD_ROLLBACK_PROLOGUE except_vec_vi
 NESTED(except_vec_vi, 0, sp)
 	SAVE_SOME
 	SAVE_AT
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index fa50078..0b2cc58 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -43,6 +43,9 @@
 #include <asm/types.h>
 #include <asm/stacktrace.h>
 
+extern void check_wait(void);
+extern asmlinkage void r4k_wait(void);
+extern asmlinkage void rollback_handle_int(void);
 extern asmlinkage void handle_int(void);
 extern asmlinkage void handle_tlbm(void);
 extern asmlinkage void handle_tlbl(void);
@@ -1198,6 +1201,9 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 
 		extern char except_vec_vi, except_vec_vi_lui;
 		extern char except_vec_vi_ori, except_vec_vi_end;
+		extern char rollback_except_vec_vi;
+		char *vec_start = (cpu_wait == r4k_wait) ?
+			&rollback_except_vec_vi : &except_vec_vi;
 #ifdef CONFIG_MIPS_MT_SMTC
 		/*
 		 * We need to provide the SMTC vectored interrupt handler
@@ -1205,11 +1211,11 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 		 * Status.IM bit to be masked before going there.
 		 */
 		extern char except_vec_vi_mori;
-		const int mori_offset = &except_vec_vi_mori - &except_vec_vi;
+		const int mori_offset = &except_vec_vi_mori - vec_start;
 #endif /* CONFIG_MIPS_MT_SMTC */
-		const int handler_len = &except_vec_vi_end - &except_vec_vi;
-		const int lui_offset = &except_vec_vi_lui - &except_vec_vi;
-		const int ori_offset = &except_vec_vi_ori - &except_vec_vi;
+		const int handler_len = &except_vec_vi_end - vec_start;
+		const int lui_offset = &except_vec_vi_lui - vec_start;
+		const int ori_offset = &except_vec_vi_ori - vec_start;
 
 		if (handler_len > VECTORSPACING) {
 			/*
@@ -1219,7 +1225,7 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 			panic("VECTORSPACING too small");
 		}
 
-		memcpy(b, &except_vec_vi, handler_len);
+		memcpy(b, vec_start, handler_len);
 #ifdef CONFIG_MIPS_MT_SMTC
 		BUG_ON(n > 7);	/* Vector index %d exceeds SMTC maximum. */
 
@@ -1497,6 +1503,10 @@ void __init trap_init(void)
 	extern char except_vec3_generic, except_vec3_r4000;
 	extern char except_vec4;
 	unsigned long i;
+	int rollback;
+
+	check_wait();
+	rollback = (cpu_wait == r4k_wait);
 
 	if (cpu_has_veic || cpu_has_vint)
 		ebase = (unsigned long) alloc_bootmem_low_pages(0x200 + VECTORSPACING*64);
@@ -1558,7 +1568,7 @@ void __init trap_init(void)
 	if (board_be_init)
 		board_be_init();
 
-	set_except_vector(0, handle_int);
+	set_except_vector(0, rollback ? rollback_handle_int : handle_int);
 	set_except_vector(1, handle_tlbm);
 	set_except_vector(2, handle_tlbl);
 	set_except_vector(3, handle_tlbs);
