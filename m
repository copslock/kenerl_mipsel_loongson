Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jun 2013 00:25:37 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39343 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827529Ab3FEWZ220jEO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jun 2013 00:25:28 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UkM8v-0000eC-9W; Wed, 05 Jun 2013 17:25:21 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH v8] MIPS: micromips: Fix improper definition of ISA exception bit.
Date:   Wed,  5 Jun 2013 17:25:17 -0500
Message-Id: <1370471117-21794-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36715
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
or microMIPS mode. This bit is Config3.ISAOnExc and was improperly
defined as bits 16 and 17 instead of just bit 16. A new function was
added so that platforms could set this bit when running a kernel
compiled with only microMIPS instructions.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
Changes from v7:
* Move all code functionality into 'trap_init'.

 arch/mips/include/asm/mipsregs.h |    2 +-
 arch/mips/kernel/cpu-probe.c     |    3 ---
 arch/mips/kernel/traps.c         |    9 +++++++++
 3 files changed, 10 insertions(+), 4 deletions(-)

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
index c6568bf..b0d04a2 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -272,9 +272,6 @@ static inline unsigned int decode_config3(struct cpuinfo_mips *c)
 		c->options |= MIPS_CPU_ULRI;
 	if (config3 & MIPS_CONF3_ISA)
 		c->options |= MIPS_CPU_MICROMIPS;
-#ifdef CONFIG_CPU_MICROMIPS
-	write_c0_config3(read_c0_config3() | MIPS_CONF3_ISA_OE);
-#endif
 	if (config3 & MIPS_CONF3_VZ)
 		c->ases |= MIPS_ASE_VZ;
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index a75ae40..6b398f9 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1837,6 +1837,15 @@ void __init trap_init(void)
 			ebase += (read_c0_ebase() & 0x3ffff000);
 	}
 
+	if (cpu_has_mmips) {
+		unsigned int config3 = read_c0_config3();
+
+		if (IS_ENABLED(CONFIG_CPU_MICROMIPS))
+			write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
+		else
+			write_c0_config3(config3 & ~MIPS_CONF3_ISA_OE);
+	}
+
 	if (board_ebase_setup)
 		board_ebase_setup();
 	per_cpu_trap_init(true);
-- 
1.7.2.5
