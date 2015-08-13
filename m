Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 15:25:18 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:55470 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012053AbbHMNY6RQgEC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 15:24:58 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7DDOge7003483
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 13 Aug 2015 13:24:42 GMT
Received: from localhost.localdomain ([10.144.34.184])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t7DDObQO030804;
        Thu, 13 Aug 2015 15:24:41 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Janne Huttunen <janne.huttunen@nokia.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 05/14] MIPS: OCTEON: configure minimum PKO packet sizes on CN68XX
Date:   Thu, 13 Aug 2015 16:21:37 +0300
Message-Id: <1439472106-7750-6-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1234
X-purgate-ID: 151667::1439472282-00007F5C-3376EEBC/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48846
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

CN68XX has common minimum packet size filters that need to be configured
for the traffic to work. Just set them to a default value.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index ed4816c2..376701f 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -658,6 +658,21 @@ static int __cvmx_helper_global_setup_pko(void)
 	fau_to.s.tout_val = 0xfff;
 	fau_to.s.tout_enb = 0;
 	cvmx_write_csr(CVMX_IOB_FAU_TIMEOUT, fau_to.u64);
+
+	if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
+		union cvmx_pko_reg_min_pkt min_pkt;
+
+		min_pkt.u64 = 0;
+		min_pkt.s.size1 = 59;
+		min_pkt.s.size2 = 59;
+		min_pkt.s.size3 = 59;
+		min_pkt.s.size4 = 59;
+		min_pkt.s.size5 = 59;
+		min_pkt.s.size6 = 59;
+		min_pkt.s.size7 = 59;
+		cvmx_write_csr(CVMX_PKO_REG_MIN_PKT, min_pkt.u64);
+	}
+
 	return 0;
 }
 
-- 
2.4.3
