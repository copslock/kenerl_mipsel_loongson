Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 13:35:24 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47188 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817165AbaEULfWNPYEw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 13:35:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 183AA4B044C0E
        for <linux-mips@linux-mips.org>; Wed, 21 May 2014 12:35:13 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 21 May
 2014 12:35:15 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 21 May 2014 12:35:15 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.137) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 21 May 2014 12:35:13 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org # v3.14+>
Subject: [PATCH] MIPS: Fix typo when reporting cache and ftlb errors for ImgTec cores
Date:   Wed, 21 May 2014 12:35:00 +0100
Message-ID: <1400672100-19092-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.137]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40213
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

Introduced by the following two commits:
75b5b5e0a262790fa11043fe45700499c7e3d818
"MIPS: Add support for FTLBs"
6de20451857ed14a4eecc28d08f6de5925d1cf96
"MIPS: Add printing of ES bit for Imgtec cores when cache error occurs"

Cc: stable@vger.kernel.org # v3.14+
Reported-by: Matheus Almeida <Matheus.Almeida@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 074e857..8119ac2 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1545,7 +1545,7 @@ asmlinkage void cache_parity_error(void)
 	       reg_val & (1<<30) ? "secondary" : "primary",
 	       reg_val & (1<<31) ? "data" : "insn");
 	if (cpu_has_mips_r2 &&
-	    ((current_cpu_data.processor_id && 0xff0000) == PRID_COMP_MIPS)) {
+	    ((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_MIPS)) {
 		pr_err("Error bits: %s%s%s%s%s%s%s%s\n",
 			reg_val & (1<<29) ? "ED " : "",
 			reg_val & (1<<28) ? "ET " : "",
@@ -1585,7 +1585,7 @@ asmlinkage void do_ftlb(void)
 
 	/* For the moment, report the problem and hang. */
 	if (cpu_has_mips_r2 &&
-	    ((current_cpu_data.processor_id && 0xff0000) == PRID_COMP_MIPS)) {
+	    ((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_MIPS)) {
 		pr_err("FTLB error exception, cp0_ecc=0x%08x:\n",
 		       read_c0_ecc());
 		pr_err("cp0_errorepc == %0*lx\n", field, read_c0_errorepc());
-- 
1.9.3
