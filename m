Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 18:58:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24299 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992328AbcHSQ6NUZlLr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 18:58:13 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0018BF78D4E88;
        Fri, 19 Aug 2016 17:57:51 +0100 (IST)
Received: from localhost (10.100.200.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 19 Aug
 2016 17:57:55 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: CM: Fix mips_cm_max_vp_width for non-MT kernels on MT systems
Date:   Fri, 19 Aug 2016 17:57:15 +0100
Message-ID: <20160819165715.26650-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54688
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

When discovering the number of VPEs per core, smp_num_siblings will be
incorrect for kernels built without support for the MIPS MultiThreading
(MT) ASE running on systems which implement said ASE. This leads to
accesses to VPEs in secondary cores being performed incorrectly since
mips_cm_vp_id calculates the wrong ID to write to the local "other"
registers. Fix this by examining the number of VPEs in the core as
reported by the CM.

This patch presumes that the number of VPEs will be the same in each
core of the system. As this path only applies to systems with CM version
2.5 or lower, and this property is true of all such known systems, this
is likely to be fine but is described in a comment for good measure.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Ralf: This fixes interrupt routing for non-MT kernels running on MT
      systems, where without it they tend to suffer from both lost &
      spurious interrupts. It would be great to get in for v4.8.
---
 arch/mips/include/asm/mips-cm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 9411a4c..810091a 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -458,10 +458,21 @@ static inline int mips_cm_revision(void)
 static inline unsigned int mips_cm_max_vp_width(void)
 {
 	extern int smp_num_siblings;
+	uint32_t cfg;
 
 	if (mips_cm_revision() >= CM_REV_CM3)
 		return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW_MSK;
 
+	if (mips_cm_present()) {
+		/*
+		 * We presume that all cores in the system will have the same
+		 * number of VP(E)s, and if that ever changes then this will
+		 * need revisiting.
+		 */
+		cfg = read_gcr_cl_config() & CM_GCR_Cx_CONFIG_PVPE_MSK;
+		return (cfg >> CM_GCR_Cx_CONFIG_PVPE_SHF) + 1;
+	}
+
 	if (config_enabled(CONFIG_SMP))
 		return smp_num_siblings;
 
-- 
2.9.3
