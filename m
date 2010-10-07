Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 01:07:33 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:18314 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491206Ab0JGXFF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 01:05:05 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cae50dd0002>; Thu, 07 Oct 2010 18:59:42 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:20 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Oct 2010 16:04:20 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o97N46b9026952;
        Thu, 7 Oct 2010 16:04:06 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o97N44H0026951;
        Thu, 7 Oct 2010 16:04:04 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 05/14] MIPS: Octeon: Handle Octeon II caches.
Date:   Thu,  7 Oct 2010 16:03:44 -0700
Message-Id: <1286492633-26885-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 07 Oct 2010 23:04:20.0777 (UTC) FILETIME=[F9C30190:01CB6673]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/c-octeon.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index 0f9c488..16c4d25 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -181,10 +181,10 @@ static void __cpuinit probe_octeon(void)
 	unsigned int config1;
 	struct cpuinfo_mips *c = &current_cpu_data;
 
+	config1 = read_c0_config1();
 	switch (c->cputype) {
 	case CPU_CAVIUM_OCTEON:
 	case CPU_CAVIUM_OCTEON_PLUS:
-		config1 = read_c0_config1();
 		c->icache.linesz = 2 << ((config1 >> 19) & 7);
 		c->icache.sets = 64 << ((config1 >> 22) & 7);
 		c->icache.ways = 1 + ((config1 >> 16) & 7);
@@ -204,6 +204,20 @@ static void __cpuinit probe_octeon(void)
 		c->options |= MIPS_CPU_PREFETCH;
 		break;
 
+	case CPU_CAVIUM_OCTEON2:
+		c->icache.linesz = 2 << ((config1 >> 19) & 7);
+		c->icache.sets = 8;
+		c->icache.ways = 37;
+		c->icache.flags |= MIPS_CACHE_VTAG;
+		icache_size = c->icache.sets * c->icache.ways * c->icache.linesz;
+
+		c->dcache.linesz = 128;
+		c->dcache.ways = 32;
+		c->dcache.sets = 8;
+		dcache_size = c->dcache.sets * c->dcache.ways * c->dcache.linesz;
+		c->options |= MIPS_CPU_PREFETCH;
+		break;
+
 	default:
 		panic("Unsupported Cavium Networks CPU type\n");
 		break;
-- 
1.7.2.3
