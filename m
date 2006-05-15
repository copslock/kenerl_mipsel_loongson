Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 19:27:46 +0200 (CEST)
Received: from bender.bawue.de ([193.7.176.20]:4778 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133718AbWEOR1h (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2006 19:27:37 +0200
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id B28D644D07; Mon, 15 May 2006 19:27:36 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1FfgqV-0002x8-2R; Mon, 15 May 2006 18:27:03 +0100
Date:	Mon, 15 May 2006 18:27:03 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Update/Fix instruction definitions
Message-ID: <20060515172703.GE9026@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

A small bugfix for up to now unused instruction definitions, and a
somewhat larger update to cover MIPS32R2 instructions.


Signed-off-by:  Thiemo Seufer <ths@networkno.de>


diff -urpN linux-orig/include/asm-mips/inst.h linux-work/include/asm-mips/inst.h
--- linux-orig/include/asm-mips/inst.h	2006-04-24 12:02:35.000000000 +0100
+++ linux-work/include/asm-mips/inst.h	2006-05-15 03:06:31.000000000 +0100
@@ -6,6 +6,7 @@
  * for more details.
  *
  * Copyright (C) 1996, 2000 by Ralf Baechle
+ * Copyright (C) 2006 by Thiemo Seufer
  */
 #ifndef _ASM_INST_H
 #define _ASM_INST_H
@@ -21,14 +22,14 @@ enum major_op {
 	cop0_op, cop1_op, cop2_op, cop1x_op,
 	beql_op, bnel_op, blezl_op, bgtzl_op,
 	daddi_op, daddiu_op, ldl_op, ldr_op,
-	major_1c_op, jalx_op, major_1e_op, major_1f_op,
+	spec2_op, jalx_op, mdmx_op, spec3_op,
 	lb_op, lh_op, lwl_op, lw_op,
 	lbu_op, lhu_op, lwr_op, lwu_op,
 	sb_op, sh_op, swl_op, sw_op,
 	sdl_op, sdr_op, swr_op, cache_op,
 	ll_op, lwc1_op, lwc2_op, pref_op,
 	lld_op, ldc1_op, ldc2_op, ld_op,
-	sc_op, swc1_op, swc2_op, rdhwr_op,
+	sc_op, swc1_op, swc2_op, major_3b_op,
 	scd_op, sdc1_op, sdc2_op, sd_op
 };
 
@@ -37,7 +38,7 @@ enum major_op {
  */
 enum spec_op {
 	sll_op, movc_op, srl_op, sra_op,
-	sllv_op, srlv_op, srav_op, spec1_unused_op, /* Opcode 0x07 is unused */
+	sllv_op, pmon_op, srlv_op, srav_op,
 	jr_op, jalr_op, movz_op, movn_op,
 	syscall_op, break_op, spim_op, sync_op,
 	mfhi_op, mthi_op, mflo_op, mtlo_op,
@@ -55,6 +56,28 @@ enum spec_op {
 };
 
 /*
+ * func field of spec2 opcode.
+ */
+enum spec2_op {
+	madd_op, maddu_op, mul_op, spec2_3_unused_op,
+	msub_op, msubu_op, /* more unused ops */
+	clz_op = 0x20, clo_op,
+	dclz_op = 0x24, dclo_op,
+	sdbpp_op = 0x3f
+};
+
+/*
+ * func field of spec3 opcode.
+ */
+enum spec3_op {
+	ext_op, dextm_op, dextu_op, dext_op,
+	ins_op, dinsm_op, dinsu_op, dins_op,
+	bshfl_op = 0x20,
+	dbshfl_op = 0x24,
+	rdhwr_op = 0x3f
+};
+
+/*
  * rt field of bcond opcodes.
  */
 enum rt_op {
@@ -151,8 +174,8 @@ enum cop1x_func {
  * func field for mad opcodes (MIPS IV).
  */
 enum mad_func {
-	madd_op      = 0x08, msub_op      = 0x0a,
-	nmadd_op     = 0x0c, nmsub_op     = 0x0e
+	madd_fp_op      = 0x08, msub_fp_op      = 0x0a,
+	nmadd_fp_op     = 0x0c, nmsub_fp_op     = 0x0e
 };
 
 /*
