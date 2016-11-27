Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Nov 2016 01:31:14 +0100 (CET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:57350 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992942AbcK0AbFbOMU- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Nov 2016 01:31:05 +0100
Received: from localhost.localdomain (85-76-44-71-nat.elisa-mobile.fi [85.76.44.71])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id CA2A41A2638;
        Sun, 27 Nov 2016 02:31:04 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] MIPS: OCTEON: kill cvmx_helper_link_autoconf()
Date:   Sun, 27 Nov 2016 02:30:51 +0200
Message-Id: <20161127003051.27725-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.9.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55897
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

Kill cvmx_helper_link_autoconf(). Nobody uses this function.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../cavium-octeon/executive/cvmx-helper-rgmii.c    |  3 +-
 .../cavium-octeon/executive/cvmx-helper-sgmii.c    |  3 +-
 .../mips/cavium-octeon/executive/cvmx-helper-spi.c |  3 +-
 .../cavium-octeon/executive/cvmx-helper-xaui.c     |  3 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    | 47 +---------------------
 arch/mips/include/asm/octeon/cvmx-helper-rgmii.h   |  3 +-
 arch/mips/include/asm/octeon/cvmx-helper-sgmii.h   |  3 +-
 arch/mips/include/asm/octeon/cvmx-helper-spi.h     |  3 +-
 arch/mips/include/asm/octeon/cvmx-helper-xaui.h    |  3 +-
 arch/mips/include/asm/octeon/cvmx-helper.h         | 14 +------
 10 files changed, 10 insertions(+), 75 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
index 671ab1d..ba4753c 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-rgmii.c
@@ -287,8 +287,7 @@ cvmx_helper_link_info_t __cvmx_helper_rgmii_link_get(int ipd_port)
  * Configure an IPD/PKO port for the specified link state. This
  * function does not influence auto negotiation at the PHY level.
  * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
+ * by cvmx_helper_link_get().
  *
  * @ipd_port:  IPD/PKO port to configure
  * @link_info: The new link state
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
index 5437534..5782833 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-sgmii.c
@@ -500,8 +500,7 @@ cvmx_helper_link_info_t __cvmx_helper_sgmii_link_get(int ipd_port)
  * Configure an IPD/PKO port for the specified link state. This
  * function does not influence auto negotiation at the PHY level.
  * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
+ * by cvmx_helper_link_get().
  *
  * @ipd_port:  IPD/PKO port to configure
  * @link_info: The new link state
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
index 1f3030c..ef16aa0 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-spi.c
@@ -188,8 +188,7 @@ cvmx_helper_link_info_t __cvmx_helper_spi_link_get(int ipd_port)
  * Configure an IPD/PKO port for the specified link state. This
  * function does not influence auto negotiation at the PHY level.
  * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
+ * by cvmx_helper_link_get().
  *
  * @ipd_port:  IPD/PKO port to configure
  * @link_info: The new link state
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
index d347fe1..19d54e0 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
@@ -295,8 +295,7 @@ cvmx_helper_link_info_t __cvmx_helper_xaui_link_get(int ipd_port)
  * Configure an IPD/PKO port for the specified link state. This
  * function does not influence auto negotiation at the PHY level.
  * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
+ * by cvmx_helper_link_get().
  *
  * @ipd_port:  IPD/PKO port to configure
  * @link_info: The new link state
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 6456af6..f24be0b 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -69,10 +69,6 @@ void (*cvmx_override_ipd_port_setup) (int ipd_port);
 /* Port count per interface */
 static int interface_port_count[5];
 
