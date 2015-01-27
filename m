Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2015 22:17:42 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40210 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011890AbbA0VR0B0-lP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2015 22:17:26 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 11F734715B50A;
        Tue, 27 Jan 2015 21:17:15 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 27 Jan 2015 21:17:18 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 27 Jan 2015 21:17:16 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 1/3] MIPS: Add arch CDMM definitions and probing
Date:   Tue, 27 Jan 2015 21:16:39 +0000
Message-ID: <1422393401-13543-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1422393401-13543-1-git-send-email-james.hogan@imgtec.com>
References: <1422393401-13543-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Add architectural definitions and probing for the MIPS Common Device
Mapped Memory (CDMM) region. When supported and enabled at a particular
physical address, this region allows some number of per-CPU devices to
be discovered and controlled via MMIO.

A bit exists in Config3 to determine whether the feature is present, and
a CDMMBase CP0 register allows the region to be enabled at a particular
physical address.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/cpu-features.h |  4 ++++
 arch/mips/include/asm/cpu.h          |  1 +
 arch/mips/include/asm/mipsregs.h     | 11 +++++++++++
 arch/mips/kernel/cpu-probe.c         |  2 ++
 4 files changed, 18 insertions(+)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 2897cfafcaf0..83e9db058a72 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -348,4 +348,8 @@
 # define cpu_has_fre		(cpu_data[0].options & MIPS_CPU_FRE)
 #endif
 
+#ifndef cpu_has_cdmm
+# define cpu_has_cdmm		(cpu_data[0].options & MIPS_CPU_CDMM)
+#endif
+
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 33866fce4d63..2086372fa72a 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -370,6 +370,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_RIXIEX		0x200000000ull /* CPU has unique exception codes for {Read, Execute}-Inhibit exceptions */
 #define MIPS_CPU_MAAR		0x400000000ull /* MAAR(I) registers are present */
 #define MIPS_CPU_FRE		0x800000000ull /* FRE & UFE bits implemented */
+#define MIPS_CPU_CDMM		0x10000000000ll /* CPU has Common Device Memory Map */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 5e4aef304b02..2969ceaecfd3 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -750,6 +750,14 @@
 #define MIPS_PWCTL_PSN_SHIFT	0
 #define MIPS_PWCTL_PSN_MASK	0x0000003f
 
+/* CDMMBase register bit definitions */
+#define MIPS_CDMMBASE_SIZE_SHIFT 0
+#define MIPS_CDMMBASE_SIZE	(_ULCAST_(511) << MIPS_CDMMBASE_SIZE_SHIFT)
+#define MIPS_CDMMBASE_CI	(_ULCAST_(1) << 9)
+#define MIPS_CDMMBASE_EN	(_ULCAST_(1) << 10)
+#define MIPS_CDMMBASE_ADDR_SHIFT 11
+#define MIPS_CDMMBASE_ADDR_START 15
+
 #ifndef __ASSEMBLY__
 
 /*
@@ -1279,6 +1287,9 @@ do {									\
 #define read_c0_ebase()		__read_32bit_c0_register($15, 1)
 #define write_c0_ebase(val)	__write_32bit_c0_register($15, 1, val)
 
+#define read_c0_cdmmbase()	__read_ulong_c0_register($15, 2)
+#define write_c0_cdmmbase(val)	__write_ulong_c0_register($15, 2, val)
+
 /* MIPSR3 */
 #define read_c0_segctl0()	__read_32bit_c0_register($5, 2)
 #define write_c0_segctl0(val)	__write_32bit_c0_register($5, 2, val)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5342674842f5..2eabcc023ed4 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -426,6 +426,8 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 	/* Only tested on 32-bit cores */
 	if ((config3 & MIPS_CONF3_PW) && config_enabled(CONFIG_32BIT))
 		c->options |= MIPS_CPU_HTW;
+	if (config3 & MIPS_CONF3_CDMM)
+		c->options |= MIPS_CPU_CDMM;
 
 	return config3 & MIPS_CONF_M;
 }
-- 
2.0.5
