Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2008 18:01:57 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10453 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21157677AbYJJRBz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Oct 2008 18:01:55 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48ef8a6a0000>; Fri, 10 Oct 2008 13:01:35 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Oct 2008 10:01:29 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Oct 2008 10:01:29 -0700
Message-ID: <48EF8A69.9070307@caviumnetworks.com>
Date:	Fri, 10 Oct 2008 10:01:29 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Report all watch register masks in /proc/cpuinfo.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2008 17:01:29.0411 (UTC) FILETIME=[D6B3F130:01C92AF9]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Report all watch register masks in /proc/cpuinfo.

Some CPUs have heterogeneous watch register properties.  Let's show
them all.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/proc.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 0dda76c..87cab9f 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -23,6 +23,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	unsigned int fp_vers;
 	unsigned long n = (unsigned long) v - 1;
 	char fmt [64];
+	int i;
 
 	preempt_disable();
 	version = current_cpu_data.processor_id;
@@ -59,11 +60,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	              cpu_has_divec ? "yes" : "no");
 	seq_printf(m, "hardware watchpoint\t: %s",
 		   cpu_has_watch ? "yes, " : "no\n");
-	if (cpu_has_watch)
-		seq_printf(m,
-			   "count: %d, address/irw mask: 0x%04x\n",
-			   cpu_data[n].watch_reg_count,
-			   cpu_data[n].watch_reg_masks[0]);
+	if (cpu_has_watch) {
+		seq_printf(m, "count: %d, address/irw mask: [", 
+			   cpu_data[n].watch_reg_count);
+		for (i = 0; i < cpu_data[n].watch_reg_count; i++)
+			seq_printf(m, "%s0x%04x", i ? ", " : "" ,
+				   cpu_data[n].watch_reg_masks[i]);
+		seq_printf(m, "]\n");
+	}
 	seq_printf(m, "ASEs implemented\t:%s%s%s%s%s%s\n",
 		      cpu_has_mips16 ? " mips16" : "",
 		      cpu_has_mdmx ? " mdmx" : "",
