Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Aug 2014 10:37:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2082 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007354AbaH2Ihxj1zZr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Aug 2014 10:37:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C64B92C507136
        for <linux-mips@linux-mips.org>; Fri, 29 Aug 2014 09:37:44 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 29 Aug
 2014 09:37:46 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 29 Aug 2014 09:37:45 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.67) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 29 Aug 2014 09:37:45 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: cpu: Add 'noftlb' kernel command line option to disable the FTLB
Date:   Fri, 29 Aug 2014 09:37:26 +0100
Message-ID: <1409301446-23865-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.67]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Add new 'noftlb' kernel command line option to disable the FTLB.
Since the kernel command line is not available when probing and
enabling the CPU features in cpu_probe(), we let the kernel configure
the FTLB during the config4 decode operation and we disable the FTLB later
on, once the command line has become available to us. This should have
no negative effects since FTLB isn't used so early in the boot process.
FTLB increases the effective TLB size leading to less TLB misses. However,
sometimes it's useful to be able to disable it when debugging memory related
core features or other hardware components.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cpu-probe.c | 64 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 94c4a0c0a577..61572c9407c1 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -69,6 +69,63 @@ static int __init htw_disable(char *s)
 
 __setup("nohtw", htw_disable);
 
+static int mips_ftlb_disabled;
+static int mips_has_ftlb_configured;
+
+static void set_ftlb_enable(struct cpuinfo_mips *c, int enable);
+
+static int __init ftlb_disable(char *s)
+{
+	unsigned int config4, mmuextdef;
+
+	/*
+	 * If the core hasn't done any FTLB configuration, there is nothing
+	 * for us to do here.
+	 */
+	if (!mips_has_ftlb_configured)
+		return 1;
+
+	/* Disable it in the boot cpu */
+	set_ftlb_enable(&cpu_data[0], 0);
+
+	back_to_back_c0_hazard();
+
+	config4 = read_c0_config4();
+
+	/* Check that FTLB has been disabled */
+	mmuextdef = config4 & MIPS_CONF4_MMUEXTDEF;
+	/* MMUSIZEEXT == VTLB ON, FTLB OFF */
+	if (mmuextdef == MIPS_CONF4_MMUEXTDEF_FTLBSIZEEXT) {
+		/* This should never happen */
+		pr_warn("FTLB could not be disabled!\n");
+		return 1;
+	}
+
+	mips_ftlb_disabled = 1;
+	mips_has_ftlb_configured = 0;
+
+	/*
+	 * noftlb is mainly used for debug purposes so print
+	 * an informative message instead of using pr_debug()
+	 */
+	pr_info("FTLB has been disabled\n");
+
+	/*
+	 * Some of these bits are duplicated in the decode_config4.
+	 * MIPS_CONF4_MMUEXTDEF_MMUSIZEEXT is the only possible case
+	 * once FTLB has been disabled so undo what decode_config4 did.
+	 */
+	cpu_data[0].tlbsize -= cpu_data[0].tlbsizeftlbways *
+			       cpu_data[0].tlbsizeftlbsets;
+	cpu_data[0].tlbsizeftlbsets = 0;
+	cpu_data[0].tlbsizeftlbways = 0;
+
+	return 1;
+}
+
+__setup("noftlb", ftlb_disable);
+
+
 static inline void check_errata(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -368,6 +425,8 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 			ftlb_page = MIPS_CONF4_VFTLBPAGESIZE;
 			/* fall through */
 		case MIPS_CONF4_MMUEXTDEF_FTLBSIZEEXT:
+			if (mips_ftlb_disabled)
+				break;
 			newcf4 = (config4 & ~ftlb_page) |
 				(page_size_ftlb(mmuextdef) <<
 				 MIPS_CONF4_FTLBPAGESIZE_SHIFT);
@@ -387,6 +446,7 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 			c->tlbsizeftlbways = ((config4 & MIPS_CONF4_FTLBWAYS) >>
 					      MIPS_CONF4_FTLBWAYS_SHIFT) + 2;
 			c->tlbsize += c->tlbsizeftlbways * c->tlbsizeftlbsets;
+			mips_has_ftlb_configured = 1;
 			break;
 		}
 	}
@@ -422,8 +482,8 @@ static void decode_configs(struct cpuinfo_mips *c)
 
 	c->scache.flags = MIPS_CACHE_NOT_PRESENT;
 
-	/* Enable FTLB if present */
-	set_ftlb_enable(c, 1);
+	/* Enable FTLB if present and not disabled */
+	set_ftlb_enable(c, !mips_ftlb_disabled);
 
 	ok = decode_config0(c);			/* Read Config registers.  */
 	BUG_ON(!ok);				/* Arch spec violation!	 */
-- 
2.0.4
