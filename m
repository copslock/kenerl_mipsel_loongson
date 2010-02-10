Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2010 00:14:18 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15982 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492372Ab0BJXNu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2010 00:13:50 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b733db60000>; Wed, 10 Feb 2010 15:13:58 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:12:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:12:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1ANCo9r005839;
        Wed, 10 Feb 2010 15:12:50 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1ANCoHL005838;
        Wed, 10 Feb 2010 15:12:50 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 5/6] MIPS: Give Octeon+ CPUs their own cputype.
Date:   Wed, 10 Feb 2010 15:12:48 -0800
Message-Id: <1265843569-5786-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <4B733C71.8030304@caviumnetworks.com>
References: <4B733C71.8030304@caviumnetworks.com>
X-OriginalArrivalTime: 10 Feb 2010 23:12:52.0410 (UTC) FILETIME=[91FDC1A0:01CAAAA6]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This allows us to treat them differently at runtime.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/cpu.h  |    2 +-
 arch/mips/kernel/cpu-probe.c |    6 +++++-
 arch/mips/mm/c-octeon.c      |    7 ++++---
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index cf373a9..a5acda4 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -224,7 +224,7 @@ enum cpu_type_enum {
 	 * MIPS64 class processors
 	 */
 	CPU_5KC, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
-	CPU_CAVIUM_OCTEON,
+	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS,
 
 	CPU_LAST
 };
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 9ea5ca8..ee67aac 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -162,6 +162,7 @@ void __init check_wait(void)
 	case CPU_BCM6348:
 	case CPU_BCM6358:
 	case CPU_CAVIUM_OCTEON:
+	case CPU_CAVIUM_OCTEON_PLUS:
 		cpu_wait = r4k_wait;
 		break;
 
@@ -911,11 +912,14 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_CAVIUM_CN38XX:
 	case PRID_IMP_CAVIUM_CN31XX:
 	case PRID_IMP_CAVIUM_CN30XX:
+		c->cputype = CPU_CAVIUM_OCTEON;
+		goto name_and_platform;
 	case PRID_IMP_CAVIUM_CN58XX:
 	case PRID_IMP_CAVIUM_CN56XX:
 	case PRID_IMP_CAVIUM_CN50XX:
 	case PRID_IMP_CAVIUM_CN52XX:
-		c->cputype = CPU_CAVIUM_OCTEON;
+		c->cputype = CPU_CAVIUM_OCTEON_PLUS;
+name_and_platform:
 		__cpu_name[cpu] = "Cavium Octeon";
 		if (cpu == 0)
 			__elf_platform = "octeon";
diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
index af85959..0f9c488 100644
--- a/arch/mips/mm/c-octeon.c
+++ b/arch/mips/mm/c-octeon.c
@@ -183,6 +183,7 @@ static void __cpuinit probe_octeon(void)
 
 	switch (c->cputype) {
 	case CPU_CAVIUM_OCTEON:
+	case CPU_CAVIUM_OCTEON_PLUS:
 		config1 = read_c0_config1();
 		c->icache.linesz = 2 << ((config1 >> 19) & 7);
 		c->icache.sets = 64 << ((config1 >> 22) & 7);
@@ -192,10 +193,10 @@ static void __cpuinit probe_octeon(void)
 			c->icache.sets * c->icache.ways * c->icache.linesz;
 		c->icache.waybit = ffs(icache_size / c->icache.ways) - 1;
 		c->dcache.linesz = 128;
-		if (OCTEON_IS_MODEL(OCTEON_CN3XXX))
-			c->dcache.sets = 1; /* CN3XXX has one Dcache set */
-		else
+		if (c->cputype == CPU_CAVIUM_OCTEON_PLUS)
 			c->dcache.sets = 2; /* CN5XXX has two Dcache sets */
+		else
+			c->dcache.sets = 1; /* CN3XXX has one Dcache set */
 		c->dcache.ways = 64;
 		dcache_size =
 			c->dcache.sets * c->dcache.ways * c->dcache.linesz;
-- 
1.6.2.5
