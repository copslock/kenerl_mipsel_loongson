Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:07:57 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18315 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491207Ab0JGXFG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:05:06 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50de0000>; Thu, 07 Oct 2010 18:59:42 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:20 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:20 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N47i7026956;
        Thu, 7 Oct 2010 16:04:07 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N472l026955;
        Thu, 7 Oct 2010 16:04:07 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 06/14] MIPS: Octeon: Probe for Octeon II CPUs.
Date:   Thu,  7 Oct 2010 16:03:45 -0700
Message-Id: <1286492633-26885-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:20.0902 (UTC) FILETIME=[F9D61460:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The OCTEON II ISA extends the original OCTEON ISA, so give it its own
__elf_platform string so optimized libraries can be selected in
userspace.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/cpu-probe.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index b1b304e..b9378cd 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -187,6 +187,7 @@ void __init check_wait(void)
 	case CPU_BCM6358:
 	case CPU_CAVIUM_OCTEON:
 	case CPU_CAVIUM_OCTEON_PLUS:
+	case CPU_CAVIUM_OCTEON2:
 	case CPU_JZRISC:
 		cpu_wait = r4k_wait;
 		break;
@@ -953,6 +954,12 @@ platform:
 		if (cpu == 0)
 			__elf_platform = "octeon";
 		break;
+	case PRID_IMP_CAVIUM_CN63XX:
+		c->cputype = CPU_CAVIUM_OCTEON2;
+		__cpu_name[cpu] = "Cavium Octeon II";
+		if (cpu == 0)
+			__elf_platform = "octeon2";
+		break;
 	default:
 		printk(KERN_INFO "Unknown Octeon chip!\n");
 		c->cputype = CPU_UNKNOWN;
-- 
1.7.2.3
