Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 16:37:21 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:27999 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026246AbbEPOf0s14JE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 16:35:26 +0200
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4GEY9I6004071
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 May 2015 14:34:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEY8U1016046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 16 May 2015 14:34:08 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEY8a1012183;
        Sat, 16 May 2015 14:34:08 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.239.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 May 2015 07:34:07 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: OCTEON: Use correct CSR to soft reset
Date:   Sat, 16 May 2015 10:33:12 -0400
Message-Id: <1431786833-25487-4-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
References: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Chandrakala Chavva <cchavva@caviumnetworks.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit fe2360f8f505ea8340f710f1c80a8f56462bdd62 ]

This fixes reboot for Octeon III boards

[ralf@linux-mips.org: Dropped segment for function cvmx_reset_octeon()
which was removed by the preceeding commit.]

Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9464/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/cavium-octeon/setup.c     | 5 ++++-
 arch/mips/include/asm/octeon/cvmx.h | 8 --------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 5ebdb32..de9b625 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -412,7 +412,10 @@ static void octeon_restart(char *command)
 
 	mb();
 	while (1)
-		cvmx_write_csr(CVMX_CIU_SOFT_RST, 1);
+		if (OCTEON_IS_OCTEON3())
+			cvmx_write_csr(CVMX_RST_SOFT_RST, 1);
+		else
+			cvmx_write_csr(CVMX_CIU_SOFT_RST, 1);
 }
 
 
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index f991e77..f5ca449 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -436,14 +436,6 @@ static inline uint64_t cvmx_get_cycle_global(void)
 
 /***************************************************************************/
 
-static inline void cvmx_reset_octeon(void)
-{
-	union cvmx_ciu_soft_rst ciu_soft_rst;
-	ciu_soft_rst.u64 = 0;
-	ciu_soft_rst.s.soft_rst = 1;
-	cvmx_write_csr(CVMX_CIU_SOFT_RST, ciu_soft_rst.u64);
-}
-
 /* Return the number of cores available in the chip */
 static inline uint32_t cvmx_octeon_num_cores(void)
 {
-- 
2.1.0
