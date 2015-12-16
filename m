Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:53:25 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30039 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014078AbbLPXuRfAfq0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:17 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id DC192B519DD9D;
        Wed, 16 Dec 2015 23:50:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:10 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:10 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 11/16] MIPS: Break down cacheops.h definitions
Date:   Wed, 16 Dec 2015 23:49:36 +0000
Message-ID: <1450309781-28030-12-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50658
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

Most of the cache op codes defined in cacheops.h are split into a 2-bit
cache identifier, and a 3-bit cache op code which does largely the same
thing semantically regardless of the cache identifier.

To allow the use of these definitions by KVM for decoding cache ops,
break the definitions down into parts where it makes sense to do so, and
add masks for the Cache and Op field within the cache op.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cacheops.h | 106 +++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 42 deletions(-)

diff --git a/arch/mips/include/asm/cacheops.h b/arch/mips/include/asm/cacheops.h
index 06b9bc7ea14b..c3212ff26723 100644
--- a/arch/mips/include/asm/cacheops.h
+++ b/arch/mips/include/asm/cacheops.h
@@ -12,54 +12,76 @@
 #define __ASM_CACHEOPS_H
 
 /*
+ * Most cache ops are split into a 2 bit field identifying the cache, and a 3
+ * bit field identifying the cache operation.
+ */
+#define CacheOp_Cache			0x03
+#define CacheOp_Op			0x1c
+
+#define Cache_I				0x00
+#define Cache_D				0x01
+#define Cache_T				0x02
+#define Cache_S				0x03
+
+#define Index_Writeback_Inv		0x00
+#define Index_Load_Tag			0x04
+#define Index_Store_Tag			0x08
+#define Hit_Invalidate			0x10
+#define Hit_Writeback_Inv		0x14	/* not with Cache_I though */
+#define Hit_Writeback			0x18
+
+/*
  * Cache Operations available on all MIPS processors with R4000-style caches
  */
-#define Index_Invalidate_I		0x00
-#define Index_Writeback_Inv_D		0x01
-#define Index_Load_Tag_I		0x04
-#define Index_Load_Tag_D		0x05
-#define Index_Store_Tag_I		0x08
-#define Index_Store_Tag_D		0x09
-#define Hit_Invalidate_I		0x10
-#define Hit_Invalidate_D		0x11
-#define Hit_Writeback_Inv_D		0x15
+#define Index_Invalidate_I		(Cache_I | Index_Writeback_Inv)
+#define Index_Writeback_Inv_D		(Cache_D | Index_Writeback_Inv)
+#define Index_Load_Tag_I		(Cache_I | Index_Load_Tag)
+#define Index_Load_Tag_D		(Cache_D | Index_Load_Tag)
+#define Index_Store_Tag_I		(Cache_I | Index_Store_Tag)
+#define Index_Store_Tag_D		(Cache_D | Index_Store_Tag)
+#define Hit_Invalidate_I		(Cache_I | Hit_Invalidate)
+#define Hit_Invalidate_D		(Cache_D | Hit_Invalidate)
+#define Hit_Writeback_Inv_D		(Cache_D | Hit_Writeback_Inv)
 
 /*
  * R4000-specific cacheops
  */
-#define Create_Dirty_Excl_D		0x0d
-#define Fill				0x14
-#define Hit_Writeback_I			0x18
-#define Hit_Writeback_D			0x19
+#define Create_Dirty_Excl_D		(Cache_D | 0x0c)
+#define Fill				(Cache_I | 0x14)
+#define Hit_Writeback_I			(Cache_I | Hit_Writeback)
+#define Hit_Writeback_D			(Cache_D | Hit_Writeback)
 
 /*
  * R4000SC and R4400SC-specific cacheops
  */
