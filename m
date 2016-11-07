Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:20:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17074 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992213AbcKGLTf5yiFd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:19:35 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 27C14AD147763;
        Mon,  7 Nov 2016 11:19:27 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:19:28 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 5/7] MIPS: memcpy: Use ta* instead of manually defining t4-t7
Date:   Mon, 7 Nov 2016 11:18:00 +0000
Message-ID: <20161107111802.12071-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111802.12071-1-paul.burton@imgtec.com>
References: <20161107111802.12071-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Manually defining registers t4-t7 to match the o32 ABI in 64 bit kernels
is at best a dirty hack. Use the generic ta* definitions instead, which
further prepares us for using a standard calling convention.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/cavium-octeon/octeon-memcpy.S | 12 ++++--------
 arch/mips/lib/memcpy.S                  | 26 +++++++++++---------------
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 6f312a2..db49fca 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -112,10 +112,6 @@
 #define t1	$9
 #define t2	$10
 #define t3	$11
-#define t4	$12
-#define t5	$13
-#define t6	$14
-#define t7	$15
 
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 #define LDFIRST LOADR
@@ -391,7 +387,7 @@ l_exc:
 	LOAD	t0, TI_TASK($28)
 	LOAD	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
 	SUB	len, AT, t0		# len number of uncopied bytes
-	bnez	t7, 2f		/* Skip the zeroing out part if inatomic */
+	bnez	ta0, 2f		/* Skip the zeroing out part if inatomic */
 	/*
 	 * Here's where we rely on src and dst being incremented in tandem,
 	 *   See (3) above.
@@ -473,16 +469,16 @@ EXPORT_SYMBOL(memcpy)
  */
 LEAF(__copy_user)
 EXPORT_SYMBOL(__copy_user)
-	li	t7, 0				/* not inatomic */
+	li	ta0, 0				/* not inatomic */
 __copy_user_common:
 	__BUILD_COPY_USER COPY_USER_MODE v0
 	END(__copy_user)
 
 /*
- * t7 is used as a flag to note inatomic mode.
+ * ta0 is used as a flag to note inatomic mode.
  */
 LEAF(__copy_user_inatomic)
 EXPORT_SYMBOL(__copy_user_inatomic)
 	b	__copy_user_common
-	 li	t7, 1
+	 li	ta0, 1
 	END(__copy_user_inatomic)
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 052f7a1..48684c4 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -172,10 +172,6 @@
 #define t1	$9
 #define t2	$10
 #define t3	$11
-#define t4	$12
-#define t5	$13
-#define t6	$14
-#define t7	$15
 
 #else
 
@@ -314,8 +310,8 @@
 	LOAD(t2, UNIT(2)(src), .Ll_exc_copy\@)
 	LOAD(t3, UNIT(3)(src), .Ll_exc_copy\@)
 	SUB	len, len, 8*NBYTES
-	LOAD(t4, UNIT(4)(src), .Ll_exc_copy\@)
-	LOAD(t7, UNIT(5)(src), .Ll_exc_copy\@)
+	LOAD(ta0, UNIT(4)(src), .Ll_exc_copy\@)
+	LOAD(ta1, UNIT(5)(src), .Ll_exc_copy\@)
 	STORE(t0, UNIT(0)(dst),	.Ls_exc_p8u\@)
 	STORE(t1, UNIT(1)(dst),	.Ls_exc_p7u\@)
 	LOAD(t0, UNIT(6)(src), .Ll_exc_copy\@)
@@ -324,8 +320,8 @@
 	ADD	dst, dst, 8*NBYTES
 	STORE(t2, UNIT(-6)(dst), .Ls_exc_p6u\@)
 	STORE(t3, UNIT(-5)(dst), .Ls_exc_p5u\@)
-	STORE(t4, UNIT(-4)(dst), .Ls_exc_p4u\@)
-	STORE(t7, UNIT(-3)(dst), .Ls_exc_p3u\@)
+	STORE(ta0, UNIT(-4)(dst), .Ls_exc_p4u\@)
+	STORE(ta1, UNIT(-3)(dst), .Ls_exc_p3u\@)
 	STORE(t0, UNIT(-2)(dst), .Ls_exc_p2u\@)
 	STORE(t1, UNIT(-1)(dst), .Ls_exc_p1u\@)
 	PREFS(	0, 8*32(src) )
@@ -554,7 +550,7 @@
 	LOADK	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
 	 nop
 	SUB	len, AT, t0		# len number of uncopied bytes
-	bnez	t6, .Ldone\@	/* Skip the zeroing part if inatomic */
+	bnez	ta2, .Ldone\@	/* Skip the zeroing part if inatomic */
 	/*
 	 * Here's where we rely on src and dst being incremented in tandem,
 	 *   See (3) above.
@@ -630,7 +626,7 @@ LEAF(memcpy)					/* a0=dst a1=src a2=len */
 EXPORT_SYMBOL(memcpy)
 	move	v0, dst				/* return value */
 .L__memcpy:
-	li	t6, 0	/* not inatomic */
+	li	ta2, 0	/* not inatomic */
 	/* Legacy Mode, user <-> user */
 	__BUILD_COPY_USER MEMCPY_MODE USEROP USEROP len
 	END(memcpy)
@@ -648,19 +644,19 @@ EXPORT_SYMBOL(memcpy)
 	.align	5
 LEAF(__copy_user)
 EXPORT_SYMBOL(__copy_user)
-	li	t6, 0	/* not inatomic */
+	li	ta2, 0	/* not inatomic */
 __copy_user_common:
 	/* Legacy Mode, user <-> user */
 	__BUILD_COPY_USER LEGACY_MODE USEROP USEROP v0
 	END(__copy_user)
 
 /*
- * t6 is used as a flag to note inatomic mode.
+ * ta2 is used as a flag to note inatomic mode.
  */
 LEAF(__copy_user_inatomic)
 EXPORT_SYMBOL(__copy_user_inatomic)
 	b	__copy_user_common
-	li	t6, 1
+	li	ta2, 1
 	END(__copy_user_inatomic)
 
 #ifdef CONFIG_EVA
@@ -675,7 +671,7 @@ EXPORT_SYMBOL(__copy_user_inatomic)
 LEAF(__copy_user_inatomic_eva)
 EXPORT_SYMBOL(__copy_user_inatomic_eva)
 	b       __copy_from_user_common
-	li	t6, 1
+	li	ta2, 1
 	END(__copy_user_inatomic_eva)
 
 /*
@@ -684,7 +680,7 @@ EXPORT_SYMBOL(__copy_user_inatomic_eva)
 
 LEAF(__copy_from_user_eva)
 EXPORT_SYMBOL(__copy_from_user_eva)
-	li	t6, 0	/* not inatomic */
+	li	ta2, 0	/* not inatomic */
 __copy_from_user_common:
 	__BUILD_COPY_USER EVA_MODE USEROP KERNELOP v0
 END(__copy_from_user_eva)
-- 
2.10.2
