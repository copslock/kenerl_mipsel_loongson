Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2010 19:12:32 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3194 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492399Ab0BWSM2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2010 19:12:28 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b841a930002>; Tue, 23 Feb 2010 10:12:35 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 23 Feb 2010 10:11:55 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 23 Feb 2010 10:11:55 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1NIBp93008401;
        Tue, 23 Feb 2010 10:11:51 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1NIBnbk008400;
        Tue, 23 Feb 2010 10:11:49 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Give Octeon+ CPUs their own __cpu_name
Date:   Tue, 23 Feb 2010 10:11:47 -0800
Message-Id: <1266948707-8357-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 23 Feb 2010 18:11:55.0869 (UTC) FILETIME=[AED300D0:01CAB4B3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

This couuld be rolled into the original linux-queue patch that
extablishes CPU_CAVIUM_OCTEON_PLUS.

 arch/mips/kernel/cpu-probe.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ee67aac..be5bb16 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -913,14 +913,15 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_CAVIUM_CN31XX:
 	case PRID_IMP_CAVIUM_CN30XX:
 		c->cputype = CPU_CAVIUM_OCTEON;
-		goto name_and_platform;
+		__cpu_name[cpu] = "Cavium Octeon";
+		goto platform;
 	case PRID_IMP_CAVIUM_CN58XX:
 	case PRID_IMP_CAVIUM_CN56XX:
 	case PRID_IMP_CAVIUM_CN50XX:
 	case PRID_IMP_CAVIUM_CN52XX:
 		c->cputype = CPU_CAVIUM_OCTEON_PLUS;
-name_and_platform:
-		__cpu_name[cpu] = "Cavium Octeon";
+		__cpu_name[cpu] = "Cavium Octeon+";
+platform:
 		if (cpu == 0)
 			__elf_platform = "octeon";
 		break;
-- 
1.6.6.1
