Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 14:00:03 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:2573 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825660Ab2JaM6qfPOEg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Oct 2012 13:58:46 +0100
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 31 Oct 2012 05:57:25 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 31 Oct 2012 05:58:02 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 3587E40FE3; Wed, 31
 Oct 2012 05:58:30 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 06/15] MIPS: Netlogic: Move fdt init to plat_mem_setup
Date:   Wed, 31 Oct 2012 18:31:32 +0530
Message-ID: <97b6604ed199834e487ba9dfa5f4646640a893d3.1351688140.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1351688140.git.jchandra@broadcom.com>
References: <cover.1351688140.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7C8FFFBF2102191012-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

At this point early printk is available, so debugging device tree
issues is easier.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/xlp/setup.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index d899709..b886a50 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -68,10 +68,23 @@ static void nlm_linux_exit(void)
 
 void __init plat_mem_setup(void)
 {
+	void *fdtp;
+
 	panic_timeout	= 5;
 	_machine_restart = (void (*)(char *))nlm_linux_exit;
 	_machine_halt	= nlm_linux_exit;
 	pm_power_off	= nlm_linux_exit;
+
+	/*
+	 * If no FDT pointer is passed in, use the built-in FDT.
+	 * device_tree_init() does not handle CKSEG0 pointers in
+	 * 64-bit, so convert pointer.
+	 */
+	fdtp = (void *)(long)fw_arg0;
+	if (!fdtp)
+		fdtp = __dtb_start;
+	fdtp = phys_to_virt(__pa(fdtp));
+	early_init_devtree(fdtp);
 }
 
 const char *get_system_type(void)
@@ -96,23 +109,11 @@ void xlp_mmu_init(void)
 
 void __init prom_init(void)
 {
-	void *fdtp;
-
 	xlp_mmu_init();
 	nlm_hal_init();
 
-	/*
-	 * If no FDT pointer is passed in, use the built-in FDT.
-	 * device_tree_init() does not handle CKSEG0 pointers in
-	 * 64-bit, so convert pointer.
-	 */
-	fdtp = (void *)(long)fw_arg0;
-	if (!fdtp)
-		fdtp = __dtb_start;
-	fdtp = phys_to_virt(__pa(fdtp));
-	early_init_devtree(fdtp);
-
 	nlm_common_ebase = read_c0_ebase() & (~((1 << 12) - 1));
+
 #ifdef CONFIG_SMP
 	nlm_wakeup_secondary_cpus(0xffffffff);
 
-- 
1.7.9.5
