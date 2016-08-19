Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 19:19:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39757 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992547AbcHSRT2kXgSr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 19:19:28 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2CFAD7C58D190;
        Fri, 19 Aug 2016 18:19:08 +0100 (IST)
Received: from localhost (10.100.200.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 19 Aug
 2016 18:19:12 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/3] MIPS: Configure FTLB after probing TLB sizes from config4
Date:   Fri, 19 Aug 2016 18:18:27 +0100
Message-ID: <20160819171828.29109-3-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160819171828.29109-1-paul.burton@imgtec.com>
References: <20160819171828.29109-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On some cores (proAptiv, P5600) we make use of the sizes of the TLBs
to determine the desired FTLB:VTLB write ratio. However set_ftlb_enable
& thus calculate_ftlb_probability is called before decode_config4. This
results in us calculating a probability based on zero sizes, and we end
up setting FTLBP=3 for a 3:1 FTLB:VTLB write ratio in all cases. This
will make abysmal use of the available FTLB resources in the affected
cores.

Fix this by configuring the FTLB probability after having decoded
config4. However we do need to have enabled the FTLB before that point
such that fields in config4 actually reflect that an FTLB is present. So
set_ftlb_enable is now called twice, with flags indicating that it
should configure the write probability only the second time.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Fixes: cf0a8aa0226d ("MIPS: cpu-probe: Set the FTLB probability bit on
  supported cores")
---
 arch/mips/kernel/cpu-probe.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ae29050..5069b5b1 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -352,7 +352,12 @@ __setup("nohtw", htw_disable);
 static int mips_ftlb_disabled;
 static int mips_has_ftlb_configured;
 
-static int set_ftlb_enable(struct cpuinfo_mips *c, int enable);
+enum ftlb_flags {
+	FTLB_EN		= 1 << 0,
+	FTLB_SET_PROB	= 1 << 1,
+};
+
+static int set_ftlb_enable(struct cpuinfo_mips *c, enum ftlb_flags flags);
 
 static int __init ftlb_disable(char *s)
 {
@@ -531,7 +536,7 @@ static unsigned int calculate_ftlb_probability(struct cpuinfo_mips *c)
 		return 3;
 }
 
-static int set_ftlb_enable(struct cpuinfo_mips *c, int enable)
+static int set_ftlb_enable(struct cpuinfo_mips *c, enum ftlb_flags flags)
 {
 	unsigned int config;
 
@@ -542,28 +547,32 @@ static int set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 	case CPU_P6600:
 		/* proAptiv & related cores use Config6 to enable the FTLB */
 		config = read_c0_config6();
-		/* Clear the old probability value */
-		config &= ~(3 << MIPS_CONF6_FTLBP_SHIFT);
-		if (enable)
-			/* Enable FTLB */
-			write_c0_config6(config |
-					 (calculate_ftlb_probability(c)
-					  << MIPS_CONF6_FTLBP_SHIFT)
-					 | MIPS_CONF6_FTLBEN);
+
+		if (flags & FTLB_EN)
+			config |= MIPS_CONF6_FTLBEN;
 		else
-			/* Disable FTLB */
-			write_c0_config6(config &  ~MIPS_CONF6_FTLBEN);
+			config &= ~MIPS_CONF6_FTLBEN;
+
+		if (flags & FTLB_SET_PROB) {
+			config &= ~(3 << MIPS_CONF6_FTLBP_SHIFT);
+			config |= calculate_ftlb_probability(c)
+				  << MIPS_CONF6_FTLBP_SHIFT;
+		}
+
+		write_c0_config6(config);
 		break;
 	case CPU_I6400:
 		/* There's no way to disable the FTLB */
-		return !enable;
+		if (!(flags & FTLB_EN))
+			return 1;
+		return 0;
 	case CPU_LOONGSON3:
 		/* Flush ITLB, DTLB, VTLB and FTLB */
 		write_c0_diag(LOONGSON_DIAG_ITLB | LOONGSON_DIAG_DTLB |
 			      LOONGSON_DIAG_VTLB | LOONGSON_DIAG_FTLB);
 		/* Loongson-3 cores use Config6 to enable the FTLB */
 		config = read_c0_config6();
-		if (enable)
+		if (flags & FTLB_EN)
 			/* Enable FTLB */
 			write_c0_config6(config & ~MIPS_CONF6_FTLBDIS);
 		else
@@ -783,6 +792,7 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 				       PAGE_SIZE, config4);
 				/* Switch FTLB off */
 				set_ftlb_enable(c, 0);
+				mips_ftlb_disabled = 1;
 				break;
 			}
 			c->tlbsizeftlbsets = 1 <<
@@ -847,7 +857,7 @@ static void decode_configs(struct cpuinfo_mips *c)
 	c->scache.flags = MIPS_CACHE_NOT_PRESENT;
 
 	/* Enable FTLB if present and not disabled */
-	set_ftlb_enable(c, !mips_ftlb_disabled);
+	set_ftlb_enable(c, mips_ftlb_disabled ? 0 : FTLB_EN);
 
 	ok = decode_config0(c);			/* Read Config registers.  */
 	BUG_ON(!ok);				/* Arch spec violation!	 */
@@ -897,6 +907,9 @@ static void decode_configs(struct cpuinfo_mips *c)
 		}
 	}
 
+	/* configure the FTLB write probability */
+	set_ftlb_enable(c, (mips_ftlb_disabled ? 0 : FTLB_EN) | FTLB_SET_PROB);
+
 	mips_probe_watch_registers(c);
 
 #ifndef CONFIG_MIPS_CPS
-- 
2.9.3
