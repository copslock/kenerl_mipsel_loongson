Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 18:47:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56596 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012162AbcBHRrESIMPY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 18:47:04 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id CB5B4957DF2EC;
        Mon,  8 Feb 2016 17:46:54 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 8 Feb 2016 17:46:57 +0000
Received: from localhost (10.100.200.4) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 8 Feb
 2016 17:46:57 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        <linux-kernel@vger.kernel.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        "James Hogan" <james.hogan@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Fix early CM probing
Date:   Mon, 8 Feb 2016 09:46:31 -0800
Message-ID: <1454953591-19491-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.4]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51859
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

Commit c014d164f21d ("MIPS: Add platform callback before initializing
the L2 cache") added a platform_early_l2_init function in order to allow
platforms to probe for the CM before L2 initialisation is performed, so
that CM GCRs are available to mips_sc_probe.

That commit actually fails to do anything useful, since it checks
mips_cm_revision to determine whether it should call mips_cm_probe but
the result of mips_cm_revision will always be 0 until mips_cm_probe has
been called. Thus the "early" mips_cm_probe call never occurs.

Fix this & drop the useless weak platform_early_l2_init function by
simply calling mips_cm_probe from setup_arch. For platforms that don't
select CONFIG_MIPS_CM this will be a no-op, and for those that do it
removes the requirement for them to call mips_cm_probe manually
(although doing so isn't harmful for now).

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/kernel/setup.c         |  1 +
 arch/mips/mm/sc-mips.c           | 10 ----------
 arch/mips/mti-malta/malta-init.c |  8 --------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 569a7d5..5fdaf8b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -782,6 +782,7 @@ static inline void prefill_possible_map(void) {}
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
+	mips_cm_probe();
 	prom_init();
 
 	setup_early_fdc_console();
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 3bd0597..2496475 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -181,10 +181,6 @@ static int __init mips_sc_probe_cm3(void)
 	return 1;
 }
 
-void __weak platform_early_l2_init(void)
-{
-}
-
 static inline int __init mips_sc_probe(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
@@ -194,12 +190,6 @@ static inline int __init mips_sc_probe(void)
 	/* Mark as not present until probe completed */
 	c->scache.flags |= MIPS_CACHE_NOT_PRESENT;
 
-	/*
-	 * Do we need some platform specific probing before
-	 * we configure L2?
-	 */
-	platform_early_l2_init();
-
 	if (mips_cm_revision() >= CM_REV_CM3)
 		return mips_sc_probe_cm3();
 
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index 571148c..dc2c521 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -293,7 +293,6 @@ mips_pci_controller:
 	console_config();
 #endif
 	/* Early detection of CMP support */
-	mips_cm_probe();
 	mips_cpc_probe();
 
 	if (!register_cps_smp_ops())
@@ -304,10 +303,3 @@ mips_pci_controller:
 		return;
 	register_up_smp_ops();
 }
-
-void platform_early_l2_init(void)
-{
-	/* L2 configuration lives in the CM3 */
-	if (mips_cm_revision() >= CM_REV_CM3)
-		mips_cm_probe();
-}
-- 
2.7.0
