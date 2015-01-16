Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:02:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8945 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010714AbbAPKxQPVYu0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:16 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 86A21C54D2DE2
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:08 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:10 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:09 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 38/70] MIPS: lib: memcpy: Add MIPS R6 support
Date:   Fri, 16 Jan 2015 10:49:17 +0000
Message-ID: <1421405389-15512-39-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

MIPS R6 does not support the unaligned load and store instructions
so we add a special MIPS R6 case to copy one byte at a time if we
need to read/write to unaligned memory addresses.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/memcpy.S | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 5d3238af9b5c..9245e1705e69 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -293,9 +293,14 @@
 	 and	t0, src, ADDRMASK
 	PREFS(	0, 2*32(src) )
 	PREFD(	1, 2*32(dst) )
+#ifndef CONFIG_CPU_MIPSR6
 	bnez	t1, .Ldst_unaligned\@
 	 nop
 	bnez	t0, .Lsrc_unaligned_dst_aligned\@
+#else
+	or	t0, t0, t1
+	bnez	t0, .Lcopy_unaligned_bytes\@
+#endif
 	/*
 	 * use delay slot for fall-through
 	 * src and dst are aligned; need to compute rem
@@ -376,6 +381,7 @@
 	bne	rem, len, 1b
 	.set	noreorder
 
+#ifndef CONFIG_CPU_MIPSR6
 	/*
 	 * src and dst are aligned, need to copy rem bytes (rem < NBYTES)
 	 * A loop would do only a byte at a time with possible branch
@@ -477,6 +483,7 @@
 	bne	len, rem, 1b
 	.set	noreorder
 
+#endif /* !CONFIG_CPU_MIPSR6 */
 .Lcopy_bytes_checklen\@:
 	beqz	len, .Ldone\@
 	 nop
@@ -504,6 +511,22 @@
 .Ldone\@:
 	jr	ra
 	 nop
+
+#ifdef CONFIG_CPU_MIPSR6
+.Lcopy_unaligned_bytes\@:
+1:
+	COPY_BYTE(0)
+	COPY_BYTE(1)
+	COPY_BYTE(2)
+	COPY_BYTE(3)
+	COPY_BYTE(4)
+	COPY_BYTE(5)
+	COPY_BYTE(6)
+	COPY_BYTE(7)
+	ADD	src, src, 8
+	b	1b
+	 ADD	dst, dst, 8
+#endif /* CONFIG_CPU_MIPSR6 */
 	.if __memcpy == 1
 	END(memcpy)
 	.set __memcpy, 0
-- 
2.2.1
