Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Dec 2013 20:47:32 +0100 (CET)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:41824 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825716Ab3LCTrJPt6Ni (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Dec 2013 20:47:09 +0100
Received: by mail-ie0-f171.google.com with SMTP id ar20so24749867iec.16
        for <multiple recipients>; Tue, 03 Dec 2013 11:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V78igDPb0JyKMdwLVfidrwHCn1bUNUMAX2DvwgCKzZQ=;
        b=EJr7PB0g6TGd6Uv24PyHmVghzfpyxbyzJ548VcWEi25H7FI3xOfSg8nqww4Fc5/59d
         K2VQ1eUgvRfMVPQ9xvUM8pTI+gMk0fCi6N2t1SPeGzeO5u7X1fV1A48kXJ6/Jqk1tqVk
         Jonpmi41WR2QJNgb6nPHUPIlfBwGN836Crmu5MtuxDLuwXYb+mNKDDwAaaxfq57znqt5
         93PXc7q6IKxEVOR3riXr8C6Pux0Vg7hNUJGLwKgJbil5BpT3w0PLhLKplZdp1wEdddqG
         WOoFDUClRsglJdbZOncliCQLpzAARYcUkbu6UJQL94z+uOlWa3JsSGCWywKpMtc8EO2U
         Bl0g==
X-Received: by 10.42.61.147 with SMTP id u19mr33403850ich.36.1386100022997;
        Tue, 03 Dec 2013 11:47:02 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id y10sm4704995igl.4.2013.12.03.11.47.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 11:47:01 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id rB3Jl0S3006116;
        Tue, 3 Dec 2013 11:47:00 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id rB3JkxUd006115;
        Tue, 3 Dec 2013 11:46:59 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS: OCTEON: Supply OCTEON+ USB nodes in internal device trees.
Date:   Tue,  3 Dec 2013 11:46:51 -0800
Message-Id: <1386100012-6077-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1386100012-6077-1-git-send-email-ddaney.cavm@gmail.com>
References: <1386100012-6077-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

This will be needed by the next patch to use said nodes for probing
via the device tree.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../cavium-octeon/executive/cvmx-helper-board.c    | 27 ++++++++++++++++++
 arch/mips/cavium-octeon/octeon-platform.c          | 32 ++++++++++++++++++++++
 arch/mips/cavium-octeon/octeon_3xxx.dts            | 19 +++++++++++++
 arch/mips/include/asm/octeon/cvmx-helper-board.h   |  9 ++++++
 4 files changed, 87 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 0a1283c..b764df6 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -722,3 +722,30 @@ int __cvmx_helper_board_hardware_enable(int interface)
 	}
 	return 0;
 }
+
+/**
+ * Get the clock type used for the USB block based on board type.
+ * Used by the USB code for auto configuration of clock type.
+ *
+ * Return USB clock type enumeration
+ */
+enum cvmx_helper_board_usb_clock_types __cvmx_helper_board_usb_get_clock_type(void)
+{
+	switch (cvmx_sysinfo_get()->board_type) {
+	case CVMX_BOARD_TYPE_BBGW_REF:
+	case CVMX_BOARD_TYPE_LANAI2_A:
+	case CVMX_BOARD_TYPE_LANAI2_U:
+	case CVMX_BOARD_TYPE_LANAI2_G:
+	case CVMX_BOARD_TYPE_NIC10E_66:
+	case CVMX_BOARD_TYPE_UBNT_E100:
+		return USB_CLOCK_TYPE_CRYSTAL_12;
+	case CVMX_BOARD_TYPE_NIC10E:
+		return USB_CLOCK_TYPE_REF_12;
+	default:
+		break;
+	}
+	/* Most boards except NIC10e use a 12MHz crystal */
+	if (OCTEON_IS_MODEL(OCTEON_FAM_2))
+		return USB_CLOCK_TYPE_CRYSTAL_12;
+	return USB_CLOCK_TYPE_REF_48;
+}
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 1830874..cd4fd6b 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -171,6 +171,7 @@ device_initcall(octeon_ohci_device_init);
 static struct of_device_id __initdata octeon_ids[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "cavium,octeon-6335-uctl", },
