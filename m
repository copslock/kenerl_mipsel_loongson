Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:19:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:15233 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009137AbaLRPMS3zLb3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:12:18 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 821AE557EBB0A
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:12:09 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:12:12 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:12:11 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 30/67] MIPS: kernel: traps: Add MIPS R6 related definitions
Date:   Thu, 18 Dec 2014 15:09:39 +0000
Message-ID: <1418915416-3196-31-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44765
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Add MIPS R6 support to cache and ftlb exceptions, as well as
to the hwrena and ebase register configuration.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/traps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b3568c049b72..5223f173a5db 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1576,7 +1576,7 @@ asmlinkage void cache_parity_error(void)
 	printk("Decoded c0_cacheerr: %s cache fault in %s reference.\n",
 	       reg_val & (1<<30) ? "secondary" : "primary",
 	       reg_val & (1<<31) ? "data" : "insn");
-	if (cpu_has_mips_r2 &&
+	if ((cpu_has_mips_r2 || cpu_has_mips_r6) &&
 	    ((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_MIPS)) {
 		pr_err("Error bits: %s%s%s%s%s%s%s%s\n",
 			reg_val & (1<<29) ? "ED " : "",
@@ -1616,7 +1616,7 @@ asmlinkage void do_ftlb(void)
 	unsigned int reg_val;
 
 	/* For the moment, report the problem and hang. */
-	if (cpu_has_mips_r2 &&
+	if ((cpu_has_mips_r2 || cpu_has_mips_r6) &&
 	    ((current_cpu_data.processor_id & 0xff0000) == PRID_COMP_MIPS)) {
 		pr_err("FTLB error exception, cp0_ecc=0x%08x:\n",
 		       read_c0_ecc());
@@ -1905,7 +1905,7 @@ static void configure_hwrena(void)
 {
 	unsigned int hwrena = cpu_hwrena_impl_bits;
 
-	if (cpu_has_mips_r2)
+	if (cpu_has_mips_r2 || cpu_has_mips_r6)
 		hwrena |= 0x0000000f;
 
 	if (!noulri && cpu_has_userlocal)
@@ -1949,7 +1949,7 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	 *  o read IntCtl.IPTI to determine the timer interrupt
 	 *  o read IntCtl.IPPCI to determine the performance counter interrupt
 	 */
-	if (cpu_has_mips_r2) {
+	if (cpu_has_mips_r2 || cpu_has_mips_r6) {
 		cp0_compare_irq_shift = CAUSEB_TI - CAUSEB_IP;
 		cp0_compare_irq = (read_c0_intctl() >> INTCTLB_IPTI) & 7;
 		cp0_perfcount_irq = (read_c0_intctl() >> INTCTLB_IPPCI) & 7;
@@ -2040,7 +2040,7 @@ void __init trap_init(void)
 #else
         ebase = CKSEG0;
 #endif
-		if (cpu_has_mips_r2)
+		if (cpu_has_mips_r2 || cpu_has_mips_r6)
 			ebase += (read_c0_ebase() & 0x3ffff000);
 	}
 
-- 
2.2.0
