Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 06:04:17 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:19073 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037821AbWIKFEO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 11 Sep 2006 06:04:14 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 11 Sep 2006 14:04:13 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 0A09220598;
	Mon, 11 Sep 2006 14:04:04 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id EB12C20595;
	Mon, 11 Sep 2006 14:04:03 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8B543W0097421;
	Mon, 11 Sep 2006 14:04:03 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 11 Sep 2006 14:04:03 +0900 (JST)
Message-Id: <20060911.140403.126141483.nemoto@toshiba-tops.co.jp>
To:	nigel@mips.com
Cc:	ralf@linux-mips.org, dan@debian.org, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <450491FA.3010600@mips.com>
References: <4501AABC.1050009@mips.com>
	<20060909.225641.41198763.anemo@mba.ocn.ne.jp>
	<450491FA.3010600@mips.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 10 Sep 2006 23:30:18 +0100, Nigel Stephens <nigel@mips.com> wrote:
> > 	LEAF(handle_ri_rdhwr_vivt)
...
> >
> > I'm wondering if this could work on CONFIG_MIPS_MT_SMTC case...
> 
> No, that wouldn't be reliable for CONFIG_MIPS_MT_SMTC, but then again 
> the only CPU which currently runs SMTC has VIPT caches

Then this woule be better then "take 2" patch?  This add some overhead
to fast RDHWR emulation path but no overhead to TLB refill path.

The tlb_probe_hazard is not exist in main branch for now but already
exist in queue branch.


Take 3.  Comments (especially from pipeline wizards) are welcome.

Add special short path for emulationg RDHWR which is used to support
TLS.  Add an extra prologue for cpu_has_vtag_icache case.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 37fda3d..55e090e 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -19,6 +19,7 @@ #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
 #include <asm/war.h>
+#include <asm/page.h>
 
 #define PANIC_PIC(msg)					\
 		.set push;				\
@@ -375,6 +376,72 @@ #endif
 	BUILD_HANDLER dsp dsp sti silent		/* #26 */
 	BUILD_HANDLER reserved reserved sti verbose	/* others */
 
+	.align	5
+	LEAF(handle_ri_rdhwr_vivt)
+#ifdef CONFIG_MIPS_MT_SMTC
+	PANIC_PIC("handle_ri_rdhwr_vivt called")
+#else
+	.set	push
+	.set	noat
+	.set	noreorder
+	/* check if TLB contains a entry for EPC */
+	MFC0	k1, CP0_ENTRYHI
+	andi	k1, 0xff	/* ASID_MASK */
+	MFC0	k0, CP0_EPC
+	PTR_SRL	k0, PAGE_SHIFT + 1
+	PTR_SLL	k0, PAGE_SHIFT + 1
+	or	k1, k0
+	MTC0	k1, CP0_ENTRYHI
+	mtc0_tlbw_hazard
+	tlbp
+#ifdef CONFIG_CPU_MIPSR2
+	_ehb			/* tlb_probe_hazard */
+#else
+	nop; nop; nop; nop; nop; nop	/* tlb_probe_hazard */
+#endif
+	mfc0	k1, CP0_INDEX
+	.set	pop
+	bltz	k1, handle_ri	/* slow path */
+	/* fall thru */
+#endif
+	END(handle_ri_rdhwr_vivt)
+
+	LEAF(handle_ri_rdhwr)
+	.set	push
+	.set	noat
+	.set	noreorder
+	/* 0x7c03e83b: rdhwr v1,$29 */
+	MFC0	k1, CP0_EPC
+	lui	k0, 0x7c03
+	lw	k1, (k1)
+	ori	k0, 0xe83b
+	.set	reorder
+	bne	k0, k1, handle_ri	/* if not ours */
+	/* The insn is rdhwr.  No need to check CAUSE.BD here. */
+	get_saved_sp	/* k1 := current_thread_info */
+	.set	noreorder
+	MFC0	k0, CP0_EPC
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+	ori	k1, _THREAD_MASK
+	xori	k1, _THREAD_MASK
+	LONG_L	v1, TI_TP_VALUE(k1)
+	LONG_ADDIU	k0, 4
+	jr	k0
+	 rfe
+#else
+	LONG_ADDIU	k0, 4		/* stall on $k0 */
+	MTC0	k0, CP0_EPC
+	/* I hope three instructions between MTC0 and ERET are enough... */
+	ori	k1, _THREAD_MASK
+	xori	k1, _THREAD_MASK
+	LONG_L	v1, TI_TP_VALUE(k1)
+	.set	mips3
+	eret
+	.set	mips0
+#endif
+	.set	pop
+	END(handle_ri_rdhwr)
+
 #ifdef CONFIG_64BIT
 /* A temporary overflow handler used by check_daddi(). */
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e51d8fd..7ae454a 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -53,6 +53,8 @@ extern asmlinkage void handle_dbe(void);
 extern asmlinkage void handle_sys(void);
 extern asmlinkage void handle_bp(void);
 extern asmlinkage void handle_ri(void);
+extern asmlinkage void handle_ri_rdhwr_vivt(void);
+extern asmlinkage void handle_ri_rdhwr(void);
 extern asmlinkage void handle_cpu(void);
 extern asmlinkage void handle_ov(void);
 extern asmlinkage void handle_tr(void);
@@ -1453,6 +1455,15 @@ #endif
 	memcpy((void *)(uncached_ebase + offset), addr, size);
 }
 
+int __initdata rdhwr_noopt;
+static int __init set_rdhwr_noopt(char *str)
+{
+	rdhwr_noopt = 1;
+	return 1;
+}
+
+__setup("rdhwr_noopt", set_rdhwr_noopt);
+
 void __init trap_init(void)
 {
 	extern char except_vec3_generic, except_vec3_r4000;
@@ -1532,7 +1543,9 @@ void __init trap_init(void)
 
 	set_except_vector(8, handle_sys);
 	set_except_vector(9, handle_bp);
-	set_except_vector(10, handle_ri);
+	set_except_vector(10, rdhwr_noopt ? handle_ri :
+			  (cpu_has_vtag_icache ?
+			   handle_ri_rdhwr_vivt : handle_ri_rdhwr));
 	set_except_vector(11, handle_cpu);
 	set_except_vector(12, handle_ov);
 	set_except_vector(13, handle_tr);
