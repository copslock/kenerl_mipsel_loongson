Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 09:58:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44950 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011234AbaKSI6VNn8C0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 09:58:21 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9705FAEEA52AA
        for <linux-mips@linux-mips.org>; Wed, 19 Nov 2014 08:58:13 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 19 Nov
 2014 08:58:15 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 19 Nov 2014 08:58:15 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.149) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 19 Nov 2014 08:58:14 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: lib: memset: Clean up some MIPS{EL,EB} ifdefery
Date:   Wed, 19 Nov 2014 08:58:10 +0000
Message-ID: <1416387490-18921-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44284
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

The toolchain defines exactly one of __MIPSEB__ and
__MIPSEL__. As a result, simplify the ifdefery a little bit.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/memset.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 7b0e5462ca51..c8fe6b1968fb 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -114,8 +114,7 @@
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(LONG_S_L, a1, (a0), .Lfirst_fixup\@)	/* make word/dword aligned */
-#endif
-#ifdef __MIPSEL__
+#else
 	EX(LONG_S_R, a1, (a0), .Lfirst_fixup\@)	/* make word/dword aligned */
 #endif
 	PTR_SUBU	a0, t0			/* long align ptr */
@@ -164,8 +163,7 @@
 	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(LONG_S_R, a1, -1(a0), .Llast_fixup\@)
-#endif
-#ifdef __MIPSEL__
+#else
 	EX(LONG_S_L, a1, -1(a0), .Llast_fixup\@)
 #endif
 1:	jr		ra
-- 
2.1.3
