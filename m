Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 05:41:12 +0200 (CEST)
Received: from smtpbgau1.qq.com ([54.206.16.166]:33464 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011926AbbD2Dkcnx1j7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Apr 2015 05:40:32 +0200
X-QQ-mid: bizesmtp2t1430278773t190t154
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Apr 2015 11:39:31 +0800 (CST)
X-QQ-SSF: 01100000002000F0F212B00A0000000
X-QQ-FEAT: xflb0yrtfs+bvuIN9XWFE/QQCL9vCjgnfaU96NQZ61Mxau9Yw4jePwFLNT8pR
        IbLLbhmSlXF3LG2ks1C9X9ycPeHbpvzp7lgJR+G7P/f1R/trhBM7yXBwEdcRW7a91VGy7Nn
        uRa2CoX3Abk5VVQFbo/MqbgUikJ8gqZVWwodayzplBN99APFI/InUv0tsHjuJFky9RexIvc
        N8u3ogT6Lk6PTq+vheRroLZmFQG3UcuzsQtEJXjt5xRxXIJS/J1jL
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>, Chunbo Cui <cuicb@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/8] MIPS: Loongson: Add basic Loongson-1A CPU support
Date:   Wed, 29 Apr 2015 11:57:20 +0800
Message-Id: <1430279847-25120-2-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
References: <1430279847-25120-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47154
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

Signed-off-by: Chunbo Cui <cuicb@lemote.com>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-type.h   | 3 ++-
 arch/mips/include/asm/cpu.h        | 2 +-
 arch/mips/kernel/cpu-probe.c       | 6 +++++-
 arch/mips/loongson1/Platform       | 1 +
 arch/mips/loongson1/common/setup.c | 6 +++++-
 arch/mips/mm/c-r4k.c               | 7 +++++++
 6 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index 33f3cab..526f3d8 100644
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
index e3adca1..13c8c72 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -231,7 +231,7 @@
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130		0x0080
 #define PRID_REV_34K_V1_0_2	0x0022
-#define PRID_REV_LOONGSON1B	0x0020
+#define PRID_REV_LOONGSON1A_1B	0x0020
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
 #define PRID_REV_LOONGSON3A	0x0005
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index e36515d..dde36eb 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1007,8 +1007,12 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
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
 
diff --git a/arch/mips/loongson1/Platform b/arch/mips/loongson1/Platform
index 1186344..f7d057f 100644
--- a/arch/mips/loongson1/Platform
+++ b/arch/mips/loongson1/Platform
@@ -4,4 +4,5 @@ cflags-$(CONFIG_CPU_LOONGSON1)	+= \
 
 platform-$(CONFIG_MACH_LOONGSON1)	+= loongson1/
 cflags-$(CONFIG_MACH_LOONGSON1)		+= -I$(srctree)/arch/mips/include/asm/mach-loongson1
+load-$(CONFIG_LOONGSON1_LS1A)		+= 0xffffffff80200000
 load-$(CONFIG_LOONGSON1_LS1B)		+= 0xffffffff80100000
diff --git a/arch/mips/loongson1/common/setup.c b/arch/mips/loongson1/common/setup.c
index 62f41af..c3d2036 100644
--- a/arch/mips/loongson1/common/setup.c
+++ b/arch/mips/loongson1/common/setup.c
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
index 0dbb65a..3ded31e 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1277,6 +1277,13 @@ static void probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
 			break;
 		}
+	case CPU_LOONGSON1:
+		if ((read_c0_config7() & (1 << 16))) {
+			/* effectively physically indexed dcache,
+			   thus no virtual aliases. */
+			c->dcache.flags |= MIPS_CACHE_PINDEX;
+			break;
+		}
 	default:
 		if (has_74k_erratum || c->dcache.waysize > PAGE_SIZE)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
-- 
1.9.0



.
