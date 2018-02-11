Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2018 08:56:31 +0100 (CET)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:58623 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeBKH4Yd0qYs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2018 08:56:24 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 754293F68F;
        Sun, 11 Feb 2018 08:56:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id e-9AMaCYlyUr; Sun, 11 Feb 2018 08:56:15 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 8349F3F685;
        Sun, 11 Feb 2018 08:56:11 +0100 (CET)
Date:   Sun, 11 Feb 2018 08:56:10 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Cc:     linux-mips@linux-mips.org
Subject: [RFC] MIPS: R5900: Workaround exception NOP execution bug (FLX05)
Message-ID: <20180211075608.GC2222@localhost.localdomain>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

For the R5900, there are cases in which the first two instructions
in an exception handler are executed as NOP instructions, when
certain exceptions occur and then a bus error occurs immediately
before jumping to the exception handler (FLX05).

The corrective measure is to place NOP in the first two instruction
locations in all exception handlers.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
This change has been ported from v2.6 patches.

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index c7b64f4a8ad3..4008298c1880 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -32,6 +32,10 @@
 NESTED(except_vec3_generic, 0, sp)
 	.set	push
 	.set	noat
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 #if R5432_CP0_INTERRUPT_WAR
 #ifdef CONFIG_CPU_R5900
 	sync.p
@@ -62,6 +66,8 @@ NESTED(except_vec3_r4000, 0, sp)
 	.set	arch=r4000
 	.set	noat
 #ifdef CONFIG_CPU_R5900
+	nop
+	nop
 	sync.p
 #endif
 	mfc0	k1, CP0_CAUSE
@@ -174,6 +180,10 @@ LEAF(__r4k_wait)
 	.align	5
 BUILD_ROLLBACK_PROLOGUE handle_int
 NESTED(handle_int, PT_SIZE, sp)
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 	.cfi_signal_frame
 #ifdef CONFIG_TRACE_IRQFLAGS
 	/*
@@ -275,6 +285,10 @@ NESTED(handle_int, PT_SIZE, sp)
  * to fit into space reserved for the exception handler.
  */
 NESTED(except_vec4, 0, sp)
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 1:	j	1b			/* Dummy, will be replaced */
 	END(except_vec4)
 
@@ -285,6 +299,10 @@ NESTED(except_vec4, 0, sp)
  * unconditional jump to this vector.
  */
 NESTED(except_vec_ejtag_debug, 0, sp)
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 	j	ejtag_debug_handler
 #ifdef CONFIG_CPU_MICROMIPS
 	 nop
@@ -300,6 +318,10 @@ NESTED(except_vec_ejtag_debug, 0, sp)
  */
 BUILD_ROLLBACK_PROLOGUE except_vec_vi
 NESTED(except_vec_vi, 0, sp)
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 	SAVE_SOME docfi=1
 	SAVE_AT docfi=1
 	.set	push
@@ -319,6 +341,10 @@ EXPORT(except_vec_vi_end)
  * Complete the register saves and invoke the handler which is passed in $v0
  */
 NESTED(except_vec_vi_handler, 0, sp)
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 	SAVE_TEMP
 	SAVE_STATIC
 	CLI
@@ -378,6 +404,10 @@ NESTED(except_vec_vi_handler, 0, sp)
 NESTED(ejtag_debug_handler, PT_SIZE, sp)
 	.set	push
 	.set	noat
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 	MTC0	k0, CP0_DESAVE
 #ifdef CONFIG_CPU_R5900
 	sync.p
@@ -424,6 +454,10 @@ EXPORT(ejtag_debug_buffer)
  * unconditional jump to this vector.
  */
 NESTED(except_vec_nmi, 0, sp)
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 	j	nmi_handler
 #ifdef CONFIG_CPU_MICROMIPS
 	 nop
@@ -436,6 +470,10 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.cfi_signal_frame
 	.set	push
 	.set	noat
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 	/*
 	 * Clear ERL - restore segment mapping
 	 * Clear BEV - required for page fault exception handler to work
@@ -521,6 +559,10 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	NESTED(handle_\exception, PT_SIZE, sp)
 	.cfi_signal_frame
 	.set	noat
+#ifdef CONFIG_CPU_R5900
+	nop
+	nop
+#endif
 	SAVE_ALL
 	FEXPORT(handle_\exception\ext)
 	__build_clear_\clear
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index 89b425646647..e56f988b5c20 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -30,6 +30,18 @@ NESTED(handle_sys, PT_SIZE, sp)
 	.set	noat
 #ifdef CONFIG_CPU_R5900
 	/*
+	 * For the R5900, there are cases in which the first two instructions
+	 * in an exception handler are executed as NOP instructions, when
+	 * certain exceptions occur and then a bus error occurs immediately
+	 * before jumping to the exception handler (FLX05).
+	 *
+	 * The corrective measure is to place NOP in the first two instruction
+	 * locations in all exception handlers.
+	 */
+	nop
+	nop
+
+	/*
 	 * We don't want to stumble over broken sign extensions from
 	 * userland. O32 does never use the upper half, but since the
 	 * R5900 does not implement CP0.Status.UX it cannot enforce it.
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a18b013fd887..fc7ec8f9eed8 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1308,6 +1308,11 @@ static void build_r4000_tlb_refill_handler(void)
 	memset(relocs, 0, sizeof(relocs));
 	memset(final_handler, 0, sizeof(final_handler));
 
+#ifdef CONFIG_CPU_R5900
+	uasm_i_nop(&p);
+	uasm_i_nop(&p);
+#endif
+
 	if (IS_ENABLED(CONFIG_64BIT) && (scratch_reg >= 0 || scratchpad_available()) && use_bbit_insns()) {
 		htlb_info = build_fast_tlb_refill_handler(&p, &l, &r, K0, K1,
 							  scratch_reg);
@@ -2049,6 +2054,11 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
 {
 	struct work_registers wr = build_get_work_registers(p);
 
+#ifdef CONFIG_CPU_R5900
+	uasm_i_nop(p);
+	uasm_i_nop(p);
+#endif
+
 #ifdef CONFIG_64BIT
 	build_get_pmde64(p, l, r, wr.r1, wr.r2); /* get pmd in ptr */
 #else
