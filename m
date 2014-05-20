Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 16:49:37 +0200 (CEST)
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:38185
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855030AbaETOscqoHkP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 May 2014 16:48:32 +0200
Received: from localhost.localdomain (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Tue, 20 May 2014 14:48:29 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 02/15] MIPS: Move system level config items from CPU_CAVIUM_OCTEON to CAVIUM_OCTEON_SOC
Date:   Tue, 20 May 2014 16:47:03 +0200
Message-ID: <1400597236-11352-3-git-send-email-andreas.herrmann@caviumnetworks.com>
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
X-archive-position: 40176
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

They are a property of the SoC not the CPU itself.

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/Kconfig |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5cd695f..de32ab5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -721,6 +721,11 @@ config CAVIUM_OCTEON_SOC
 	select ZONE_DMA32
 	select HOLES_IN_ZONE
 	select ARCH_REQUIRE_GPIOLIB
+	select LIBFDT
+	select USE_OF
+	select ARCH_SPARSEMEM_ENABLE
+	select SYS_SUPPORTS_SMP
+	select NR_CPUS_DEFAULT_16
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
@@ -1398,16 +1403,11 @@ config CPU_SB1
 config CPU_CAVIUM_OCTEON
 	bool "Cavium Octeon processor"
 	depends on SYS_HAS_CPU_CAVIUM_OCTEON
-	select ARCH_SPARSEMEM_ENABLE
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_64BIT_KERNEL
-	select SYS_SUPPORTS_SMP
-	select NR_CPUS_DEFAULT_16
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
-	select LIBFDT
-	select USE_OF
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	select MIPS_L1_CACHE_SHIFT_7
 	help
-- 
1.7.9.5
