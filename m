Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2006 15:39:09 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:34514 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133864AbWGJOi5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2006 15:38:57 +0100
Received: from localhost (p8142-ipad212funabasi.chiba.ocn.ne.jp [58.91.172.142])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 19722B49A; Mon, 10 Jul 2006 23:38:52 +0900 (JST)
Date:	Mon, 10 Jul 2006 23:40:10 +0900 (JST)
Message-Id: <20060710.234010.07457279.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, macro@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060709.011259.92587435.anemo@mba.ocn.ne.jp>
References: <20060708.011245.82794581.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0607071715360.25285@blysk.ds.pg.gda.pl>
	<20060709.011259.92587435.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Take 2.  Comments (especially from pipeline wizards) are welcome.

Add special short path for emulationg RDHWR which is used to support
TLS.  The handle_tlbl synthesizer takes a care for
cpu_has_vtag_icache.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 37fda3d..dfceea9 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -375,6 +375,43 @@ #endif
 	BUILD_HANDLER dsp dsp sti silent		/* #26 */
 	BUILD_HANDLER reserved reserved sti verbose	/* others */
 
+	.align	5
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
index 954a198..46eba9f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -52,6 +52,7 @@ extern asmlinkage void handle_dbe(void);
 extern asmlinkage void handle_sys(void);
 extern asmlinkage void handle_bp(void);
 extern asmlinkage void handle_ri(void);
+extern asmlinkage void handle_ri_rdhwr(void);
 extern asmlinkage void handle_cpu(void);
 extern asmlinkage void handle_ov(void);
 extern asmlinkage void handle_tr(void);
@@ -1381,6 +1382,15 @@ #endif
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
@@ -1460,7 +1470,7 @@ void __init trap_init(void)
 
 	set_except_vector(8, handle_sys);
 	set_except_vector(9, handle_bp);
