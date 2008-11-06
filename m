Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 20:59:00 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:49306 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23298208AbYKFUzd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 20:55:33 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4913599f0000>; Thu, 06 Nov 2008 15:54:55 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:54 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:54 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mA6KsoXO027725;
	Thu, 6 Nov 2008 12:54:50 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mA6Ksnp9027724;
	Thu, 6 Nov 2008 12:54:49 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 12/29] MIPS: Probe for Cavium OCTEON CPUs.
Date:	Thu,  6 Nov 2008 12:54:25 -0800
Message-Id: <1226004875-27654-12-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <491358F5.7040002@caviumnetworks.com>
References: <491358F5.7040002@caviumnetworks.com>
X-OriginalArrivalTime: 06 Nov 2008 20:54:54.0745 (UTC) FILETIME=[EBAF9090:01C94051]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add probe function for Cavium OCTEON CPUs and hook it up.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/cpu-probe.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index c9207b5..6b3c63d 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -154,6 +154,7 @@ void __init check_wait(void)
 	case CPU_25KF:
 	case CPU_PR4450:
 	case CPU_BCM3302:
+	case CPU_CAVIUM_OCTEON:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -875,6 +876,27 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 	}
 }
 
+static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
+{
+	decode_configs(c);
+	switch (c->processor_id & 0xff00) {
+	case PRID_IMP_CAVIUM_CN38XX:
+	case PRID_IMP_CAVIUM_CN31XX:
+	case PRID_IMP_CAVIUM_CN30XX:
+	case PRID_IMP_CAVIUM_CN58XX:
+	case PRID_IMP_CAVIUM_CN56XX:
+	case PRID_IMP_CAVIUM_CN50XX:
+	case PRID_IMP_CAVIUM_CN52XX:
+		c->cputype = CPU_CAVIUM_OCTEON;
+		__cpu_name[cpu] = "Cavium Octeon";
+		break;
+	default:
+		printk(KERN_INFO "Unknown Octeon chip!\n");
+		c->cputype = CPU_UNKNOWN;
+		break;
+	}
+}
+
 const char *__cpu_name[NR_CPUS];
 
 __cpuinit void cpu_probe(void)
@@ -909,6 +931,9 @@ __cpuinit void cpu_probe(void)
 	case PRID_COMP_NXP:
 		cpu_probe_nxp(c, cpu);
 		break;
+	case PRID_COMP_CAVIUM:
+		cpu_probe_cavium(c, cpu);
+		break;
 	}
 
 	BUG_ON(!__cpu_name[cpu]);
-- 
1.5.6.5
