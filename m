Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 21:46:35 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39041 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827529Ab3FETqakOfEH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 21:46:30 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UkJf4-0000RN-Rn; Wed, 05 Jun 2013 14:46:22 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
Subject: [PATCH v5] MIPS: micromips: Fix improper definition of ISA exception bit.
Date:   Wed,  5 Jun 2013 14:46:18 -0500
Message-Id: <1370461579-20177-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36702
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
Acked-by: David Daney <david.daney@cavium.com>
---
Changes in v5:
* Call 'set_micromips_exception_mode' from 'traps_init' instead of being
  in platform-specific code.
* Update 'set_micromips_exception_mode' function to set or clear the
  Config3.ISAOnExc depending on the binary type of the kernel.

 arch/mips/include/asm/mipsregs.h |   20 +++++++++++++++++++-
 arch/mips/kernel/cpu-probe.c     |    3 ---
 arch/mips/kernel/traps.c         |    5 +++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 87e6207..52ade03 100644
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
@@ -1161,6 +1161,24 @@ do {									\
 #define write_c0_brcm_sleepcount(val)	__write_32bit_c0_register($22, 7, val)
 
 /*
+ * Set exceptions to be taken in microMIPS mode only, otherwise
+ * set for classic exceptions.
+ */
+#ifdef CONFIG_CPU_MICROMIPS
+static inline void set_micromips_exception_mode(void)
+{
+	unsigned int config3 = read_c0_config3();
+
+	if (config3 & MIPS_CONF3_ISA)
+		write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
+	else
+		write_c0_config3(config3 & ~MIPS_CONF3_ISA_OE);
+}
+#else
+static inline void set_micromips_exception_mode(void) {}
+#endif 
+
+/*
  * Macros to access the floating point coprocessor control registers
  */
 #define read_32bit_cp1_register(source)					\
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
index a75ae40..151ed59 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1837,6 +1837,11 @@ void __init trap_init(void)
 			ebase += (read_c0_ebase() & 0x3ffff000);
 	}
 
+	/*
+	 * Set microMIPS exceptions for platforms that support it.
+	 */
+	set_micromips_exception_mode();
+
 	if (board_ebase_setup)
 		board_ebase_setup();
 	per_cpu_trap_init(true);
-- 
1.7.2.5
