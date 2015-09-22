Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:29:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52563 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009093AbbIVS3urptCP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:29:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 35ED4C2FB8FCA;
        Tue, 22 Sep 2015 19:29:41 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:29:44 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:29:43 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/3] MIPS: CM: provide a function to map from CPU to VP ID
Date:   Tue, 22 Sep 2015 11:29:09 -0700
Message-ID: <1442946551-27893-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442946551-27893-1-git-send-email-paul.burton@imgtec.com>
References: <1442946551-27893-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49314
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

The VP ID of a given CPU may not match up with the CPU number used by
Linux. For example, if the width of the VP part of the VP ID is wider
than log2(number of VPs per core) and the system has multiple cores then
this will be the case. Alternatively, if a pre-r6 system implements the
MT ASE with multiple VPEs per core and Linux is built without support
for the MT ASE then the numbers won't match up either. Provide a
function to convert from CPU number to VP ID.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/mips-cm.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index d75b75e..1f1927a 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -194,6 +194,7 @@ BUILD_CM_RW(reg3_mask,		MIPS_CM_GCB_OFS + 0xc8)
 BUILD_CM_R_(gic_status,		MIPS_CM_GCB_OFS + 0xd0)
 BUILD_CM_R_(cpc_status,		MIPS_CM_GCB_OFS + 0xf0)
 BUILD_CM_RW(l2_config,		MIPS_CM_GCB_OFS + 0x130)
+BUILD_CM_RW(sys_config2,	MIPS_CM_GCB_OFS + 0x150)
 
 /* Core Local & Core Other register accessor functions */
 BUILD_CM_Cx_RW(reset_release,	0x00)
@@ -316,6 +317,10 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 #define CM_GCR_L2_CONFIG_ASSOC_SHF		0
 #define CM_GCR_L2_CONFIG_ASSOC_MSK		(_ULCAST_(0xff) << 0)
 
+/* GCR_SYS_CONFIG2 register fields */
+#define CM_GCR_SYS_CONFIG2_MAXVPW_SHF		0
+#define CM_GCR_SYS_CONFIG2_MAXVPW_MSK		(_ULCAST_(0xf) << 0)
+
 /* GCR_Cx_COHERENCE register fields */
 #define CM_GCR_Cx_COHERENCE_COHDOMAINEN_SHF	0
 #define CM_GCR_Cx_COHERENCE_COHDOMAINEN_MSK	(_ULCAST_(0xff) << 0)
@@ -405,4 +410,38 @@ static inline int mips_cm_revision(void)
 	return read_gcr_rev();
 }
 
+/**
+ * mips_cm_max_vp_width() - return the width in bits of VP indices
+ *
+ * Return: the width, in bits, of VP indices in fields that combine core & VP
+ * indices.
+ */
+static inline unsigned int mips_cm_max_vp_width(void)
+{
+	extern int smp_num_siblings;
+
+	if (mips_cm_revision() >= CM_REV_CM3)
+		return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW_MSK;
+
+	return smp_num_siblings;
+}
+
+/**
+ * mips_cm_vp_id() - calculate the hardware VP ID for a CPU
+ * @cpu: the CPU whose VP ID to calculate
+ *
+ * Hardware such as the GIC uses identifiers for VPs which may not match the
+ * CPU numbers used by Linux. This function calculates the hardware VP
+ * identifier corresponding to a given CPU.
+ *
+ * Return: the VP ID for the CPU.
+ */
+static inline unsigned int mips_cm_vp_id(unsigned int cpu)
+{
+	unsigned int core = cpu_data[cpu].core;
+	unsigned int vp = cpu_vpe_id(&cpu_data[cpu]);
+
+	return (core * mips_cm_max_vp_width()) + vp;
+}
+
 #endif /* __MIPS_ASM_MIPS_CM_H__ */
-- 
2.5.3
