Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2016 16:51:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44164 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008125AbcC2OvIT4gA5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2016 16:51:08 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 24AB54C9494CA;
        Tue, 29 Mar 2016 15:50:59 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 15:51:02 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 29 Mar 2016 15:51:01 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <Zubair.Kakakhel@imgtec.com>, <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Detect DSP v3 support
Date:   Tue, 29 Mar 2016 15:50:25 +0100
Message-ID: <1459263025-9433-1-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

DSPv3 is supported on all MIPSr6 systems which indicate support for DSPv2.

This doesn't require any changes to the kernel's handling of DSP
resources. The patch is to detect support and indicate it in /proc/cpuinfo

DSP v3 introduces a new instruction BPOSGE32C

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>

---

Based on v4.6-rc1
---
 arch/mips/include/asm/cpu-features.h | 4 ++++
 arch/mips/include/asm/cpu.h          | 1 +
 arch/mips/kernel/cpu-probe.c         | 5 ++++-
 arch/mips/kernel/proc.c              | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index eeec8c8..0671f29 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -307,6 +307,10 @@
 #define cpu_has_dsp2		(cpu_data[0].ases & MIPS_ASE_DSP2P)
 #endif
 
+#ifndef cpu_has_dsp3
+#define cpu_has_dsp3		(cpu_data[0].ases & MIPS_ASE_DSP3)
+#endif
+
 #ifndef cpu_has_mipsmt
 #define cpu_has_mipsmt		(cpu_data[0].ases & MIPS_ASE_MIPSMT)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index a97ca97..e699b23 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -401,5 +401,6 @@ enum cpu_type_enum {
 #define MIPS_ASE_DSP2P		0x00000040 /* Signal Processing ASE Rev 2 */
 #define MIPS_ASE_VZ		0x00000080 /* Virtualization ASE */
 #define MIPS_ASE_MSA		0x00000100 /* MIPS SIMD Architecture */
+#define MIPS_ASE_DSP3		0x00000200 /* Signal Processing ASE Rev 3*/
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b725b71..da0f3be 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -679,8 +679,11 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_RIXI;
 	if (config3 & MIPS_CONF3_DSP)
 		c->ases |= MIPS_ASE_DSP;
-	if (config3 & MIPS_CONF3_DSP2P)
+	if (config3 & MIPS_CONF3_DSP2P) {
 		c->ases |= MIPS_ASE_DSP2P;
+		if (cpu_has_mips_r6)
+			c->ases |= MIPS_ASE_DSP3;
+	}
 	if (config3 & MIPS_CONF3_VINT)
 		c->options |= MIPS_CPU_VINT;
 	if (config3 & MIPS_CONF3_VEIC)
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 298b2b7..97dc01b 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -114,6 +114,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (cpu_has_smartmips)	seq_printf(m, "%s", " smartmips");
 	if (cpu_has_dsp)	seq_printf(m, "%s", " dsp");
 	if (cpu_has_dsp2)	seq_printf(m, "%s", " dsp2");
+	if (cpu_has_dsp3)	seq_printf(m, "%s", " dsp3");
 	if (cpu_has_mipsmt)	seq_printf(m, "%s", " mt");
 	if (cpu_has_mmips)	seq_printf(m, "%s", " micromips");
 	if (cpu_has_vz)		seq_printf(m, "%s", " vz");
-- 
1.9.1
