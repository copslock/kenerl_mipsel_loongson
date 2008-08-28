Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2008 23:02:45 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:35549 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28575155AbYH1WCn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Aug 2008 23:02:43 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 90D6B320D19;
	Thu, 28 Aug 2008 22:02:53 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 28 Aug 2008 22:02:53 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.14]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Aug 2008 15:02:36 -0700
Message-ID: <48B7207C.8060407@avtrex.com>
Date:	Thu, 28 Aug 2008 15:02:36 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [Patch 3/6] MIPS: Probe watch registers and report configuration.
References: <48B71ADD.601@avtrex.com>
In-Reply-To: <48B71ADD.601@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2008 22:02:36.0747 (UTC) FILETIME=[C7E961B0:01C90959]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips


Probe for watch register characteristics, and report them in
/proc/cpuinfo.

Signed-off-by: David Daney <ddaney@avtrex.com>
---
 arch/mips/kernel/cpu-probe.c |    2 ++
 arch/mips/kernel/proc.c      |   10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

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
index 36f0653..11402f5 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -50,8 +50,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "tlb_entries\t\t: %d\n", cpu_data[n].tlbsize);
 	seq_printf(m, "extra interrupt vector\t: %s\n",
 	              cpu_has_divec ? "yes" : "no");
-	seq_printf(m, "hardware watchpoint\t: %s\n",
-	              cpu_has_watch ? "yes" : "no");
+	seq_printf(m, "hardware watchpoint\t: %s",
+		   cpu_has_watch ? "yes, " : "no\n");
+	if (cpu_has_watch)
+		seq_printf(m,
+			   "count: %d, address mask: 0x%04x, irw mask 0x%02x\n",
+			   cpu_data[n].watch_reg_count,
+			   cpu_data[n].watch_reg_mask,
+			   cpu_data[n].watch_reg_irw);
 	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s\n",
 		      cpu_has_mips16 ? " mips16" : "",
 		      cpu_has_mdmx ? " mdmx" : "",
-- 
1.5.5.1
