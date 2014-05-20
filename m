Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 16:50:48 +0200 (CEST)
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:26693
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855082AbaETOtB3004t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 May 2014 16:49:01 +0200
Received: from localhost.localdomain (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Tue, 20 May 2014 14:48:36 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 03/15] MIPS: OCTEON: Move CAVIUM_OCTEON_CVMSEG_SIZE to CPU_CAVIUM_OCTEON
Date:   Tue, 20 May 2014 16:47:04 +0200
Message-ID: <1400597236-11352-4-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM3PR01CA004.eurprd01.prod.exchangelabs.com
 (10.242.240.14) To DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 02176E2458
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6069001)(6009001)(428001)(199002)(189002)(79102001)(36756003)(48376002)(66066001)(77982001)(92726001)(50466002)(74502001)(46102001)(64706001)(47776003)(80022001)(20776003)(50226001)(33646001)(101416001)(50986999)(76482001)(77156001)(89996001)(42186004)(81542001)(92566001)(62966002)(81342001)(87976001)(93916002)(87286001)(4396001)(19580395003)(83072002)(88136002)(85852003)(21056001)(76176999)(83322001)(31966008)(74662001)(86362001)(99396002)(102836001)(19580405001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:localhost.localdomain;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

From: David Daney <david.daney@cavium.com>

CVMSEG is related to the CPU core not the SoC system.  So needs to be
configurable there.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/cavium-octeon/Kconfig |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 227705d..c5e9975 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -10,6 +10,17 @@ config CAVIUM_CN63XXP1
 	  non-CN63XXP1 hardware, so it is recommended to select "n"
 	  unless it is known the workarounds are needed.
 
+config CAVIUM_OCTEON_CVMSEG_SIZE
+	int "Number of L1 cache lines reserved for CVMSEG memory"
+	range 0 54
+	default 1
+	help
+	  CVMSEG LM is a segment that accesses portions of the dcache as a
+	  local memory; the larger CVMSEG is, the smaller the cache is.
+	  This selects the size of CVMSEG LM, which is in cache blocks. The
+	  legally range is from zero to 54 cache blocks (i.e. CVMSEG LM is
+	  between zero and 6192 bytes).
+
 endif # CPU_CAVIUM_OCTEON
 
 if CAVIUM_OCTEON_SOC
@@ -23,16 +34,16 @@ config CAVIUM_OCTEON_2ND_KERNEL
 	  with this option to be run at the same time as one built without this
 	  option.
 
-config CAVIUM_OCTEON_CVMSEG_SIZE
-	int "Number of L1 cache lines reserved for CVMSEG memory"
-	range 0 54
-	default 1
+config CAVIUM_OCTEON_HW_FIX_UNALIGNED
+	bool "Enable hardware fixups of unaligned loads and stores"
+	default "y"
 	help
-	  CVMSEG LM is a segment that accesses portions of the dcache as a
-	  local memory; the larger CVMSEG is, the smaller the cache is.
-	  This selects the size of CVMSEG LM, which is in cache blocks. The
-	  legally range is from zero to 54 cache blocks (i.e. CVMSEG LM is
-	  between zero and 6192 bytes).
+	  Configure the Octeon hardware to automatically fix unaligned loads
+	  and stores. Normally unaligned accesses are fixed using a kernel
+	  exception handler. This option enables the hardware automatic fixups,
+	  which requires only an extra 3 cycles. Disable this option if you
+	  are running code that relies on address exceptions on unaligned
+	  accesses.
 
 config CAVIUM_OCTEON_LOCK_L2
 	bool "Lock often used kernel code in the L2"
@@ -86,7 +97,6 @@ config SWIOTLB
 	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
 
-
 config OCTEON_ILM
 	tristate "Module to measure interrupt latency using Octeon CIU Timer"
 	help
-- 
1.7.9.5
