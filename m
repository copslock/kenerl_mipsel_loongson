Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 20:22:23 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36394 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815746Ab3FDSWV25xS0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 20:22:21 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1Ujvs5-0006II-Cw; Tue, 04 Jun 2013 13:22:13 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH] MIPS: micromips: Fix improper definition of ISA exception bit.
Date:   Tue,  4 Jun 2013 13:22:07 -0500
Message-Id: <1370370127-19681-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

The ISA exception bit selects whether exceptions are taken in classic
MIPS or microMIPS mode. This bit is Config3.ISAOnExc and is bit 16. It
It was improperly defined as bits 16 and 17. Fortunately, bit 17 is
read-only and did not effect microMIPS operation. However, detecting
a classic or microMIPS kernel when examining the /proc/cpuinfo file,
the result always showed a microMIPS kernel.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h |    2 +-
 arch/mips/kernel/cpu-probe.c     |   11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 87e6207..fed1c3e 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -596,7 +596,7 @@
 #define MIPS_CONF3_RXI		(_ULCAST_(1) << 12)
 #define MIPS_CONF3_ULRI		(_ULCAST_(1) << 13)
 #define MIPS_CONF3_ISA		(_ULCAST_(3) << 14)
-#define MIPS_CONF3_ISA_OE	(_ULCAST_(3) << 16)
+#define MIPS_CONF3_ISA_OE	(_ULCAST_(1) << 16)
 #define MIPS_CONF3_VZ		(_ULCAST_(1) << 23)
 
 #define MIPS_CONF4_MMUSIZEEXT	(_ULCAST_(255) << 0)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c6568bf..822bfe4 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -256,6 +256,12 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->ases |= MIPS_ASE_SMARTMIPS;
 		c->options |= MIPS_CPU_RIXI;
 	}
+	if (config3 & MIPS_CONF3_ISA) {
+		c->options |= MIPS_CPU_MICROMIPS;
+#ifdef CONFIG_CPU_MICROMIPS
+		write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
+#endif
+	}
 	if (config3 & MIPS_CONF3_RXI)
 		c->options |= MIPS_CPU_RIXI;
 	if (config3 & MIPS_CONF3_DSP)
@@ -270,11 +276,6 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->ases |= MIPS_ASE_MIPSMT;
 	if (config3 & MIPS_CONF3_ULRI)
 		c->options |= MIPS_CPU_ULRI;
-	if (config3 & MIPS_CONF3_ISA)
-		c->options |= MIPS_CPU_MICROMIPS;
-#ifdef CONFIG_CPU_MICROMIPS
-	write_c0_config3(read_c0_config3() | MIPS_CONF3_ISA_OE);
-#endif
 	if (config3 & MIPS_CONF3_VZ)
 		c->ases |= MIPS_ASE_VZ;
 
-- 
1.7.2.5
