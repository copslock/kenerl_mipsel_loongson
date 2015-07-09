Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 11:46:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58816 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009984AbbGIJl6UYBlh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 11:41:58 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D83E0C259ABE5
        for <linux-mips@linux-mips.org>; Thu,  9 Jul 2015 10:41:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Jul 2015 10:41:52 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 9 Jul 2015 10:41:52 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 18/19] MIPS: kernel: cpu-probe: Fix VTLB/FTLB configuration for R6
Date:   Thu, 9 Jul 2015 10:40:52 +0100
Message-ID: <1436434853-30001-19-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48155
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

R6 has dropped the MMUExtDef field from the config4 register and it
now returns 0. However, the return value means nothing in that case
and the only supported configuration for R6 is the VTLB+FTLB
(MMUextDef == 3). As a result, rework the code so that the correct
value is set for R6 cores.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/cpu-probe.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 6da5f2db6792..62dae429fe70 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -546,7 +546,16 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 	if (cpu_has_tlb) {
 		if (((config4 & MIPS_CONF4_IE) >> 29) == 2)
 			c->options |= MIPS_CPU_TLBINV;
-		mmuextdef = config4 & MIPS_CONF4_MMUEXTDEF;
+		/*
+		 * This is a bit ugly. R6 has dropped that field from
+		 * config4 and the only valid configuration is VTLB+FTLB so
+		 * set a good value for mmuextdef for that case.
+		 */
+		if (cpu_has_mips_r6)
+			mmuextdef = MIPS_CONF4_MMUEXTDEF_VTLBSIZEEXT;
+		else
+			mmuextdef = config4 & MIPS_CONF4_MMUEXTDEF;
+
 		switch (mmuextdef) {
 		case MIPS_CONF4_MMUEXTDEF_MMUSIZEEXT:
 			c->tlbsize += (config4 & MIPS_CONF4_MMUSIZEEXT) * 0x40;
-- 
2.4.5
