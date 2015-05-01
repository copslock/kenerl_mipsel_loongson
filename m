Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:40:11 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49101 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026373AbbEAThzfhqRS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:37:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id EEC6C56F4B4;
        Fri,  1 May 2015 22:37:55 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id t3b27+BULDMz; Fri,  1 May 2015 22:37:51 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id AC7DE5BC009;
        Fri,  1 May 2015 22:37:47 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 06/11] MIPS: OCTEON: rename __cvmx_helper_npi/rgmii_probe
Date:   Fri,  1 May 2015 22:37:08 +0300
Message-Id: <1430509033-12113-7-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47195
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

Rename __cvmx_helper_npi/rgmii_probe to __cvmx_helper_npi/rgmii_enumerate
as only latter are used.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/executive/cvmx-helper.c  | 12 ++++++------
 arch/mips/include/asm/octeon/cvmx-helper-npi.h   |  7 +++----
 arch/mips/include/asm/octeon/cvmx-helper-rgmii.h |  7 +++----
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index de6e619..c0c541b 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -308,15 +308,15 @@ static int __cvmx_helper_loop_enumerate(int interface)
 }
 
 /**
- * Probe a NPI interface and determine the number of ports
+ * Enumerate a NPI interface and determine the number of ports
  * connected to it. The NPI interface should still be down
  * after this call.
  *
- * @interface: Interface to probe
+ * @interface: Interface to enumerate
  *
  * Returns Number of ports on the interface. Zero to disable.
  */
-int __cvmx_helper_npi_probe(int interface)
+int __cvmx_helper_npi_enumerate(int interface)
 {
 #if CVMX_PKO_QUEUES_PER_PORT_PCI > 0
 	if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX))
@@ -346,13 +346,13 @@ int __cvmx_helper_npi_probe(int interface)
 }
 
 /**
- * Probe RGMII ports and determine the number present
+ * Enumerate RGMII ports and determine the number present
  *
- * @interface: Interface to probe
+ * @interface: Interface to enumerate
  *
  * Returns Number of RGMII/GMII/MII ports (0-4).
  */
-int __cvmx_helper_rgmii_probe(int interface)
+int __cvmx_helper_rgmii_enumerate(int interface)
 {
 	int num_ports = 0;
 	union cvmx_gmxx_inf_mode mode;
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-npi.h b/arch/mips/include/asm/octeon/cvmx-helper-npi.h
index 8df4c7f..bab9931 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-npi.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-npi.h
@@ -36,16 +36,15 @@
 #define __CVMX_HELPER_NPI_H__
 
 /**
- * Probe a NPI interface and determine the number of ports
+ * Enumerate a NPI interface and determine the number of ports
  * connected to it. The NPI interface should still be down after
  * this call.
  *
- * @interface: Interface to probe
+ * @interface: Interface to enumerate
  *
  * Returns Number of ports on the interface. Zero to disable.
  */
-extern int __cvmx_helper_npi_probe(int interface);
-#define __cvmx_helper_npi_enumerate __cvmx_helper_npi_probe
+extern int __cvmx_helper_npi_enumerate(int interface);
 
 /**
  * Bringup and enable a NPI interface. After this call packet
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h b/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
index 4d7a3db..df7717b 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
@@ -36,14 +36,13 @@
 #define __CVMX_HELPER_RGMII_H__
 
 /**
- * Probe RGMII ports and determine the number present
+ * Enumerate RGMII ports and determine the number present
  *
- * @interface: Interface to probe
+ * @interface: Interface to enumerate
  *
  * Returns Number of RGMII/GMII/MII ports (0-4).
  */
-extern int __cvmx_helper_rgmii_probe(int interface);
-#define __cvmx_helper_rgmii_enumerate __cvmx_helper_rgmii_probe
+extern int __cvmx_helper_rgmii_enumerate(int interface);
 
 /**
  * Put an RGMII interface in loopback mode. Internal packets sent
-- 
2.3.3
