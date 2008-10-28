Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:11:19 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:28949 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22533333AbYJ1AFJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:05:09 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f70003>; Mon, 27 Oct 2008 20:04:07 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:11 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:10 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S036Pq003304;
	Mon, 27 Oct 2008 17:03:06 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S036hS003303;
	Mon, 27 Oct 2008 17:03:06 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 15/36] Probe for Cavium OCTEON CPUs.
Date:	Mon, 27 Oct 2008 17:02:47 -0700
Message-Id: <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:11.0038 (UTC) FILETIME=[90AB95E0:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add probe function for Cavium OCTEON CPUs and hook it up.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/cpu-probe.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 30f7e8c..fc2403c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -154,6 +154,7 @@ void __init check_wait(void)
 	case CPU_25KF:
 	case CPU_PR4450:
 	case CPU_BCM3302:
+	case CPU_CAVIUM_OCTEON:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -815,6 +816,27 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c)
 	}
 }
 
+static inline void cpu_probe_cavium(struct cpuinfo_mips *c)
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
+		break;
+	default:
+		printk(KERN_INFO "Unknown Octeon chip!\n");
+		c->cputype = CPU_UNKNOWN;
+		break;
+	}
+	mips_probe_watch_registers(c);
+}
+
 const char *__cpu_name[NR_CPUS];
 
 /*
@@ -892,6 +914,7 @@ static const char *mips_cpu_names[] = {
 	[CPU_BCM4710]		= "Broadcom BCM4710",
 	[CPU_PR4450]		= "Philips PR4450",
 	[CPU_LOONGSON2]		= "ICT Loongson-2",
+	[CPU_CAVIUM_OCTEON]	= "Cavium Octeon",
 	[CPU_LAST]		= NULL
 };
 
@@ -939,6 +962,9 @@ __cpuinit void cpu_probe(void)
 	case PRID_COMP_NXP:
 		cpu_probe_nxp(c);
 		break;
+	case PRID_COMP_CAVIUM:
+		cpu_probe_cavium(c);
+		break;
 	default:
 		c->cputype = CPU_UNKNOWN;
 	}
-- 
1.5.6.5
