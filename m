Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2015 18:50:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2500 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013662AbbIQQuhE5zvP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Sep 2015 18:50:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B37E8FB61E51C;
        Thu, 17 Sep 2015 17:50:28 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 17 Sep 2015 17:50:31 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 17 Sep 2015 17:50:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/2] MIPS: Fix FTLB detection for R6
Date:   Thu, 17 Sep 2015 17:49:21 +0100
Message-ID: <1442508561-12260-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1442508561-12260-1-git-send-email-james.hogan@imgtec.com>
References: <1442508561-12260-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

R6 removed the Config4.MMUExtDef field, with the low 16 bits only
allowed to contain FTLB fields, and commit e87569cd6c57 ("MIPS:
cpu-probe: Fix VTLB/FTLB configuration for R6") updated the probing of
this field to assume an FTLB is always present for R6.

However the FTLB may still be absent. The presence of those fields is
actually specified by the MMU type in the Config.MT field, so use that
(the new cpu_has_ftlb) to determine whether the FTLB is actually
present.

Fixes: e87569cd6c57 ("MIPS: cpu-probe: Fix VTLB/FTLB configuration for R6")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/cpu-probe.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 397551cf2e7b..09a51d091941 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -561,15 +561,18 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
 	if (cpu_has_tlb) {
 		if (((config4 & MIPS_CONF4_IE) >> 29) == 2)
 			c->options |= MIPS_CPU_TLBINV;
+
 		/*
-		 * This is a bit ugly. R6 has dropped that field from
-		 * config4 and the only valid configuration is VTLB+FTLB so
-		 * set a good value for mmuextdef for that case.
+		 * R6 has dropped the MMUExtDef field from config4.
+		 * On R6 the fields always describe the FTLB, and only if it is
+		 * present according to Config.MT.
 		 */
-		if (cpu_has_mips_r6)
-			mmuextdef = MIPS_CONF4_MMUEXTDEF_VTLBSIZEEXT;
-		else
+		if (!cpu_has_mips_r6)
 			mmuextdef = config4 & MIPS_CONF4_MMUEXTDEF;
+		else if (cpu_has_ftlb)
+			mmuextdef = MIPS_CONF4_MMUEXTDEF_VTLBSIZEEXT;
+		else
+			mmuextdef = 0;
 
 		switch (mmuextdef) {
 		case MIPS_CONF4_MMUEXTDEF_MMUSIZEEXT:
-- 
2.4.6
