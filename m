Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 22:45:08 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:42596 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992285AbcIAUoKkBcrN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 22:44:10 +0200
Received: from localhost.localdomain (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 343AE4338;
        Thu,  1 Sep 2016 23:44:10 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/6] MIPS: OCTEON: don't try to maintain link state in early init
Date:   Thu,  1 Sep 2016 23:43:56 +0300
Message-Id: <20160901204400.16562-3-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160901204400.16562-1-aaro.koskinen@iki.fi>
References: <20160901204400.16562-1-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Don't try to maintain link state in early init. Leave that to
actual ethernet/phy drivers.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c |  3 +--
 arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c  |  2 --
 arch/mips/cavium-octeon/executive/cvmx-helper.c       | 10 ----------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index f59c88e..809cd8b 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -243,8 +243,7 @@ int __cvmx_helper_rgmii_enable(int interface)
 	/* enable the ports now */
 	for (port = 0; port < num_ports; port++) {
 		union cvmx_gmxx_prtx_cfg gmx_cfg;
-		cvmx_helper_link_autoconf(cvmx_helper_get_ipd_port
-					  (interface, port));
+
 		gmx_cfg.u64 =
 		    cvmx_read_csr(CVMX_GMXX_PRTX_CFG(port, interface));
 		gmx_cfg.s.en = 1;
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index a56ee59..d347fe1 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -234,8 +234,6 @@ int __cvmx_helper_xaui_enable(int interface)
 	cvmx_write_csr(CVMX_GMXX_TX_INT_EN(interface), gmx_tx_int_en.u64);
 	cvmx_write_csr(CVMX_PCSXX_INT_EN_REG(interface), pcsx_int_en_reg.u64);
 
-	cvmx_helper_link_autoconf(cvmx_helper_get_ipd_port(interface, 0));
-
 	/* (8) Enable packet reception */
 	xauiMiscCtl.s.gmxeno = 0;
 	cvmx_write_csr(CVMX_PCSXX_MISC_CTL_REG(interface), xauiMiscCtl.u64);
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index ff26d02..6456af6 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -841,7 +841,6 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
 	int retry_cnt;
 	int retry_loop_cnt;
 	int i;
-	cvmx_helper_link_info_t link_info;
 
 	/* Save values for restore at end */
 	uint64_t prtx_cfg =
@@ -1002,15 +1001,6 @@ fix_ipd_exit:
 		       (INDEX(FIX_IPD_OUTPORT), INTERFACE(FIX_IPD_OUTPORT)),
 		       frame_max);
 	cvmx_write_csr(CVMX_ASXX_PRT_LOOP(INTERFACE(FIX_IPD_OUTPORT)), 0);
-	/* Set link to down so autonegotiation will set it up again */
-	link_info.u64 = 0;
-	cvmx_helper_link_set(FIX_IPD_OUTPORT, link_info);
-
-	/*
-	 * Bring the link back up as autonegotiation is not done in
-	 * user applications.
-	 */
-	cvmx_helper_link_autoconf(FIX_IPD_OUTPORT);
 
 	CVMX_SYNC;
 	if (num_segs)
-- 
2.9.2
