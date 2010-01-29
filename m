Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 01:52:56 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9595 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492759Ab0A2Aw2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jan 2010 01:52:28 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6231500004>; Thu, 28 Jan 2010 16:52:32 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 28 Jan 2010 16:52:18 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 28 Jan 2010 16:52:18 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o0T0qEBI026629;
        Thu, 28 Jan 2010 16:52:14 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o0T0qEoP026628;
        Thu, 28 Jan 2010 16:52:14 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] MIPS: Set __elf_platform for Octeon.
Date:   Thu, 28 Jan 2010 16:52:13 -0800
Message-Id: <1264726333-26599-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1264726333-26599-1-git-send-email-ddaney@caviumnetworks.com>
References: <1264726333-26599-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 29 Jan 2010 00:52:18.0896 (UTC) FILETIME=[4EEC8500:01CAA07D]
X-archive-position: 25730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18540

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/cpu-probe.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 91ba1c8..906a2d1 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -908,6 +908,8 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_CAVIUM_CN52XX:
 		c->cputype = CPU_CAVIUM_OCTEON;
 		__cpu_name[cpu] = "Cavium Octeon";
+		if (cpu == 0)
+			__elf_platform = "octeon";
 		break;
 	default:
 		printk(KERN_INFO "Unknown Octeon chip!\n");
-- 
1.6.0.6
