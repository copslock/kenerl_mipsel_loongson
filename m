Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 14:58:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:60668 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834703AbaDPM5UlzXpH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 14:57:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 08F0CC1A9346E
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 13:57:11 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 16 Apr
 2014 13:57:13 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 13:57:13 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 13:57:12 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 14/39] MIPS: CPC: provide locking functions
Date:   Wed, 16 Apr 2014 13:53:05 +0100
Message-ID: <1397652810-4336-15-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39821
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

This patch provides functions to lock & unlock access to the
"core-other" register region of the CPC. Without performing appropriate
locking it is possible for code using this region to be preempted or to
race with code on another VPE within the same core, with one changing
the core which the "core-other" region is acting upon at an inopportune
time for the other.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/mips-cpc.h | 27 +++++++++++++++++++++++++++
 arch/mips/kernel/mips-cpc.c      | 26 ++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
index c5bb609..e139a53 100644
--- a/arch/mips/include/asm/mips-cpc.h
+++ b/arch/mips/include/asm/mips-cpc.h
@@ -152,4 +152,31 @@ BUILD_CPC_Cx_RW(other,		0x10)
 #define CPC_Cx_OTHER_CORENUM_SHF		16
 #define CPC_Cx_OTHER_CORENUM_MSK		(_ULCAST_(0xff) << 16)
 
+#ifdef CONFIG_MIPS_CPC
+
+/**
+ * mips_cpc_lock_other - lock access to another core
+ * core: the other core to be accessed
+ *
+ * Call before operating upon a core via the 'other' register region in
+ * order to prevent the region being moved during access. Must be followed
+ * by a call to mips_cpc_unlock_other.
+ */
+extern void mips_cpc_lock_other(unsigned int core);
+
+/**
+ * mips_cpc_unlock_other - unlock access to another core
+ *
+ * Call after operating upon another core via the 'other' register region.
+ * Must be called after mips_cpc_lock_other.
+ */
+extern void mips_cpc_unlock_other(void);
+
+#else /* !CONFIG_MIPS_CPC */
+
+static inline void mips_cpc_lock_other(unsigned int core) { }
+static inline void mips_cpc_unlock_other(void) { }
+
+#endif /* !CONFIG_MIPS_CPC */
+
 #endif /* __MIPS_ASM_MIPS_CPC_H__ */
diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
index c9dc674..2368fc5 100644
--- a/arch/mips/kernel/mips-cpc.c
+++ b/arch/mips/kernel/mips-cpc.c
@@ -15,6 +15,10 @@
 
 void __iomem *mips_cpc_base;
 
+static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
+
+static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
+
 phys_t __weak mips_cpc_phys_base(void)
 {
 	u32 cpc_base;
@@ -39,6 +43,10 @@ phys_t __weak mips_cpc_phys_base(void)
 int mips_cpc_probe(void)
 {
 	phys_t addr;
+	unsigned cpu;
+
+	for_each_possible_cpu(cpu)
+		spin_lock_init(&per_cpu(cpc_core_lock, cpu));
 
 	addr = mips_cpc_phys_base();
 	if (!addr)
@@ -50,3 +58,21 @@ int mips_cpc_probe(void)
 
 	return 0;
 }
+
+void mips_cpc_lock_other(unsigned int core)
+{
+	unsigned curr_core;
+	preempt_disable();
+	curr_core = current_cpu_data.core;
+	spin_lock_irqsave(&per_cpu(cpc_core_lock, curr_core),
+			  per_cpu(cpc_core_lock_flags, curr_core));
+	write_cpc_cl_other(core << CPC_Cx_OTHER_CORENUM_SHF);
+}
+
+void mips_cpc_unlock_other(void)
+{
+	unsigned curr_core = current_cpu_data.core;
+	spin_unlock_irqrestore(&per_cpu(cpc_core_lock, curr_core),
+			       per_cpu(cpc_core_lock_flags, curr_core));
+	preempt_enable();
+}
-- 
1.8.5.3
