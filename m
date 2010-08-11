Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2010 19:31:05 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.187]:62674 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492342Ab0HKRa6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Aug 2010 19:30:58 +0200
Received: from corscience.de (DSL01.212.114.252.242.ip-pool.NEFkom.net [212.114.252.242])
        by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
        id 0Mg0GL-1OXJsq1xxd-00NIQg; Wed, 11 Aug 2010 18:50:01 +0200
Received: from localhost (unknown [192.168.102.9])
        by corscience.de (Postfix) with ESMTP id 02D0E51F50;
        Wed, 11 Aug 2010 18:50:01 +0200 (CEST)
Received: from abiessmann by localhost with local (Exim 4.72)
        (envelope-from <biessmann@corscience.de>)
        id 1OjEV6-0006Em-WF; Wed, 11 Aug 2010 18:50:01 +0200
From:   =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH] cavium-octeon: determine if helper should build
Date:   Wed, 11 Aug 2010 18:49:53 +0200
Message-Id: <1281545393-23690-1-git-send-email-biessmann@corscience.de>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V02:K0:Jg6lrylfCqiDt0vlsHVd2yft7HU2csdKNh3vg4BJJiD
 q/q57psZkgKO+xR9MOGijzkCwWxUw/7FZJvU/DyoLpjiwsMSzI
 hX5D58XzRrblau7jBM8vAB7evzjwrhrsI6AvJxzGcD4rxwQ7pY
 6BLYDB7Vnau1Nsz2FtbQkTdWQ+L+9tE5066t2H53O7Auv4LvsR
 3pBJcEml1zU61sc7rJF0A==
Return-Path: <biessmann@corscience.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: biessmann@corscience.de
Precedence: bulk
X-list: linux-mips

 This patch adds an config switch to determine if we need to build some
 workaround helper files.

 The staging driver octeon-ethernet references some symbols which are only
 built when PCI is enabled. The new config switch enables these symbols in
 bothe cases.

Signed-off-by: Andreas Bießmann <biessmann@corscience.de>
---
 arch/mips/cavium-octeon/Kconfig            |    4 ++++
 arch/mips/cavium-octeon/executive/Makefile |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 094c17e..47323ca 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -83,3 +83,7 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC
 	depends on CPU_CAVIUM_OCTEON
+
+config CAVIUM_OCTEON_HELPER
+	def_bool y
+	depends on OCTEON_ETHERNET || PCI
diff --git a/arch/mips/cavium-octeon/executive/Makefile b/arch/mips/cavium-octeon/executive/Makefile
index 2fd66db..7f41c5b 100644
--- a/arch/mips/cavium-octeon/executive/Makefile
+++ b/arch/mips/cavium-octeon/executive/Makefile
@@ -11,4 +11,4 @@
 
 obj-y += cvmx-bootmem.o cvmx-l2c.o cvmx-sysinfo.o octeon-model.o
 
-obj-$(CONFIG_PCI) += cvmx-helper-errata.o cvmx-helper-jtag.o
+obj-$(CONFIG_CAVIUM_OCTEON_HELPER) += cvmx-helper-errata.o cvmx-helper-jtag.o
-- 
1.7.1
