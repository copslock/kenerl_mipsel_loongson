Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 07:19:48 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:49498 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006952AbbCDGSjiJ5qz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 07:18:39 +0100
Received: from localhost (unknown [166.170.43.162])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 98EE692F;
        Wed,  4 Mar 2015 06:18:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.18 121/151] MIPS: HTW: Prevent accidental HTW start due to nested htw_{start, stop}
Date:   Tue,  3 Mar 2015 22:14:15 -0800
Message-Id: <20150304055517.278230841@linuxfoundation.org>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <20150304055457.084276421@linuxfoundation.org>
References: <20150304055457.084276421@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit ed4cbc81addbc076b016c5b979fd1a02f0897f0a upstream.

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

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9118/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/cpu-info.h    |    5 +++++
 arch/mips/include/asm/mmu_context.h |    7 ++++++-
 arch/mips/include/asm/pgtable.h     |   24 ++++++++++++++++++------
 arch/mips/kernel/cpu-probe.c        |    4 +++-
 4 files changed, 32 insertions(+), 8 deletions(-)

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
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -25,7 +25,6 @@ do {									\
 	if (cpu_has_htw) {						\
 		write_c0_pwbase(pgd);					\
 		back_to_back_c0_hazard();				\
-		htw_reset();						\
 	}								\
 } while (0)
 
@@ -142,6 +141,7 @@ static inline void switch_mm(struct mm_s
 	unsigned long flags;
 	local_irq_save(flags);
 
+	htw_stop();
 	/* Check if our ASID is of an older version and thus invalid */
 	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & ASID_VERSION_MASK)
 		get_new_mmu_context(next, cpu);
@@ -154,6 +154,7 @@ static inline void switch_mm(struct mm_s
 	 */
 	cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	cpumask_set_cpu(cpu, mm_cpumask(next));
+	htw_start();
 
 	local_irq_restore(flags);
 }
@@ -180,6 +181,7 @@ activate_mm(struct mm_struct *prev, stru
 
 	local_irq_save(flags);
 
+	htw_stop();
 	/* Unconditionally get a new ASID.  */
 	get_new_mmu_context(next, cpu);
 
@@ -189,6 +191,7 @@ activate_mm(struct mm_struct *prev, stru
 	/* mark mmu ownership change */
 	cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	cpumask_set_cpu(cpu, mm_cpumask(next));
+	htw_start();
 
 	local_irq_restore(flags);
 }
@@ -203,6 +206,7 @@ drop_mmu_context(struct mm_struct *mm, u
 	unsigned long flags;
 
 	local_irq_save(flags);
+	htw_stop();
 
 	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
 		get_new_mmu_context(mm, cpu);
@@ -211,6 +215,7 @@ drop_mmu_context(struct mm_struct *mm, u
 		/* will get a new context next time */
 		cpu_context(cpu, mm) = 0;
 	}
+	htw_start();
 	local_irq_restore(flags);
 }
 
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -99,19 +99,31 @@ extern void paging_init(void);
 
 #define htw_stop()							\
 do {									\
+	unsigned long flags;						\
+									\
 	if (cpu_has_htw) {						\
-		write_c0_pwctl(read_c0_pwctl() &			\
-			       ~(1 << MIPS_PWCTL_PWEN_SHIFT));		\
-		back_to_back_c0_hazard();				\
+		local_irq_save(flags);					\
+		if(!raw_current_cpu_data.htw_seq++) {			\
+			write_c0_pwctl(read_c0_pwctl() &		\
+				       ~(1 << MIPS_PWCTL_PWEN_SHIFT));	\
+			back_to_back_c0_hazard();			\
+		}							\
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
 
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -367,8 +367,10 @@ static inline unsigned int decode_config
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
