Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 15:28:16 +0200 (CEST)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:53728 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012374AbbHMNZDf4Dfh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 15:25:03 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7DDOhO0009923
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2015 13:24:43 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7DDObQP030804;
        Thu, 13 Aug 2015 15:24:41 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Janne Huttunen <janne.huttunen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 06/14] MIPS: OCTEON: add definitions for setting up SSO
Date:   Thu, 13 Aug 2015 16:21:38 +0300
Message-Id: <1439472106-7750-7-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 2059
X-purgate-ID: 151667::1439472283-0000676C-B8EADBB4/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48856
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

From: Janne Huttunen <janne.huttunen@nokia.com>

Some Octeon II models have SSO instead of POW and use a different register
for setting the interrupt thresholds. Add the necessary definitions for
configuring the interrupts also on those models.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/include/asm/octeon/cvmx-pow-defs.h | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/mips/include/asm/octeon/cvmx-pow-defs.h b/arch/mips/include/asm/octeon/cvmx-pow-defs.h
index 9020ef4..6a3db4b 100644
--- a/arch/mips/include/asm/octeon/cvmx-pow-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-pow-defs.h
@@ -52,6 +52,12 @@
 #define CVMX_POW_WQ_INT_THRX(offset) (CVMX_ADD_IO_SEG(0x0001670000000080ull) + ((offset) & 15) * 8)
 #define CVMX_POW_WS_PCX(offset) (CVMX_ADD_IO_SEG(0x0001670000000280ull) + ((offset) & 15) * 8)
 
+#define CVMX_SSO_WQ_INT (CVMX_ADD_IO_SEG(0x0001670000001000ull))
+#define CVMX_SSO_WQ_IQ_DIS (CVMX_ADD_IO_SEG(0x0001670000001010ull))
+#define CVMX_SSO_WQ_INT_PC (CVMX_ADD_IO_SEG(0x0001670000001020ull))
+#define CVMX_SSO_PPX_GRP_MSK(offset) (CVMX_ADD_IO_SEG(0x0001670000006000ull) + ((offset) & 31) * 8)
+#define CVMX_SSO_WQ_INT_THRX(offset) (CVMX_ADD_IO_SEG(0x0001670000007000ull) + ((offset) & 63) * 8)
+
 union cvmx_pow_bist_stat {
 	uint64_t u64;
 	struct cvmx_pow_bist_stat_s {
@@ -1286,4 +1292,27 @@ union cvmx_pow_ws_pcx {
 	struct cvmx_pow_ws_pcx_s cnf71xx;
 };
 
+union cvmx_sso_wq_int_thrx {
+	uint64_t u64;
+	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
+		uint64_t reserved_33_63:31;
+		uint64_t tc_en:1;
+		uint64_t tc_thr:4;
+		uint64_t reserved_26_27:2;
+		uint64_t ds_thr:12;
+		uint64_t reserved_12_13:2;
+		uint64_t iq_thr:12;
+#else
+		uint64_t iq_thr:12;
+		uint64_t reserved_12_13:2;
+		uint64_t ds_thr:12;
+		uint64_t reserved_26_27:2;
+		uint64_t tc_thr:4;
+		uint64_t tc_en:1;
+		uint64_t reserved_33_63:31;
+#endif
+	} s;
+};
+
 #endif
-- 
2.4.3
