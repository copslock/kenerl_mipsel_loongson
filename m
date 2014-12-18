Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:12:38 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21797 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009151AbaLRPLRqQ6-j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:17 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 017891D8F2EAA
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:12 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:11 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 07/67] MIPS: asm: asm: Add new macros to set ISA and arch asm annotations
Date:   Thu, 18 Dec 2014 15:09:16 +0000
Message-ID: <1418915416-3196-8-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44742
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

There are certain places where the code uses .set mips32 or .set mips64
or .set arch=r4000. In preparation of MIPS R6 support, and in order to
use as less #ifdefs as possible, we define new macros to set similar
annotations for MIPS R6

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/asm.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 7c26b28bf252..bb857a87ccd1 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -342,6 +342,19 @@ symbol		=	value
 #define LONGLOG		3
 #endif
 
+#ifdef CONFIG_CPU_MIPSR6
+#define MIPS_ISA_LEVEL_RAW mips64r6
+#define MIPS_ISA_LEVEL "mips64r6"
+#define MIPS_ISA_ARCH_LEVEL_RAW MIPS_ISA_LEVEL_RAW
+#define MIPS_ISA_ARCH_LEVEL MIPS_ISA_LEVEL
+#else
+/* MIPS64 is a superset of MIPS32 */
+#define MIPS_ISA_LEVEL_RAW mips64
+#define MIPS_ISA_LEVEL "mips64"
+#define MIPS_ISA_ARCH_LEVEL_RAW arch=r4000
+#define MIPS_ISA_ARCH_LEVEL "arch=r4000"
+#endif /* CONFIG_CPU_MIPSR6 */
+
 /*
  * How to add/sub/load/store/shift pointers.
  */
-- 
2.2.0
