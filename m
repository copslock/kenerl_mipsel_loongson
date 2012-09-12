Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2012 19:02:13 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:33960 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903346Ab2ILRCF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2012 19:02:05 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TBqK7-0003K9-Jf; Wed, 12 Sep 2012 12:01:59 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 1/2] MIPS: Add base architecture support for RI and XI.
Date:   Wed, 12 Sep 2012 12:01:48 -0500
Message-Id: <1347469309-11468-2-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1347469309-11468-1-git-send-email-sjhill@mips.com>
References: <1347469309-11468-1-git-send-email-sjhill@mips.com>
X-archive-position: 34479
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
 arch/mips/include/asm/cpu-features.h |    3 +++
 arch/mips/include/asm/cpu.h          |    1 +
 arch/mips/include/asm/mipsregs.h     |    1 +
 arch/mips/kernel/cpu-probe.c         |    6 +++++-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index bba9398..232cb1e 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -95,6 +95,9 @@
 #ifndef cpu_has_smartmips
 #define cpu_has_smartmips      (cpu_data[0].ases & MIPS_ASE_SMARTMIPS)
 #endif
+#ifndef cpu_has_rixi
+#define cpu_has_rixi		(cpu_data[0].options & MIPS_CPU_RIXI)
+#endif
 #ifndef kernel_uses_smartmips_rixi
 #define kernel_uses_smartmips_rixi 0
 #endif
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 4889fae..f3150f6 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -323,6 +323,7 @@ enum cpu_type_enum {
 #define MIPS_CPU_VEIC		0x00100000 /* CPU supports MIPSR2 external interrupt controller mode */
 #define MIPS_CPU_ULRI		0x00200000 /* CPU has ULRI feature */
 #define MIPS_CPU_MICROMIPS	0x01000000 /* CPU has microMIPS capability */
+#define MIPS_CPU_RIXI		0x02000000 /* CPU has TLB Read/eXec Inhibit */
 
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
index 009fc13..b63732c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -422,8 +422,12 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 
 	config3 = read_c0_config3();
 
-	if (config3 & MIPS_CONF3_SM)
+	if (config3 & MIPS_CONF3_SM) {
 		c->ases |= MIPS_ASE_SMARTMIPS;
+		c->options |= MIPS_CPU_RIXI;
+	}
+	if (config3 & MIPS_CONF3_RXI)
+		c->options |= MIPS_CPU_RIXI;
 	if (config3 & MIPS_CONF3_DSP)
 		c->ases |= MIPS_ASE_DSP;
 	if (config3 & MIPS_CONF3_DSP2P)
-- 
1.7.9.5
