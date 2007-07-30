Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 01:38:22 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:22938 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022963AbXG3AiT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Jul 2007 01:38:19 +0100
Received: (qmail 21777 invoked by uid 511); 30 Jul 2007 00:41:57 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 30 Jul 2007 00:41:57 -0000
From:	Songmao Tian <tiansm@lemote.com>
To:	linux-mips@linux-mips.org
Cc:	Songmao Tian <tiansm@lemote.com>
Subject: [PATCH] [MIPS] Fix name conflict
Date:	Mon, 30 Jul 2007 08:37:07 +0800
Message-Id: <11857558271466-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.2
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

error: 'cpu_clock' redeclared as different kind of symbol
include/linux/sched.h:1356: error: previous declaration of 'cpu_clock' was here

Signed-off-by: Songmao Tian <tiansm@lemote.com>
---
 arch/mips/lemote/lm2e/prom.c          |    6 +++---
 arch/mips/lemote/lm2e/setup.c         |    4 ++--
 arch/mips/pmc-sierra/yosemite/prom.c  |    4 ++--
 arch/mips/pmc-sierra/yosemite/setup.c |    4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/lemote/lm2e/prom.c b/arch/mips/lemote/lm2e/prom.c
index 67312d7..535674e 100644
--- a/arch/mips/lemote/lm2e/prom.c
+++ b/arch/mips/lemote/lm2e/prom.c
@@ -23,7 +23,7 @@
 #include <asm/bootinfo.h>
 
 extern unsigned long bus_clock;
-extern unsigned long cpu_clock;
+extern unsigned long mips_cpu_clock;
 extern unsigned int memsize, highmemsize;
 extern int putDebugChar(unsigned char byte);
 
@@ -81,7 +81,7 @@ do {									\
 	l = (long)*env;
 	while (l != 0) {
 		parse_even_earlier(bus_clock, "busclock", l);
-		parse_even_earlier(cpu_clock, "cpuclock", l);
+		parse_even_earlier(mips_cpu_clock, "cpuclock", l);
 		parse_even_earlier(memsize, "memsize", l);
 		parse_even_earlier(highmemsize, "highmemsize", l);
 		env++;
@@ -91,7 +91,7 @@ do {									\
 		memsize = 256;
 
 	pr_info("busclock=%ld, cpuclock=%ld,memsize=%d,highmemsize=%d\n",
-	       bus_clock, cpu_clock, memsize, highmemsize);
+	       bus_clock, mips_cpu_clock, memsize, highmemsize);
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/lemote/lm2e/setup.c b/arch/mips/lemote/lm2e/setup.c
index 0e4d1fa..c043c9c 100644
--- a/arch/mips/lemote/lm2e/setup.c
+++ b/arch/mips/lemote/lm2e/setup.c
@@ -58,7 +58,7 @@ extern void mips_reboot_setup(void);
 #define PTR_PAD(p) (p)
 #endif
 
-unsigned long cpu_clock;
+unsigned long mips_cpu_clock;
 unsigned long bus_clock;
 unsigned int memsize;
 unsigned int highmemsize = 0;
@@ -71,7 +71,7 @@ void __init plat_timer_setup(struct irqaction *irq)
 static void __init loongson2e_time_init(void)
 {
 	/* setup mips r4k timer */
-	mips_hpt_frequency = cpu_clock / 2;
+	mips_hpt_frequency = mips_cpu_clock / 2;
 }
 
 static unsigned long __init mips_rtc_get_time(void)
diff --git a/arch/mips/pmc-sierra/yosemite/prom.c b/arch/mips/pmc-sierra/yosemite/prom.c
index 1e1685e..83628ba 100644
--- a/arch/mips/pmc-sierra/yosemite/prom.c
+++ b/arch/mips/pmc-sierra/yosemite/prom.c
@@ -34,7 +34,7 @@ extern void prom_grab_secondary(void);
 struct callvectors *debug_vectors;
 
 extern unsigned long yosemite_base;
-extern unsigned long cpu_clock;
+extern unsigned long mips_cpu_clock;
 
 const char *get_system_type(void)
 {
@@ -119,7 +119,7 @@ void __init prom_init(void)
 					  16);
 
 		if (strncmp("cpuclock", *env, strlen("cpuclock")) == 0)
-			cpu_clock =
+			mips_cpu_clock =
 			    simple_strtol(*env + strlen("cpuclock="), NULL,
 					  10);
 
diff --git a/arch/mips/pmc-sierra/yosemite/setup.c b/arch/mips/pmc-sierra/yosemite/setup.c
index f7f93ae..17fdb8d 100644
--- a/arch/mips/pmc-sierra/yosemite/setup.c
+++ b/arch/mips/pmc-sierra/yosemite/setup.c
@@ -59,7 +59,7 @@ unsigned char titan_ge_mac_addr_base[6] = {
 	0x00, 0xe0, 0x04, 0x00, 0x00, 0x21
 };
 
-unsigned long cpu_clock;
+unsigned long mips_cpu_clock;
 unsigned long yosemite_base;
 
 static struct m48t37_rtc *m48t37_base;
@@ -140,7 +140,7 @@ void __init plat_timer_setup(struct irqaction *irq)
 
 void yosemite_time_init(void)
 {
-	mips_hpt_frequency = cpu_clock / 2;
+	mips_hpt_frequency = mips_cpu_clock / 2;
 mips_hpt_frequency = 33000000 * 3 * 5;
 }
 
-- 
1.5.2.2