+	{ .compatible = "cavium,octeon-5750-usbn", },
 	{ .compatible = "cavium,octeon-3860-bootbus", },
 	{ .compatible = "cavium,mdio-mux", },
 	{ .compatible = "gpio-leds", },
@@ -682,6 +683,37 @@ end_led:
 		}
 	}
 
+	/* DWC2 USB */
+	alias_prop = fdt_getprop(initial_boot_params, aliases,
+				 "usbn", NULL);
+	if (alias_prop) {
+		int usbn = fdt_path_offset(initial_boot_params, alias_prop);
+
+		if (usbn >= 0 && (current_cpu_type() == CPU_CAVIUM_OCTEON2 ||
+				  !octeon_has_feature(OCTEON_FEATURE_USB))) {
+			pr_debug("Deleting usbn\n");
+			fdt_nop_node(initial_boot_params, usbn);
+			fdt_nop_property(initial_boot_params, aliases, "usbn");
+		} else  {
+			__be32 new_f[1];
+			enum cvmx_helper_board_usb_clock_types c;
+			c = __cvmx_helper_board_usb_get_clock_type();
+			switch (c) {
+			case USB_CLOCK_TYPE_REF_48:
+				new_f[0] = cpu_to_be32(48000000);
+				fdt_setprop_inplace(initial_boot_params, usbn,
+						    "refclk-frequency",  new_f, sizeof(new_f));
+				/* Fall through ...*/
+			case USB_CLOCK_TYPE_REF_12:
+				/* Missing "refclk-type" defaults to external. */
+				fdt_nop_property(initial_boot_params, usbn, "refclk-type");
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
 	return 0;
 }
 
diff --git a/arch/mips/cavium-octeon/octeon_3xxx.dts b/arch/mips/cavium-octeon/octeon_3xxx.dts
index 88cb42d..fa33115 100644
--- a/arch/mips/cavium-octeon/octeon_3xxx.dts
+++ b/arch/mips/cavium-octeon/octeon_3xxx.dts
@@ -550,6 +550,24 @@
 				big-endian-regs;
 			};
 		};
+
+		usbn: usbn@1180068000000 {
+			compatible = "cavium,octeon-5750-usbn";
+			reg = <0x11800 0x68000000 0x0 0x1000>;
+			ranges; /* Direct mapping */
+			#address-cells = <2>;
+			#size-cells = <2>;
+			/* 12MHz, 24MHz and 48MHz allowed */
+			refclk-frequency = <12000000>;
+			/* Either "crystal" or "external" */
+			refclk-type = "crystal";
+
+			usbc@16f0010000000 {
+				compatible = "cavium,octeon-5750-usbc";
+				reg = <0x16f00 0x10000000 0x0 0x80000>;
+				interrupts = <0 56>;
+			};
+		};
 	};
 
 	aliases {
@@ -566,6 +584,7 @@
 		flash0 = &flash0;
 		cf0 = &cf0;
 		uctl = &uctl;
+		usbn = &usbn;
 		led0 = &led0;
 	};
  };
diff --git a/arch/mips/include/asm/octeon/cvmx-helper-board.h b/arch/mips/include/asm/octeon/cvmx-helper-board.h
index 41785dd..8933203 100644
--- a/arch/mips/include/asm/octeon/cvmx-helper-board.h
+++ b/arch/mips/include/asm/octeon/cvmx-helper-board.h
@@ -36,6 +36,13 @@
 
 #include <asm/octeon/cvmx-helper.h>
 
+enum cvmx_helper_board_usb_clock_types {
+	USB_CLOCK_TYPE_REF_12,
+	USB_CLOCK_TYPE_REF_24,
+	USB_CLOCK_TYPE_REF_48,
+	USB_CLOCK_TYPE_CRYSTAL_12,
+};
+
 typedef enum {
 	set_phy_link_flags_autoneg = 0x1,
 	set_phy_link_flags_flow_control_dont_touch = 0x0 << 1,
@@ -154,4 +161,6 @@ extern int __cvmx_helper_board_interface_probe(int interface,
  */
 extern int __cvmx_helper_board_hardware_enable(int interface);
 
+enum cvmx_helper_board_usb_clock_types __cvmx_helper_board_usb_get_clock_type(void);
+
 #endif /* __CVMX_HELPER_BOARD_H__ */
-- 
1.7.11.7
