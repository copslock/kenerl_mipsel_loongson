Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Mar 2016 04:46:54 +0100 (CET)
Received: from smtpproxy19.qq.com ([184.105.206.84]:41405 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007209AbcCBDqt2Csnd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Mar 2016 04:46:49 +0100
X-QQ-mid: bizesmtp15t1456890379t866t23
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 02 Mar 2016 11:45:48 +0800 (CST)
X-QQ-SSF: 01100000000000F0FK70B00A0000000
X-QQ-FEAT: 3jlOKZxptE7qGAvcvqZd0VcTxc1hBxZHP+oWB3mYXntfiIoP8bqHqgQHAwZ3i
        PHKMv/tQOxOPuw8ha9R2LQAnGsILAmAqbnUErfJqNf6O0XW3WGTyDnecn8Pw39nglA9+AvB
        8tONrq3Ag8FlqAZzMKCXdg2XP7+0pOMC7gbMmpQUXOR+xz29sliwJDQOKFZfSqBSfb59TX+
        biIMjd1NYV8lFGF5Rh0Oh0EI/kBz/FfG5zfwNX8jcvRgGkkQZfwlRU0g6Q94e/fY9hzWmMu
        AbXt+ne9qV8l99s/usXfv/1Fs=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V5 3/5] MIPS: Loongson: Invalidate special TLBs when needed
Date:   Wed,  2 Mar 2016 11:45:13 +0800
Message-Id: <1456890315-28814-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456890315-28814-1-git-send-email-chenhc@lemote.com>
References: <1456890315-28814-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52409
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
index 2a2ae86..ef605e2 100644
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
index c17d762..7593529 100644
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
@@ -93,7 +96,7 @@ void local_flush_tlb_all(void)
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
 	htw_start();
-	flush_itlb();
+	flush_spec_tlb();
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(local_flush_tlb_all);
@@ -159,7 +162,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		} else {
 			drop_mmu_context(mm, cpu);
 		}
-		flush_itlb();
+		flush_spec_tlb();
 		local_irq_restore(flags);
 	}
 }
@@ -205,7 +208,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	} else {
 		local_flush_tlb_all();
 	}
-	flush_itlb();
+	flush_spec_tlb();
 	local_irq_restore(flags);
 }
 
@@ -240,7 +243,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 	finish:
 		write_c0_entryhi(oldpid);
 		htw_start();
-		flush_itlb_vm(vma);
+		flush_spec_tlb_vm(vma);
 		local_irq_restore(flags);
 	}
 }
@@ -274,7 +277,7 @@ void local_flush_tlb_one(unsigned long page)
 	}
 	write_c0_entryhi(oldpid);
 	htw_start();
-	flush_itlb();
+	flush_spec_tlb();
 	local_irq_restore(flags);
 }
 
@@ -357,7 +360,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	}
 	tlbw_use_hazard();
 	htw_start();
-	flush_itlb_vm(vma);
+	flush_spec_tlb_vm(vma);
 	local_irq_restore(flags);
 }
 
-- 
2.7.0
