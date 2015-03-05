Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 16:08:45 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:13433 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007137AbbCEPInhUAG- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 16:08:43 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 5 Mar
 2015 18:08:39 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: OCTEON: Use correct CSR to soft reset
Date:   Thu, 5 Mar 2015 18:06:11 +0300
Message-ID: <1425567974-31912-1-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.3.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksey.makarov@auriga.com
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

This fixes reboot for Octeon III boards

Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/cavium-octeon/setup.c     | 5 ++++-
 arch/mips/include/asm/octeon/cvmx.h | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 01130e9..73348af 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -416,7 +416,10 @@ static void octeon_restart(char *command)
 
 	mb();
 	while (1)
-		cvmx_write_csr(CVMX_CIU_SOFT_RST, 1);
+		if (OCTEON_IS_OCTEON3())
+			cvmx_write_csr(CVMX_RST_SOFT_RST, 1);
+		else
+			cvmx_write_csr(CVMX_CIU_SOFT_RST, 1);
 }
 
 
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 33db1c8..fb575d7 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -66,6 +66,7 @@ enum cvmx_mips_space {
 #include <asm/octeon/cvmx-led-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
 #include <asm/octeon/cvmx-pow-defs.h>
+#include <asm/octeon/cvmx-rst-defs.h>
 
 #include <asm/octeon/cvmx-bootinfo.h>
 #include <asm/octeon/cvmx-bootmem.h>
@@ -441,7 +442,10 @@ static inline void cvmx_reset_octeon(void)
 	union cvmx_ciu_soft_rst ciu_soft_rst;
 	ciu_soft_rst.u64 = 0;
 	ciu_soft_rst.s.soft_rst = 1;
-	cvmx_write_csr(CVMX_CIU_SOFT_RST, ciu_soft_rst.u64);
+	if (OCTEON_IS_OCTEON3())
+		cvmx_write_csr(CVMX_RST_SOFT_RST, ciu_soft_rst.u64);
+	else
+		cvmx_write_csr(CVMX_CIU_SOFT_RST, ciu_soft_rst.u64);
 }
 
 /* Return the number of cores available in the chip */
-- 
2.3.0