-/* Port last configured link info index by IPD/PKO port */
-static cvmx_helper_link_info_t
-    port_link_info[CVMX_PIP_NUM_INPUT_PORTS];
-
 /**
  * Return the number of interfaces the chip has. Each interface
  * may have multiple ports. Most chips support two interfaces,
@@ -1136,41 +1132,6 @@ int cvmx_helper_initialize_packet_io_local(void)
 }
 
 /**
- * Auto configure an IPD/PKO port link state and speed. This
- * function basically does the equivalent of:
- * cvmx_helper_link_set(ipd_port, cvmx_helper_link_get(ipd_port));
- *
- * @ipd_port: IPD/PKO port to auto configure
- *
- * Returns Link state after configure
- */
-cvmx_helper_link_info_t cvmx_helper_link_autoconf(int ipd_port)
-{
-	cvmx_helper_link_info_t link_info;
-	int interface = cvmx_helper_get_interface_num(ipd_port);
-	int index = cvmx_helper_get_interface_index_num(ipd_port);
-
-	if (index >= cvmx_helper_ports_on_interface(interface)) {
-		link_info.u64 = 0;
-		return link_info;
-	}
-
-	link_info = cvmx_helper_link_get(ipd_port);
-	if (link_info.u64 == port_link_info[ipd_port].u64)
-		return link_info;
-
-	/* If we fail to set the link speed, port_link_info will not change */
-	cvmx_helper_link_set(ipd_port, link_info);
-
-	/*
-	 * port_link_info should be the current value, which will be
-	 * different than expect if cvmx_helper_link_set() failed.
-	 */
-	return port_link_info[ipd_port];
-}
-EXPORT_SYMBOL_GPL(cvmx_helper_link_autoconf);
-
-/**
  * Return the link state of an IPD/PKO port as returned by
  * auto negotiation. The result of this function may not match
  * Octeon's link config if auto negotiation has changed since
@@ -1233,8 +1194,7 @@ EXPORT_SYMBOL_GPL(cvmx_helper_link_get);
  * Configure an IPD/PKO port for the specified link state. This
  * function does not influence auto negotiation at the PHY level.
  * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
+ * by cvmx_helper_link_get().
  *
  * @ipd_port:  IPD/PKO port to configure
  * @link_info: The new link state
@@ -1276,11 +1236,6 @@ int cvmx_helper_link_set(int ipd_port, cvmx_helper_link_info_t link_info)
 	case CVMX_HELPER_INTERFACE_MODE_LOOP:
 		break;
 	}
-	/* Set the port_link_info here so that the link status is updated
-	   no matter how cvmx_helper_link_set is called. We don't change
-	   the value if link_set failed */
-	if (result == 0)
-		port_link_info[ipd_port].u64 = link_info.u64;
 	return result;
 }
 EXPORT_SYMBOL_GPL(cvmx_helper_link_set);
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h b/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
index 4d7a3db..f89775b 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-rgmii.h
@@ -80,8 +80,7 @@ extern cvmx_helper_link_info_t __cvmx_helper_rgmii_link_get(int ipd_port);
  * Configure an IPD/PKO port for the specified link state. This
  * function does not influence auto negotiation at the PHY level.
  * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
+ * by cvmx_helper_link_get().
  *
  * @ipd_port:  IPD/PKO port to configure
  * @link_info: The new link state
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h b/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
index 4debb1c..63fd213 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-sgmii.h
@@ -74,8 +74,7 @@ extern cvmx_helper_link_info_t __cvmx_helper_sgmii_link_get(int ipd_port);
  * Configure an IPD/PKO port for the specified link state. This
  * function does not influence auto negotiation at the PHY level.
  * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
+ * by cvmx_helper_link_get().
  *
  * @ipd_port:  IPD/PKO port to configure
  * @link_info: The new link state
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-spi.h b/arch/mips/include/asm/octeon/cvmx-helper-spi.h
index 9f1c6b9..d5adf85 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-spi.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-spi.h
@@ -71,8 +71,7 @@ extern cvmx_helper_link_info_t __cvmx_helper_spi_link_get(int ipd_port);
  * Configure an IPD/PKO port for the specified link state. This
  * function does not influence auto negotiation at the PHY level.
  * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
+ * by cvmx_helper_link_get().
  *
  * @ipd_port:  IPD/PKO port to configure
  * @link_info: The new link state
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-xaui.h b/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
index 5e89ed7..f8ce53f 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-xaui.h
@@ -74,8 +74,7 @@ extern cvmx_helper_link_info_t __cvmx_helper_xaui_link_get(int ipd_port);
  * Configure an IPD/PKO port for the specified link state. This
  * function does not influence auto negotiation at the PHY level.
  * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
+ * by cvmx_helper_link_get().
  *
  * @ipd_port:  IPD/PKO port to configure
  * @link_info: The new link state
diff --git a/arch/mips/include/asm/octeon/cvmx-helper.h b/arch/mips/include/asm/octeon/cvmx-helper.h
index 5a3090d..0ed87cb 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper.h
@@ -156,17 +156,6 @@ extern cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
 								   interface);
 
 /**
- * Auto configure an IPD/PKO port link state and speed. This
- * function basically does the equivalent of:
- * cvmx_helper_link_set(ipd_port, cvmx_helper_link_get(ipd_port));
- *
- * @ipd_port: IPD/PKO port to auto configure
- *
- * Returns Link state after configure
- */
-extern cvmx_helper_link_info_t cvmx_helper_link_autoconf(int ipd_port);
-
-/**
  * Return the link state of an IPD/PKO port as returned by
  * auto negotiation. The result of this function may not match
  * Octeon's link config if auto negotiation has changed since
@@ -182,8 +171,7 @@ extern cvmx_helper_link_info_t cvmx_helper_link_get(int ipd_port);
  * Configure an IPD/PKO port for the specified link state. This
  * function does not influence auto negotiation at the PHY level.
  * The passed link state must always match the link state returned
- * by cvmx_helper_link_get(). It is normally best to use
- * cvmx_helper_link_autoconf() instead.
+ * by cvmx_helper_link_get().
  *
  * @ipd_port:  IPD/PKO port to configure
  * @link_info: The new link state
-- 
2.9.2
