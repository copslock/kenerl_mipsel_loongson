Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 03:00:53 +0100 (CET)
Received: from smtpbg291.qq.com ([113.108.11.223]:48967 "EHLO smtpbg291.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992255AbdBHB7BvwqK2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Feb 2017 02:59:01 +0100
X-QQ-mid: bizesmtp3t1486519093tqanhgsaj
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 08 Feb 2017 09:58:13 +0800 (CST)
X-QQ-SSF: 01100000002000F0FH61B00A0000000
X-QQ-FEAT: r8geFCKg7nY4xCgZ6e/UXeEMIascK3zPsVeYb96asxI1GSs9pmbcCqLehVxim
        2LIfFoorNdXS+pB93nX6vHOeKBnP/Li1Za4wpYRhyVgA31UEE9GFMWTxrpQRtSSwUWRrTEA
        qXanAn/F2IXivKCZbN19HyEfDDaN9BDDBDNgctUz4z0Erf1T2R0qXwBw3xlmraiZUPZsaDl
        yQWLKgfxvmdK8F74oeQjyrVI650RPRlZqKmqIs36MXzGe6cYAE9243Jhzf8jYscG1opNeNb
        ubHCaUGaKJ2xGZXgS1MOxk4MGFrm5Ka6hVkg==
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        Binbin Zhou <zhoubb@lemote.com>,
        HuaCai Chen <chenhc@lemote.com>
Subject: [PATCH v5 3/8] MIPS: Loongson: Add basic Loongson-1A CPU support
Date:   Wed,  8 Feb 2017 09:57:44 +0800
Message-Id: <1486519069-9364-4-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1486519069-9364-1-git-send-email-zhoubb@lemote.com>
References: <1486519069-9364-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56722
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

The Loongson-1A CPU is similar with Loongson-1B/1C, which is a 32-bit SoC.
It implements the MIPS32 release 2 instruction set.

It is a cost-effective single chip system based on LS232 processor core,
and is applicable to fields such as industrial control, and security applications.

Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: HuaCai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu-type.h    |  3 ++-
 arch/mips/kernel/cpu-probe.c        |  4 +++-
 arch/mips/loongson32/Platform       |  1 +
 arch/mips/loongson32/common/setup.c |  4 +++-
 arch/mips/mm/c-r4k.c                | 10 ++++++++++
 5 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index bdd6dc1..13ea1ea5 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -24,7 +24,8 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_LOONGSON3:
 #endif
 
-#if defined(CONFIG_SYS_HAS_CPU_LOONGSON1B) || \
+#if defined(CONFIG_SYS_HAS_CPU_LOONGSON1A) || \
+    defined(CONFIG_SYS_HAS_CPU_LOONGSON1B) || \
     defined(CONFIG_SYS_HAS_CPU_LOONGSON1C)
 	case CPU_LOONGSON1:
 #endif
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 657d65d..59ad3b7 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1503,7 +1503,9 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON1ABC:
-#ifdef CONFIG_CPU_LOONGSON1B
+#if defined(CONFIG_LOONGSON1_LS1A)
+			__cpu_name[cpu] = "Loongson 1A";
+#elif defined(CONFIG_CPU_LOONGSON1B)
 			__cpu_name[cpu] = "Loongson 1B";
 #endif
 			break;
diff --git a/arch/mips/loongson32/Platform b/arch/mips/loongson32/Platform
index ffe01c6..a9e0fa7 100644
--- a/arch/mips/loongson32/Platform
+++ b/arch/mips/loongson32/Platform
@@ -4,5 +4,6 @@ cflags-$(CONFIG_CPU_LOONGSON1)	+= \
 
 platform-$(CONFIG_MACH_LOONGSON32)	+= loongson32/
 cflags-$(CONFIG_MACH_LOONGSON32)	+= -I$(srctree)/arch/mips/include/asm/mach-loongson32
+load-$(CONFIG_LOONGSON1_LS1A)		+= 0xffffffff80200000
 load-$(CONFIG_LOONGSON1_LS1B)		+= 0xffffffff80100000
 load-$(CONFIG_LOONGSON1_LS1C)		+= 0xffffffff80100000
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index c8e8b3e..1c3324a 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -22,7 +22,9 @@ const char *get_system_type(void)
 
 	switch (processor_id & PRID_REV_MASK) {
 	case PRID_REV_LOONGSON1ABC:
-#if defined(CONFIG_LOONGSON1_LS1B)
+#if defined(CONFIG_LOONGSON1_LS1A)
+		return "LOONGSON LS1A";
+#elif defined(CONFIG_LOONGSON1_LS1B)
 		return "LOONGSON LS1B";
 #elif defined(CONFIG_LOONGSON1_LS1C)
 		return "LOONGSON LS1C";
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e7f798d..44c4088 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1366,6 +1366,16 @@ static void probe_pcache(void)
 		c->options |= MIPS_CPU_PREFETCH;
 		break;
 
+	case CPU_LOONGSON1:
+		if (read_c0_config7() & MIPS_CONF7_AR) {
+			/*
+			 * effectively physically indexed dcache,
+			 * thus no virtual aliases.
+			 */
+			c->dcache.flags |= MIPS_CACHE_PINDEX;
+			break;
+		}
+
 	default:
 		if (!(config & MIPS_CONF_M))
 			panic("Don't know how to probe P-caches on this cpu.");
-- 
2.9.3
