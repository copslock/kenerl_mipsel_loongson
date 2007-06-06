Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 07:57:26 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:65417 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021514AbXFFGyE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 07:54:04 +0100
Received: (qmail 7101 invoked by uid 511); 6 Jun 2007 07:00:20 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 07:00:20 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 14/15] tlb handling support for Loongson2 processor
Date:	Wed,  6 Jun 2007 14:52:51 +0800
Message-Id: <1181112774155-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811127722019-git-send-email-tiansm@lemote.com>
References: <11811127722019-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 arch/mips/mm/tlb-r4k.c |   23 ++++++++++++++++++++++-
 arch/mips/mm/tlbex.c   |    8 +++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 65160d4..dcd6913 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -48,6 +48,22 @@ extern void build_tlb_refill_handler(void);
 
 #endif /* CONFIG_MIPS_MT_SMTC */
 
+#if defined(CONFIG_CPU_LOONGSON2)
+/*
+ * LOONGSON2 has a 4 entry itlb which is a subset of dtlb,
+ * unfortrunately, itlb is not totally transparent to software.
+ */
+#define FLUSH_ITLB write_c0_diag(4);
+
+#define FLUSH_ITLB_VM(vma) { if ((vma)->vm_flags & VM_EXEC)  write_c0_diag(4); }
+
+#else
+
+#define FLUSH_ITLB
+#define FLUSH_ITLB_VM(vma)
+
+#endif
+
 void local_flush_tlb_all(void)
 {
 	unsigned long flags;
@@ -73,6 +89,7 @@ void local_flush_tlb_all(void)
 	}
 	tlbw_use_hazard();
 	write_c0_entryhi(old_ctx);
+	FLUSH_ITLB;
 	EXIT_CRITICAL(flags);
 }
 
@@ -136,6 +153,7 @@ void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		} else {
 			drop_mmu_context(mm, cpu);
 		}
+		FLUSH_ITLB;
 		EXIT_CRITICAL(flags);
 	}
 }
@@ -178,6 +196,7 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	} else {
 		local_flush_tlb_all();
 	}
+	FLUSH_ITLB;
 	EXIT_CRITICAL(flags);
 }
 
@@ -210,6 +229,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 
 	finish:
 		write_c0_entryhi(oldpid);
+		FLUSH_ITLB_VM(vma);
 		EXIT_CRITICAL(flags);
 	}
 }
@@ -241,7 +261,7 @@ void local_flush_tlb_one(unsigned long page)
 		tlbw_use_hazard();
 	}
 	write_c0_entryhi(oldpid);
-
+	FLUSH_ITLB;
 	EXIT_CRITICAL(flags);
 }
 
@@ -293,6 +313,7 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
 	else
 		tlb_write_indexed();
 	tlbw_use_hazard();
+	FLUSH_ITLB_VM(vma);
 	EXIT_CRITICAL(flags);
 }
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e714929..4ec0964 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -893,6 +893,7 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
 	case CPU_4KSC:
 	case CPU_20KC:
 	case CPU_25KF:
+	case CPU_LOONGSON2:
 		tlbw(p);
 		break;
 
@@ -1276,7 +1277,8 @@ static void __init build_r4000_tlb_refill_handler(void)
 	 * need three, with the second nop'ed and the third being
 	 * unused.
 	 */
-#ifdef CONFIG_32BIT
+	/* Loongson2 ebase is different than r4k, we have more space */
+#if defined(CONFIG_32BIT) || defined(CONFIG_CPU_LOONGSON2)
 	if ((p - tlb_handler) > 64)
 		panic("TLB refill handler space exceeded");
 #else
@@ -1289,7 +1291,7 @@ static void __init build_r4000_tlb_refill_handler(void)
 	/*
 	 * Now fold the handler in the TLB refill handler space.
 	 */
-#ifdef CONFIG_32BIT
+#if defined(CONFIG_32BIT) || defined(CONFIG_CPU_LOONGSON2)
 	f = final_handler;
 	/* Simplest case, just copy the handler. */
 	copy_handler(relocs, labels, tlb_handler, p, f);
@@ -1336,7 +1338,7 @@ static void __init build_r4000_tlb_refill_handler(void)
 		final_len);
 
 	f = final_handler;
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && !defined(CONFIG_CPU_LOONGSON2)
 	if (final_len > 32)
 		final_len = 64;
 	else
-- 
1.5.2.1
