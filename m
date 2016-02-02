Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 07:51:29 +0100 (CET)
Received: from smtpbg202.qq.com ([184.105.206.29]:56022 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007168AbcBBGv2Dhzg3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2016 07:51:28 +0100
X-QQ-mid: bizesmtp14t1454395823t407t32
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 02 Feb 2016 14:49:20 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: r8geFCKg7nb+W9xvq624rxwqNrRRmxx8L9PlDq0Y3tikSjoDWhHVKQOpFDb3q
        dwuvBta0dGOBV6Fbl+QSYoYLPCm6fJZHsIMIXE17hjO/zTiB8UWO0k8ou38AR79hXOhrYV3
        hS/OkTyFagwszXJFoJtJTs9mYoYURxvybCzDplQey1dMwY1YgG14xZeK1kioew5N86YLqCy
        l/O9W0TAmOELZyOEkuRFNmxgvIYjgfANS2HNb/f5Y1CYJheIFybHh8eLf/dyMu2wcuRm9K6
        lCYycCNCmkFqzzhIJZdchgLys=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 2/6] MIPS: Loongson: Invalidate special TLBs when needed
Date:   Tue,  2 Feb 2016 14:48:40 +0800
Message-Id: <1454395724-28442-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454395724-28442-1-git-send-email-chenhc@lemote.com>
References: <1454395724-28442-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51617
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
 arch/mips/kernel/cpu-probe.c |  2 ++
 arch/mips/mm/tlb-r4k.c       | 27 +++++++++++++++------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 9e963f2..2c5ec1e 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -562,6 +562,8 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 					   << MIPS_CONF7_FTLBP_SHIFT));
 		break;
 	case CPU_LOONGSON3:
+		/* Flush ITLB, DTLB, VTLB and FTLB */
+		write_c0_diag(1<<2 | 1<<3 | 1<<12 | 1<<13);
 		/* Loongson-3 cores use Config6 to enable the FTLB */
 		config = read_c0_config6();
 		if (enable)
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 5037d58..8baa288 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -27,25 +27,28 @@
 extern void build_tlb_refill_handler(void);
 
 /*
- * LOONGSON2/3 has a 4 entry itlb which is a subset of dtlb,
- * unfortunately, itlb is not totally transparent to software.
+ * LOONGSON-2 has a 4 entry itlb which is a subset of jtlb, LOONGSON-3 has
+ * a 4 entry itlb and a 4 entry dtlb which are subsets of jtlb. Unfortunately,
+ * itlb/dtlb are not totally transparent to software.
  */
-static inline void flush_itlb(void)
+static inline void flush_spec_tlb(void)
 {
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
+		write_c0_diag(0x4);
+		break;
 	case CPU_LOONGSON3:
-		write_c0_diag(4);
+		write_c0_diag(0xc);
 		break;
 	default:
 		break;
 	}
 }
 
-static inline void flush_itlb_vm(struct vm_area_struct *vma)
+static inline void flush_spec_tlb_vm(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & VM_EXEC)
-		flush_itlb();
+		flush_spec_tlb();
 }
 
 void local_flush_tlb_all(void)
@@ -92,7 +95,7 @@ void local_flush_tlb_all(void)
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
 	htw_start();
-	flush_itlb();
+	flush_spec_tlb();
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(local_flush_tlb_all);
@@ -158,7 +161,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		} else {
 			drop_mmu_context(mm, cpu);
 		}
-		flush_itlb();
+		flush_spec_tlb();
 		local_irq_restore(flags);
 	}
 }
@@ -204,7 +207,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	} else {
 		local_flush_tlb_all();
 	}
-	flush_itlb();
+	flush_spec_tlb();
 	local_irq_restore(flags);
 }
 
@@ -239,7 +242,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 	finish:
 		write_c0_entryhi(oldpid);
 		htw_start();
-		flush_itlb_vm(vma);
+		flush_spec_tlb_vm(vma);
 		local_irq_restore(flags);
 	}
 }
@@ -273,7 +276,7 @@ void local_flush_tlb_one(unsigned long page)
 	}
 	write_c0_entryhi(oldpid);
 	htw_start();
-	flush_itlb();
+	flush_spec_tlb();
 	local_irq_restore(flags);
 }
 
@@ -356,7 +359,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	}
 	tlbw_use_hazard();
 	htw_start();
-	flush_itlb_vm(vma);
+	flush_spec_tlb_vm(vma);
 	local_irq_restore(flags);
 }
 
-- 
2.4.6
