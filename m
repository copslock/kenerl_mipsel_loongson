Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:40:45 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49107 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026385AbbEATh5hblMy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:37:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 13F8156F588;
        Fri,  1 May 2015 22:37:56 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id 0eAxrNXreweV; Fri,  1 May 2015 22:37:51 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 8ACF75BC00C;
        Fri,  1 May 2015 22:37:48 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 09/11] MIPS: OCTEON: move ethernet-specific helpers to staging
Date:   Fri,  1 May 2015 22:37:11 +0300
Message-Id: <1430509033-12113-10-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Move all ethernet-specific helpers to staging.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/Makefile                |  8 +-------
 arch/mips/cavium-octeon/executive/cvmx-helper-board.c     |  1 +
 arch/mips/cavium-octeon/executive/cvmx-helper.c           |  1 +
 drivers/staging/octeon/Makefile                           | 15 ++++++++++++++-
 .../executive => drivers/staging/octeon}/cvmx-cmd-queue.c |  0
 .../staging/octeon}/cvmx-helper-ethernet.c                |  0
 .../staging/octeon}/cvmx-helper-loop.c                    |  0
 .../staging/octeon}/cvmx-helper-npi.c                     |  0
 .../staging/octeon}/cvmx-helper-rgmii.c                   |  0
 .../staging/octeon}/cvmx-helper-sgmii.c                   |  0
 .../staging/octeon}/cvmx-helper-spi.c                     |  0
 .../staging/octeon}/cvmx-helper-util.c                    |  0
 .../staging/octeon}/cvmx-helper-xaui.c                    |  0
 .../staging/octeon}/cvmx-interrupt-decodes.c              |  0
 .../staging/octeon}/cvmx-interrupt-rsl.c                  |  0
 .../executive => drivers/staging/octeon}/cvmx-link.c      |  0
 .../executive => drivers/staging/octeon}/cvmx-pko.c       |  0
 .../executive => drivers/staging/octeon}/cvmx-spi.c       |  0
 18 files changed, 17 insertions(+), 8 deletions(-)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-cmd-queue.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-ethernet.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-loop.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-npi.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-rgmii.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-sgmii.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-spi.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-util.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-helper-xaui.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-interrupt-decodes.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-interrupt-rsl.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-link.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-pko.c (100%)
 rename {arch/mips/cavium-octeon/executive => drivers/staging/octeon}/cvmx-spi.c (100%)

diff --git a/arch/mips/cavium-octeon/executive/Makefile b/arch/mips/cavium-octeon/executive/Makefile
index abafe06..6e59ee4 100644
--- a/arch/mips/cavium-octeon/executive/Makefile
+++ b/arch/mips/cavium-octeon/executive/Makefile
@@ -10,11 +10,5 @@
 #
 
 obj-y += cvmx-bootmem.o cvmx-l2c.o cvmx-sysinfo.o octeon-model.o
-obj-y += cvmx-pko.o cvmx-spi.o cvmx-cmd-queue.o \
-	cvmx-helper-board.o cvmx-helper.o cvmx-helper-xaui.o \
-	cvmx-helper-rgmii.o cvmx-helper-sgmii.o cvmx-helper-npi.o \
-	cvmx-helper-loop.o cvmx-helper-spi.o cvmx-helper-util.o \
-	cvmx-helper-ethernet.o cvmx-link.o \
-	cvmx-interrupt-decodes.o cvmx-interrupt-rsl.o
-
+obj-y += cvmx-helper-board.o cvmx-helper.o
 obj-y += cvmx-helper-errata.o cvmx-helper-jtag.o
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 10f8de1..32d3284 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -186,6 +186,7 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 	     cvmx_sysinfo_get()->board_type);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_board_get_mii_address);
 
 /**
  * This function is called by cvmx_helper_interface_probe() after it
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 414ca1a..995fa42 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -506,3 +506,4 @@ int cvmx_helper_interface_enumerate(int interface)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cvmx_helper_interface_enumerate);
diff --git a/drivers/staging/octeon/Makefile b/drivers/staging/octeon/Makefile
index 9012dee..9a72fea 100644
--- a/drivers/staging/octeon/Makefile
+++ b/drivers/staging/octeon/Makefile
@@ -20,4 +20,17 @@ octeon-ethernet-y += ethernet-sgmii.o
 octeon-ethernet-y += ethernet-spi.o
 octeon-ethernet-y += ethernet-tx.o
 octeon-ethernet-y += ethernet-xaui.o
-
+octeon-ethernet-y += cvmx-cmd-queue.o
+octeon-ethernet-y += cvmx-helper-ethernet.o
+octeon-ethernet-y += cvmx-helper-loop.o
+octeon-ethernet-y += cvmx-helper-npi.o
+octeon-ethernet-y += cvmx-helper-rgmii.o
+octeon-ethernet-y += cvmx-helper-sgmii.o
+octeon-ethernet-y += cvmx-helper-spi.o
+octeon-ethernet-y += cvmx-helper-util.o
+octeon-ethernet-y += cvmx-helper-xaui.o
+octeon-ethernet-y += cvmx-interrupt-decodes.o
+octeon-ethernet-y += cvmx-interrupt-rsl.o
+octeon-ethernet-y += cvmx-link.o
+octeon-ethernet-y += cvmx-pko.o
+octeon-ethernet-y += cvmx-spi.o
diff --git a/arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c b/drivers/staging/octeon/cvmx-cmd-queue.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c
rename to drivers/staging/octeon/cvmx-cmd-queue.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-ethernet.c b/drivers/staging/octeon/cvmx-helper-ethernet.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-helper-ethernet.c
rename to drivers/staging/octeon/cvmx-helper-ethernet.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-loop.c b/drivers/staging/octeon/cvmx-helper-loop.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-helper-loop.c
rename to drivers/staging/octeon/cvmx-helper-loop.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-npi.c b/drivers/staging/octeon/cvmx-helper-npi.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-helper-npi.c
rename to drivers/staging/octeon/cvmx-helper-npi.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/drivers/staging/octeon/cvmx-helper-rgmii.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
rename to drivers/staging/octeon/cvmx-helper-rgmii.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/drivers/staging/octeon/cvmx-helper-sgmii.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
rename to drivers/staging/octeon/cvmx-helper-sgmii.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/drivers/staging/octeon/cvmx-helper-spi.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
rename to drivers/staging/octeon/cvmx-helper-spi.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-util.c b/drivers/staging/octeon/cvmx-helper-util.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-helper-util.c
rename to drivers/staging/octeon/cvmx-helper-util.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/drivers/staging/octeon/cvmx-helper-xaui.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
rename to drivers/staging/octeon/cvmx-helper-xaui.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-interrupt-decodes.c b/drivers/staging/octeon/cvmx-interrupt-decodes.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-interrupt-decodes.c
rename to drivers/staging/octeon/cvmx-interrupt-decodes.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-interrupt-rsl.c b/drivers/staging/octeon/cvmx-interrupt-rsl.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-interrupt-rsl.c
rename to drivers/staging/octeon/cvmx-interrupt-rsl.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-link.c b/drivers/staging/octeon/cvmx-link.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-link.c
rename to drivers/staging/octeon/cvmx-link.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/drivers/staging/octeon/cvmx-pko.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-pko.c
rename to drivers/staging/octeon/cvmx-pko.c
diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/drivers/staging/octeon/cvmx-spi.c
similarity index 100%
rename from arch/mips/cavium-octeon/executive/cvmx-spi.c
rename to drivers/staging/octeon/cvmx-spi.c
-- 
2.3.3
