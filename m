Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12009C282CC
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D283720821
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfBDWl7 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:41:59 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:60636 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfBDWl7 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 4 Feb 2019 17:41:59 -0500
Received: from localhost.localdomain (85-76-69-76-nat.elisa-mobile.fi [85.76.69.76])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 9DFCB300C3;
        Tue,  5 Feb 2019 00:41:55 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 5/5] MIPS: OCTEON: program rx/tx-delay always from DT
Date:   Tue,  5 Feb 2019 00:41:49 +0200
Message-Id: <20190204224149.8139-6-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190204224149.8139-1-aaro.koskinen@iki.fi>
References: <20190204224149.8139-1-aaro.koskinen@iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Program rx/tx-delay always from DT.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 .../boot/dts/cavium-octeon/octeon_3xxx.dts    |  6 +++
 .../mips/boot/dts/cavium-octeon/ubnt_e100.dts |  6 +++
 .../executive/cvmx-helper-board.c             | 39 ------------------
 .../cavium-octeon/executive/cvmx-helper.c     |  1 -
 arch/mips/cavium-octeon/octeon-platform.c     | 40 +++++++++++++++++++
 .../include/asm/octeon/cvmx-helper-board.h    | 12 ------
 6 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
index 1c50cca4ea53..dda0559cef50 100644
--- a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
+++ b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
@@ -180,6 +180,8 @@
 				ethernet@0 {
 					phy-handle = <&phy2>;
 					cavium,alt-phy-handle = <&phy100>;
+					rx-delay = <0>;
+					tx-delay = <0>;
 					fixed-link {
 						speed = <1000>;
 						full-duplex;
@@ -188,6 +190,8 @@
 				ethernet@1 {
 					phy-handle = <&phy3>;
 					cavium,alt-phy-handle = <&phy101>;
+					rx-delay = <0>;
+					tx-delay = <0>;
 					fixed-link {
 						speed = <1000>;
 						full-duplex;
@@ -196,6 +200,8 @@
 				ethernet@2 {
 					phy-handle = <&phy4>;
 					cavium,alt-phy-handle = <&phy102>;
+					rx-delay = <0>;
+					tx-delay = <0>;
 				};
 				ethernet@3 {
 					compatible = "cavium,octeon-3860-pip-port";
diff --git a/arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts b/arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts
index 243e5dc444fb..962f37fbc7db 100644
--- a/arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts
+++ b/arch/mips/boot/dts/cavium-octeon/ubnt_e100.dts
@@ -33,12 +33,18 @@
 			interface@0 {
 				ethernet@0 {
 					phy-handle = <&phy7>;
+					rx-delay = <0>;
+					tx-delay = <0x10>;
 				};
 				ethernet@1 {
 					phy-handle = <&phy6>;
+					rx-delay = <0>;
+					tx-delay = <0x10>;
 				};
 				ethernet@2 {
 					phy-handle = <&phy5>;
+					rx-delay = <0>;
+					tx-delay = <0x10>;
 				};
 			};
 		};
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 634eae578ffe..2e2d45bc850d 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -320,45 +320,6 @@ int __cvmx_helper_board_interface_probe(int interface, int supported_ports)
 	return supported_ports;
 }
 
-/**
- * Enable packet input/output from the hardware. This function is
- * called after by cvmx_helper_packet_hardware_enable() to
- * perform board specific initialization. For most boards
- * nothing is needed.
- *
- * @interface: Interface to enable
- *
- * Returns Zero on success, negative on failure
- */
-int __cvmx_helper_board_hardware_enable(int interface)
-{
-	if (cvmx_sysinfo_get()->board_type == CVMX_BOARD_TYPE_CN3005_EVB_HS5) {
-		if (interface == 0) {
-			/* Different config for switch port */
-			cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(1, interface), 0);
-			cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(1, interface), 0);
-			/*
-			 * Boards with gigabit WAN ports need a
-			 * different setting that is compatible with
-			 * 100 Mbit settings
-			 */
-			cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(0, interface),
-				       0xc);
-			cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(0, interface),
-				       0xc);
-		}
-	} else if (cvmx_sysinfo_get()->board_type ==
-			CVMX_BOARD_TYPE_UBNT_E100) {
-		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(0, interface), 0);
-		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(0, interface), 0x10);
-		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(1, interface), 0);
-		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(1, interface), 0x10);
-		cvmx_write_csr(CVMX_ASXX_RX_CLK_SETX(2, interface), 0);
-		cvmx_write_csr(CVMX_ASXX_TX_CLK_SETX(2, interface), 0x10);
-	}
-	return 0;
-}
-
 /**
  * Get the clock type used for the USB block based on board type.
  * Used by the USB code for auto configuration of clock type.
diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
index 151fd440a4b4..de391541d6f7 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
@@ -762,7 +762,6 @@ static int __cvmx_helper_packet_hardware_enable(int interface)
 		result = __cvmx_helper_loop_enable(interface);
 		break;
 	}
-	result |= __cvmx_helper_board_hardware_enable(interface);
 	return result;
 }
 
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index b4073750822d..51685f893eab 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -603,6 +603,45 @@ static void __init octeon_fdt_rm_ethernet(int node)
 	fdt_nop_node(initial_boot_params, node);
 }
 
+static void __init _octeon_rx_tx_delay(int eth, int rx_delay, int tx_delay)
+{
+	fdt_setprop_inplace_cell(initial_boot_params, eth, "rx-delay",
+				 rx_delay);
+	fdt_setprop_inplace_cell(initial_boot_params, eth, "tx-delay",
+				 tx_delay);
+}
+
+static void __init octeon_rx_tx_delay(int eth, int iface, int port)
+{
+	switch (cvmx_sysinfo_get()->board_type) {
+	case CVMX_BOARD_TYPE_CN3005_EVB_HS5:
+		if (iface == 0) {
+			if (port == 0) {
+				/*
+				 * Boards with gigabit WAN ports need a
+				 * different setting that is compatible with
+				 * 100 Mbit settings
+				 */
+				_octeon_rx_tx_delay(eth, 0xc, 0x0c);
+				return;
+			} else if (port == 1) {
+				/* Different config for switch port. */
+				_octeon_rx_tx_delay(eth, 0x0, 0x0);
+				return;
+			}
+		}
+		break;
+	case CVMX_BOARD_TYPE_UBNT_E100:
+		if (iface == 0 && port <= 2) {
+			_octeon_rx_tx_delay(eth, 0x0, 0x10);
+			return;
+		}
+		break;
+	}
+	fdt_nop_property(initial_boot_params, eth, "rx-delay");
+	fdt_nop_property(initial_boot_params, eth, "tx-delay");
+}
+
 static void __init octeon_fdt_pip_port(int iface, int i, int p, int max)
 {
 	char name_buffer[20];
@@ -633,6 +672,7 @@ static void __init octeon_fdt_pip_port(int iface, int i, int p, int max)
 		WARN_ON(octeon_has_fixed_link(ipd_port));
 	else if (!octeon_has_fixed_link(ipd_port))
 		fdt_nop_node(initial_boot_params, fixed_link);
+	octeon_rx_tx_delay(eth, i, p);
 }
 
 static void __init octeon_fdt_pip_iface(int pip, int idx)
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-board.h b/arch/mips/include/asm/octeon/cvmx-helper-board.h
index b4d19c21b62c..d7fdcf0a0088 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-board.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-board.h
@@ -119,18 +119,6 @@ extern cvmx_helper_link_info_t __cvmx_helper_board_link_get(int ipd_port);
 extern int __cvmx_helper_board_interface_probe(int interface,
 					       int supported_ports);
 
-/**
- * Enable packet input/output from the hardware. This function is
- * called after by cvmx_helper_packet_hardware_enable() to
- * perform board specific initialization. For most boards
- * nothing is needed.
- *
- * @interface: Interface to enable
- *
- * Returns Zero on success, negative on failure
- */
-extern int __cvmx_helper_board_hardware_enable(int interface);
-
 enum cvmx_helper_board_usb_clock_types __cvmx_helper_board_usb_get_clock_type(void);
 
 #endif /* __CVMX_HELPER_BOARD_H__ */
-- 
2.17.0

