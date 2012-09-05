Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2012 22:28:42 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:56493 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903405Ab2IEU2N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2012 22:28:13 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1T9MCl-0004QI-7w; Wed, 05 Sep 2012 15:28:07 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 1/4] MIPS: Add base architecture support for RI and XI.
Date:   Wed,  5 Sep 2012 15:27:55 -0500
Message-Id: <1346876878-25965-2-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346876878-25965-1-git-send-email-sjhill@mips.com>
References: <1346876878-25965-1-git-send-email-sjhill@mips.com>
X-archive-position: 34419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Originally both Read Inhibit (RI) and Execute Inhibit (XI) were
supported by the TLB only for a SmartMIPS core. The MIPSr3(TM)
Architecture now defines an optional feature to implement these
TLB bits separately. Support for one or both features can be
checked by looking at the Config3.RXI bit.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cpu-features.h |    6 ++++++
 arch/mips/include/asm/cpu.h          |    2 ++
 arch/mips/include/asm/mipsregs.h     |    1 +
 arch/mips/kernel/cpu-probe.c         |   12 +++++++++++-
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 080edd8..c78a77b 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -98,6 +98,12 @@
 #ifndef kernel_uses_smartmips_rixi
 #define kernel_uses_smartmips_rixi 0
 #endif
+#ifndef cpu_has_ri
+#define cpu_has_ri		(cpu_data[0].options & MIPS_CPU_RI)
+#endif 
+#ifndef cpu_has_xi
+#define cpu_has_xi		(cpu_data[0].options & MIPS_CPU_XI)
+#endif
 #ifndef cpu_has_mmips
 #define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 4889fae..1b928ed 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -323,6 +323,8 @@ enum cpu_type_enum {
 #define MIPS_CPU_VEIC		0x00100000 /* CPU supports MIPSR2 external interrupt controller mode */
 #define MIPS_CPU_ULRI		0x00200000 /* CPU has ULRI feature */
 #define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
+#define MIPS_CPU_RI		0x02000000 /* CPU has TLB Read Inhibit */
+#define MIPS_CPU_XI		0x04000000 /* CPU has TLB Execute Inhibit */
 
 /*
  * CPU ASE encodings
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index cdb9c87..19430fb 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -591,6 +591,7 @@
 #define MIPS_CONF3_LPA		(_ULCAST_(1) <<  7)
 #define MIPS_CONF3_DSP		(_ULCAST_(1) << 10)
 #define MIPS_CONF3_DSP2P	(_ULCAST_(1) << 11)
+#define MIPS_CONF3_RXI		(_ULCAST_(1) << 12)
 #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
 #define MIPS_CONF3_ISA		(_ULCAST_(3) << 14)
 #define MIPS_CONF3_ISA_OE	(_ULCAST_(1) << 16)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 009fc13..e85d732 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -422,8 +422,18 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 
 	config3 = read_c0_config3();
 
-	if (config3 & MIPS_CONF3_SM)
+	if (config3 & MIPS_CONF3_SM) {
 		c->ases |= MIPS_ASE_SMARTMIPS;
+		c->options |= MIPS_CPU_RI;
+		c->options |= MIPS_CPU_XI;
+	}
+	if (config3 & MIPS_CONF3_RXI) {
+		write_c0_pagegrain(read_c0_pagegrain() | PG_RIE | PG_XIE);
+		if (read_c0_pagegrain() & PG_RIE)
+			c->options |= MIPS_CPU_RI;
+		if (read_c0_pagegrain() & PG_XIE)
+			c->options |= MIPS_CPU_XI;
+	}
 	if (config3 & MIPS_CONF3_DSP)
 		c->ases |= MIPS_ASE_DSP;
 	if (config3 & MIPS_CONF3_DSP2P)
-- 
1.7.9.5
