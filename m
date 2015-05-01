Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 21:39:55 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:34927 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026358AbbEAThytHpxR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 21:37:54 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 5C7C25A6D68;
        Fri,  1 May 2015 22:37:44 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id 8OybUfd4fI3E; Fri,  1 May 2015 22:37:37 +0300 (EEST)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 643355BC007;
        Fri,  1 May 2015 22:37:47 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc:     devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [RFC PATCH 04/11] MIPS: OCTEON: move interface enumeration helpers to cvmx-helper
Date:   Fri,  1 May 2015 22:37:06 +0300
Message-Id: <1430509033-12113-5-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
References: <1430509033-12113-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47194
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

Move interface enumeration helpers to cvmx-helper.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../mips/cavium-octeon/executive/cvmx-helper-npi.c |  38 -------
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |  46 --------
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |   4 -
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |  10 --
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |  12 ---
 arch/mips/cavium-octeon/executive/cvmx-helper.c    | 117 +++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-helper-loop.h    |   1 -
 7 files changed, 117 insertions(+), 111 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-npi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-npi.c
index cc94cfa..9f7bcc4 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-npi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-npi.c
@@ -38,44 +38,6 @@
 #include <asm/octeon/cvmx-pip-defs.h>
 
 /**
- * Probe a NPI interface and determine the number of ports
- * connected to it. The NPI interface should still be down
- * after this call.
- *
- * @interface: Interface to probe
- *
- * Returns Number of ports on the interface. Zero to disable.
- */
-int __cvmx_helper_npi_probe(int interface)
-{
-#if CVMX_PKO_QUEUES_PER_PORT_PCI > 0
-	if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX))
-		return 4;
-	else if (OCTEON_IS_MODEL(OCTEON_CN56XX)
-		 && !OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X))
-		/* The packet engines didn't exist before pass 2 */
-		return 4;
-	else if (OCTEON_IS_MODEL(OCTEON_CN52XX)
-		 && !OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X))
-		/* The packet engines didn't exist before pass 2 */
-		return 4;
-#if 0
-	/*
-	 * Technically CN30XX, CN31XX, and CN50XX contain packet
-	 * engines, but nobody ever uses them. Since this is the case,
-	 * we disable them here.
-	 */
-	else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
-		 || OCTEON_IS_MODEL(OCTEON_CN50XX))
-		return 2;
-	else if (OCTEON_IS_MODEL(OCTEON_CN30XX))
-		return 1;
-#endif
-#endif
-	return 0;
-}
-
-/**
  * Bringup and enable a NPI interface. After this call packet
  * I/O should be fully functional. This is called with IPD
  * enabled but PKO disabled.
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index f59c88e..730812c 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -48,52 +48,6 @@ void __cvmx_interrupt_gmxx_enable(int interface);
 void __cvmx_interrupt_asxx_enable(int block);
 
 /**
- * Probe RGMII ports and determine the number present
- *
- * @interface: Interface to probe
- *
- * Returns Number of RGMII/GMII/MII ports (0-4).
- */
-int __cvmx_helper_rgmii_probe(int interface)
-{
-	int num_ports = 0;
-	union cvmx_gmxx_inf_mode mode;
-	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
-
-	if (mode.s.type) {
-		if (OCTEON_IS_MODEL(OCTEON_CN38XX)
-		    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
-			cvmx_dprintf("ERROR: RGMII initialize called in "
-				     "SPI interface\n");
-		} else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
-			   || OCTEON_IS_MODEL(OCTEON_CN30XX)
-			   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
-			/*
-			 * On these chips "type" says we're in
-			 * GMII/MII mode. This limits us to 2 ports
-			 */
-			num_ports = 2;
-		} else {
-			cvmx_dprintf("ERROR: Unsupported Octeon model in %s\n",
-				     __func__);
-		}
-	} else {
-		if (OCTEON_IS_MODEL(OCTEON_CN38XX)
-		    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
-			num_ports = 4;
-		} else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
-			   || OCTEON_IS_MODEL(OCTEON_CN30XX)
-			   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
-			num_ports = 3;
-		} else {
-			cvmx_dprintf("ERROR: Unsupported Octeon model in %s\n",
-				     __func__);
-		}
-	}
-	return num_ports;
-}
-
-/**
  * Put an RGMII interface in loopback mode. Internal packets sent
  * out will be received back again on the same port. Externally
  * received packets will echo back out.
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index 6a47b04..03ae748 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -330,10 +330,6 @@ static int __cvmx_helper_sgmii_hardware_init(int interface, int num_ports)
 	return 0;
 }
 
-int __cvmx_helper_sgmii_enumerate(int interface)
-{
-	return 4;
-}
 /**
  * Probe a SGMII interface and determine the number of ports
  * connected to it. The SGMII interface should still be down after
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
index 1f3030c..a2cf7f1 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
@@ -51,16 +51,6 @@ void __cvmx_interrupt_stxx_int_msk_enable(int index);
 #define CVMX_HELPER_SPI_TIMEOUT 10
 #endif
 
-int __cvmx_helper_spi_enumerate(int interface)
-{
-	if ((cvmx_sysinfo_get()->board_type != CVMX_BOARD_TYPE_SIM) &&
-	    cvmx_spi4000_is_present(interface)) {
-		return 10;
-	} else {
-		return 16;
-	}
-}
-
 /**
  * Probe a SPI interface and determine the number of ports
  * connected to it. The SPI interface should still be down after
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index 49d7507..21b7b5a 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -45,18 +45,6 @@ void __cvmx_interrupt_gmxx_enable(int interface);
 void __cvmx_interrupt_pcsx_intx_en_reg_enable(int index, int block);
 void __cvmx_interrupt_pcsxx_int_en_reg_enable(int index);
 
-int __cvmx_helper_xaui_enumerate(int interface)
-{
-	union cvmx_gmxx_hg2_control gmx_hg2_control;
-
-	/* If HiGig2 is enabled return 16 ports, otherwise return 1 port */
-	gmx_hg2_control.u64 = cvmx_read_csr(CVMX_GMXX_HG2_CONTROL(interface));
-	if (gmx_hg2_control.s.hg2tx_en)
-		return 16;
-	else
-		return 1;
-}
-
 /**
  * Probe a XAUI interface and determine the number of ports
  * connected to it. The XAUI interface should still be down
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index b531ffa..de6e619 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -301,6 +301,123 @@ cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int interface)
 	}
 }
 EXPORT_SYMBOL_GPL(cvmx_helper_interface_get_mode);
+
+static int __cvmx_helper_loop_enumerate(int interface)
+{
+	return 4;
+}
+
+/**
+ * Probe a NPI interface and determine the number of ports
+ * connected to it. The NPI interface should still be down
+ * after this call.
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of ports on the interface. Zero to disable.
+ */
+int __cvmx_helper_npi_probe(int interface)
+{
+#if CVMX_PKO_QUEUES_PER_PORT_PCI > 0
+	if (OCTEON_IS_MODEL(OCTEON_CN38XX) || OCTEON_IS_MODEL(OCTEON_CN58XX))
+		return 4;
+	else if (OCTEON_IS_MODEL(OCTEON_CN56XX)
+		 && !OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X))
+		/* The packet engines didn't exist before pass 2 */
+		return 4;
+	else if (OCTEON_IS_MODEL(OCTEON_CN52XX)
+		 && !OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X))
+		/* The packet engines didn't exist before pass 2 */
+		return 4;
+#if 0
+	/*
+	 * Technically CN30XX, CN31XX, and CN50XX contain packet
+	 * engines, but nobody ever uses them. Since this is the case,
+	 * we disable them here.
+	 */
+	else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
+		 || OCTEON_IS_MODEL(OCTEON_CN50XX))
+		return 2;
+	else if (OCTEON_IS_MODEL(OCTEON_CN30XX))
+		return 1;
+#endif
+#endif
+	return 0;
+}
+
+/**
+ * Probe RGMII ports and determine the number present
+ *
+ * @interface: Interface to probe
+ *
+ * Returns Number of RGMII/GMII/MII ports (0-4).
+ */
+int __cvmx_helper_rgmii_probe(int interface)
+{
+	int num_ports = 0;
+	union cvmx_gmxx_inf_mode mode;
+	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
+
+	if (mode.s.type) {
+		if (OCTEON_IS_MODEL(OCTEON_CN38XX)
+		    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+			cvmx_dprintf("ERROR: RGMII initialize called in "
+				     "SPI interface\n");
+		} else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
+			   || OCTEON_IS_MODEL(OCTEON_CN30XX)
+			   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+			/*
+			 * On these chips "type" says we're in
+			 * GMII/MII mode. This limits us to 2 ports
+			 */
+			num_ports = 2;
+		} else {
+			cvmx_dprintf("ERROR: Unsupported Octeon model in %s\n",
+				     __func__);
+		}
+	} else {
+		if (OCTEON_IS_MODEL(OCTEON_CN38XX)
+		    || OCTEON_IS_MODEL(OCTEON_CN58XX)) {
+			num_ports = 4;
+		} else if (OCTEON_IS_MODEL(OCTEON_CN31XX)
+			   || OCTEON_IS_MODEL(OCTEON_CN30XX)
+			   || OCTEON_IS_MODEL(OCTEON_CN50XX)) {
+			num_ports = 3;
+		} else {
+			cvmx_dprintf("ERROR: Unsupported Octeon model in %s\n",
+				     __func__);
+		}
+	}
+	return num_ports;
+}
+
+int __cvmx_helper_sgmii_enumerate(int interface)
+{
+	return 4;
+}
+
+int __cvmx_helper_spi_enumerate(int interface)
+{
+	if ((cvmx_sysinfo_get()->board_type != CVMX_BOARD_TYPE_SIM) &&
+	    cvmx_spi4000_is_present(interface)) {
+		return 10;
+	} else {
+		return 16;
+	}
+}
+
+int __cvmx_helper_xaui_enumerate(int interface)
+{
+	union cvmx_gmxx_hg2_control gmx_hg2_control;
+
+	/* If HiGig2 is enabled return 16 ports, otherwise return 1 port */
+	gmx_hg2_control.u64 = cvmx_read_csr(CVMX_GMXX_HG2_CONTROL(interface));
+	if (gmx_hg2_control.s.hg2tx_en)
+		return 16;
+	else
+		return 1;
+}
+
 /**
  * Return the number of ports on an interface. Depending on the
  * chip and configuration, this can be 1-16. A value of 0
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-loop.h b/arch/mips/include/asm/octeon/cvmx-helper-loop.h
index 077f0e9..e646a6c 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-loop.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-loop.h
@@ -44,7 +44,6 @@
  * Returns Number of ports on the interface. Zero to disable.
  */
 extern int __cvmx_helper_loop_probe(int interface);
-static inline int __cvmx_helper_loop_enumerate(int interface) {return 4; }
 
 /**
  * Bringup and enable a LOOP interface. After this call packet
-- 
2.3.3
