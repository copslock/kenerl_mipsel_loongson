Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 03:45:18 +0200 (CEST)
Received: from smtpbg341.qq.com ([14.17.44.36]:59415 "EHLO smtpbg341.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27030399AbcESBnqdWgu0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 May 2016 03:43:46 +0200
X-QQ-mid: bizesmtp3t1463622153t766t307
Received: from localhost.localdomain (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 19 May 2016 09:42:32 +0800 (CST)
X-QQ-SSF: 01100000002000F0FG60000A0000000
X-QQ-FEAT: 7qOBSEc3UDD6fROIIM1v/uQIjbvMa1itbQaA18DsnTHX5gqtiP2WDrY4ZWpAo
        xHRoVG7Ne4mVoQiqRG/CKC4TthhiiMrFxhGaBSRcXkYFzYpR2Hl2DsA9CadFpMJ0rCB8a+L
        oyEs72xQ4tGgCnTbv6ZRx2/hyB7KjZx2mK4m1VTh9B/c4o0o3/Gf3Vz0EawfR0mJZJMfDU1
        w+B7VOeag6yUi6rpP6tePmgTl9c+8mDypbCNmam2trpA3puh5A8C0/prT6OMR/jzYYbzkRg
        6zwHBbR9tjB6Y8r/4Q7COM/p7XfFzVqr0jNQ==
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuichboo@163.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH RESEND v4 1/9] MIPS: Loongson: Add basic Loongson-1A CPU support
Date:   Thu, 19 May 2016 09:38:26 +0800
Message-Id: <1463621912-9883-2-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
References: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

The Loongson 1A is similar with Loongson 1B, which is a 32-bit SoC.
It implements the MIPS32 release 2 instruction set.

They share the same PRID, so we rewrite the PRID_REV_LOONGSON1B to
PRID_REV_LOONGSON1A_1B, and use their CPU macros to distinguish.

Signed-off-by: Chunbo Cui <cuichboo@163.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-type.h    | 3 ++-
 arch/mips/include/asm/cpu.h         | 2 +-
 arch/mips/kernel/cpu-probe.c        | 6 +++++-
 arch/mips/loongson32/Platform       | 1 +
 arch/mips/loongson32/common/setup.c | 6 +++++-
 arch/mips/mm/c-r4k.c                | 9 +++++++++
 6 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index fbe1881..ab69178 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -24,7 +24,8 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_LOONGSON3:
 #endif
 
-#ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
+#if defined(CONFIG_SYS_HAS_CPU_LOONGSON1A) || \
+    defined(CONFIG_SYS_HAS_CPU_LOONGSON1B)
 	case CPU_LOONGSON1:
 #endif
 
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index f672df8..43812ba 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -239,7 +239,7 @@
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130		0x0080
 #define PRID_REV_34K_V1_0_2	0x0022
-#define PRID_REV_LOONGSON1B	0x0020
+#define PRID_REV_LOONGSON1A_1B	0x0020
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
 #define PRID_REV_LOONGSON3A_R1	0x0005
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5ac5c3e..efa8c33 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1497,8 +1497,12 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_LOONGSON1;
 
 		switch (c->processor_id & PRID_REV_MASK) {
-		case PRID_REV_LOONGSON1B:
+		case PRID_REV_LOONGSON1A_1B:
+#ifdef CONFIG_CPU_LOONGSON1A
+			__cpu_name[cpu] = "Loongson 1A";
+#else
 			__cpu_name[cpu] = "Loongson 1B";
+#endif
 			break;
 		}
 
diff --git a/arch/mips/loongson32/Platform b/arch/mips/loongson32/Platform
index ebb6dc2..e114c85 100644
--- a/arch/mips/loongson32/Platform
+++ b/arch/mips/loongson32/Platform
@@ -4,4 +4,5 @@ cflags-$(CONFIG_CPU_LOONGSON1)	+= \
 
 platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
 cflags-$(CONFIG_MACH_LOONGSON32)	+= -I$(srctree)/arch/mips/include/asm/mach-loongson32
+load-$(CONFIG_LOONGSON1_LS1A)		+= 0xffffffff80200000
 load-$(CONFIG_LOONGSON1_LS1B)		+= 0xffffffff80100000
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 62f41af..c3d2036 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -21,8 +21,12 @@ const char *get_system_type(void)
 	unsigned int processor_id = (&current_cpu_data)->processor_id;
 
 	switch (processor_id & PRID_REV_MASK) {
-	case PRID_REV_LOONGSON1B:
+	case PRID_REV_LOONGSON1A_1B:
+#ifdef CONFIG_CPU_LOONGSON1A
+		return "LOONGSON LS1A";
+#else
 		return "LOONGSON LS1B";
+#endif
 	default:
 		return "LOONGSON (unknown)";
 	}
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ef7f925..8c9eabc 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1306,6 +1306,15 @@ static void probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
 			break;
 		}
+	case CPU_LOONGSON1:
+		if ((read_c0_config7() & (1 << 16))) {
+			/*
+			 * effectively physically indexed dcache,
+			 * thus no virtual aliases.
+			 */
+			c->dcache.flags |= MIPS_CACHE_PINDEX;
+			break;
+		}
 	default:
 		if (has_74k_erratum || c->dcache.waysize > PAGE_SIZE)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
-- 
1.9.1
