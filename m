Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2017 21:07:19 +0100 (CET)
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:51114 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993885AbdCFUGo5WzVU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2017 21:06:44 +0100
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v26K1H96027201;
        Mon, 6 Mar 2017 14:06:38 -0600
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2918j6henm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2017 14:06:38 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod2.natinst.com (8.16.0.17/8.16.0.17) with ESMTPS id v26K6aht030984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2017 14:06:37 -0600
Received: from us-aus-exch3.ni.corp.natinst.com (130.164.68.13) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 6 Mar 2017 14:06:36 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch3.ni.corp.natinst.com (130.164.68.13) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 6 Mar 2017 14:06:36 -0600
Received: from nathan3500-linux-VM.amer.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Mon, 6 Mar 2017 14:06:36 -0600
From:   Nathan Sullivan <nathan.sullivan@ni.com>
To:     <linus.walleij@linaro.org>, <gnurou@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <ralf@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-mips@linux-mips.org>,
        Nathan Sullivan <nathan.sullivan@ni.com>
Subject: [PATCH 2/2] MIPS: NI 169445 board support
Date:   Mon, 6 Mar 2017 14:06:01 -0600
Message-ID: <1488830761-681-3-git-send-email-nathan.sullivan@ni.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1488830761-681-1-git-send-email-nathan.sullivan@ni.com>
References: <1488830761-681-1-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-06_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1702020001
 definitions=main-1703060160
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-06_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=30 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.0.1-1702020001 definitions=main-1703060160
Return-Path: <nathan.sullivan@ni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nathan.sullivan@ni.com
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

Support the National Instruments 169445 board.

Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
---
 Documentation/devicetree/bindings/mips/ni.txt   |   7 ++
 arch/mips/boot/dts/Makefile                     |   1 +
 arch/mips/boot/dts/ni/169445.dts                | 101 ++++++++++++++++++++
 arch/mips/boot/dts/ni/Makefile                  |   7 ++
 arch/mips/configs/generic/board-ni169445.config | 117 ++++++++++++++++++++++++
 arch/mips/generic/Kconfig                       |   6 ++
 arch/mips/generic/vmlinux.its.S                 |  25 +++++
 7 files changed, 264 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/ni.txt
 create mode 100644 arch/mips/boot/dts/ni/169445.dts
 create mode 100644 arch/mips/boot/dts/ni/Makefile
 create mode 100644 arch/mips/configs/generic/board-ni169445.config

diff --git a/Documentation/devicetree/bindings/mips/ni.txt b/Documentation/devicetree/bindings/mips/ni.txt
new file mode 100644
index 0000000..722bf2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/ni.txt
@@ -0,0 +1,7 @@
+National Instruments MIPS platforms
+
+required root node properties:
+	- compatible: must be "ni,169445"
+
+CPU Nodes
+	- compatible: must be "mti,mips14KEc"
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index b9db492..27b0f37 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -4,6 +4,7 @@ dts-dirs	+= img
 dts-dirs	+= ingenic
 dts-dirs	+= lantiq
 dts-dirs	+= mti
+dts-dirs	+= ni
 dts-dirs	+= netlogic
 dts-dirs	+= pic32
 dts-dirs	+= qca
