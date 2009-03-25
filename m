Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 16:52:39 +0000 (GMT)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:10414 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S28575227AbZCYQtj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 16:49:39 +0000
Received: by fxm23 with SMTP id 23so148335fxm.0
        for <linux-mips@linux-mips.org>; Wed, 25 Mar 2009 09:49:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ON12irkEpqXTDZp4sO9SIoDGc28XSEQzNXI7LJhobRM=;
        b=QJTQJr1AqyB3xApmQZAO+4enCaHOqboQ8wzhZsCyxBcKwPClTQQHEzRFAGcCOg+hMw
         BUN1oi8e276Z9af/ndibnKlcWLo+8TAZFdsiJ0I0rirD6lbM3slDtYahluYsyVU7DMst
         cC2bpRLzAFmAokySlCjk5XNekNG22AFi5icJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=xidsIunmnRC+GFL3BFu/wYFyt4lCyV/gVOkziRi+BHroKnnTmc1L8VHOzyDHm4DqYK
         LPrvDi52Pd0/Sb8MEMxEfr02m8pnr0OSe/VK4CSKNosF+IpA7rLZ6Ch/gfnYU7cCvwhi
         +AQjVFpsKH4lIARDJVVfSX+5RTb8qSmwXqWmo=
Received: by 10.103.226.10 with SMTP id d10mr3981772mur.35.1237999773794;
        Wed, 25 Mar 2009 09:49:33 -0700 (PDT)
Received: from localhost.localdomain (p5496CCD7.dip.t-dialin.net [84.150.204.215])
        by mx.google.com with ESMTPS id e10sm14966093muf.41.2009.03.25.09.49.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 09:49:33 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 1/6] Alchemy: unify CPU model constants.
Date:	Wed, 25 Mar 2009 17:49:28 +0100
Message-Id: <1237999773-5174-2-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
References: <1237999773-5174-1-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

This patch removes the various CPU_AU1??? model constants in favor of
a single CPU_ALCHEMY one.

All currently existing Alchemy models are identical in terms of cpu
core and cache size/organization.  The parts of the mips kernel which
need to know the exact CPU revision extract it from the c0_prid register
already; and finally nothing else in-tree depends on those any more.

Should a new variant with slightly different "company options" and/or
"processor revision" bits in c0_prid appear, it will be supported
immediately (minus an exact model string in cpuinfo).

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/include/asm/cpu.h  |    3 +--
 arch/mips/kernel/cpu-probe.c |   21 ++++-----------------
 arch/mips/mm/c-r4k.c         |   17 +++++------------
 arch/mips/mm/tlbex.c         |    8 +-------
 4 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index c018727..3bdc0e3 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -209,8 +209,7 @@ enum cpu_type_enum {
 	 * MIPS32 class processors
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_1004K, CPU_74K,
-	CPU_AU1000, CPU_AU1100, CPU_AU1200, CPU_AU1210, CPU_AU1250, CPU_AU1500,
-	CPU_AU1550, CPU_PR4450, CPU_BCM3302, CPU_BCM4710,
+	CPU_ALCHEMY, CPU_PR4450, CPU_BCM3302, CPU_BCM4710,
 
 	/*
 	 * MIPS64 class processors
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 1bdbcad..b13b8eb 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -183,13 +183,7 @@ void __init check_wait(void)
 	case CPU_TX49XX:
 		cpu_wait = r4k_wait_irqoff;
 		break;
-	case CPU_AU1000:
-	case CPU_AU1100:
-	case CPU_AU1500:
-	case CPU_AU1550:
-	case CPU_AU1200:
-	case CPU_AU1210:
-	case CPU_AU1250:
+	case CPU_ALCHEMY:
 		cpu_wait = au1k_wait;
 		break;
 	case CPU_20KC:
@@ -783,37 +777,30 @@ static inline void cpu_probe_alchemy(struct cpuinfo_mips *c, unsigned int cpu)
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_AU1_REV1:
 	case PRID_IMP_AU1_REV2:
+		c->cputype = CPU_ALCHEMY;
 		switch ((c->processor_id >> 24) & 0xff) {
 		case 0:
-			c->cputype = CPU_AU1000;
 			__cpu_name[cpu] = "Au1000";
 			break;
 		case 1:
-			c->cputype = CPU_AU1500;
 			__cpu_name[cpu] = "Au1500";
 			break;
 		case 2:
-			c->cputype = CPU_AU1100;
 			__cpu_name[cpu] = "Au1100";
 			break;
 		case 3:
-			c->cputype = CPU_AU1550;
 			__cpu_name[cpu] = "Au1550";
 			break;
 		case 4:
-			c->cputype = CPU_AU1200;
 			__cpu_name[cpu] = "Au1200";
-			if ((c->processor_id & 0xff) == 2) {
-				c->cputype = CPU_AU1250;
+			if ((c->processor_id & 0xff) == 2)
 				__cpu_name[cpu] = "Au1250";
-			}
 			break;
 		case 5:
-			c->cputype = CPU_AU1210;
 			__cpu_name[cpu] = "Au1210";
 			break;
 		default:
-			panic("Unknown Au Core!");
+			__cpu_name[cpu] = "Au1xxx";
 			break;
 		}
 		break;
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index c43f4b2..0454505 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1026,13 +1026,7 @@ static void __cpuinit probe_pcache(void)
 		c->icache.flags |= MIPS_CACHE_VTAG;
 		break;
 
-	case CPU_AU1000:
-	case CPU_AU1500:
-	case CPU_AU1100:
-	case CPU_AU1550:
-	case CPU_AU1200:
-	case CPU_AU1210:
-	case CPU_AU1250:
+	case CPU_ALCHEMY:
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
 		break;
 	}
@@ -1244,7 +1238,7 @@ void au1x00_fixup_config_od(void)
 	/*
 	 * Au1100 errata actually keeps silence about this bit, so we set it
 	 * just in case for those revisions that require it to be set according
-	 * to arch/mips/au1000/common/cputable.c
+	 * to the (now gone) cpu table.
 	 */
 	case 0x02030200: /* Au1100 AB */
 	case 0x02030201: /* Au1100 BA */
@@ -1314,11 +1308,10 @@ static void __cpuinit coherency_setup(void)
 		break;
 	/*
 	 * We need to catch the early Alchemy SOCs with
-	 * the write-only co_config.od bit and set it back to one...
+	 * the write-only co_config.od bit and set it back to one on:
+	 * Au1000 rev DA, HA, HB;  Au1100 AB, BA, BC, Au1500 AB
 	 */
-	case CPU_AU1000: /* rev. DA, HA, HB */
-	case CPU_AU1100: /* rev. AB, BA, BC ?? */
-	case CPU_AU1500: /* rev. AB */
+	case CPU_ALCHEMY:
 		au1x00_fixup_config_od();
 		break;
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index f335cf6..122c9c1 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -292,13 +292,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_R4300:
 	case CPU_5KC:
 	case CPU_TX49XX:
-	case CPU_AU1000:
-	case CPU_AU1100:
-	case CPU_AU1500:
-	case CPU_AU1550:
-	case CPU_AU1200:
-	case CPU_AU1210:
-	case CPU_AU1250:
+	case CPU_ALCHEMY:
 	case CPU_PR4450:
 		uasm_i_nop(p);
 		tlbw(p);
-- 
1.6.2
