Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 May 2014 07:56:38 +0200 (CEST)
Received: from mail-pb0-f43.google.com ([209.85.160.43]:60323 "EHLO
        mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821443AbaEYF4MX7vis (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 May 2014 07:56:12 +0200
Received: by mail-pb0-f43.google.com with SMTP id up15so6102852pbc.30
        for <linux-mips@linux-mips.org>; Sat, 24 May 2014 22:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=7qbvdgxEfa3huvP+aY5bnEPH+Pg7DSNjY+ONjKJocnw=;
        b=HV5O/aCGCiuIH/RYfIDZdrYuCPNhXFRqEe61l2BdMbqEojlC4xo1A10S1j3hvlldmB
         y3+qUXUDiU4CPnyhFchhlXNqPQtjEIxgl3qGXa0lpGv7HmvuKjC7/Vn5f9aMdIG8UNBo
         dklaL+j2cFoUn79O+xcaXXlzRHapRVs7v4PxB1DWjACRdwtLkppGiuouNd6ck4ySjXLE
         bsZ9WIG3zHWVO2TUbXu9lgRQOHht4ED/qw13nNtItXRXfn2Eti1FkrkmAFhpL1vdoEpe
         ZYsMPLz4Ungp7gp8ALHrQ4O8ByVWZT15bQ0Atlw+DCEIUY5bVQml6Jsr0AvnEB4r702I
         Eg1g==
X-Received: by 10.68.113.68 with SMTP id iw4mr18009805pbb.119.1400997365610;
        Sat, 24 May 2014 22:56:05 -0700 (PDT)
Received: from software.domain.org ([222.92.8.142])
        by mx.google.com with ESMTPSA id fe2sm12013187pbc.68.2014.05.24.22.56.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 May 2014 22:56:04 -0700 (PDT)
From:   chenj <chenj@lemote.com>
To:     linux-mips@linux-mips.org
Cc:     chenhc@lemote.com, chenj <chenj@lemote.com>
Subject: [v4, Resend] MIPS: lib: csum_partial: more instruction paral
Date:   Sun, 25 May 2014 14:02:22 +0800
Message-Id: <1400997742-9393-1-git-send-email-chenj@lemote.com>
X-Mailer: git-send-email 1.9.0
Return-Path: <fykcee1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40266
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

Computing sum introduces true data dependency. This patch removes some
true data depdendencies, hence instruction level parallelism is
improved.

This patch brings at most 50% csum performance gain on Loongson 3a
processor in our test.

One example about how this patch works is in CSUM_BIGCHUNK1:
// ** original **    vs    ** patch applied **
    ADDC(sum, t0)           ADDC(t0, t1)
    ADDC(sum, t1)           ADDC(t2, t3)
    ADDC(sum, t2)           ADDC(sum, t0)
    ADDC(sum, t3)           ADDC(sum, t2)

In the original implementation, each ADDC(sum, ...) references the sum
value updated by previous ADDC.

With patch applied, the first two ADDC operations are independent,
hence can be executed simultaneously if possible.

Another example is in the "copy and sum calculating chunk":
// ** original **    vs    ** patch applied **
    STORE(t0, UNIT(0) ...   STORE(t0, UNIT(0) ...
    ADDC(sum, t0)           ADDC(t0, t1)
    STORE(t1, UNIT(1) ...   STORE(t1, UNIT(1) ...
    ADDC(sum, t1)           ADDC(sum, t0)
    STORE(t2, UNIT(2) ...   STORE(t2, UNIT(2) ...
    ADDC(sum, t2)           ADDC(t2, t3)
    STORE(t3, UNIT(3) ...   STORE(t3, UNIT(3) ...
    ADDC(sum, t3)           ADDC(sum, t2)

With patch applied, the first and third ADDC are independent.

Signed-off-by: chenj <chenj@lemote.com>
---
1. The result can be found at
http://dev.lemote.com/files/upload/software/csum-opti/csum-opti-benchmark.html
And is generated by a userspace test program:
http://dev.lemote.com/files/upload/software/csum-opti/csum-test.tar.gz

[v2: amend commit message]
[v3: further amend commit message]
[v4: amend commit message & sign-off my patch]

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
