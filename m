Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2014 09:03:12 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:53376 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824847AbaEOHDEQOjYB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 May 2014 09:03:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id B58BD2311F
        for <linux-mips@linux-mips.org>; Thu, 15 May 2014 15:02:54 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8-OgGXyYVBE3; Thu, 15 May 2014 15:02:54 +0800 (CST)
Received: from software.domain.org (unknown [222.92.8.142])
        (Authenticated sender: chenj@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id 16ADC22EA5;
        Thu, 15 May 2014 15:02:54 +0800 (CST)
From:   chenj <chenj@lemote.com>
To:     linux-mips@linux-mips.org
Cc:     chenj <chenj@lemote.com>
Subject: [PATCH 1/2] MIPS: lib: csum_partial: more instruction paral
Date:   Thu, 15 May 2014 15:09:02 +0800
Message-Id: <1400137743-8806-1-git-send-email-chenj@lemote.com>
X-Mailer: git-send-email 1.9.0
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

This will bring at most 50% performance gain on loongson3a.
See
http://dev.lemote.com/files/upload/software/csum-opti/csum-opti-benchmark.html

The benchmark is done in userspace through
http://dev.lemote.com/files/upload/software/csum-opti/csum-test.tar.gz
---
 arch/mips/lib/csum_partial.S | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 9901237..6cea101 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -76,10 +76,10 @@
 	LOAD	_t1, (offset + UNIT(1))(src);			\
 	LOAD	_t2, (offset + UNIT(2))(src);			\
 	LOAD	_t3, (offset + UNIT(3))(src);			\
+	ADDC(_t0, _t1);						\
+	ADDC(_t2, _t3);						\
 	ADDC(sum, _t0);						\
-	ADDC(sum, _t1);						\
-	ADDC(sum, _t2);						\
-	ADDC(sum, _t3)
+	ADDC(sum, _t2)
 
 #ifdef USE_DOUBLE
 #define CSUM_BIGCHUNK(src, offset, sum, _t0, _t1, _t2, _t3)	\
@@ -501,21 +501,21 @@ LEAF(csum_partial)
 	SUB	len, len, 8*NBYTES
 	ADD	src, src, 8*NBYTES
 	STORE(t0, UNIT(0)(dst),	.Ls_exc\@)
-	ADDC(sum, t0)
+	ADDC(t0, t1)
 	STORE(t1, UNIT(1)(dst),	.Ls_exc\@)
-	ADDC(sum, t1)
+	ADDC(sum, t0)
 	STORE(t2, UNIT(2)(dst),	.Ls_exc\@)
-	ADDC(sum, t2)
+	ADDC(t2, t3)
 	STORE(t3, UNIT(3)(dst),	.Ls_exc\@)
-	ADDC(sum, t3)
+	ADDC(sum, t2)
 	STORE(t4, UNIT(4)(dst),	.Ls_exc\@)
-	ADDC(sum, t4)
+	ADDC(t4, t5)
 	STORE(t5, UNIT(5)(dst),	.Ls_exc\@)
-	ADDC(sum, t5)
+	ADDC(sum, t4)
 	STORE(t6, UNIT(6)(dst),	.Ls_exc\@)
-	ADDC(sum, t6)
+	ADDC(t6, t7)
 	STORE(t7, UNIT(7)(dst),	.Ls_exc\@)
-	ADDC(sum, t7)
+	ADDC(sum, t6)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 8*NBYTES
 	bgez	len, 1b
@@ -541,13 +541,13 @@ LEAF(csum_partial)
 	SUB	len, len, 4*NBYTES
 	ADD	src, src, 4*NBYTES
 	STORE(t0, UNIT(0)(dst),	.Ls_exc\@)
-	ADDC(sum, t0)
+	ADDC(t0, t1)
 	STORE(t1, UNIT(1)(dst),	.Ls_exc\@)
-	ADDC(sum, t1)
+	ADDC(sum, t0)
 	STORE(t2, UNIT(2)(dst),	.Ls_exc\@)
-	ADDC(sum, t2)
+	ADDC(t2, t3)
 	STORE(t3, UNIT(3)(dst),	.Ls_exc\@)
-	ADDC(sum, t3)
+	ADDC(sum, t2)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
 	beqz	len, .Ldone\@
@@ -646,13 +646,13 @@ LEAF(csum_partial)
 	nop				# improves slotting
 #endif
 	STORE(t0, UNIT(0)(dst),	.Ls_exc\@)
-	ADDC(sum, t0)
+	ADDC(t0, t1)
 	STORE(t1, UNIT(1)(dst),	.Ls_exc\@)
-	ADDC(sum, t1)
+	ADDC(sum, t0)
 	STORE(t2, UNIT(2)(dst),	.Ls_exc\@)
-	ADDC(sum, t2)
+	ADDC(t2, t3)
 	STORE(t3, UNIT(3)(dst),	.Ls_exc\@)
-	ADDC(sum, t3)
+	ADDC(sum, t2)
 	.set	reorder				/* DADDI_WAR */
 	ADD	dst, dst, 4*NBYTES
 	bne	len, rem, 1b
-- 
1.9.0
