Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 19:02:15 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19978 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491109Ab1BQSCM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 19:02:12 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5d62d70000>; Thu, 17 Feb 2011 10:03:03 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 10:02:10 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 10:02:10 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p1HI265Y026093;
        Thu, 17 Feb 2011 10:02:06 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p1HI25lB026091;
        Thu, 17 Feb 2011 10:02:05 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH] MIPS: Only include arch/mips/cavium-octeon/Kconfig if CPU_CAVIUM_OCTEON
Date:   Thu, 17 Feb 2011 10:02:03 -0800
Message-Id: <1297965723-26059-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 17 Feb 2011 18:02:10.0753 (UTC) FILETIME=[CC5DA310:01CBCECC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Instead of making each Octeon specific option depend on
CPU_CAVIUM_OCTEON, just quit including cavium-octeon/Kconfig if it is
not applicable.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/Kconfig               |    4 ++++
 arch/mips/cavium-octeon/Kconfig |    3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bd7b64d..b0a1cb3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -748,7 +748,11 @@ source "arch/mips/sgi-ip27/Kconfig"
 source "arch/mips/sibyte/Kconfig"
 source "arch/mips/txx9/Kconfig"
 source "arch/mips/vr41xx/Kconfig"
+
+if CPU_CAVIUM_OCTEON
 source "arch/mips/cavium-octeon/Kconfig"
+endif
+
 source "arch/mips/loongson/Kconfig"
 
 endmenu
diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index caae228..3dab0ec 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -1,6 +1,5 @@
 config CAVIUM_OCTEON_SPECIFIC_OPTIONS
 	bool "Enable Octeon specific options"
-	depends on CPU_CAVIUM_OCTEON
 	default "y"
 
 config CAVIUM_CN63XXP1
@@ -93,7 +92,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC
-	depends on CPU_CAVIUM_OCTEON
 
 config CAVIUM_OCTEON_HELPER
 	def_bool y
@@ -107,6 +105,5 @@ config NEED_SG_DMA_LENGTH
 
 config SWIOTLB
 	def_bool y
-	depends on CPU_CAVIUM_OCTEON
 	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
-- 
1.7.2.3
