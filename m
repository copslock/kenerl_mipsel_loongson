Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 19:36:57 +0100 (CET)
Received: from [69.28.251.93] ([69.28.251.93]:33351 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492020Ab0KWSgu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 19:36:50 +0100
Received: (qmail 32277 invoked from network); 23 Nov 2010 18:36:47 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 23 Nov 2010 18:36:47 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Tue, 23 Nov 2010 10:36:47 -0800
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <alex@ozo.com>, <florian@openwrt.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] MIPS: Fix regression on BCM4710 processor detection
Date:   Tue, 23 Nov 2010 10:26:45 -0800
Message-Id: <e5a865920b2154408318972b62e92953@localhost>
In-Reply-To: <8a8eee995454c8b271cceb440e31699a@localhost>
References: <8a8eee995454c8b271cceb440e31699a@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

BCM4710 uses the BMIPS32 core (like BCM6345), not the MIPS 4Kc core as
was previously believed.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Tested-by: Alexandros C. Couloumbis <alex@ozo.com>
---
 arch/mips/include/asm/cpu.h  |    4 ++--
 arch/mips/kernel/cpu-probe.c |    7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 06d59dc..8687753 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -111,8 +111,8 @@
  * These are the PRID's for when 23:16 == PRID_COMP_BROADCOM
  */
 
-#define PRID_IMP_BMIPS4KC	0x4000
-#define PRID_IMP_BMIPS32	0x8000
+#define PRID_IMP_BMIPS32_REV4	0x4000
+#define PRID_IMP_BMIPS32_REV8	0x8000
 #define PRID_IMP_BMIPS3300	0x9000
 #define PRID_IMP_BMIPS3300_ALT	0x9100
 #define PRID_IMP_BMIPS3300_BUG	0x0000
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 71620e1..68dae7b 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -905,7 +905,8 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
 	switch (c->processor_id & 0xff00) {
-	case PRID_IMP_BMIPS32:
+	case PRID_IMP_BMIPS32_REV4:
+	case PRID_IMP_BMIPS32_REV8:
 		c->cputype = CPU_BMIPS32;
 		__cpu_name[cpu] = "Broadcom BMIPS32";
 		break;
@@ -933,10 +934,6 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 		__cpu_name[cpu] = "Broadcom BMIPS5000";
 		c->options |= MIPS_CPU_ULRI;
 		break;
-	case PRID_IMP_BMIPS4KC:
-		c->cputype = CPU_4KC;
-		__cpu_name[cpu] = "MIPS 4Kc";
-		break;
 	}
 }
 
-- 
1.7.0.4
