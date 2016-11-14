Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 04:13:47 +0100 (CET)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:40869 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992121AbcKNDNW0zWFm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Nov 2016 04:13:22 +0100
X-QQ-mid: bizesmtp1t1479093172t8e6o4851
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 14 Nov 2016 11:12:26 +0800 (CST)
X-QQ-SSF: 01100000002000F0FJ72000A0000000
X-QQ-FEAT: r8geFCKg7nZzrvPvjblf1FumiakPHgS8l83c7CB7nc4yATV/gpUSyVkBvLQmC
        4Ob/SA7qm84fspM/qPOr+oPXnc4pzkELMiufjP96GZ023TDDgb5X38ZInNA9WLUOhX+CN47
        LRFqMtvaxdKoUFSnvsdofAzlnp37pWoJncfahvLVii4Ed/icbGiYOnSpLx3Ws7Setu+v4Gd
        j92wfZquFQpERXO3UHnSelOe+O5XQexnuksrz64hQjAMz0emOW+sln+A7P09MlPA5ls1EzP
        c7TWfRK2UkwYJ8F3axFES34a4=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 1/7] MIPS: Loongson: Add Loongson-3A R3 basic support
Date:   Mon, 14 Nov 2016 11:12:39 +0800
Message-Id: <1479093165-625-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1479093165-625-1-git-send-email-chenhc@lemote.com>
References: <1479093165-625-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55810
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

Loongson-3A R3 is very similar to Loongson-3A R2.

All Loongson-3 CPU family:

Code-name       Brand-name       PRId
Loongson-3A R1  Loongson-3A1000  0x6305
Loongson-3A R2  Loongson-3A2000  0x6308
Loongson-3A R3  Loongson-3A3000  0x6309
Loongson-3B R1  Loongson-3B1000  0x6306
Loongson-3B R2  Loongson-3B1500  0x6307

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/cpu.h           |  1 +
 arch/mips/kernel/cpu-probe.c          |  6 ++++++
 arch/mips/loongson64/common/env.c     |  1 +
 arch/mips/loongson64/loongson-3/smp.c |  5 +++--
 drivers/platform/mips/cpu_hwmon.c     | 17 +++++++++++++----
 5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 9a83724..255ead7 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -247,6 +247,7 @@
 #define PRID_REV_LOONGSON3B_R1	0x0006
 #define PRID_REV_LOONGSON3B_R2	0x0007
 #define PRID_REV_LOONGSON3A_R2	0x0008
+#define PRID_REV_LOONGSON3A_R3	0x0009
 
 /*
  * Older processors used to encode processor version and revision in two
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index dd31754..3432c83 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1821,6 +1821,12 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
 			set_elf_platform(cpu, "loongson3a");
 			set_isa(c, MIPS_CPU_ISA_M64R2);
 			break;
+		case PRID_REV_LOONGSON3A_R3:
+			c->cputype = CPU_LOONGSON3;
+			__cpu_name[cpu] = "ICT Loongson-3";
+			set_elf_platform(cpu, "loongson3a");
+			set_isa(c, MIPS_CPU_ISA_M64R2);
+			break;
 		}
 
 		decode_configs(c);
diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/common/env.c
index 57d590a..98307c2 100644
--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -193,6 +193,7 @@ void __init prom_init_env(void)
 			break;
 		case PRID_REV_LOONGSON3A_R1:
 		case PRID_REV_LOONGSON3A_R2:
+		case PRID_REV_LOONGSON3A_R3:
 			cpu_clock_freq = 900000000;
 			break;
 		case PRID_REV_LOONGSON3B_R1:
diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64/loongson-3/smp.c
index 99aab9f..4db1798 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -502,7 +502,7 @@ static void loongson3a_r1_play_dead(int *state_addr)
 		: "a1");
 }
 
-static void loongson3a_r2_play_dead(int *state_addr)
+static void loongson3a_r2r3_play_dead(int *state_addr)
 {
 	register int val;
 	register long cpuid, core, node, count;
@@ -663,8 +663,9 @@ void play_dead(void)
 			(void *)CKSEG1ADDR((unsigned long)loongson3a_r1_play_dead);
 		break;
 	case PRID_REV_LOONGSON3A_R2:
+	case PRID_REV_LOONGSON3A_R3:
 		play_dead_at_ckseg1 =
-			(void *)CKSEG1ADDR((unsigned long)loongson3a_r2_play_dead);
+			(void *)CKSEG1ADDR((unsigned long)loongson3a_r2r3_play_dead);
 		break;
 	case PRID_REV_LOONGSON3B_R1:
 	case PRID_REV_LOONGSON3B_R2:
diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
index 4300a55..46ab7d86 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -17,14 +17,23 @@
  */
 int loongson3_cpu_temp(int cpu)
 {
-	u32 reg;
+	u32 reg, prid_rev;
 
 	reg = LOONGSON_CHIPTEMP(cpu);
-	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1)
+	prid_rev = read_c0_prid() & PRID_REV_MASK;
+	switch (prid_rev) {
+	case PRID_REV_LOONGSON3A_R1:
 		reg = (reg >> 8) & 0xff;
-	else
+		break;
+	case PRID_REV_LOONGSON3A_R2:
+	case PRID_REV_LOONGSON3B_R1:
+	case PRID_REV_LOONGSON3B_R2:
 		reg = ((reg >> 8) & 0xff) - 100;
-
+		break;
+	case PRID_REV_LOONGSON3A_R3:
+		reg = (reg & 0xffff)*731/0x4000 - 273;
+		break;
+	}
 	return (int)reg * 1000;
 }
 
-- 
2.7.0
