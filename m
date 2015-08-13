Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 15:25:35 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:55469 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012193AbbHMNY6RQgEC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 15:24:58 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7DDOhrU003550
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2015 13:24:43 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7DDObQQ030804;
        Thu, 13 Aug 2015 15:24:42 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Janne Huttunen <janne.huttunen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 07/14] MIPS/staging: OCTEON: properly enable/disable SSO WQE interrupts
Date:   Thu, 13 Aug 2015 16:21:39 +0300
Message-Id: <1439472106-7750-8-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 3609
X-purgate-ID: 151667::1439472283-00007F5C-05717731/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

The Octeon models with SSO instead of POW need to use a different register
for configuring the WQE interrupt thresholds.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/staging/octeon/ethernet-rx.c | 54 ++++++++++++++++++++++++++----------
 drivers/staging/octeon/ethernet.c    |  5 +++-
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 22853d3..1636bd9 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -195,12 +195,19 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 		prefetch(work);
 		did_work_request = 0;
 		if (work == NULL) {
-			union cvmx_pow_wq_int wq_int;
+			if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
+				cvmx_write_csr(CVMX_SSO_WQ_IQ_DIS,
+					       1ull << pow_receive_group);
+				cvmx_write_csr(CVMX_SSO_WQ_INT,
+					       1ull << pow_receive_group);
+			} else {
+				union cvmx_pow_wq_int wq_int;
 
-			wq_int.u64 = 0;
-			wq_int.s.iq_dis = 1 << pow_receive_group;
-			wq_int.s.wq_int = 1 << pow_receive_group;
-			cvmx_write_csr(CVMX_POW_WQ_INT, wq_int.u64);
+				wq_int.u64 = 0;
+				wq_int.s.iq_dis = 1 << pow_receive_group;
+				wq_int.s.wq_int = 1 << pow_receive_group;
+				cvmx_write_csr(CVMX_POW_WQ_INT, wq_int.u64);
+			}
 			break;
 		}
 		pskb = (struct sk_buff **)(cvm_oct_get_buffer_ptr(work->packet_ptr) -
@@ -422,8 +429,6 @@ void cvm_oct_rx_initialize(void)
 {
 	int i;
 	struct net_device *dev_for_napi = NULL;
-	union cvmx_pow_wq_int_thrx int_thr;
-	union cvmx_pow_wq_int_pc int_pc;
 
 	for (i = 0; i < TOTAL_NUMBER_OF_PORTS; i++) {
 		if (cvm_oct_device[i]) {
@@ -449,15 +454,34 @@ void cvm_oct_rx_initialize(void)
 
 	disable_irq_nosync(OCTEON_IRQ_WORKQ0 + pow_receive_group);
 
-	int_thr.u64 = 0;
-	int_thr.s.tc_en = 1;
-	int_thr.s.tc_thr = 1;
 	/* Enable POW interrupt when our port has at least one packet */
-	cvmx_write_csr(CVMX_POW_WQ_INT_THRX(pow_receive_group), int_thr.u64);
-
-	int_pc.u64 = 0;
-	int_pc.s.pc_thr = 5;
-	cvmx_write_csr(CVMX_POW_WQ_INT_PC, int_pc.u64);
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
+		union cvmx_sso_wq_int_thrx int_thr;
+		union cvmx_pow_wq_int_pc int_pc;
+
+		int_thr.u64 = 0;
+		int_thr.s.tc_en = 1;
+		int_thr.s.tc_thr = 1;
+		cvmx_write_csr(CVMX_SSO_WQ_INT_THRX(pow_receive_group),
+			       int_thr.u64);
+
+		int_pc.u64 = 0;
+		int_pc.s.pc_thr = 5;
+		cvmx_write_csr(CVMX_SSO_WQ_INT_PC, int_pc.u64);
+	} else {
+		union cvmx_pow_wq_int_thrx int_thr;
+		union cvmx_pow_wq_int_pc int_pc;
+
+		int_thr.u64 = 0;
+		int_thr.s.tc_en = 1;
+		int_thr.s.tc_thr = 1;
+		cvmx_write_csr(CVMX_POW_WQ_INT_THRX(pow_receive_group),
+			       int_thr.u64);
+
+		int_pc.u64 = 0;
+		int_pc.s.pc_thr = 5;
+		cvmx_write_csr(CVMX_POW_WQ_INT_PC, int_pc.u64);
+	}
 
 	/* Schedule NAPI now. This will indirectly enable the interrupt. */
 	napi_schedule(&cvm_oct_napi);
diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index f9dba23..363742a 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -859,7 +859,10 @@ static int cvm_oct_remove(struct platform_device *pdev)
 	int port;
 
 	/* Disable POW interrupt */
-	cvmx_write_csr(CVMX_POW_WQ_INT_THRX(pow_receive_group), 0);
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
+		cvmx_write_csr(CVMX_SSO_WQ_INT_THRX(pow_receive_group), 0);
+	else
+		cvmx_write_csr(CVMX_POW_WQ_INT_THRX(pow_receive_group), 0);
 
 	cvmx_ipd_disable();
 
-- 
2.4.3
