Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 00:50:23 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13450 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491761Ab1ITWtt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Sep 2011 00:49:49 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e7918d50000>; Tue, 20 Sep 2011 15:51:01 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 20 Sep 2011 15:49:46 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 20 Sep 2011 15:49:46 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id p8KMnjrh011564;
        Tue, 20 Sep 2011 15:49:45 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p8KMnjQZ011563;
        Tue, 20 Sep 2011 15:49:45 -0700
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 2/2] MIPS: Add probes for more Octeon II CPUs.
Date:   Tue, 20 Sep 2011 15:49:41 -0700
Message-Id: <1316558981-11526-2-git-send-email-david.daney@cavium.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1316558981-11526-1-git-send-email-david.daney@cavium.com>
References: <1316558981-11526-1-git-send-email-david.daney@cavium.com>
X-OriginalArrivalTime: 20 Sep 2011 22:49:46.0591 (UTC) FILETIME=[9875CEF0:01CC77E7]
X-archive-position: 31113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11118

Detect cn61XX, cn66XX and cn68XX CPUs in cpu_probe_cavium().

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/cpu-probe.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ebc0cd2..aa327a7 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -978,7 +978,10 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 platform:
 		set_elf_platform(cpu, "octeon");
 		break;
+	case PRID_IMP_CAVIUM_CN61XX:
 	case PRID_IMP_CAVIUM_CN63XX:
+	case PRID_IMP_CAVIUM_CN66XX:
+	case PRID_IMP_CAVIUM_CN68XX:
 		c->cputype = CPU_CAVIUM_OCTEON2;
 		__cpu_name[cpu] = "Cavium Octeon II";
 		set_elf_platform(cpu, "octeon2");
-- 
1.7.2.3
