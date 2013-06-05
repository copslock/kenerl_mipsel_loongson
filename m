Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 20:05:47 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:38861 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6820116Ab3FESFmGAo9v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 20:05:42 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UkI5V-0000Jk-1S; Wed, 05 Jun 2013 13:05:33 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org,
        ddaney.cavm@gmail.com
Subject: [PATCH v4] MIPS: micromips: Fix improper definition of ISA exception bit.
Date:   Wed,  5 Jun 2013 13:05:29 -0500
Message-Id: <1370455529-19621-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36697
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
Changes in v4:
* Removed code from 'cpu-probe.c' and added new inline function to
  set exception mode.
* Reworded and simplified commit message.

 arch/mips/include/asm/mipsregs.h |   17 ++++++++++++++++-
 arch/mips/kernel/cpu-probe.c     |    3 ---
 arch/mips/mti-malta/malta-init.c |    2 ++
 arch/mips/mti-sead3/sead3-init.c |    2 ++
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 87e6207..434fd26 100644
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
@@ -1161,6 +1161,21 @@ do {									\
 #define write_c0_brcm_sleepcount(val)	__write_32bit_c0_register($22, 7, val)
 
 /*
+ * Set exceptions to be taken in microMIPS mode only.
+ */
+#ifdef CONFIG_CPU_MICROMIPS
+static inline void set_micromips_exception_mode(void)
+{
+	unsigned int config3 = read_c0_config3();
+
+	if (config3 & MIPS_CONF3_ISA)
+		write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
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
 
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index ff8caff..76e0205 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -106,6 +106,8 @@ extern struct plat_smp_ops msmtc_smp_ops;
 
 void __init prom_init(void)
 {
+	set_micromips_exception_mode();
+
 	mips_display_message("LINUX");
 
 	/*
diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
index bfbd17b..9e314cb 100644
--- a/arch/mips/mti-sead3/sead3-init.c
+++ b/arch/mips/mti-sead3/sead3-init.c
@@ -130,6 +130,8 @@ static void __init mips_ejtag_setup(void)
 
 void __init prom_init(void)
 {
+	set_micromips_exception_mode();
+
 	board_nmi_handler_setup = mips_nmi_setup;
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
-- 
1.7.2.5
