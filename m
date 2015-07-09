Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 11:43:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26373 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009933AbbGIJlmNOQth (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 11:41:42 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3DCC73358AB4D
        for <linux-mips@linux-mips.org>; Thu,  9 Jul 2015 10:41:33 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Jul 2015 10:41:35 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 9 Jul 2015 10:41:34 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 08/19] MIPS: support CM3 L2 cache
Date:   Thu, 9 Jul 2015 10:40:42 +0100
Message-ID: <1436434853-30001-9-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48145
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

From: Paul Burton <paul.burton@imgtec.com>

Detect the L2 cache configuration from GCR_L2_CONFIG when a CM3 is
present in the system, rather than from Config2 which does not expose
the L2 configuration on I6400.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mm/sc-mips.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 4ceafd13870c..5fa452e8cff9 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -14,6 +14,7 @@
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
 #include <asm/r4kcache.h>
+#include <asm/mips-cm.h>
 
 /*
  * MIPS32/MIPS64 L2 cache handling
@@ -94,6 +95,34 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 	return 1;
 }
 
+static int __init mips_sc_probe_cm3(void)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	unsigned long cfg = read_gcr_l2_config();
+	unsigned long sets, line_sz, assoc;
+
+	if (cfg & CM_GCR_L2_CONFIG_BYPASS_MSK)
+		return 0;
+
+	sets = cfg & CM_GCR_L2_CONFIG_SET_SIZE_MSK;
+	sets >>= CM_GCR_L2_CONFIG_SET_SIZE_SHF;
+	c->scache.sets = 64 << sets;
+
+	line_sz = cfg & CM_GCR_L2_CONFIG_LINE_SIZE_MSK;
+	line_sz >>= CM_GCR_L2_CONFIG_LINE_SIZE_SHF;
+	c->scache.linesz = 2 << line_sz;
+
+	assoc = cfg & CM_GCR_L2_CONFIG_ASSOC_MSK;
+	assoc >>= CM_GCR_L2_CONFIG_ASSOC_SHF;
+	c->scache.ways = assoc + 1;
+	c->scache.waysize = c->scache.sets * c->scache.linesz;
+	c->scache.waybit = __ffs(c->scache.waysize);
+
+	c->scache.flags &= ~MIPS_CACHE_NOT_PRESENT;
+
+	return 1;
+}
+
 static inline int __init mips_sc_probe(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -103,6 +132,9 @@ static inline int __init mips_sc_probe(void)
 	/* Mark as not present until probe completed */
 	c->scache.flags |= MIPS_CACHE_NOT_PRESENT;
 
+	if (mips_cm_revision() >= CM_REV_CM3)
+		return mips_sc_probe_cm3();
+
 	/* Ignore anything but MIPSxx processors */
 	if (!(c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2 |
 			      MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R1 |
-- 
2.4.5
