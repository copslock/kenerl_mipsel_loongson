Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2006 00:15:23 +0100 (BST)
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:44251 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by ftp.linux-mips.org with ESMTP
	id S20039566AbWJGXPV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Oct 2006 00:15:21 +0100
Received: from mail.ferretporn.se (83.250.8.219) by pne-smtpout1-sn2.hy.skanova.net (7.2.075)
        id 4516FC4100369BD4 for linux-mips@linux-mips.org; Sun, 8 Oct 2006 01:15:15 +0200
Received: from peepoe.ferretporn.se (peepoe.ferretporn.se [192.168.0.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ferretporn.se (Postfix) with ESMTP id 6E88DCBF4
	for <linux-mips@linux-mips.org>; Sun,  8 Oct 2006 01:15:14 +0200 (CEST)
From:	Karl-Johan Karlsson <creideiki+linux-mips@ferretporn.se>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Show actual CPU information in /proc/cpuinfo
Date:	Sun, 8 Oct 2006 01:15:02 +0200
User-Agent: KMail/1.9.4
X-Eric-Conspiracy: There is no conspiracy
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610080115.12452.creideiki+linux-mips@ferretporn.se>
Return-Path: <creideiki+linux-mips@ferretporn.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creideiki+linux-mips@ferretporn.se
Precedence: bulk
X-list: linux-mips

Currently, /proc/cpuinfo contains several copies of the information for 
whatever processor we happen to be scheduled on. This patch makes it contain 
the proper information for each CPU, which is particularly useful on mixed 
R12k/R10k IP27 machines.

Signed-off-by: Karl-Johan Karlsson <creideiki@lysator.liu.se>
---
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index d8beef1..46ee5a6 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -89,9 +89,9 @@ static const char *cpu_name[] = {
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
-	unsigned int version = current_cpu_data.processor_id;
-	unsigned int fp_vers = current_cpu_data.fpu_id;
 	unsigned long n = (unsigned long) v - 1;
+	unsigned int version = cpu_data[n].processor_id;
+	unsigned int fp_vers = cpu_data[n].fpu_id;
 	char fmt [64];
 
 #ifdef CONFIG_SMP
@@ -108,8 +108,8 @@ #endif
 	seq_printf(m, "processor\t\t: %ld\n", n);
 	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
 	        cpu_has_fpu ? "  FPU V%d.%d" : "");
-	seq_printf(m, fmt, cpu_name[current_cpu_data.cputype <= CPU_LAST ?
-	                            current_cpu_data.cputype : CPU_UNKNOWN],
+	seq_printf(m, fmt, cpu_name[cpu_data[n].cputype <= CPU_LAST ?
+	                            cpu_data[n].cputype : CPU_UNKNOWN],
 	                           (version >> 4) & 0x0f, version & 0x0f,
 	                           (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
 	seq_printf(m, "BogoMIPS\t\t: %lu.%02lu\n",
@@ -118,7 +118,7 @@ #endif
 	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
 	seq_printf(m, "microsecond timers\t: %s\n",
 	              cpu_has_counter ? "yes" : "no");
-	seq_printf(m, "tlb_entries\t\t: %d\n", current_cpu_data.tlbsize);
+	seq_printf(m, "tlb_entries\t\t: %d\n", cpu_data[n].tlbsize);
 	seq_printf(m, "extra interrupt vector\t: %s\n",
 	              cpu_has_divec ? "yes" : "no");
 	seq_printf(m, "hardware watchpoint\t: %s\n",
