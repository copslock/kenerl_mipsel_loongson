Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 15:59:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:50892 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133487AbWGGO7X (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2006 15:59:23 +0100
Received: from localhost (p1163-ipad206funabasi.chiba.ocn.ne.jp [222.146.104.163])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6E794951A; Fri,  7 Jul 2006 23:59:16 +0900 (JST)
Date:	Sat, 08 Jul 2006 00:00:32 +0900 (JST)
Message-Id: <20060708.000032.88471510.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 11933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Adding special short path for emulationg RDHWR which is used to
support TLS.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index b563811..545bcb1 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -357,7 +357,7 @@ #endif
 	BUILD_HANDLER ibe be cli silent			/* #6  */
 	BUILD_HANDLER dbe be cli silent			/* #7  */
 	BUILD_HANDLER bp bp sti silent			/* #9  */
-	BUILD_HANDLER ri ri sti silent			/* #10 */
+	BUILD_HANDLER ri_slow ri sti silent		/* #10 */
 	BUILD_HANDLER cpu cpu sti silent		/* #11 */
 	BUILD_HANDLER ov ov sti silent			/* #12 */
 	BUILD_HANDLER tr tr sti silent			/* #13 */
@@ -369,6 +369,39 @@ #endif
 	BUILD_HANDLER dsp dsp sti silent		/* #26 */
 	BUILD_HANDLER reserved reserved sti verbose	/* others */
 
+	.align	5
+	LEAF(handle_ri)
+	.set	push
+	.set	noat
+	mfc0	k0, CP0_CAUSE
+	MFC0	k1, CP0_EPC
+	bltz	k0, handle_ri_slow	/* if delay slot */
+	lw	k0, (k1)
+	li	k1, 0x7c03e83b	/* rdhwr v1,$29 */
+	bne	k0, k1, handle_ri_slow	/* if not ours */
+	get_saved_sp	/* k1 := current_thread_info */
+	MFC0	k0, CP0_EPC
+	LONG_ADDIU	k0, 4
+	.set	noreorder
+#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
+	ori	k1, _THREAD_MASK
+	xori	k1, _THREAD_MASK
+	LONG_L	v1, TI_TP_VALUE(k1)
+	jr	k0
+	 rfe
+#else
+	/* I hope three instructions between MTC0 and ERET are enough... */
+	MTC0	k0, CP0_EPC
+	ori	k1, _THREAD_MASK
+	xori	k1, _THREAD_MASK
+	LONG_L	v1, TI_TP_VALUE(k1)
+	.set	mips3
+	eret
+	.set	mips0
+#endif
+	.set	pop
+	END(handle_ri)
+
 #ifdef CONFIG_64BIT
 /* A temporary overflow handler used by check_daddi(). */
 
