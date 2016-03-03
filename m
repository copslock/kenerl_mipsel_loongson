Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2016 02:47:52 +0100 (CET)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:57627 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007622AbcCCBrraY6xl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Mar 2016 02:47:47 +0100
X-QQ-mid: bizesmtp1t1456969638t592t302
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 03 Mar 2016 09:46:27 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK70B00A0000000
X-QQ-FEAT: 6dXuswn9i1V+A0JH7fcUkwYseLPiam9ajCgw6mX1q2OzJ7hLNHjf08dtKbL6W
        hrPWqK5He+T8d9w/EDjoJ/pX9/ZHGQlDElWyjEglYDqHSlPQpM8XqT3X/hexpGj/ivegx7o
        +p0cBmaK2fvXoeX+NFYfAaaerhjKv6ptuUXrcy4t2R1b+pogZuwdj0/4AMfVomOV70+5wJ9
        nKYk4WfXoZCGqHhYvn3M3hVc0jvv/uF8rzFxddVmOpHJLwGh90ef4AYuMe10FM/2Kaq/EUQ
        TujoT4/LcJBmKm3Qos/VS2+qk=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V6 3/5] MIPS: Loongson: Invalidate special TLBs when needed
Date:   Thu,  3 Mar 2016 09:45:11 +0800
Message-Id: <1456969513-1683-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456969513-1683-1-git-send-email-chenhc@lemote.com>
References: <1456969513-1683-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Loongson-2 has a 4 entry itlb which is a subset of jtlb, Loongson-3 has
a 4 entry itlb and a 4 entry dtlb which are subsets of jtlb. We should
write diag register to invalidate itlb/dtlb when flushing jtlb because
itlb/dtlb are not totally transparent to software.

For Loongson-3A R2 (and newer), we should invalidate ITLB, DTLB, VTLB
and FTLB before we enable/disable FTLB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/mipsregs.h |  9 +++++++++
 arch/mips/kernel/cpu-probe.c     |  3 +++
 arch/mips/mm/tlb-r4k.c           | 27 +++++++++++++++------------
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 9290fd4..e41e9d9 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -759,6 +759,15 @@
 /* Disable Branch Return Cache */
 #define R10K_DIAG_D_BRC		(_ULCAST_(1) << 22)
 
+/* Flush ITLB */
+#define LOONGSON_DIAG_ITLB	(_ULCAST_(1) << 2)
+/* Flush DTLB */
+#define LOONGSON_DIAG_DTLB	(_ULCAST_(1) << 3)
+/* Flush VTLB */
+#define LOONGSON_DIAG_VTLB	(_ULCAST_(1) << 12)
+/* Flush FTLB */
+#define LOONGSON_DIAG_FTLB	(_ULCAST_(1) << 13)
+
 /*
  * Coprocessor 1 (FPU) register names
  */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 2a2ae86..1c41f10 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -562,6 +562,9 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 					   << MIPS_CONF7_FTLBP_SHIFT));
 		break;
 	case CPU_LOONGSON3:
+		/* Flush ITLB, DTLB, VTLB and FTLB */
+		write_c0_diag(LOONGSON_DIAG_ITLB | LOONGSON_DIAG_DTLB |
+			      LOONGSON_DIAG_VTLB | LOONGSON_DIAG_FTLB);
 		/* Loongson-3 cores use Config6 to enable the FTLB */
 		config = read_c0_config6();
 		if (enable)
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index c17d762..4c3362b 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -28,25 +28,28 @@
 extern void build_tlb_refill_handler(void);
 
 /*
- * LOONGSON2/3 has a 4 entry itlb which is a subset of dtlb,
- * unfortunately, itlb is not totally transparent to software.
+ * LOONGSON-2 has a 4 entry itlb which is a subset of jtlb, LOONGSON-3 has
+ * a 4 entry itlb and a 4 entry dtlb which are subsets of jtlb. Unfortunately,
+ * itlb/dtlb are not totally transparent to software.
  */
-static inline void flush_itlb(void)
+static inline void flush_micro_tlb(void)
 {
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
+		write_c0_diag(LOONGSON_DIAG_ITLB);
+		break;
 	case CPU_LOONGSON3:
-		write_c0_diag(4);
+		write_c0_diag(LOONGSON_DIAG_ITLB | LOONGSON_DIAG_DTLB);
 		break;
 	default:
 		break;
 	}
 }
 
-static inline void flush_itlb_vm(struct vm_area_struct *vma)
+static inline void flush_micro_tlb_vm(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & VM_EXEC)
-		flush_itlb();
+		flush_micro_tlb();
 }
 
 void local_flush_tlb_all(void)
@@ -93,7 +96,7 @@ void local_flush_tlb_all(void)
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
 	htw_start();
-	flush_itlb();
+	flush_micro_tlb();
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(local_flush_tlb_all);
@@ -159,7 +162,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		} else {
 			drop_mmu_context(mm, cpu);
 		}
-		flush_itlb();
+		flush_micro_tlb();
 		local_irq_restore(flags);
 	}
 }
@@ -205,7 +208,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	} else {
 		local_flush_tlb_all();
 	}
-	flush_itlb();
+	flush_micro_tlb();
 	local_irq_restore(flags);
 }
 
@@ -240,7 +243,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 	finish:
 		write_c0_entryhi(oldpid);
 		htw_start();
-		flush_itlb_vm(vma);
+		flush_micro_tlb_vm(vma);
 		local_irq_restore(flags);
 	}
 }
@@ -274,7 +277,7 @@ void local_flush_tlb_one(unsigned long page)
 	}
 	write_c0_entryhi(oldpid);
 	htw_start();
-	flush_itlb();
+	flush_micro_tlb();
 	local_irq_restore(flags);
 }
 
@@ -357,7 +360,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	}
 	tlbw_use_hazard();
 	htw_start();
-	flush_itlb_vm(vma);
+	flush_micro_tlb_vm(vma);
 	local_irq_restore(flags);
 }
 
-- 
2.7.0
