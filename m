Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Dec 2010 22:17:27 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19509 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492584Ab0LTVRW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Dec 2010 22:17:22 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d0fc8090001>; Mon, 20 Dec 2010 13:18:01 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 20 Dec 2010 13:18:38 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 20 Dec 2010 13:18:37 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBKLHD2A020533;
        Mon, 20 Dec 2010 13:17:14 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBKLHD36020532;
        Mon, 20 Dec 2010 13:17:13 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/3] MIPS: Probe for presence of KScratch registers.
Date:   Mon, 20 Dec 2010 13:17:06 -0800
Message-Id: <1292879828-20493-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1292879828-20493-1-git-send-email-ddaney@caviumnetworks.com>
References: <1292879828-20493-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 20 Dec 2010 21:18:38.0007 (UTC) FILETIME=[77BE9C70:01CBA08B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Probe c0_config4 for KScratch registers and report them in
/proc/cpuinfo.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cpu-info.h |    1 +
 arch/mips/kernel/cpu-probe.c     |    2 ++
 arch/mips/kernel/proc.c          |    2 ++
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index b39def3..c454550 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -78,6 +78,7 @@ struct cpuinfo_mips {
 	unsigned int		watch_reg_use_cnt; /* Usable by ptrace */
 #define NUM_WATCH_REGS 4
 	u16			watch_reg_masks[NUM_WATCH_REGS];
+	unsigned int		kscratch_mask; /* Usable KScratch mask. */
 } __attribute__((aligned(SMP_CACHE_BYTES)));
 
 extern struct cpuinfo_mips cpu_data[];
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 68dae7b..f65d4c8 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -739,6 +739,8 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 	    && cpu_has_tlb)
 		c->tlbsize += (config4 & MIPS_CONF4_MMUSIZEEXT) * 0x40;
 
+	c->kscratch_mask = (config4 >> 16) & 0xff;
+
 	return config4 & MIPS_CONF_M;
 }
 
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 26109c4..f40bd6b 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -69,6 +69,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		);
 	seq_printf(m, "shadow register sets\t: %d\n",
 		       cpu_data[n].srsets);
+	seq_printf(m, "kscratch registers\t: %d\n",
+		   hweight8(cpu_data[n].kscratch_mask));
 	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
 
 	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
-- 
1.7.2.3
