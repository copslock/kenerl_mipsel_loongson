Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:25:54 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:25072 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010500AbbAGLVpUcY5V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:45 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54169617"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 07 Jan 2015 03:36:15 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:58 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:22:11 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 B8DC340FE6;    Wed,  7 Jan 2015 03:20:55 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 17/17] MIPS: Netlogic: Add built-in dts for XLP5xx boards
Date:   Wed, 7 Jan 2015 16:58:38 +0530
Message-ID: <1420630118-17198-18-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45000
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

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/boot/dts/Makefile    |  1 +
 arch/mips/boot/dts/xlp_rvp.dts | 77 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/netlogic/Kconfig     |  9 +++++
 arch/mips/netlogic/xlp/dt.c    | 10 ++++--
 4 files changed, 94 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/boot/dts/xlp_rvp.dts

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 4f49fa4..de26ec6 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_DT_XLP_EVP)		+= xlp_evp.dtb
 dtb-$(CONFIG_DT_XLP_SVP)		+= xlp_svp.dtb
 dtb-$(CONFIG_DT_XLP_FVP)		+= xlp_fvp.dtb
 dtb-$(CONFIG_DT_XLP_GVP)		+= xlp_gvp.dtb
+dtb-$(CONFIG_DT_XLP_RVP)		+= xlp_rvp.dtb
 dtb-$(CONFIG_DTB_RT2880_EVAL)		+= rt2880_eval.dtb
 dtb-$(CONFIG_DTB_RT305X_EVAL)		+= rt3052_eval.dtb
 dtb-$(CONFIG_DTB_RT3883_EVAL)		+= rt3883_eval.dtb
diff --git a/arch/mips/boot/dts/xlp_rvp.dts b/arch/mips/boot/dts/xlp_rvp.dts
new file mode 100644
index 00000000..7188aed
--- /dev/null
+++ b/arch/mips/boot/dts/xlp_rvp.dts
@@ -0,0 +1,77 @@
+/*
+ * XLP5XX Device Tree Source for RVP boards
+ */
+
+/dts-v1/;
+/ {
+	model = "netlogic,XLP-RVP";
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
+			reg = <0 0x112100 0xa00>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <125000000>;
+			interrupt-parent = <&pic>;
+			interrupts = <17>;
+		};
+		pic: pic@110000 {
+			compatible = "netlogic,xlp-pic";
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			reg = <0 0x110000 0x200>;
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
+
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 rdinit=/sbin/init";
+	};
+};
diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index 0823321..fb00606 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -41,6 +41,15 @@ config DT_XLP_GVP
 	  pointer to the kernel.  The corresponding DTS file is at
 	  arch/mips/netlogic/dts/xlp_gvp.dts
 
+config DT_XLP_RVP
+	bool "Built-in device tree for XLP RVP boards"
+	default y
+	help
+	  Add an FDT blob for XLP RVP board into the kernel.
+	  This DTB will be used if the firmware does not pass in a DTB
+	  pointer to the kernel.  The corresponding DTS file is at
+	  arch/mips/netlogic/dts/xlp_rvp.dts
+
 config NLM_MULTINODE
 	bool "Support for multi-chip boards"
 	depends on NLM_XLP_BOARD
diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
index 7cc4603..a625bdb 100644
--- a/arch/mips/netlogic/xlp/dt.c
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -41,17 +41,21 @@
 
 #include <asm/prom.h>
 
-extern u32 __dtb_xlp_evp_begin[], __dtb_xlp_svp_begin[],
-	__dtb_xlp_fvp_begin[], __dtb_xlp_gvp_begin[];
+extern u32 __dtb_xlp_evp_begin[], __dtb_xlp_svp_begin[], __dtb_xlp_fvp_begin[],
+	__dtb_xlp_gvp_begin[], __dtb_xlp_rvp_begin[];
 static void *xlp_fdt_blob;
 
 void __init *xlp_dt_init(void *fdtp)
 {
 	if (!fdtp) {
 		switch (current_cpu_data.processor_id & PRID_IMP_MASK) {
+#ifdef CONFIG_DT_XLP_RVP
+		case PRID_IMP_NETLOGIC_XLP5XX:
+			fdtp = __dtb_xlp_rvp_begin;
+			break;
+#endif
 #ifdef CONFIG_DT_XLP_GVP
 		case PRID_IMP_NETLOGIC_XLP9XX:
-		case PRID_IMP_NETLOGIC_XLP5XX:
 			fdtp = __dtb_xlp_gvp_begin;
 			break;
 #endif
-- 
1.9.1
