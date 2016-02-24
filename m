Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 15:38:38 +0100 (CET)
Received: from smtpbg65.qq.com ([103.7.28.233]:57456 "EHLO smtpbg65.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006739AbcBXOifzYEZ6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2016 15:38:35 +0100
X-QQ-mid: bizesmtp8t1456324690t074t110
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 24 Feb 2016 22:37:19 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK70B00A0000000
X-QQ-FEAT: s2GiS5gUmyJ5VllIrdUzW1pfI49DwQKroh3PbEY946JTavvzaNut1KH7eyOJS
        9Dk+f78IoF43Dy7u50iZVor98fRlZ/vkM9OI7FKyibO4PL28lJp3MLqY+nvw3+qnkaXP+if
        4oXO4IOd2GQj6ORUjMPT19hvJC91zQhcg3vBcks8w8D+whWNk7JhzZE2BzsX0YEp2WnJFLb
        dYa7AV80f1rFHrkoJHz9whOVsnaNMhqpsGNA9rWpX6+2xUIYamX7kk8To8HqRLgJDabxty6
        9j3zu21KdELD3NwxphsIJCRDut4jOj+irVpQ==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 5/5] MIPS: Loongson-3: Introduce CONFIG_LOONGSON3_ENHANCEMENT
Date:   Wed, 24 Feb 2016 22:33:04 +0800
Message-Id: <1456324384-18118-8-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52199
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

New Loongson 3 CPU (since Loongson-3A R2, as opposed to Loongson-3A R1,
Loongson-3B R1 and Loongson-3B R2) has many enhancements, such as FTLB,
L1-VCache, EI/DI/Wait/Prefetch instruction, DSP/DSPv2 ASE, User Local
register, Read-Inhibit/Execute-Inhibit, SFB (Store Fill Buffer), Fast
TLB refill support, etc.

This patch introduce a config option, CONFIG_LOONGSON3_ENHANCEMENT, to
enable those enhancements which cannot be probed at run time. If you
want a generic kernel to run on all Loongson 3 machines, please say 'N'
here. If you want a high-performance kernel to run on new Loongson 3
machines only, please say 'Y' here.

Some additional explanations:
1) SFB locates between core and L1 cache, it causes memory access out
   of order, so writel/outl (and other similar functions) need a I/O
   reorder barrier.
2) Loongson 3 has a bug that di instruction can not save the irqflag,
   so arch_local_irq_save() is modified. Since CPU_MIPSR2 is selected
   by CONFIG_LOONGSON3_ENHANCEMENT, generic kernel doesn't use ei/di
   at all.
3) CPU_HAS_PREFETCH is selected by CONFIG_LOONGSON3_ENHANCEMENT, so
   MIPS_CPU_PREFETCH (used by uasm) probing is also put in this patch.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Kconfig                                      | 18 ++++++++++++++++++
 arch/mips/include/asm/hazards.h                        |  7 ++++---
 arch/mips/include/asm/io.h                             | 10 +++++-----
 arch/mips/include/asm/irqflags.h                       |  5 +++++
 .../include/asm/mach-loongson64/kernel-entry-init.h    | 12 ++++++++++++
 arch/mips/mm/c-r4k.c                                   |  2 ++
 arch/mips/mm/page.c                                    |  9 +++++++++
 7 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 38c0b11..68ec57a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1350,6 +1350,24 @@ config CPU_LOONGSON3
 		The Loongson 3 processor implements the MIPS64R2 instruction
 		set with many extensions.
 
+config LOONGSON3_ENHANCEMENT
+	bool "New Loongson 3 CPU Enhancements"
+	default n
+	select CPU_MIPSR2
+	select CPU_HAS_PREFETCH
+	depends on CPU_LOONGSON3
+	help
+	  New Loongson 3 CPU (since Loongson-3A R2, as opposed to Loongson-3A
+	  R1, Loongson-3B R1 and Loongson-3B R2) has many enhancements, such as
+	  FTLB, L1-VCache, EI/DI/Wait/Prefetch instruction, DSP/DSPv2 ASE, User
+	  Local register, Read-Inhibit/Execute-Inhibit, SFB (Store Fill Buffer),
+	  Fast TLB refill support, etc.
+
+	  This option enable those enhancements which cannot be probed at run
+	  time. If you want a generic kernel to run on all Loongson 3 machines,
+	  please say 'N' here. If you want a high-performance kernel to run on
+	  new Loongson 3 machines only, please say 'Y' here.
+
 config CPU_LOONGSON2E
 	bool "Loongson 2E"
 	depends on SYS_HAS_CPU_LOONGSON2E
diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 7b99efd..dbb1eb6 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -22,7 +22,8 @@
 /*
  * TLB hazards
  */
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) && !defined(CONFIG_CPU_CAVIUM_OCTEON)
+#if (defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6)) && \
+	!defined(CONFIG_CPU_CAVIUM_OCTEON) && !defined(CONFIG_LOONGSON3_ENHANCEMENT)
 
 /*
  * MIPSR2 defines ehb for hazard avoidance
@@ -155,8 +156,8 @@ do {									\
 } while (0)
 
 #elif defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_CPU_CAVIUM_OCTEON) || \
-	defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_CPU_R10000) || \
-	defined(CONFIG_CPU_R5500) || defined(CONFIG_CPU_XLR)
+	defined(CONFIG_CPU_LOONGSON2) || defined(CONFIG_LOONGSON3_ENHANCEMENT) || \
+	defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_R5500) || defined(CONFIG_CPU_XLR)
 
 /*
  * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 2b4dc7a..ecabc00 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -304,10 +304,10 @@ static inline void iounmap(const volatile void __iomem *addr)
 #undef __IS_KSEG1
 }
 
-#ifdef CONFIG_CPU_CAVIUM_OCTEON
-#define war_octeon_io_reorder_wmb()		wmb()
+#if defined(CONFIG_CPU_CAVIUM_OCTEON) || defined(CONFIG_LOONGSON3_ENHANCEMENT)
+#define war_io_reorder_wmb()		wmb()
 #else
-#define war_octeon_io_reorder_wmb()		do { } while (0)
+#define war_io_reorder_wmb()		do { } while (0)
 #endif
 
 #define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)			\
@@ -318,7 +318,7 @@ static inline void pfx##write##bwlq(type val,				\
 	volatile type *__mem;						\
 	type __val;							\
 									\
-	war_octeon_io_reorder_wmb();					\
+	war_io_reorder_wmb();					\
 									\
 	__mem = (void *)__swizzle_addr_##bwlq((unsigned long)(mem));	\
 									\
@@ -387,7 +387,7 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 	volatile type *__addr;						\
 	type __val;							\
 									\
-	war_octeon_io_reorder_wmb();					\
+	war_io_reorder_wmb();					\
 									\
 	__addr = (void *)__swizzle_addr_##bwlq(mips_io_port_base + port); \
 									\
diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 65c351e..9d3610b 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -41,7 +41,12 @@ static inline unsigned long arch_local_irq_save(void)
 	"	.set	push						\n"
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
+#if defined(CONFIG_CPU_LOONGSON3)
+	"	mfc0	%[flags], $12					\n"
+	"	di							\n"
+#else
 	"	di	%[flags]					\n"
+#endif
 	"	andi	%[flags], 1					\n"
 	"	" __stringify(__irq_disable_hazard) "			\n"
 	"	.set	pop						\n"
diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index da83482..8393bc54 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -26,6 +26,12 @@
 	mfc0	t0, $5, 1
 	or	t0, (0x1 << 29)
 	mtc0	t0, $5, 1
+#ifdef CONFIG_LOONGSON3_ENHANCEMENT
+	/* Enable STFill Buffer */
+	mfc0	t0, $16, 6
+	or	t0, 0x100
+	mtc0	t0, $16, 6
+#endif
 	_ehb
 	.set	pop
 #endif
@@ -46,6 +52,12 @@
 	mfc0	t0, $5, 1
 	or	t0, (0x1 << 29)
 	mtc0	t0, $5, 1
+#ifdef CONFIG_LOONGSON3_ENHANCEMENT
+	/* Enable STFill Buffer */
+	mfc0	t0, $16, 6
+	or	t0, 0x100
+	mtc0	t0, $16, 6
+#endif
 	_ehb
 	.set	pop
 #endif
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 65fb28c..dc05dc3 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1170,6 +1170,8 @@ static void probe_pcache(void)
 					  c->dcache.ways *
 					  c->dcache.linesz;
 		c->dcache.waybit = 0;
+		if ((prid & PRID_REV_MASK) >= PRID_REV_LOONGSON3A_R2)
+			c->options |= MIPS_CPU_PREFETCH;
 		break;
 
 	case CPU_CAVIUM_OCTEON3:
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 885d73f..c41953c 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -188,6 +188,15 @@ static void set_prefetch_parameters(void)
 			}
 			break;
 
+		case CPU_LOONGSON3:
+			/* Loongson-3 only support the Pref_Load/Pref_Store. */
+			pref_bias_clear_store = 128;
+			pref_bias_copy_load = 128;
+			pref_bias_copy_store = 128;
+			pref_src_mode = Pref_Load;
+			pref_dst_mode = Pref_Store;
+			break;
+
 		default:
 			pref_bias_clear_store = 128;
 			pref_bias_copy_load = 256;
-- 
2.7.0
