Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 12:03:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37123 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010872AbbAPKx3UFi2J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:53:29 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9BE0FF55DD51
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:53:21 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:53:23 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:53:23 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC v2 43/70] MIPS: mm: scache: Add secondary cache support for MIPS R6 cores
Date:   Fri, 16 Jan 2015 10:49:22 +0000
Message-ID: <1421405389-15512-44-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45187
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

The secondary cache initialization and configuration code is processor
specific so we need to handle MIPS R6 cores as well.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mm/c-r4k.c   | 3 ++-
 arch/mips/mm/sc-mips.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 7ecee761ae2d..3f8059602765 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1473,7 +1473,8 @@ static void setup_scache(void)
 
 	default:
 		if (c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2 |
-				    MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)) {
+				    MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R1 |
+				    MIPS_CPU_ISA_M64R2 | MIPS_CPU_ISA_M64R6)) {
 #ifdef CONFIG_MIPS_CPU_SCACHE
 			if (mips_sc_init ()) {
 				scache_size = c->scache.ways * c->scache.sets * c->scache.linesz;
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index fd9b5d45e91b..4ceafd13870c 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -105,7 +105,8 @@ static inline int __init mips_sc_probe(void)
 
 	/* Ignore anything but MIPSxx processors */
 	if (!(c->isa_level & (MIPS_CPU_ISA_M32R1 | MIPS_CPU_ISA_M32R2 |
-			      MIPS_CPU_ISA_M64R1 | MIPS_CPU_ISA_M64R2)))
+			      MIPS_CPU_ISA_M32R6 | MIPS_CPU_ISA_M64R1 |
+			      MIPS_CPU_ISA_M64R2 | MIPS_CPU_ISA_M64R6)))
 		return 0;
 
 	/* Does this MIPS32/MIPS64 CPU have a config2 register? */
-- 
2.2.1
