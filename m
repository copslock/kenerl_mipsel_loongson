Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:45:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6413 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859946AbaGKPpBc63SY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:45:01 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 118D1170AB9C7
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:44:52 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:44:54 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:44:54 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:44:53 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 01/13] MIPS: allow msa.h to be included in assembly files
Date:   Fri, 11 Jul 2014 16:44:27 +0100
Message-ID: <1405093479-5123-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
References: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.172]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41136
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

Just #ifdef away the C functions when included from an assembly file,
as will be done in a following commit.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/msa.h | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index 538f6d4..e80e85c 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -12,6 +12,8 @@
 
 #include <asm/mipsregs.h>
 
+#ifndef __ASSEMBLY__
+
 extern void _save_msa(struct task_struct *);
 extern void _restore_msa(struct task_struct *);
 
@@ -133,15 +135,6 @@ static inline void write_msa_##name(unsigned int val)		\
 
 #endif /* !TOOLCHAIN_SUPPORTS_MSA */
 
-#define MSA_IR		0
-#define MSA_CSR		1
-#define MSA_ACCESS	2
-#define MSA_SAVE	3
-#define MSA_MODIFY	4
-#define MSA_REQUEST	5
-#define MSA_MAP		6
-#define MSA_UNMAP	7
-
 __BUILD_MSA_CTL_REG(ir, 0)
 __BUILD_MSA_CTL_REG(csr, 1)
 __BUILD_MSA_CTL_REG(access, 2)
@@ -151,6 +144,17 @@ __BUILD_MSA_CTL_REG(request, 5)
 __BUILD_MSA_CTL_REG(map, 6)
 __BUILD_MSA_CTL_REG(unmap, 7)
 
+#endif /* !__ASSEMBLY__ */
+
+#define MSA_IR		0
+#define MSA_CSR		1
+#define MSA_ACCESS	2
+#define MSA_SAVE	3
+#define MSA_MODIFY	4
+#define MSA_REQUEST	5
+#define MSA_MAP		6
+#define MSA_UNMAP	7
+
 /* MSA Implementation Register (MSAIR) */
 #define MSA_IR_REVB		0
 #define MSA_IR_REVF		(_ULCAST_(0xff) << MSA_IR_REVB)
-- 
2.0.1
