Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 12:16:52 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:63752 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867264Ab3LULLLOzt03 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Dec 2013 12:11:11 +0100
X-IronPort-AV: E=Sophos;i="4.95,527,1384329600"; 
   d="scan'208";a="4638697"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 21 Dec 2013 03:17:17 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Sat, 21 Dec 2013 03:11:09 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.1.438.0; Sat, 21 Dec 2013 03:11:09 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 A9A7C246AA;    Sat, 21 Dec 2013 03:11:08 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Jayachandran C <jchandra@broadcom.com>, <ralf@linux-mips.org>
Subject: [PATCH 18/18] MIPS: Netlogic: Add default DTB for XLP9XX SoC
Date:   Sat, 21 Dec 2013 16:52:30 +0530
Message-ID: <1387624950-31297-19-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38791
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

Add a default device tree fie for XLP9XX boards, and add code to use
this device tree if no DTB is passed to the kernel.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/Kconfig         |    9 +++++
 arch/mips/netlogic/dts/Makefile    |    1 +
 arch/mips/netlogic/dts/xlp_gvp.dts |   76 ++++++++++++++++++++++++++++++++++++
 arch/mips/netlogic/xlp/dt.c        |    7 +++-
 4 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/netlogic/dts/xlp_gvp.dts

diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index 852a4ee..4eb683a 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -28,6 +28,15 @@ config DT_XLP_FVP
 	  pointer to the kernel.  The corresponding DTS file is at
 	  arch/mips/netlogic/dts/xlp_fvp.dts
 
+config DT_XLP_GVP
+	bool "Built-in device tree for XLP GVP boards"
+	default y
+	help
+	  Add an FDT blob for XLP GVP board into the kernel.
+	  This DTB will be used if the firmware does not pass in a DTB
+	  pointer to the kernel.  The corresponding DTS file is at
+	  arch/mips/netlogic/dts/xlp_gvp.dts
+
 config NLM_MULTINODE
 	bool "Support for multi-chip boards"
 	depends on NLM_XLP_BOARD
diff --git a/arch/mips/netlogic/dts/Makefile b/arch/mips/netlogic/dts/Makefile
index 0b9be5f..25c8e87 100644
--- a/arch/mips/netlogic/dts/Makefile
+++ b/arch/mips/netlogic/dts/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_DT_XLP_EVP) := xlp_evp.dtb.o
 obj-$(CONFIG_DT_XLP_SVP) += xlp_svp.dtb.o
 obj-$(CONFIG_DT_XLP_FVP) += xlp_fvp.dtb.o
+obj-$(CONFIG_DT_XLP_GVP) += xlp_gvp.dtb.o
diff --git a/arch/mips/netlogic/dts/xlp_gvp.dts b/arch/mips/netlogic/dts/xlp_gvp.dts
new file mode 100644
index 0000000..047d27f
--- /dev/null
+++ b/arch/mips/netlogic/dts/xlp_gvp.dts
@@ -0,0 +1,76 @@
+/*
+ * XLP9XX Device Tree Source for GVP boards
+ */
+
+/dts-v1/;
+/ {
+	model = "netlogic,XLP-GVP";
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
+		pic: pic@4000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			reg = <0 0x110000 0x200>;
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
diff --git a/arch/mips/netlogic/xlp/dt.c b/arch/mips/netlogic/xlp/dt.c
index 8316d54..5754097 100644
--- a/arch/mips/netlogic/xlp/dt.c
+++ b/arch/mips/netlogic/xlp/dt.c
@@ -42,13 +42,18 @@
 #include <asm/prom.h>
 
 extern u32 __dtb_xlp_evp_begin[], __dtb_xlp_svp_begin[],
-	__dtb_xlp_fvp_begin[], __dtb_start[];
+	__dtb_xlp_fvp_begin[], __dtb_xlp_gvp_begin[], __dtb_start[];
 static void *xlp_fdt_blob;
 
 void __init *xlp_dt_init(void *fdtp)
 {
 	if (!fdtp) {
 		switch (current_cpu_data.processor_id & 0xff00) {
+#ifdef CONFIG_DT_XLP_GVP
+		case PRID_IMP_NETLOGIC_XLP9XX:
+			fdtp = __dtb_xlp_gvp_begin;
+			break;
+#endif
 #ifdef CONFIG_DT_XLP_FVP
 		case PRID_IMP_NETLOGIC_XLP2XX:
 			fdtp = __dtb_xlp_fvp_begin;
-- 
1.7.9.5
