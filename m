Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 08:07:31 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:64905 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20184153AbYIWHHY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Sep 2008 08:07:24 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 3F2C7321569
	for <linux-mips@linux-mips.org>; Tue, 23 Sep 2008 07:07:21 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Tue, 23 Sep 2008 07:07:21 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.229]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 23 Sep 2008 00:07:17 -0700
Message-ID: <48D895A4.3090403@avtrex.com>
Date:	Tue, 23 Sep 2008 00:07:16 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [Patch 3/6] MIPS: Probe watch registers and report configuration.
References: <48D89470.5090404@avtrex.com>
In-Reply-To: <48D89470.5090404@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2008 07:07:17.0134 (UTC) FILETIME=[034472E0:01C91D4B]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips


Probe for watch register characteristics, and report them in /proc/cpuinfo.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 arch/mips/kernel/cpu-probe.c |    2 ++
 arch/mips/kernel/proc.c      |    9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 335a6ae..d0d07b8 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -21,6 +21,7 @@
 #include <asm/fpu.h>
 #include <asm/mipsregs.h>
 #include <asm/system.h>
+#include <asm/watch.h>
 
 /*
  * Not all of the MIPS CPUs have the "wait" instruction available. Moreover,
@@ -685,6 +686,7 @@ static inline void spram_config(void) {}
 static inline void cpu_probe_mips(struct cpuinfo_mips *c)
 {
 	decode_configs(c);
+	mips_probe_watch_registers(c);
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_4KC:
 		c->cputype = CPU_4KC;
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 36f0653..9d60679 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -50,8 +50,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "tlb_entries\t\t: %d\n", cpu_data[n].tlbsize);
 	seq_printf(m, "extra interrupt vector\t: %s\n",
 	              cpu_has_divec ? "yes" : "no");
-	seq_printf(m, "hardware watchpoint\t: %s\n",
-	              cpu_has_watch ? "yes" : "no");
+	seq_printf(m, "hardware watchpoint\t: %s",
+		   cpu_has_watch ? "yes, " : "no\n");
+	if (cpu_has_watch)
+		seq_printf(m,
+			   "count: %d, address/irw mask: 0x%04x\n",
+			   cpu_data[n].watch_reg_count,
+			   cpu_data[n].watch_reg_masks[0]);
 	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s\n",
 		      cpu_has_mips16 ? " mips16" : "",
 		      cpu_has_mdmx ? " mdmx" : "",
-- 
1.5.5.1
