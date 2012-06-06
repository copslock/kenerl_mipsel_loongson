Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 23:50:34 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:56016 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903712Ab2FFVu2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 23:50:28 +0200
Received: by dadm1 with SMTP id m1so10111154dad.36
        for <multiple recipients>; Wed, 06 Jun 2012 14:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wCTwCHyCXV0QncUkmP1/ohK9HAxV7rNc81EjmPAOxYA=;
        b=CpRtpx+e1n+oapskvNtfNT9GaYxzgkDXIMMB7aSrtmdGFGSaU8TAMAc7FPjCmVG78C
         5a85QwH/KWcCkYb4eJdrD0InK2sN7nYUhloCZEnXagMKIJQl5V8ZyaEr013CK0aGQ8s2
         U1rc+XAsFtcSIGZa049Kngg0V0exJLDzb84iFtgX5xYBedIqFvPnsUFEKoNGkWdXYwoa
         s6JVIn1j/zXnQTXw4FaKwEOSL7M3RSjFhXwqeDzjewN6MvH6XKa2Qh2Qwchz9N8F2VSD
         +ZffvdPiF0zhOWi4M3VnKiuBKshs1OKNGMXqZ3xdtw8aEwftIIA7S30sbdHdrScB5ooR
         yUVg==
Received: by 10.68.197.198 with SMTP id iw6mr1420488pbc.36.1339019421830;
        Wed, 06 Jun 2012 14:50:21 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id vc6sm1665715pbc.6.2012.06.06.14.50.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 14:50:20 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q56LoJ1i010778;
        Wed, 6 Jun 2012 14:50:19 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q56LoInq010777;
        Wed, 6 Jun 2012 14:50:18 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Implement Octeon specific __copy_user_inatomic
Date:   Wed,  6 Jun 2012 14:50:17 -0700
Message-Id: <1339019417-10745-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
X-archive-position: 33576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <ddaney@caviumnetworks.com>

The generic version seems to prefetch past the end of memory.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-memcpy.S |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 88e0cdd..d55bd6a 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -164,6 +164,14 @@
 	.set	noat
 
 /*
+ * t7 is used as a flag to note inatomic mode.
+ */
+LEAF(__copy_user_inatomic)
+	b	__copy_user_common
+	 li	t7, 1
+	END(__copy_user_inatomic)
+
+/*
  * A combined memcpy/__copy_user
  * __copy_user sets len to 0 for success; else to an upper bound of
  * the number of uncopied bytes.
@@ -174,6 +182,8 @@ LEAF(memcpy)					/* a0=dst a1=src a2=len */
 	move	v0, dst				/* return value */
 __memcpy:
 FEXPORT(__copy_user)
+	li	t7, 0				/* not inatomic */
+__copy_user_common:
 	/*
 	 * Note: dst & src may be unaligned, len may be 0
 	 * Temps
@@ -412,7 +422,6 @@ l_exc_copy:
 	 * Assumes src < THREAD_BUADDR($28)
 	 */
 	LOAD	t0, TI_TASK($28)
-	 nop
 	LOAD	t0, THREAD_BUADDR(t0)
 1:
 EXC(	lb	t1, 0(src),	l_exc)
@@ -422,10 +431,9 @@ EXC(	lb	t1, 0(src),	l_exc)
 	 ADD	dst, dst, 1
 l_exc:
 	LOAD	t0, TI_TASK($28)
-	 nop
 	LOAD	t0, THREAD_BUADDR(t0)	# t0 is just past last good address
-	 nop
 	SUB	len, AT, t0		# len number of uncopied bytes
+	bnez	t7, 2f		/* Skip the zeroing out part if inatomic */
 	/*
 	 * Here's where we rely on src and dst being incremented in tandem,
 	 *   See (3) above.
@@ -443,7 +451,7 @@ l_exc:
 	ADD	dst, dst, 1
 	bnez	src, 1b
 	 SUB	src, src, 1
-	jr	ra
+2:	jr	ra
 	 nop
 
 
-- 
1.7.2.3
