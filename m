Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 10:41:37 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54724 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011118AbbAZJlVufS5Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 10:41:21 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D6A967C285523;
        Mon, 26 Jan 2015 09:41:13 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 26 Jan 2015 09:41:15 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 26 Jan 2015 09:41:14 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 2/3] MIPS: HTW: Prevent accidental HTW start due to nested htw_{start,stop}
Date:   Mon, 26 Jan 2015 09:40:35 +0000
Message-ID: <1422265236-29290-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422265236-29290-1-git-send-email-markos.chandras@imgtec.com>
References: <1422265236-29290-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45474
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

activate_mm() and switch_mm() call get_new_mmu_context() which in turn
can enable the HTW before the entryhi is changed with the new ASID.
Since the latter will enable the HTW in local_flush_tlb_all(),
then there is a small timing window where the HTW is running with the
new ASID but with an old pgd since the TLBMISS_HANDLER_SETUP_PGD
hasn't assigned a new one yet. In order to prevent that, we introduce a
simple htw counter to avoid starting HTW accidentally due to nested
htw_{start,stop}() sequences. Moreover, since various IPI calls can
enforce TLB flushing operations on a different core, such an operation
may interrupt another htw_{stop,start} in progress leading inconsistent
updates of the htw_seq variable. In order to avoid that, we disable the
interrupts whenever we update that variable.

Cc: <stable@vger.kernel.org> # 3.17+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/cpu-info.h    |  5 +++++
 arch/mips/include/asm/mmu_context.h |  7 ++++++-
 arch/mips/include/asm/pgtable.h     | 17 ++++++++++++++---
 arch/mips/kernel/cpu-probe.c        |  4 +++-
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index a6c9ccb33c5c..c3f4f2d2e108 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -84,6 +84,11 @@ struct cpuinfo_mips {
 	 * (shifted by _CACHE_SHIFT)
 	 */
 	unsigned int		writecombine;
+	/*
+	 * Simple counter to prevent enabling HTW in nested
+	 * htw_start/htw_stop calls
+	 */
+	unsigned int		htw_seq;
 } __attribute__((aligned(SMP_CACHE_BYTES)));
 
 extern struct cpuinfo_mips cpu_data[];
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 2f82568a3ee4..bc01579a907a 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -25,7 +25,6 @@ do {									\
 	if (cpu_has_htw) {						\
 		write_c0_pwbase(pgd);					\
 		back_to_back_c0_hazard();				\
-		htw_reset();						\
 	}								\
 } while (0)
 
@@ -142,6 +141,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	unsigned long flags;
 	local_irq_save(flags);
 
+	htw_stop();
 	/* Check if our ASID is of an older version and thus invalid */
 	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & ASID_VERSION_MASK)
 		get_new_mmu_context(next, cpu);
@@ -154,6 +154,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 */
 	cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	cpumask_set_cpu(cpu, mm_cpumask(next));
+	htw_start();
 
 	local_irq_restore(flags);
 }
@@ -180,6 +181,7 @@ activate_mm(struct mm_struct *prev, struct mm_struct *next)
 
 	local_irq_save(flags);
 
+	htw_stop();
 	/* Unconditionally get a new ASID.  */
 	get_new_mmu_context(next, cpu);
 
@@ -189,6 +191,7 @@ activate_mm(struct mm_struct *prev, struct mm_struct *next)
 	/* mark mmu ownership change */
 	cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	cpumask_set_cpu(cpu, mm_cpumask(next));
+	htw_start();
 
 	local_irq_restore(flags);
 }
@@ -203,6 +206,7 @@ drop_mmu_context(struct mm_struct *mm, unsigned cpu)
 	unsigned long flags;
 
 	local_irq_save(flags);
+	htw_stop();
 
 	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
 		get_new_mmu_context(mm, cpu);
@@ -211,6 +215,7 @@ drop_mmu_context(struct mm_struct *mm, unsigned cpu)
 		/* will get a new context next time */
 		cpu_context(cpu, mm) = 0;
 	}
+	htw_start();
 	local_irq_restore(flags);
 }
 
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 7f7c558de9fc..d2c7e9e7447e 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -99,19 +99,30 @@ extern void paging_init(void);
 
 #define htw_stop()							\
 do {									\
+	unsigned long flags;						\
+									\
 	if (cpu_has_htw) {						\
+		local_irq_save(flags);					\
+		raw_current_cpu_data.htw_seq++;				\
 		write_c0_pwctl(read_c0_pwctl() &			\
 			       ~(1 << MIPS_PWCTL_PWEN_SHIFT));		\
 		back_to_back_c0_hazard();				\
+		local_irq_restore(flags);				\
 	}								\
 } while(0)
 
 #define htw_start()							\
 do {									\
+	unsigned long flags;						\
+									\
 	if (cpu_has_htw) {						\
-		write_c0_pwctl(read_c0_pwctl() |			\
-			       (1 << MIPS_PWCTL_PWEN_SHIFT));		\
-		back_to_back_c0_hazard();				\
+		local_irq_save(flags);					\
+		if (!--raw_current_cpu_data.htw_seq) {			\
+			write_c0_pwctl(read_c0_pwctl() |		\
+				       (1 << MIPS_PWCTL_PWEN_SHIFT));	\
+			back_to_back_c0_hazard();			\
+		}							\
+		local_irq_restore(flags);				\
 	}								\
 } while(0)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index dc49cf30c2db..5d6e59f20750 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -367,8 +367,10 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 	if (config3 & MIPS_CONF3_MSA)
 		c->ases |= MIPS_ASE_MSA;
 	/* Only tested on 32-bit cores */
-	if ((config3 & MIPS_CONF3_PW) && config_enabled(CONFIG_32BIT))
+	if ((config3 & MIPS_CONF3_PW) && config_enabled(CONFIG_32BIT)) {
+		c->htw_seq = 0;
 		c->options |= MIPS_CPU_HTW;
+	}
 
 	return config3 & MIPS_CONF_M;
 }
-- 
2.2.2
