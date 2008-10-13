Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2008 18:37:21 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:28893 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S21402561AbYJMRhT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Oct 2008 18:37:19 +0100
Received: (qmail invoked by alias); 13 Oct 2008 17:37:12 -0000
Received: from p548B3450.dip0.t-ipconnect.de (EHLO localhost.localdomain) [84.139.52.80]
  by mail.gmx.net (mp047) with SMTP; 13 Oct 2008 19:37:12 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX1+zvIpJx62zIM5lqDupC1VALfZb+i8X5N/zI+iN42
	CQoYIrB4Rqwq93
From:	Johannes Dickgreber <tanzy@gmx.de>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 2/2] show_cpuinfo prints the name of the calling CPU, which i think is wrong.
Date:	Mon, 13 Oct 2008 19:36:21 +0200
Message-Id: <1223919381-24521-1-git-send-email-tanzy@gmx.de>
X-Mailer: git-send-email 1.6.0.2
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Johannes Dickgreber <tanzy@gmx.de>
---
 arch/mips/kernel/proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 9d60679..8897c53 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -38,7 +38,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "processor\t\t: %ld\n", n);
 	sprintf(fmt, "cpu model\t\t: %%s V%%d.%%d%s\n",
 	        cpu_data[n].options & MIPS_CPU_FPU ? "  FPU V%d.%d" : "");
-	seq_printf(m, fmt, __cpu_name[smp_processor_id()],
+	seq_printf(m, fmt, __cpu_name[n],
 	                           (version >> 4) & 0x0f, version & 0x0f,
 	                           (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
 	seq_printf(m, "BogoMIPS\t\t: %lu.%02lu\n",
-- 
1.6.0.2
