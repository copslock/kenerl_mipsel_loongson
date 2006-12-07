Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 16:05:39 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:740 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037653AbWLGQE4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2006 16:04:56 +0000
Received: from localhost (p8245-ipad29funabasi.chiba.ocn.ne.jp [221.184.75.245])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ACE8EB64F; Fri,  8 Dec 2006 01:04:51 +0900 (JST)
Date:	Fri, 08 Dec 2006 01:04:51 +0900 (JST)
Message-Id: <20061208.010451.51865806.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 3/3] Optimize csum_partial for 64bit kernel
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
X-archive-position: 13406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make csum_partial 64-bit powered.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index b04475d..9db3572 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -29,30 +29,49 @@ #define t4	$12
 #define t5	$13
 #define t6	$14
 #define t7	$15
+
+#define USE_DOUBLE
 #endif
 
+#ifdef USE_DOUBLE
+
+#define LOAD   ld
+#define ADD    daddu
+#define NBYTES 8
+
+#else
+
+#define LOAD   lw
+#define ADD    addu
+#define NBYTES 4
+
+#endif /* USE_DOUBLE */
+
+#define UNIT(unit)  ((unit)*NBYTES)
+
 #define ADDC(sum,reg)						\
-	addu	sum, reg;					\
+	ADD	sum, reg;					\
 	sltu	v1, sum, reg;					\
-	addu	sum, v1
+	ADD	sum, v1
 
-#define CSUM_BIGCHUNK(src, offset, sum, _t0, _t1, _t2, _t3)	\
-	lw	_t0, (offset + 0x00)(src);			\
-	lw	_t1, (offset + 0x04)(src);			\
-	lw	_t2, (offset + 0x08)(src); 			\
-	lw	_t3, (offset + 0x0c)(src); 			\
-	ADDC(sum, _t0);						\
-	ADDC(sum, _t1);						\
-	ADDC(sum, _t2);						\
-	ADDC(sum, _t3);						\
-	lw	_t0, (offset + 0x10)(src);			\
-	lw	_t1, (offset + 0x14)(src);			\
-	lw	_t2, (offset + 0x18)(src);			\
-	lw	_t3, (offset + 0x1c)(src);			\
+#define CSUM_BIGCHUNK1(src, offset, sum, _t0, _t1, _t2, _t3)	\
+	LOAD	_t0, (offset + UNIT(0))(src);			\
+	LOAD	_t1, (offset + UNIT(1))(src);			\
+	LOAD	_t2, (offset + UNIT(2))(src); 			\
+	LOAD	_t3, (offset + UNIT(3))(src); 			\
 	ADDC(sum, _t0);						\
 	ADDC(sum, _t1);						\
 	ADDC(sum, _t2);						\
-	ADDC(sum, _t3);						\
+	ADDC(sum, _t3)
+
+#ifdef USE_DOUBLE
+#define CSUM_BIGCHUNK(src, offset, sum, _t0, _t1, _t2, _t3)	\
+	CSUM_BIGCHUNK1(src, offset, sum, _t0, _t1, _t2, _t3)
+#else
+#define CSUM_BIGCHUNK(src, offset, sum, _t0, _t1, _t2, _t3)	\
+	CSUM_BIGCHUNK1(src, offset, sum, _t0, _t1, _t2, _t3);	\
+	CSUM_BIGCHUNK1(src, offset + 0x10, sum, _t0, _t1, _t2, _t3)
+#endif
 
 /*
  * a0: source address
@@ -117,11 +136,17 @@ qword_align:
 	beqz	t8, oword_align
 	 andi	t8, src, 0x10
 
+#ifdef USE_DOUBLE
+	ld	t0, 0x00(src)
+	LONG_SUBU	a1, a1, 0x8
+	ADDC(sum, t0)
+#else
 	lw	t0, 0x00(src)
 	lw	t1, 0x04(src)
 	LONG_SUBU	a1, a1, 0x8
 	ADDC(sum, t0)
 	ADDC(sum, t1)
+#endif
 	PTR_ADDU	src, src, 0x8
 	andi	t8, src, 0x10
 
@@ -129,14 +154,14 @@ oword_align:
 	beqz	t8, begin_movement
 	 LONG_SRL	t8, a1, 0x7
 
-	lw	t3, 0x08(src)
-	lw	t4, 0x0c(src)
-	lw	t0, 0x00(src)
-	lw	t1, 0x04(src)
-	ADDC(sum, t3)
-	ADDC(sum, t4)
+#ifdef USE_DOUBLE
+	ld	t0, 0x00(src)
+	ld	t1, 0x08(src)
 	ADDC(sum, t0)
 	ADDC(sum, t1)
+#else
+	CSUM_BIGCHUNK1(src, 0x00, sum, t0, t1, t3, t4)
+#endif
 	LONG_SUBU	a1, a1, 0x10
 	PTR_ADDU	src, src, 0x10
 	LONG_SRL	t8, a1, 0x7
@@ -219,6 +244,13 @@ #endif
 1:	ADDC(sum, t1)
 
 	/* fold checksum */
+#ifdef USE_DOUBLE
+	dsll32	v1, sum, 0
+	daddu	sum, v1
+	sltu	v1, sum, v1
+	dsra32	sum, sum, 0
+	addu	sum, v1
+#endif
 	sll	v1, sum, 16
 	addu	sum, v1
 	sltu	v1, sum, v1