-	set_except_vector(10, handle_ri);
+	set_except_vector(10, rdhwr_noopt ? handle_ri : handle_ri_rdhwr);
 	set_except_vector(11, handle_cpu);
 	set_except_vector(12, handle_ov);
 	set_except_vector(13, handle_tr);
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 375e099..3f53fa7 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -817,9 +817,10 @@ static __init void __attribute__((unused
  * Write random or indexed TLB entry, and care about the hazards from
  * the preceeding mtc0 and for the following eret.
  */
-enum tlb_write_entry { tlb_random, tlb_indexed };
+enum tlb_write_entry { tlb_random, tlb_indexed, tlb_arbitrary };
 
-static __init void build_tlb_write_entry(u32 **p, struct label **l,
+static __init void build_tlb_write_entry(u32 **p, unsigned int tmp,
+					 struct label **l,
 					 struct reloc **r,
 					 enum tlb_write_entry wmode)
 {
@@ -828,6 +829,11 @@ static __init void build_tlb_write_entry
 	switch (wmode) {
 	case tlb_random: tlbw = i_tlbwr; break;
 	case tlb_indexed: tlbw = i_tlbwi; break;
+	case tlb_arbitrary:
+		/* tmp contains CP0_INDEX.  see build_update_entries(). */
+		/* if tmp <= 0, use tlbwr instead of tlbwi */
+		tlbw = i_tlbwr;
+		break;
 	}
 
 	switch (current_cpu_data.cputype) {
@@ -841,6 +847,10 @@ static __init void build_tlb_write_entry
 		 * This branch uses up a mtc0 hazard nop slot and saves
 		 * two nops after the tlbw instruction.
 		 */
+		if (wmode == tlb_arbitrary) {
+			il_bgezl(p, r, tmp, label_tlbw_hazard);
+			i_tlbwi(p);
+		}
 		il_bgezl(p, r, 0, label_tlbw_hazard);
 		tlbw(p);
 		l_tlbw_hazard(l, *p);
@@ -851,8 +861,13 @@ static __init void build_tlb_write_entry
 	case CPU_R4700:
 	case CPU_R5000:
 	case CPU_R5000A:
-		i_nop(p);
+		if (wmode == tlb_arbitrary) {
+			il_bgezl(p, r, tmp, label_tlbw_hazard);
+			i_tlbwi(p);
+		} else
+			i_nop(p);
 		tlbw(p);
+		l_tlbw_hazard(l, *p);
 		i_nop(p);
 		break;
 
@@ -865,8 +880,13 @@ static __init void build_tlb_write_entry
 	case CPU_AU1550:
 	case CPU_AU1200:
 	case CPU_PR4450:
-		i_nop(p);
+		if (wmode == tlb_arbitrary) {
+			il_bgezl(p, r, tmp, label_tlbw_hazard);
+			i_tlbwi(p);
+		} else
+			i_nop(p);
 		tlbw(p);
+		l_tlbw_hazard(l, *p);
 		break;
 
 	case CPU_R10000:
@@ -878,15 +898,24 @@ static __init void build_tlb_write_entry
 	case CPU_4KSC:
 	case CPU_20KC:
 	case CPU_25KF:
+		if (wmode == tlb_arbitrary) {
+			il_bgezl(p, r, tmp, label_tlbw_hazard);
+			i_tlbwi(p);
+		}
 		tlbw(p);
+		l_tlbw_hazard(l, *p);
 		break;
 
 	case CPU_NEVADA:
-		i_nop(p); /* QED specifies 2 nops hazard */
 		/*
 		 * This branch uses up a mtc0 hazard nop slot and saves
 		 * a nop after the tlbw instruction.
 		 */
+		if (wmode == tlb_arbitrary) {
+			il_bgezl(p, r, tmp, label_tlbw_hazard);
+			i_tlbwi(p);
+		} else
+			i_nop(p); /* QED specifies 2 nops hazard */
 		il_bgezl(p, r, 0, label_tlbw_hazard);
 		tlbw(p);
 		l_tlbw_hazard(l, *p);
@@ -896,8 +925,13 @@ static __init void build_tlb_write_entry
 		i_nop(p);
 		i_nop(p);
 		i_nop(p);
-		i_nop(p);
+		if (wmode == tlb_arbitrary) {
+			il_bgezl(p, r, tmp, label_tlbw_hazard);
+			i_tlbwi(p);
+		} else
+			i_nop(p);
 		tlbw(p);
+		l_tlbw_hazard(l, *p);
 		break;
 
 	case CPU_4KEC:
@@ -905,7 +939,12 @@ static __init void build_tlb_write_entry
 	case CPU_34K:
 	case CPU_74K:
 		i_ehb(p);
+		if (wmode == tlb_arbitrary) {
+			il_bgezl(p, r, tmp, label_tlbw_hazard);
+			i_tlbwi(p);
+		}
 		tlbw(p);
+		l_tlbw_hazard(l, *p);
 		break;
 
 	case CPU_RM9000:
@@ -918,8 +957,13 @@ static __init void build_tlb_write_entry
 		i_ssnop(p);
 		i_ssnop(p);
 		i_ssnop(p);
-		i_ssnop(p);
+		if (wmode == tlb_arbitrary) {
+			il_bgezl(p, r, tmp, label_tlbw_hazard);
+			i_tlbwi(p);
+		} else
+			i_ssnop(p);
 		tlbw(p);
+		l_tlbw_hazard(l, *p);
 		i_ssnop(p);
 		i_ssnop(p);
 		i_ssnop(p);
@@ -932,8 +976,13 @@ static __init void build_tlb_write_entry
 	case CPU_VR4181:
 	case CPU_VR4181A:
 		i_nop(p);
-		i_nop(p);
+		if (wmode == tlb_arbitrary) {
+			il_bgezl(p, r, tmp, label_tlbw_hazard);
+			i_tlbwi(p);
+		} else
+			i_nop(p);
 		tlbw(p);
+		l_tlbw_hazard(l, *p);
 		i_nop(p);
 		i_nop(p);
 		break;
@@ -942,8 +991,13 @@ static __init void build_tlb_write_entry
 	case CPU_VR4133:
 	case CPU_R5432:
 		i_nop(p);
-		i_nop(p);
+		if (wmode == tlb_arbitrary) {
+			il_bgezl(p, r, tmp, label_tlbw_hazard);
+			i_tlbwi(p);
+		} else
+			i_nop(p);
 		tlbw(p);
+		l_tlbw_hazard(l, *p);
 		break;
 
 	default:
@@ -1123,7 +1177,7 @@ static __init void build_get_ptep(u32 **
 }
 
 static __init void build_update_entries(u32 **p, unsigned int tmp,
-					unsigned int ptep)
+					unsigned int ptep, int loadindex)
 {
 	/*
 	 * 64bit address support (36bit on a 32bit CPU) in a 32bit
@@ -1136,6 +1190,8 @@ #ifdef CONFIG_64BIT_PHYS_ADDR
 		i_dsrl(p, tmp, tmp, 6); /* convert to entrylo0 */
 		i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
 		i_dsrl(p, ptep, ptep, 6); /* convert to entrylo1 */
+		if (loadindex)
+			i_mfc0(p, tmp, C0_INDEX); /* used by tlb_arbitrary */
 		i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
 	} else {
 		int pte_off_even = sizeof(pte_t) / 2;
@@ -1145,6 +1201,8 @@ #ifdef CONFIG_64BIT_PHYS_ADDR
 		i_lw(p, tmp, pte_off_even, ptep); /* get even pte */
 		i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
 		i_lw(p, ptep, pte_off_odd, ptep); /* get odd pte */
+		if (loadindex)
+			i_mfc0(p, tmp, C0_INDEX); /* used by tlb_arbitrary */
 		i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
 	}
 #else
@@ -1157,8 +1215,8 @@ #else
 		i_mtc0(p, 0, C0_ENTRYLO0);
 	i_mtc0(p, tmp, C0_ENTRYLO0); /* load it */
 	i_SRL(p, ptep, ptep, 6); /* convert to entrylo1 */
-	if (r45k_bvahwbug())
-		i_mfc0(p, tmp, C0_INDEX);
+	if (r45k_bvahwbug() || loadindex)
+		i_mfc0(p, tmp, C0_INDEX); /* used by tlb_arbitrary */
 	if (r4k_250MHZhwbug())
 		i_mtc0(p, 0, C0_ENTRYLO1);
 	i_mtc0(p, ptep, C0_ENTRYLO1); /* load it */
@@ -1198,8 +1256,8 @@ #else
 #endif
 
 	build_get_ptep(&p, K0, K1);
-	build_update_entries(&p, K0, K1);
-	build_tlb_write_entry(&p, &l, &r, tlb_random);
+	build_update_entries(&p, K0, K1, 0);
+	build_tlb_write_entry(&p, K0, &l, &r, tlb_random);
 	l_leave(&l, p);
 	i_eret(&p); /* return from trap */
 
@@ -1647,12 +1705,13 @@ # endif
 static void __init
 build_r4000_tlbchange_handler_tail(u32 **p, struct label **l,
 				   struct reloc **r, unsigned int tmp,
-				   unsigned int ptr)
+				   unsigned int ptr,
+				   enum tlb_write_entry wmode)
 {
 	i_ori(p, ptr, ptr, sizeof(pte_t));
 	i_xori(p, ptr, ptr, sizeof(pte_t));
-	build_update_entries(p, tmp, ptr);
-	build_tlb_write_entry(p, l, r, tlb_indexed);
+	build_update_entries(p, tmp, ptr, wmode == tlb_arbitrary);
+	build_tlb_write_entry(p, tmp, l, r, wmode);
 	l_leave(l, *p);
 	i_eret(p); /* return from trap */
 
@@ -1667,6 +1726,9 @@ static void __init build_r4000_tlb_load_
 	struct label *l = labels;
 	struct reloc *r = relocs;
 	int i;
+ 	extern int rdhwr_noopt;
+ 	enum tlb_write_entry wmode = (!rdhwr_noopt && cpu_has_vtag_icache) ?
+		tlb_arbitrary : tlb_indexed;
 
 	memset(handle_tlbl, 0, sizeof(handle_tlbl));
 	memset(labels, 0, sizeof(labels));
@@ -1684,7 +1746,7 @@ static void __init build_r4000_tlb_load_
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
 	build_pte_present(&p, &l, &r, K0, K1, label_nopage_tlbl);
 	build_make_valid(&p, &r, K0, K1);
-	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1, wmode);
 
 	l_nopage_tlbl(&l, p);
 	i_j(&p, (unsigned long)tlb_do_page_fault_0 & 0x0fffffff);
@@ -1718,7 +1780,7 @@ static void __init build_r4000_tlb_store
 	build_r4000_tlbchange_handler_head(&p, &l, &r, K0, K1);
 	build_pte_writable(&p, &l, &r, K0, K1, label_nopage_tlbs);
 	build_make_write(&p, &r, K0, K1);
-	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1, tlb_indexed);
 
 	l_nopage_tlbs(&l, p);
 	i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
@@ -1753,7 +1815,7 @@ static void __init build_r4000_tlb_modif
 	build_pte_modifiable(&p, &l, &r, K0, K1, label_nopage_tlbm);
 	/* Present and writable bits set, set accessed and dirty bits. */
 	build_make_write(&p, &r, K0, K1);
-	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1);
+	build_r4000_tlbchange_handler_tail(&p, &l, &r, K0, K1, tlb_indexed);
 
 	l_nopage_tlbm(&l, p);
 	i_j(&p, (unsigned long)tlb_do_page_fault_1 & 0x0fffffff);
