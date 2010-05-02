Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 May 2010 23:53:48 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:54971 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492384Ab0EBVxp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 2 May 2010 23:53:45 +0200
Received: (qmail 8059 invoked from network); 2 May 2010 21:53:41 -0000
Received: from unknown (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by 127.0.0.1 with (DHE-RSA-AES128-SHA encrypted) SMTP; 2 May 2010 21:53:41 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sun, 02 May 2010 14:53:41 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Date:   Sun, 2 May 2010 14:43:52 -0700
Subject: [PATCH] MIPS: nofpu and nodsp only affect CPU0
Message-Id: <0b6db1ee1efbe0daa1320b59ab5093ba5af377b8@localhost.localdomain>
User-Agent: vim 7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

The "nofpu" and "nodsp" kernel command line options currently do not
affect CPUs that are brought online later in the boot process or
hotplugged at runtime.  It is desirable to apply the nofpu/nodsp options
to all CPUs in the system, so that surprising results are not seen when
a process migrates from one CPU to another.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/cpu-info.h |    2 ++
 arch/mips/kernel/cpu-probe.c     |    6 ++++++
 arch/mips/kernel/setup.c         |   11 +++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index b39def3..55b156b 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -84,6 +84,8 @@ extern struct cpuinfo_mips cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
 #define raw_current_cpu_data cpu_data[raw_smp_processor_id()]
 
+extern int mips_fpu_disabled, mips_dsp_disabled;
+
 extern void cpu_probe(void);
 extern void cpu_report(void);
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index be5bb16..baba603 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -982,6 +982,12 @@ __cpuinit void cpu_probe(void)
 	 */
 	BUG_ON(current_cpu_type() != c->cputype);
 
+	if (mips_fpu_disabled)
+		c->options &= ~MIPS_CPU_FPU;
+
+	if (mips_dsp_disabled)
+		c->ases &= ~MIPS_ASE_DSP;
+
 	if (c->options & MIPS_CPU_FPU) {
 		c->fpu_id = cpu_get_fpu_id();
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f9513f9..1664dc2 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -569,21 +569,24 @@ void __init setup_arch(char **cmdline_p)
 	plat_smp_setup();
 }
 
+int __cpuinitdata mips_fpu_disabled;
+
 static int __init fpu_disable(char *s)
 {
-	int i;
-
-	for (i = 0; i < NR_CPUS; i++)
-		cpu_data[i].options &= ~MIPS_CPU_FPU;
+	cpu_data[0].options &= ~MIPS_CPU_FPU;
+	mips_fpu_disabled = 1;
 
 	return 1;
 }
 
 __setup("nofpu", fpu_disable);
 
+int __cpuinitdata mips_dsp_disabled;
+
 static int __init dsp_disable(char *s)
 {
 	cpu_data[0].ases &= ~MIPS_ASE_DSP;
+	mips_dsp_disabled = 1;
 
 	return 1;
 }
-- 
1.6.3.1
