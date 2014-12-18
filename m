Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 11:21:51 +0100 (CET)
Received: from nivc-ms1.auriga.com ([80.240.102.146]:48856 "EHLO
        nivc-ms1.auriga.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009072AbaLRKVdFAPrE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 11:21:33 +0100
Received: from localhost (80.240.102.213) by NIVC-MS1.auriga.ru
 (80.240.102.146) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 18 Dec
 2014 13:21:27 +0300
From:   Aleksey Makarov <aleksey.makarov@auriga.com>
To:     <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 04/12] MIPS: OCTEON: Use correct instruction to read 64-bit COP0 register
Date:   Thu, 18 Dec 2014 13:17:56 +0300
Message-ID: <1418897888-17669-5-git-send-email-aleksey.makarov@auriga.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
References: <1418897888-17669-1-git-send-email-aleksey.makarov@auriga.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [80.240.102.213]
Return-Path: <aleksey.makarov@auriga.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44722
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

Use dmfc0/dmtc0 instructions for reading CvmMemCtl COP0 register,
its a 64-bit wide.

Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
---
 arch/mips/kernel/octeon_switch.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 590ca2d..f0a699d 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -80,7 +80,7 @@
 1:
 #if CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0
 	/* Check if we need to store CVMSEG state */
-	mfc0	t0, $11,7	/* CvmMemCtl */
+	dmfc0	t0, $11,7	/* CvmMemCtl */
 	bbit0	t0, 6, 3f	/* Is user access enabled? */
 
 	/* Store the CVMSEG state */
@@ -104,9 +104,9 @@
 	.set reorder
 
 	/* Disable access to CVMSEG */
-	mfc0	t0, $11,7	/* CvmMemCtl */
+	dmfc0	t0, $11,7	/* CvmMemCtl */
 	xori	t0, t0, 0x40	/* Bit 6 is CVMSEG user enable */
-	mtc0	t0, $11,7	/* CvmMemCtl */
+	dmtc0	t0, $11,7	/* CvmMemCtl */
 #endif
 3:
 
-- 
2.1.3
