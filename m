Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jan 2015 16:45:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55693 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010520AbbAEPpueyS8W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jan 2015 16:45:50 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 320C5AA7C3FBA;
        Mon,  5 Jan 2015 15:45:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 5 Jan 2015 15:45:44 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.101) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 5 Jan 2015 15:45:43 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: mips-cm: Fix sparse warnings
Date:   Mon, 5 Jan 2015 15:45:30 +0000
Message-ID: <1420472730-23629-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Sparse emits a bunch of warnings in mips-cm.h due to casting away of
__iomem by the addr_gcr_*() functions:

arch/mips/include/asm/mips-cm.h:134:1: warning: cast removes address space of expression

And subsequent passing of the return values to __raw_readl() and
__raw_writel() in the read_gcr_*() and write_gcr_*() functions:

arch/mips/include/asm/mips-cm.h:134:1: warning: incorrect type in argument 2 (different address spaces)
arch/mips/include/asm/mips-cm.h:134:1:    expected void volatile [noderef] <asn:2>*mem
arch/mips/include/asm/mips-cm.h:134:1:    got unsigned int [usertype] *
arch/mips/include/asm/mips-cm.h:134:1: warning: incorrect type in argument 1 (different address spaces)
arch/mips/include/asm/mips-cm.h:134:1:    expected void const volatile [noderef] <asn:2>*mem
arch/mips/include/asm/mips-cm.h:134:1:    got unsigned int [usertype] *

Fix by adding __iomem to the addr_gcr_*() return type and cast.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mips-cm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index b95a827d763e..59c0901bdd84 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -89,9 +89,9 @@ static inline bool mips_cm_has_l2sync(void)
 
 /* Macros to ease the creation of register access functions */
 #define BUILD_CM_R_(name, off)					\
-static inline u32 *addr_gcr_##name(void)			\
+static inline u32 __iomem *addr_gcr_##name(void)		\
 {								\
-	return (u32 *)(mips_cm_base + (off));			\
+	return (u32 __iomem *)(mips_cm_base + (off));		\
 }								\
 								\
 static inline u32 read_gcr_##name(void)				\
-- 
2.0.5
