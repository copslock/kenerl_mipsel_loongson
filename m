Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2012 17:10:14 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:52172 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903725Ab2FYPKF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jun 2012 17:10:05 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjAvM-0001k4-OM; Mon, 25 Jun 2012 10:09:56 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v4,1/5] MIPS: Add support for the 1074K core.
Date:   Mon, 25 Jun 2012 10:09:19 -0500
Message-Id: <1340636959-14526-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
X-archive-position: 33801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/cpu.h      |    1 +
 arch/mips/include/asm/mipsregs.h |    2 ++
 arch/mips/kernel/cpu-probe.c     |    4 ++++
 arch/mips/mm/c-r4k.c             |   20 +++++++++++++++++++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 95e40c1..ad3caba 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -94,6 +94,7 @@
 #define PRID_IMP_24KE		0x9600
 #define PRID_IMP_74K		0x9700
 #define PRID_IMP_1004K		0x9900
+#define PRID_IMP_1074K		0x9a00
 #define PRID_IMP_M14KC		0x9c00
 
 /*
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 7f87d82..60731ff 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -596,6 +596,8 @@
 #define MIPS_CONF4_MMUEXTDEF	(_ULCAST_(3) << 14)
 #define MIPS_CONF4_MMUEXTDEF_MMUSIZEEXT (_ULCAST_(1) << 14)
 
+#define MIPS_CONF6_SYND		(_ULCAST_(1) << 13)
+
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 27404ad..78644e8 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -843,6 +843,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_1004K;
 		__cpu_name[cpu] = "MIPS 1004Kc";
 		break;
+	case PRID_IMP_1074K:
+		c->cputype = CPU_74K;
+		__cpu_name[cpu] = "MIPS 1074Kc";
+		break;
 	}
 
 	spram_config();
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ce0dbee..b96ebe9 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1040,10 +1040,27 @@ static void __cpuinit probe_pcache(void)
 	case CPU_R14000:
 		break;
 
+	case CPU_74K:
+		/*
+		 * Early versions of the 74k do not update
+		 * the cache tags on a vtag miss/ptag hit
+		 * which can occur in the case of KSEG0/KUSEG aliases
+		 * In this case it is better to treat the cache as always
+		 * having aliases
+		 */
+		if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
+			c->dcache.flags |= MIPS_CACHE_VTAG;
+		if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
+			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+		if (((c->processor_id & 0xff00) == PRID_IMP_1074K) &&
+		   ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0))) {
+			c->dcache.flags |= MIPS_CACHE_VTAG;
+			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+		}
+		/* fall through */
 	case CPU_M14KC:
 	case CPU_24K:
 	case CPU_34K:
-	case CPU_74K:
 	case CPU_1004K:
 		if ((read_c0_config7() & (1 << 16))) {
 			/* effectively physically indexed dcache,
@@ -1051,6 +1068,7 @@ static void __cpuinit probe_pcache(void)
 			c->dcache.flags |= MIPS_CACHE_PINDEX;
 			break;
 		}
+		/* fall through */
 	default:
 		if (c->dcache.waysize > PAGE_SIZE)
 			c->dcache.flags |= MIPS_CACHE_ALIASES;
-- 
1.7.10.3
