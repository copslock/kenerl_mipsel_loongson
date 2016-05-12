Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 11:11:18 +0200 (CEST)
Received: from smtpbg64.qq.com ([103.7.28.238]:42887 "EHLO smtpbg64.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029236AbcELJLQ13M-T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2016 11:11:16 +0200
X-QQ-mid: esmtp20t1463044232t423t03571
Received: from localhost (unknown [180.109.228.28])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 12 May 2016 17:10:31 +0800 (CST)
X-QQ-SSF: 01000000000000F0F9200000002000P
X-QQ-FEAT: tZ7SKDDlSpGK31jJyr/zrsxPZGsVVD6iBkaAYz/cAHt0UyhqdnX/vpdNNAiGX
        +ewE1YNsf0lmz5m36NzxnUGmIIfddLdXIC/lqtfVQmIT3bUudV9WQOoV0EVK7KXIBeQoDmW
        We8VCCq9OBRRedZ8WHubQ5dqF1BZRYXIlxQFClRwuHhE0PDdPZlLYpl+CRNMePR5vYIB1tx
        o+JheUzfxm7k/cen+ZiocmE5sJaH5SVEuNdRaA0OfDJAzGOqWncyIM07dFl5GQwY=
X-QQ-GoodBg: 0
X-QQ-CSender: 842587420@qq.com
From:   Yang Ling <gnaygnil@gmail.com>
To:     ralf@linux-mips.org, kumba@gentoo.org
Cc:     paul.burton@imgtec.com, markos.chandras@imgtec.com,
        james.hogan@imgtec.com, macro@imgtec.com, david.daney@cavium.com,
        gnaygnil@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] MIPS: Add CPU support for Loongson1C
Date:   Thu, 12 May 2016 17:10:30 +0800
Message-Id: <1463044230-21887-1-git-send-email-gnaygnil@gmail.com>
X-Mailer: git-send-email 1.9.1
X-QQ-SENDSIZE: 520
Return-Path: <842587420@qq.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

Loongson 1C is a 32-bit SoC designed by Loongson Technology Co., Ltd,
with many features similar to Loongson 1B.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/include/asm/cpu-type.h | 3 ++-
 arch/mips/include/asm/cpu.h      | 1 +
 arch/mips/kernel/cpu-probe.c     | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index fbe1881..bdd6dc1 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -24,7 +24,8 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_LOONGSON3:
 #endif
 
-#ifdef CONFIG_SYS_HAS_CPU_LOONGSON1B
+#if defined(CONFIG_SYS_HAS_CPU_LOONGSON1B) || \
+    defined(CONFIG_SYS_HAS_CPU_LOONGSON1C)
 	case CPU_LOONGSON1:
 #endif
 
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index a7a9185..f70517d 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -239,6 +239,7 @@
 #define PRID_REV_VR4130		0x0080
 #define PRID_REV_34K_V1_0_2	0x0022
 #define PRID_REV_LOONGSON1B	0x0020
+#define PRID_REV_LOONGSON1C	0x0020	/* Same as Loongson-1B */
 #define PRID_REV_LOONGSON2E	0x0002
 #define PRID_REV_LOONGSON2F	0x0003
 #define PRID_REV_LOONGSON3A	0x0005
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 785e9a1..7cf7a42 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -1203,7 +1203,11 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 
 		switch (c->processor_id & PRID_REV_MASK) {
 		case PRID_REV_LOONGSON1B:
+#if defined(CONFIG_LOONGSON1_LS1B)
 			__cpu_name[cpu] = "Loongson 1B";
+#elif defined(CONFIG_LOONGSON1_LS1C)
+			__cpu_name[cpu] = "Loongson 1C";
+#endif
 			break;
 		}
 
-- 
1.9.1
