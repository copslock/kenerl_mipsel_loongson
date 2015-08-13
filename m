Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 15:26:10 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:55473 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012214AbbHMNY6mVrz9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 15:24:58 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7DDOhWn003589
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2015 13:24:44 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7DDObQR030804;
        Thu, 13 Aug 2015 15:24:43 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Janne Huttunen <janne.huttunen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 08/14] MIPS/staging: OCTEON: set SSO group mask properly on CN68XX
Date:   Thu, 13 Aug 2015 16:21:40 +0300
Message-Id: <1439472106-7750-9-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1908
X-purgate-ID: 151667::1439472284-00007F5C-C0FAFBE3/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48849
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

CN68XX uses SSO instead of POW.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/staging/octeon/ethernet-rx.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 1636bd9..abfe934 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -172,9 +172,16 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 	}
 
 	/* Only allow work for our group (and preserve priorities) */
-	old_group_mask = cvmx_read_csr(CVMX_POW_PP_GRP_MSKX(coreid));
-	cvmx_write_csr(CVMX_POW_PP_GRP_MSKX(coreid),
-		       (old_group_mask & ~0xFFFFull) | 1 << pow_receive_group);
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
+		old_group_mask = cvmx_read_csr(CVMX_SSO_PPX_GRP_MSK(coreid));
+		cvmx_write_csr(CVMX_SSO_PPX_GRP_MSK(coreid),
+				1ull << pow_receive_group);
+		cvmx_read_csr(CVMX_SSO_PPX_GRP_MSK(coreid)); /* Flush */
+	} else {
+		old_group_mask = cvmx_read_csr(CVMX_POW_PP_GRP_MSKX(coreid));
+		cvmx_write_csr(CVMX_POW_PP_GRP_MSKX(coreid),
+			(old_group_mask & ~0xFFFFull) | 1 << pow_receive_group);
+	}
 
 	if (USE_ASYNC_IOBDMA) {
 		cvmx_pow_work_request_async(CVMX_SCR_SCRATCH, CVMX_POW_NO_WAIT);
@@ -397,7 +404,13 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
 		}
 	}
 	/* Restore the original POW group mask */
-	cvmx_write_csr(CVMX_POW_PP_GRP_MSKX(coreid), old_group_mask);
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
+		cvmx_write_csr(CVMX_SSO_PPX_GRP_MSK(coreid), old_group_mask);
+		cvmx_read_csr(CVMX_SSO_PPX_GRP_MSK(coreid)); /* Flush */
+	} else {
+		cvmx_write_csr(CVMX_POW_PP_GRP_MSKX(coreid), old_group_mask);
+	}
+
 	if (USE_ASYNC_IOBDMA) {
 		/* Restore the scratch area */
 		cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
-- 
2.4.3
