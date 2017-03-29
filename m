Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2017 10:23:58 +0200 (CEST)
Received: from smtpbg202.qq.com ([184.105.206.29]:38519 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993612AbdC2IXuVZf4M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Mar 2017 10:23:50 +0200
X-QQ-mid: bizesmtp1t1490775806t2mx1o7fs
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 29 Mar 2017 16:23:10 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82000A0000000
X-QQ-FEAT: jLTfbrzLdoOJ4Ad1Xh6pD7l8BFqYglOi/MGRcz3v0BAe0EFoeh8SNAs8+wd3V
        Uxhx9xe2HAoC5u0QCkeST/pHZHKIuX/SNL7XMW2mLiCbUIDNKIq3oZB7f0NIM0zwGcvCY2x
        ygfh61K6NW0h1PdhNA0Ugok9dRE8k/tkxbPrioEMqgKED0vy0Z1aMQkkGNjFId66lR/wA6w
        7yxtTyiMsspvXZJiOFzAMo0DOb0tDuZoTQeWDvzv7NJrnPMh1aSdRyOSV/qnx8oJgQXQvX7
        Vt/cNtbKMrnvoUDy9yFUgvPlbkxtSYaaa5ZA==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 1/8] MIPS: Loongson: Add Loongson-3A R3 basic support
Date:   Wed, 29 Mar 2017 16:24:29 +0800
Message-Id: <1490775876-29918-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1490775876-29918-1-git-send-email-chenhc@lemote.com>
References: <1490775876-29918-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57459
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
index e57e685..1c94d4d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1822,6 +1822,12 @@ static inline void cpu_probe_loongson(struct cpuinfo_mips *c, unsigned int cpu)
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
index 6afa218..4707abf 100644
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
index 64659fc..1629743 100644
--- a/arch/mips/loongson64/loongson-3/smp.c
+++ b/arch/mips/loongson64/loongson-3/smp.c
@@ -503,7 +503,7 @@ static void loongson3a_r1_play_dead(int *state_addr)
 		: "a1");
 }
 
-static void loongson3a_r2_play_dead(int *state_addr)
+static void loongson3a_r2r3_play_dead(int *state_addr)
 {
 	register int val;
 	register long cpuid, core, node, count;
@@ -664,8 +664,9 @@ void play_dead(void)
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
