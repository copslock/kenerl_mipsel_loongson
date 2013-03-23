Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:27:28 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1465 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834950Ab3CWS0dLPXpj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 19:26:33 +0100
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 23 Mar 2013 11:22:00 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 23 Mar 2013 11:26:21 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 23 Mar 2013 11:26:21 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id EAC9A39289; Sat, 23
 Mar 2013 11:26:19 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 7/9] MIPS: Netlogic: Support for multiple built-in
 device trees
Date:   Sat, 23 Mar 2013 23:57:59 +0530
Message-ID: <b2bd46da7f0b3deb1a7cf5cb73acad5dc68e3e3e.1364062916.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1364062916.git.jchandra@broadcom.com>
References: <cover.1364062916.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D532D423A01621463-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35954
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This enables us to have a default device tree per SoC family to be built
into the kernel. The default device tree for XLP3xx has been added as part
of this change. Later this can be used to provide support default boards
for XLP2xx and XLP9xx SoCs.

Kconfig options are provided for each default device tree so that just the
needed ones can be selected to be built into the kernel.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/netlogic/Kconfig         |   17 +++--
 arch/mips/netlogic/dts/Makefile    |    1 +
 arch/mips/netlogic/dts/xlp_evp.dts |    2 +-
 arch/mips/netlogic/dts/xlp_svp.dts |  124 ++++++++++++++++++++++++++++++++++++
 arch/mips/netlogic/xlp/setup.c     |   22 ++++++-
 5 files changed, 158 insertions(+), 8 deletions(-)
 create mode 100644 arch/mips/netlogic/dts/xlp_svp.dts

diff --git a/arch/mips/netlogic/Kconfig b/arch/mips/netlogic/Kconfig
index 3c05bf9..e0873a3 100644
--- a/arch/mips/netlogic/Kconfig
+++ b/arch/mips/netlogic/Kconfig
@@ -2,13 +2,22 @@ if NLM_XLP_BOARD || NLM_XLR_BOARD
 
 if NLM_XLP_BOARD
 config DT_XLP_EVP
-	bool "Built-in device tree for XLP EVP/SVP boards"
+	bool "Built-in device tree for XLP EVP boards"
 	default y
 	help
-	  Add an FDT blob for XLP EVP and SVP boards into the kernel.
+	  Add an FDT blob for XLP EVP boards into the kernel.
 	  This DTB will be used if the firmware does not pass in a DTB
-          pointer to the kernel.  The corresponding DTS file is at
-          arch/mips/netlogic/dts/xlp_evp.dts
+	  pointer to the kernel.  The corresponding DTS file is at
+	  arch/mips/netlogic/dts/xlp_evp.dts
+
+config DT_XLP_SVP
+	bool "Built-in device tree for XLP SVP boards"
+	default y
+	help
+	  Add an FDT blob for XLP VP boards into the kernel.
+	  This DTB will be used if the firmware does not pass in a DTB
+	  pointer to the kernel.  The corresponding DTS file is at
+	  arch/mips/netlogic/dts/xlp_svp.dts
 
 config NLM_MULTINODE
 	bool "Support for multi-chip boards"
diff --git a/arch/mips/netlogic/dts/Makefile b/arch/mips/netlogic/dts/Makefile
index d117d46..aecb6fa 100644
--- a/arch/mips/netlogic/dts/Makefile
+++ b/arch/mips/netlogic/dts/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_DT_XLP_EVP) := xlp_evp.dtb.o
+obj-$(CONFIG_DT_XLP_SVP) += xlp_svp.dtb.o
diff --git a/arch/mips/netlogic/dts/xlp_evp.dts b/arch/mips/netlogic/dts/xlp_evp.dts
index 7628b54..e14f423 100644
--- a/arch/mips/netlogic/dts/xlp_evp.dts
+++ b/arch/mips/netlogic/dts/xlp_evp.dts
@@ -20,7 +20,7 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		compatible = "simple-bus";
-		ranges = <0 0  0 0x18000000  0x04000000	  // PCIe CFG
+		ranges = <0 0  0 0x18000000  0x04000000   // PCIe CFG
 			  1 0  0 0x16000000  0x01000000>; // GBU chipselects
 
 		serial0: serial@30000 {
diff --git a/arch/mips/netlogic/dts/xlp_svp.dts b/arch/mips/netlogic/dts/xlp_svp.dts
new file mode 100644
index 0000000..8af4bdb
--- /dev/null
+++ b/arch/mips/netlogic/dts/xlp_svp.dts
@@ -0,0 +1,124 @@
+/*
+ * XLP3XX Device Tree Source for SVP boards
+ */
+
+/dts-v1/;
+/ {
+	model = "netlogic,XLP-SVP";
+	compatible = "netlogic,xlp";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	memory {
+		device_type = "memory";
+		reg =  <0 0x00100000 0 0x0FF00000	// 255M at 1M
+			0 0x20000000 0 0xa0000000	// 2560M at 512M
+			0 0xe0000000 0 0x40000000>;
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0 0  0 0x18000000  0x04000000   // PCIe CFG
+			  1 0  0 0x16000000  0x01000000>; // GBU chipselects
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
+		i2c0: ocores@32000 {
+			compatible = "opencores,i2c-ocores";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x32100 0xa00>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <32000000>;
+			interrupt-parent = <&pic>;
+			interrupts = <30>;
+		};
+		i2c1: ocores@33000 {
+			compatible = "opencores,i2c-ocores";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x33100 0xa00>;
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
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			reg = <0 0x4000 0x200>;
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
diff --git a/arch/mips/netlogic/xlp/setup.c b/arch/mips/netlogic/xlp/setup.c
index 4894d62..af31914 100644
--- a/arch/mips/netlogic/xlp/setup.c
+++ b/arch/mips/netlogic/xlp/setup.c
@@ -56,7 +56,7 @@ uint64_t nlm_io_base;
 struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
 cpumask_t nlm_cpumask = CPU_MASK_CPU0;
 unsigned int nlm_threads_per_core;
-extern u32 __dtb_start[];
+extern u32 __dtb_xlp_evp_begin[], __dtb_xlp_svp_begin[], __dtb_start[];
 
 static void nlm_linux_exit(void)
 {
@@ -82,8 +82,24 @@ void __init plat_mem_setup(void)
 	 * 64-bit, so convert pointer.
 	 */
 	fdtp = (void *)(long)fw_arg0;
-	if (!fdtp)
-		fdtp = __dtb_start;
+	if (!fdtp) {
+		switch (current_cpu_data.processor_id & 0xff00) {
+#ifdef CONFIG_DT_XLP_SVP
+		case PRID_IMP_NETLOGIC_XLP3XX:
+			fdtp = __dtb_xlp_svp_begin;
+			break;
+#endif
+#ifdef CONFIG_DT_XLP_EVP
+		case PRID_IMP_NETLOGIC_XLP8XX:
+			fdtp = __dtb_xlp_evp_begin;
+			break;
+#endif
+		default:
+			/* Pick a built-in if any, and hope for the best */
+			fdtp = __dtb_start;
+			break;
+		}
+	}
 	fdtp = phys_to_virt(__pa(fdtp));
 	early_init_devtree(fdtp);
 }
-- 
1.7.9.5
