Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Aug 2013 11:19:27 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:4039 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826530Ab3HKJNkRE0sA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Aug 2013 11:13:40 +0200
Received: from [10.9.208.55] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 11 Aug 2013 02:07:15 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 11 Aug 2013 02:13:24 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 11 Aug 2013 02:13:24 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id BB8AFF2D77; Sun, 11
 Aug 2013 02:13:22 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@broadcom.com>,
        "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 10/10] MIPS: Netlogic: built-in DTB for XLP2xx SoC
 boards
Date:   Sun, 11 Aug 2013 14:44:00 +0530
Message-ID: <1376212440-21038-11-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
References: <1376212440-21038-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7E198BC91R079371350-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Add a default built-in device tree for XLP2xx SoC. The new file
xlp_fvp.dts has updated entries for I2C and memory.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/Kconfig         |    9 +++
 arch/mips/netlogic/dts/Makefile    |    1 +
 arch/mips/netlogic/dts/xlp_fvp.dts |  118 ++++++++++++++++++++++++++++++++++++
 arch/mips/netlogic/xlp/dt.c        |    8 ++-
 4 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/netlogic/dts/xlp_fvp.dts

diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index 2447bf9..852a4ee 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -19,6 +19,15 @@ config DT_XLP_SVP
 	  pointer to the kernel.  The corresponding DTS file is at
 	  arch/mips/netlogic/dts/xlp_svp.dts
 
+config DT_XLP_FVP
+	bool "Built-in device tree for XLP FVP boards"
+	default y
+	help
+	  Add an FDT blob for XLP FVP board into the kernel.
+	  This DTB will be used if the firmware does not pass in a DTB
+	  pointer to the kernel.  The corresponding DTS file is at
+	  arch/mips/netlogic/dts/xlp_fvp.dts
+
 config NLM_MULTINODE
 	bool "Support for multi-chip boards"
 	depends on NLM_XLP_BOARD
diff --git a/arch/mips/netlogic/dts/Makefile b/arch/mips/netlogic/dts/Makefile
index aecb6fa..0b9be5f 100644
--- a/arch/mips/netlogic/dts/Makefile
+++ b/arch/mips/netlogic/dts/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_DT_XLP_EVP) := xlp_evp.dtb.o
 obj-$(CONFIG_DT_XLP_SVP) += xlp_svp.dtb.o
+obj-$(CONFIG_DT_XLP_FVP) += xlp_fvp.dtb.o
diff --git a/arch/mips/netlogic/dts/xlp_fvp.dts b/arch/mips/netlogic/dts/xlp_fvp.dts
new file mode 100644
index 0000000..63e62b7
--- /dev/null
+++ b/arch/mips/netlogic/dts/xlp_fvp.dts
@@ -0,0 +1,118 @@
+/*
+ * XLP2XX Device Tree Source for FVP boards
+ */
+
+/dts-v1/;
+/ {
+	model = "netlogic,XLP-FVP";
+	compatible = "netlogic,xlp";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0 0  0 0x18000000  0x04000000   // PCIe CFG
+			  1 0  0 0x16000000  0x02000000>; // GBU chipselects
+
+		serial0: serial@30000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0 0x30100 0xa00>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <133333333>;
+			interrupt-parent = <&pic>;
+			interrupts = <17>;
+		};
+		serial1: serial@31000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0 0x31100 0xa00>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <133333333>;
+			interrupt-parent = <&pic>;
+			interrupts = <18>;
+		};
+		i2c0: ocores@37100 {
+			compatible = "opencores,i2c-ocores";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x37100 0x20>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <32000000>;
+			interrupt-parent = <&pic>;
+			interrupts = <30>;
+		};
+		i2c1: ocores@37120 {
+			compatible = "opencores,i2c-ocores";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x37120 0x20>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <32000000>;
+			interrupt-parent = <&pic>;
+			interrupts = <31>;
+
+			rtc@68 {
+				compatible = "dallas,ds1374";
+				reg = <0x68>;
+			};
+
+			dtt@4c {
+				compatible = "national,lm90";
+				reg = <0x4c>;
+			};
+		};
+		pic: pic@4000 {
+			compatible = "netlogic,xlp-pic";
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			reg = <0 0x4000 0x200>;
+			interrupt-controller;
+		};
+
+		nor_flash@1,0 {
+			compatible = "cfi-flash";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bank-width = <2>;
+			reg = <1 0 0x1000000>;
+
+			partition@0 {
+				label = "x-loader";
+				reg = <0x0 0x100000>; /* 1M */
+				read-only;
+			};
+
+			partition@100000 {
+				label = "u-boot";
+				reg = <0x100000 0x100000>; /* 1M */
+			};
+
+			partition@200000 {
+				label = "kernel";
+				reg = <0x200000 0x500000>; /* 5M */
+			};
+
+			partition@700000 {
+				label = "rootfs";
+				reg = <0x700000 0x800000>; /* 8M */
+			};
+
+			partition@f00000 {
+				label = "env";
+				reg = <0xf00000 0x100000>; /* 1M */
+				read-only;
+			};
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 rdinit=/sbin/init";
+	};
+};
diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
index a15cdbb..88df445 100644
--- a/arch/mips/netlogic/xlp/dt.c
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -39,12 +39,18 @@
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
 
-extern u32 __dtb_xlp_evp_begin[], __dtb_xlp_svp_begin[], __dtb_start[];
+extern u32 __dtb_xlp_evp_begin[], __dtb_xlp_svp_begin[],
+	__dtb_xlp_fvp_begin[], __dtb_start[];
 
 void __init *xlp_dt_init(void *fdtp)
 {
 	if (!fdtp) {
 		switch (current_cpu_data.processor_id & 0xff00) {
+#ifdef CONFIG_DT_XLP_FVP
+		case PRID_IMP_NETLOGIC_XLP2XX:
+			fdtp = __dtb_xlp_fvp_begin;
+			break;
+#endif
 #ifdef CONFIG_DT_XLP_SVP
 		case PRID_IMP_NETLOGIC_XLP3XX:
 			fdtp = __dtb_xlp_svp_begin;
-- 
1.7.9.5