diff --git a/arch/mips/boot/dts/ni/169445.dts b/arch/mips/boot/dts/ni/169445.dts
new file mode 100644
index 0000000..58e74b5
--- /dev/null
+++ b/arch/mips/boot/dts/ni/169445.dts
@@ -0,0 +1,101 @@
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "ni,169445";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "mti,mips14KEc";
+			clocks = <&baseclk>;
+			reg = <0>;
+		};
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x10000000>;
+	};
+
+	baseclk: baseclock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
+	};
+
+	cpu_intc: cpu_intc {
+		#address-cells = <0>;
+		compatible = "mti,cpu-interrupt-controller";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	ahb@0 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x1f300000 0x80FFF>;
+
+		gpio1:gpio-controller@1f300010 {
+			compatible = "ni,169445-nand-gpio";
+			reg = <0x10 0x4>;
+			reg-names = "dat";
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpios = <5>;
+		};
+
+		gpio2:gpio-controller@1f300014 {
+			compatible = "ni,169445-nand-gpio";
+			reg = <0x14 0x4>;
+			reg-names = "dat";
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpios = <1>;
+		};
+
+		nand@1f300000 {
+			compatible = "gpio-control-nand";
+			nand-on-flash-bbt;
+			nand-ecc-mode = "soft_bch";
+			nand-ecc-step-size = <512>;
+			nand-ecc-strength = <4>;
+			reg = <0x0 4>;
+			gpios = <&gpio2 0 0>, /* rdy */
+				<&gpio1 1 0>, /* nce */
+				<&gpio1 2 0>, /* ale */
+				<&gpio1 3 0>, /* cle */
+				<&gpio1 4 0>; /* nwp */
+		};
+
+		serial@1f380000 {
+			compatible = "ns16550a";
+			reg = <0x80000 0x1000>;
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <6>;
+			clocks = <&baseclk>;
+			reg-shift = <0>;
+		};
+
+		ethernet@1f340000 {
+			compatible = "snps,dwmac-4.10a";
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <5>;
+			interrupt-names = "macirq";
+			reg = <0x40000 0x2000>;
+			clock-names = "stmmaceth", "pclk";
+			clocks = <&baseclk>, <&baseclk>;
+
+			phy-mode = "rgmii";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+	};
+};
diff --git a/arch/mips/boot/dts/ni/Makefile b/arch/mips/boot/dts/ni/Makefile
new file mode 100644
index 0000000..66cfdff
--- /dev/null
+++ b/arch/mips/boot/dts/ni/Makefile
@@ -0,0 +1,7 @@
+dtb-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= 169445.dtb
+
+# Force kbuild to make empty built-in.o if necessary
+obj-					+= dummy.o
+
+always					:= $(dtb-y)
+clean-files				:= *.dtb *.dtb.S
diff --git a/arch/mips/configs/generic/board-ni169445.config b/arch/mips/configs/generic/board-ni169445.config
new file mode 100644
index 0000000..2c950a8
--- /dev/null
+++ b/arch/mips/configs/generic/board-ni169445.config
@@ -0,0 +1,117 @@
+CONFIG_MIPS_GENERIC=y
+CONFIG_FIT_IMAGE_FDT_NI169445=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_CPU_MIPS32_R2=y
+CONFIG_HZ_100=y
+CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_HZ_PERIODIC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=15
+CONFIG_BPF_SYSCALL=y
+# CONFIG_SHMEM is not set
+CONFIG_USERFAULTFD=y
+CONFIG_EMBEDDED=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+CONFIG_PROFILING=y
+CONFIG_CC_STACKPROTECTOR_REGULAR=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
+CONFIG_NETFILTER=y
+CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP6_NF_IPTABLES=y
+CONFIG_IP6_NF_FILTER=y
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK_RO=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_ECC_BCH=y
+CONFIG_MTD_NAND_GPIO=y
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_BLOCK=y
+# CONFIG_BLK_DEV is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ALACRITECH is not set
+# CONFIG_NET_VENDOR_AMAZON is not set
+# CONFIG_NET_VENDOR_AQUANTIA is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_EZCHIP is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NETRONOME is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_RENESAS is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SOLARFLARE is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+CONFIG_STMMAC_ETH=y
+CONFIG_DWMAC_DWC_QOS_ETH=y
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+CONFIG_LEGACY_PTY_COUNT=32
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_PTP_1588_CLOCK is not set
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
+# CONFIG_HWMON is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MIPS_PLATFORM_DEVICES is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_FANOTIFY=y
+CONFIG_UBIFS_FS=y
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XATTR=y
+# CONFIG_SQUASHFS_ZLIB is not set
+CONFIG_SQUASHFS_LZO=y
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_REDUCED=y
+CONFIG_DEBUG_FS=y
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_RCU_TRACE=y
+# CONFIG_FTRACE is not set
+# CONFIG_CRYPTO_ECHAINIV is not set
+# CONFIG_CRYPTO_HW is not set
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index a606b3f..fbf0813 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -16,4 +16,10 @@ config LEGACY_BOARD_SEAD3
 	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
 	  development boards, which boot using a legacy boot protocol.
 
+config FIT_IMAGE_FDT_NI169445
+	bool "Include FDT for NI 169445"
+	help
+	  Enable this to include the FDT for the 169445 platform from
+	  National Instruments in the FIT kernel image.
+
 endif
diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
index f67fbf1..de851f7 100644
--- a/arch/mips/generic/vmlinux.its.S
+++ b/arch/mips/generic/vmlinux.its.S
@@ -29,3 +29,28 @@
 		};
 	};
 };
+
+#ifdef CONFIG_FIT_IMAGE_FDT_NI169445
+/ {
+	images {
+		fdt@ni169445 {
+			description = "NI 169445 device tree";
+			data = /incbin/("boot/dts/ni/169445.dtb");
+			type = "flat_dt";
+			arch = "mips";
+			compression = "none";
+			hash@0 {
+				algo = "sha1";
+			};
+		};
+	};
+
+	configurations {
+		conf@ni169445 {
+			description = "NI 169445 Linux Kernel";
+			kernel = "kernel@0";
+			fdt = "fdt@ni169445";
+		};
+	};
+};
+#endif
-- 
2.1.4
