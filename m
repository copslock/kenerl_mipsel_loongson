Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:39:20 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49094 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026344AbbEAThySewG4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:37:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id E1E4056F4B3;
        Fri,  1 May 2015 22:37:55 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id bNx2lcEHWEOR; Fri,  1 May 2015 22:37:51 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id CB4185BC00A;
        Fri,  1 May 2015 22:37:47 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 07/11] MIPS: OCTEON: make all interface enumeration helpers static
Date:   Fri,  1 May 2015 22:37:09 +0300
Message-Id: <1430509033-12113-8-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47192
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

Make all interface enumeration helpers static.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c  | 10 +++++-----
 arch/mips/include/asm/octeon/cvmx-helper-npi.h   | 11 -----------
 arch/mips/include/asm/octeon/cvmx-helper-rgmii.h |  9 ---------
 arch/mips/include/asm/octeon/cvmx-helper-sgmii.h |  1 -
 arch/mips/include/asm/octeon/cvmx-helper-spi.h   |  1 -
 arch/mips/include/asm/octeon/cvmx-helper-xaui.h  |  1 -
 6 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index c0c541b..414ca1a 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -316,7 +316,7 @@ static int __cvmx_helper_loop_enumerate(int interface)
  *
  * Returns Number of ports on the interface. Zero to disable.
  */
-int __cvmx_helper_npi_enumerate(int interface)
+static int __cvmx_helper_npi_enumerate(int interface)
 {
 #if CVMX_PKO_QUEUES_PER_PORT_PCI > 0
 	if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX))
@@ -352,7 +352,7 @@ int __cvmx_helper_npi_enumerate(int interface)
  *
  * Returns Number of RGMII/GMII/MII ports (0-4).
  */
-int __cvmx_helper_rgmii_enumerate(int interface)
+static int __cvmx_helper_rgmii_enumerate(int interface)
 {
 	int num_ports = 0;
 	union cvmx_gmxx_inf_mode mode;
@@ -391,12 +391,12 @@ int __cvmx_helper_rgmii_enumerate(int interface)
 	return num_ports;
 }
 
-int __cvmx_helper_sgmii_enumerate(int interface)
+static int __cvmx_helper_sgmii_enumerate(int interface)
 {
 	return 4;
 }
 
-int __cvmx_helper_spi_enumerate(int interface)
+static int __cvmx_helper_spi_enumerate(int interface)
 {
 	if ((cvmx_sysinfo_get()->board_type != CVMX_BOARD_TYPE_SIM) &&
 	    cvmx_spi4000_is_present(interface)) {
@@ -406,7 +406,7 @@ int __cvmx_helper_spi_enumerate(int interface)
 	}
 }
 
-int __cvmx_helper_xaui_enumerate(int interface)
+static int __cvmx_helper_xaui_enumerate(int interface)
 {
 	union cvmx_gmxx_hg2_control gmx_hg2_control;
 
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-npi.h b/arch/mips/include/asm/octeon/cvmx-helper-npi.h
index bab9931..84a94ee 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-npi.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-npi.h
@@ -36,17 +36,6 @@
 #define __CVMX_HELPER_NPI_H__
 
 /**
- * Enumerate a NPI interface and determine the number of ports
- * connected to it. The NPI interface should still be down after
- * this call.
- *
- * @interface: Interface to enumerate
- *
- * Returns Number of ports on the interface. Zero to disable.
- */
-extern int __cvmx_helper_npi_enumerate(int interface);
-
-/**
  * Bringup and enable a NPI interface. After this call packet
  * I/O should be fully functional. This is called with IPD
  * enabled but PKO disabled.
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h b/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
index df7717b..7dfe5f5 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
@@ -36,15 +36,6 @@
 #define __CVMX_HELPER_RGMII_H__
 
 /**
- * Enumerate RGMII ports and determine the number present
- *
- * @interface: Interface to enumerate
- *
- * Returns Number of RGMII/GMII/MII ports (0-4).
- */
-extern int __cvmx_helper_rgmii_enumerate(int interface);
-
-/**
  * Put an RGMII interface in loopback mode. Internal packets sent
  * out will be received back again on the same port. Externally
  * received packets will echo back out.
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h b/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
index eb51835..f4c9eb1 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
@@ -45,7 +45,6 @@
  * Returns Number of ports on the interface. Zero to disable.
  */
 extern void __cvmx_helper_sgmii_probe(int interface);
-extern int __cvmx_helper_sgmii_enumerate(int interface);
 
 /**
  * Bringup and enable a SGMII interface. After this call packet
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-spi.h b/arch/mips/include/asm/octeon/cvmx-helper-spi.h
index 9f1c6b9..69bac03 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-spi.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-spi.h
@@ -42,7 +42,6 @@
  * Returns Number of ports on the interface. Zero to disable.
  */
 extern int __cvmx_helper_spi_probe(int interface);
-extern int __cvmx_helper_spi_enumerate(int interface);
 
 /**
  * Bringup and enable a SPI interface. After this call packet I/O
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-xaui.h b/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
index 9fbcea3..c392808 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
@@ -45,7 +45,6 @@
  * Returns Number of ports on the interface. Zero to disable.
  */
 extern void __cvmx_helper_xaui_probe(int interface);
-extern int __cvmx_helper_xaui_enumerate(int interface);
 
 /**
  * Bringup and enable a XAUI interface. After this call packet
-- 
2.3.3
