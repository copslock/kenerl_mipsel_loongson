Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 16:04:41 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35293 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037600AbWLGQEg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2006 16:04:36 +0000
Received: from localhost (p8245-ipad29funabasi.chiba.ocn.ne.jp [221.184.75.245])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 903F8B89A; Fri,  8 Dec 2006 01:04:31 +0900 (JST)
Date:	Fri, 08 Dec 2006 01:04:31 +0900 (JST)
Message-Id: <20061208.010431.05600019.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 1/3] Make csum_partial more readable
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
X-archive-position: 13404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Use standard o32 register name instead of T0, T1, etc, like memcpy.S.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 15611d9..3bffdbb 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -12,19 +12,23 @@ #include <asm/asm.h>
 #include <asm/regdef.h>
 
 #ifdef CONFIG_64BIT
-#define T0	ta0
-#define T1	ta1
-#define T2	ta2
-#define T3	ta3
-#define T4	t0
-#define T7	t3
-#else
-#define T0	t0
-#define T1	t1
-#define T2	t2
-#define T3	t3
-#define T4	t4
-#define T7	t7
+/*
+ * As we are sharing code base with the mips32 tree (which use the o32 ABI
+ * register definitions). We need to redefine the register definitions from
+ * the n64 ABI register naming to the o32 ABI register naming.
+ */
+#undef t0
+#undef t1
+#undef t2
+#undef t3
+#define t0	$8
+#define t1	$9
+#define t2	$10
+#define t3	$11
+#define t4	$12
+#define t5	$13
+#define t6	$14
+#define t7	$15
 #endif
 
 #define ADDC(sum,reg)						\
@@ -64,37 +68,37 @@ #define sum v0
 
 /* unknown src alignment and < 8 bytes to go  */
 small_csumcpy:
-	move	a1, T2
+	move	a1, t2
 
-	andi	T0, a1, 4
-	beqz	T0, 1f
-	 andi	T0, a1, 2
+	andi	t0, a1, 4
+	beqz	t0, 1f
+	 andi	t0, a1, 2
 
 	/* Still a full word to go  */
-	ulw	T1, (src)
+	ulw	t1, (src)
 	PTR_ADDIU	src, 4
-	ADDC(sum, T1)
+	ADDC(sum, t1)
 
-1:	move	T1, zero
-	beqz	T0, 1f
-	 andi	T0, a1, 1
+1:	move	t1, zero
+	beqz	t0, 1f
+	 andi	t0, a1, 1
 
 	/* Still a halfword to go  */
-	ulhu	T1, (src)
+	ulhu	t1, (src)
 	PTR_ADDIU	src, 2
 
-1:	beqz	T0, 1f
-	 sll	T1, T1, 16
+1:	beqz	t0, 1f
+	 sll	t1, t1, 16
 
-	lbu	T2, (src)
+	lbu	t2, (src)
 	 nop
 
 #ifdef __MIPSEB__
-	sll	T2, T2, 8
+	sll	t2, t2, 8
 #endif
-	or	T1, T2
+	or	t1, t2
 
-1:	ADDC(sum, T1)
+1:	ADDC(sum, t1)
 
 	/* fold checksum */
 	sll	v1, sum, 16
@@ -104,7 +108,7 @@ #endif
 	addu	sum, v1
 
 	/* odd buffer alignment? */
-	beqz	T7, 1f
+	beqz	t7, 1f
 	 nop
 	sll	v1, sum, 8
 	srl	sum, sum, 8
@@ -122,25 +126,25 @@ #endif
 	.align	5
 LEAF(csum_partial)
 	move	sum, zero
-	move	T7, zero
+	move	t7, zero
 
 	sltiu	t8, a1, 0x8
 	bnez	t8, small_csumcpy		/* < 8 bytes to copy */
-	 move	T2, a1
+	 move	t2, a1
 
 	beqz	a1, out
-	 andi	T7, src, 0x1			/* odd buffer? */
+	 andi	t7, src, 0x1			/* odd buffer? */
 
 hword_align:
-	beqz	T7, word_align
+	beqz	t7, word_align
 	 andi	t8, src, 0x2
 
-	lbu	T0, (src)
+	lbu	t0, (src)
 	LONG_SUBU	a1, a1, 0x1
 #ifdef __MIPSEL__
-	sll	T0, T0, 8
+	sll	t0, t0, 8
 #endif
-	ADDC(sum, T0)
+	ADDC(sum, t0)
 	PTR_ADDU	src, src, 0x1
 	andi	t8, src, 0x2
 
@@ -148,9 +152,9 @@ word_align:
 	beqz	t8, dword_align
 	 sltiu	t8, a1, 56
 
-	lhu	T0, (src)
+	lhu	t0, (src)
 	LONG_SUBU	a1, a1, 0x2
-	ADDC(sum, T0)
+	ADDC(sum, t0)
 	sltiu	t8, a1, 56
 	PTR_ADDU	src, src, 0x2
 
@@ -162,9 +166,9 @@ dword_align:
 	beqz	t8, qword_align
 	 andi	t8, src, 0x8
 
