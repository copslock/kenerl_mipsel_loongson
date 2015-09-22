Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:15:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1699 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008792AbbIVSO5px9YU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:14:57 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C58809ACF52A6;
        Tue, 22 Sep 2015 19:14:47 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:14:51 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:14:50 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 08/10] MIPS: CM: introduce core-other locking functions
Date:   Tue, 22 Sep 2015 11:12:16 -0700
Message-ID: <1442945538-26141-9-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
References: <1442945538-26141-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49309
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

Introduce mips_cm_lock_other & mips_cm_unlock_other, mirroring the
existing CPC equivalents, in order to lock access from the current core
to another via the core-other GCR region. This hasn't been required in
the past but with CM3 the CPC starts using GCR_CL_OTHER rather than
CPC_CL_OTHER and this will be required for safety.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/mips-cm.h | 32 ++++++++++++++++++++++++++++++++
 arch/mips/kernel/mips-cm.c      | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 2796424..29e6b9d 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -329,6 +329,10 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 /* GCR_Cx_OTHER register fields */
 #define CM_GCR_Cx_OTHER_CORENUM_SHF		16
 #define CM_GCR_Cx_OTHER_CORENUM_MSK		(_ULCAST_(0xffff) << 16)
+#define CM3_GCR_Cx_OTHER_CORE_SHF		8
+#define CM3_GCR_Cx_OTHER_CORE_MSK		(_ULCAST_(0x3f) << 8)
+#define CM3_GCR_Cx_OTHER_VP_SHF			0
+#define CM3_GCR_Cx_OTHER_VP_MSK			(_ULCAST_(0x7) << 0)
 
 /* GCR_Cx_RESET_BASE register fields */
 #define CM_GCR_Cx_RESET_BASE_BEVEXCBASE_SHF	12
@@ -405,4 +409,32 @@ static inline int mips_cm_revision(void)
 	return read_gcr_rev();
 }
 
+#ifdef CONFIG_MIPS_CM
+
+/**
+ * mips_cm_lock_other - lock access to another core
+ * @core: the other core to be accessed
+ * @vp: the VP within the other core to be accessed
+ *
+ * Call before operating upon a core via the 'other' register region in
+ * order to prevent the region being moved during access. Must be followed
+ * by a call to mips_cm_unlock_other.
+ */
+extern void mips_cm_lock_other(unsigned int core, unsigned int vp);
+
+/**
+ * mips_cm_unlock_other - unlock access to another core
+ *
+ * Call after operating upon another core via the 'other' register region.
+ * Must be called after mips_cm_lock_other.
+ */
+extern void mips_cm_unlock_other(void);
+
+#else /* !CONFIG_MIPS_CM */
+
+static inline void mips_cm_lock_other(unsigned int core) { }
+static inline void mips_cm_unlock_other(void) { }
+
+#endif /* !CONFIG_MIPS_CM */
+
 #endif /* __MIPS_ASM_MIPS_CM_H__ */
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index b8ceee5..fef2647 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -9,6 +9,8 @@
  */
 
 #include <linux/errno.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
 
 #include <asm/mips-cm.h>
 #include <asm/mipsregs.h>
@@ -136,6 +138,9 @@ static char *cm3_causes[32] = {
 	"0x19", "0x1a", "0x1b", "0x1c", "0x1d", "0x1e", "0x1f"
 };
 
+static DEFINE_PER_CPU_ALIGNED(spinlock_t, cm_core_lock);
+static DEFINE_PER_CPU_ALIGNED(unsigned long, cm_core_lock_flags);
+
 phys_addr_t __mips_cm_phys_base(void)
 {
 	u32 config3 = read_c0_config3();
@@ -200,6 +205,7 @@ int mips_cm_probe(void)
 {
 	phys_addr_t addr;
 	u32 base_reg;
+	unsigned cpu;
 
 	/*
 	 * No need to probe again if we have already been
@@ -247,9 +253,42 @@ int mips_cm_probe(void)
 	/* determine register width for this CM */
 	mips_cm_is64 = config_enabled(CONFIG_64BIT) && (mips_cm_revision() >= CM_REV_CM3);
 
+	for_each_possible_cpu(cpu)
+		spin_lock_init(&per_cpu(cm_core_lock, cpu));
+
 	return 0;
 }
 
+void mips_cm_lock_other(unsigned int core, unsigned int vp)
+{
+	unsigned curr_core;
+	u32 val;
+
+	preempt_disable();
+	curr_core = current_cpu_data.core;
+	spin_lock_irqsave(&per_cpu(cm_core_lock, curr_core),
+			  per_cpu(cm_core_lock_flags, curr_core));
+
+	if (mips_cm_revision() >= CM_REV_CM3) {
+		val = core << CM3_GCR_Cx_OTHER_CORE_SHF;
+		val |= vp << CM3_GCR_Cx_OTHER_VP_SHF;
+	} else {
+		BUG_ON(vp != 0);
+		val = core << CM_GCR_Cx_OTHER_CORENUM_SHF;
+	}
+
+	write_gcr_cl_other(val);
+}
+
+void mips_cm_unlock_other(void)
+{
+	unsigned curr_core = current_cpu_data.core;
+
+	spin_unlock_irqrestore(&per_cpu(cm_core_lock, curr_core),
+			       per_cpu(cm_core_lock_flags, curr_core));
+	preempt_enable();
+}
+
 void mips_cm_error_report(void)
 {
 	unsigned long revision = mips_cm_revision();
-- 
2.5.3