-#define Index_Invalidate_SI		0x02
-#define Index_Writeback_Inv_SD		0x03
-#define Index_Load_Tag_SI		0x06
-#define Index_Load_Tag_SD		0x07
-#define Index_Store_Tag_SI		0x0A
-#define Index_Store_Tag_SD		0x0B
-#define Create_Dirty_Excl_SD		0x0f
-#define Hit_Invalidate_SI		0x12
-#define Hit_Invalidate_SD		0x13
-#define Hit_Writeback_Inv_SD		0x17
-#define Hit_Writeback_SD		0x1b
-#define Hit_Set_Virtual_SI		0x1e
-#define Hit_Set_Virtual_SD		0x1f
+#define Cache_SI			0x02
+#define Cache_SD			0x03
+
+#define Index_Invalidate_SI		(Cache_SI | Index_Writeback_Inv)
+#define Index_Writeback_Inv_SD		(Cache_SD | Index_Writeback_Inv)
+#define Index_Load_Tag_SI		(Cache_SI | Index_Load_Tag)
+#define Index_Load_Tag_SD		(Cache_SD | Index_Load_Tag)
+#define Index_Store_Tag_SI		(Cache_SI | Index_Store_Tag)
+#define Index_Store_Tag_SD		(Cache_SD | Index_Store_Tag)
+#define Create_Dirty_Excl_SD		(Cache_SD | 0x0c)
+#define Hit_Invalidate_SI		(Cache_SI | Hit_Invalidate)
+#define Hit_Invalidate_SD		(Cache_SD | Hit_Invalidate)
+#define Hit_Writeback_Inv_SD		(Cache_SD | Hit_Writeback_Inv)
+#define Hit_Writeback_SD		(Cache_SD | Hit_Writeback)
+#define Hit_Set_Virtual_SI		(Cache_SI | 0x1c)
+#define Hit_Set_Virtual_SD		(Cache_SD | 0x1c)
 
 /*
  * R5000-specific cacheops
  */
-#define R5K_Page_Invalidate_S		0x17
+#define R5K_Page_Invalidate_S		(Cache_S | 0x14)
 
 /*
  * RM7000-specific cacheops
  */
-#define Page_Invalidate_T		0x16
-#define Index_Store_Tag_T		0x0a
-#define Index_Load_Tag_T		0x06
+#define Page_Invalidate_T		(Cache_T | 0x14)
+#define Index_Store_Tag_T		(Cache_T | Index_Store_Tag)
+#define Index_Load_Tag_T		(Cache_T | Index_Load_Tag)
 
 /*
  * R10000-specific cacheops
@@ -67,22 +89,22 @@
  * Cacheops 0x02, 0x06, 0x0a, 0x0c-0x0e, 0x16, 0x1a and 0x1e are unused.
  * Most of the _S cacheops are identical to the R4000SC _SD cacheops.
  */
-#define Index_Writeback_Inv_S		0x03
-#define Index_Load_Tag_S		0x07
-#define Index_Store_Tag_S		0x0B
-#define Hit_Invalidate_S		0x13
+#define Index_Writeback_Inv_S		(Cache_S | Index_Writeback_Inv)
+#define Index_Load_Tag_S		(Cache_S | Index_Load_Tag)
+#define Index_Store_Tag_S		(Cache_S | Index_Store_Tag)
+#define Hit_Invalidate_S		(Cache_S | Hit_Invalidate)
 #define Cache_Barrier			0x14
-#define Hit_Writeback_Inv_S		0x17
-#define Index_Load_Data_I		0x18
-#define Index_Load_Data_D		0x19
-#define Index_Load_Data_S		0x1b
-#define Index_Store_Data_I		0x1c
-#define Index_Store_Data_D		0x1d
-#define Index_Store_Data_S		0x1f
+#define Hit_Writeback_Inv_S		(Cache_S | Hit_Writeback_Inv)
+#define Index_Load_Data_I		(Cache_I | 0x18)
+#define Index_Load_Data_D		(Cache_D | 0x18)
+#define Index_Load_Data_S		(Cache_S | 0x18)
+#define Index_Store_Data_I		(Cache_I | 0x1c)
+#define Index_Store_Data_D		(Cache_D | 0x1c)
+#define Index_Store_Data_S		(Cache_S | 0x1c)
 
 /*
  * Loongson2-specific cacheops
  */
-#define Hit_Invalidate_I_Loongson2	0x00
+#define Hit_Invalidate_I_Loongson2	(Cache_I | 0x00)
 
 #endif	/* __ASM_CACHEOPS_H */
-- 
2.4.10