-	lw	T0, 0x00(src)
+	lw	t0, 0x00(src)
 	LONG_SUBU	a1, a1, 0x4
-	ADDC(sum, T0)
+	ADDC(sum, t0)
 	PTR_ADDU	src, src, 0x4
 	andi	t8, src, 0x8
 
@@ -172,11 +176,11 @@ qword_align:
 	beqz	t8, oword_align
 	 andi	t8, src, 0x10
 
-	lw	T0, 0x00(src)
-	lw	T1, 0x04(src)
+	lw	t0, 0x00(src)
+	lw	t1, 0x04(src)
 	LONG_SUBU	a1, a1, 0x8
-	ADDC(sum, T0)
-	ADDC(sum, T1)
+	ADDC(sum, t0)
+	ADDC(sum, t1)
 	PTR_ADDU	src, src, 0x8
 	andi	t8, src, 0x10
 
@@ -184,46 +188,46 @@ oword_align:
 	beqz	t8, begin_movement
 	 LONG_SRL	t8, a1, 0x7
 
-	lw	T3, 0x08(src)
-	lw	T4, 0x0c(src)
-	lw	T0, 0x00(src)
-	lw	T1, 0x04(src)
-	ADDC(sum, T3)
-	ADDC(sum, T4)
-	ADDC(sum, T0)
-	ADDC(sum, T1)
+	lw	t3, 0x08(src)
+	lw	t4, 0x0c(src)
+	lw	t0, 0x00(src)
+	lw	t1, 0x04(src)
+	ADDC(sum, t3)
+	ADDC(sum, t4)
+	ADDC(sum, t0)
+	ADDC(sum, t1)
 	LONG_SUBU	a1, a1, 0x10
 	PTR_ADDU	src, src, 0x10
 	LONG_SRL	t8, a1, 0x7
 
 begin_movement:
 	beqz	t8, 1f
-	 andi	T2, a1, 0x40
+	 andi	t2, a1, 0x40
 
 move_128bytes:
-	CSUM_BIGCHUNK(src, 0x00, sum, T0, T1, T3, T4)
-	CSUM_BIGCHUNK(src, 0x20, sum, T0, T1, T3, T4)
-	CSUM_BIGCHUNK(src, 0x40, sum, T0, T1, T3, T4)
-	CSUM_BIGCHUNK(src, 0x60, sum, T0, T1, T3, T4)
+	CSUM_BIGCHUNK(src, 0x00, sum, t0, t1, t3, t4)
+	CSUM_BIGCHUNK(src, 0x20, sum, t0, t1, t3, t4)
+	CSUM_BIGCHUNK(src, 0x40, sum, t0, t1, t3, t4)
+	CSUM_BIGCHUNK(src, 0x60, sum, t0, t1, t3, t4)
 	LONG_SUBU	t8, t8, 0x01
 	bnez	t8, move_128bytes
 	 PTR_ADDU	src, src, 0x80
 
 1:
-	beqz	T2, 1f
-	 andi	T2, a1, 0x20
+	beqz	t2, 1f
+	 andi	t2, a1, 0x20
 
 move_64bytes:
-	CSUM_BIGCHUNK(src, 0x00, sum, T0, T1, T3, T4)
-	CSUM_BIGCHUNK(src, 0x20, sum, T0, T1, T3, T4)
+	CSUM_BIGCHUNK(src, 0x00, sum, t0, t1, t3, t4)
+	CSUM_BIGCHUNK(src, 0x20, sum, t0, t1, t3, t4)
 	PTR_ADDU	src, src, 0x40
 
 1:
-	beqz	T2, do_end_words
+	beqz	t2, do_end_words
 	 andi	t8, a1, 0x1c
 
 move_32bytes:
-	CSUM_BIGCHUNK(src, 0x00, sum, T0, T1, T3, T4)
+	CSUM_BIGCHUNK(src, 0x00, sum, t0, t1, t3, t4)
 	andi	t8, a1, 0x1c
 	PTR_ADDU	src, src, 0x20
 
@@ -232,22 +236,22 @@ do_end_words:
 	 LONG_SRL	t8, t8, 0x2
 
 end_words:
-	lw	T0, (src)
+	lw	t0, (src)
 	LONG_SUBU	t8, t8, 0x1
-	ADDC(sum, T0)
+	ADDC(sum, t0)
 	bnez	t8, end_words
 	 PTR_ADDU	src, src, 0x4
 
 maybe_end_cruft:
-	andi	T2, a1, 0x3
+	andi	t2, a1, 0x3
 
 small_memcpy:
- j small_csumcpy; move a1, T2		/* XXX ??? */
+ j small_csumcpy; move a1, t2		/* XXX ??? */
 	beqz	t2, out
-	 move	a1, T2
+	 move	a1, t2
 
 end_bytes:
-	lb	T0, (src)
+	lb	t0, (src)
 	LONG_SUBU	a1, a1, 0x1
 	bnez	a2, end_bytes
 	 PTR_ADDU	src, src, 0x1
