Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 05:04:06 +0200 (CEST)
Received: from mga17.intel.com ([192.55.52.151]:48909 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992241AbeHCDDtGCgFH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Aug 2018 05:03:49 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="245605230"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga005.jf.intel.com with ESMTP; 02 Aug 2018 20:03:42 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 04/18] MIPS: dts: Add initial support for Intel MIPS SoCs
Date:   Fri,  3 Aug 2018 11:02:23 +0800
Message-Id: <20180803030237.3366-5-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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

From: Hua Ma <hua.ma@linux.intel.com>

Add dts files to support Intel MIPS SoCs:
- xrx500.dtsi is the chip dts
- easy350_anywan.dts is the board dts

Signed-off-by: Hua Ma <hua.ma@linux.intel.com>
Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2:
- New patch split from previous patch
- The memory address is changed to @20000000
- Update to obj-$(CONFIG_BUILTIN_DTB) as per commit fca3aa166422

 arch/mips/boot/dts/Makefile                      |  1 +
 arch/mips/boot/dts/intel-mips/Makefile           |  4 ++
 arch/mips/boot/dts/intel-mips/easy350_anywan.dts | 26 ++++++++++
 arch/mips/boot/dts/intel-mips/xrx500.dtsi        | 66 ++++++++++++++++++++++++
 4 files changed, 97 insertions(+)
 create mode 100644 arch/mips/boot/dts/intel-mips/Makefile
 create mode 100644 arch/mips/boot/dts/intel-mips/easy350_anywan.dts
 create mode 100644 arch/mips/boot/dts/intel-mips/xrx500.dtsi

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 1e79cab8e269..05f52f279047 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -3,6 +3,7 @@ subdir-y	+= brcm
 subdir-y	+= cavium-octeon
 subdir-y	+= img
 subdir-y	+= ingenic
+subdir-y	+= intel-mips
 subdir-y	+= lantiq
 subdir-y	+= mscc
 subdir-y	+= mti
diff --git a/arch/mips/boot/dts/intel-mips/Makefile b/arch/mips/boot/dts/intel-mips/Makefile
new file mode 100644
index 000000000000..adfaabbbb07c
--- /dev/null
+++ b/arch/mips/boot/dts/intel-mips/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_DTB_INTEL_MIPS_GRX500)	+= easy350_anywan.dtb
+
+obj-$(CONFIG_BUILTIN_DTB)		+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/intel-mips/easy350_anywan.dts b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
new file mode 100644
index 000000000000..e5e95f90c5e7
--- /dev/null
+++ b/arch/mips/boot/dts/intel-mips/easy350_anywan.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+#include <dt-bindings/clock/intel,grx500-clk.h>
+
+#include "xrx500.dtsi"
+
+/ {
+	model = "EASY350 ANYWAN (GRX350) Main model";
+	compatible = "intel,easy350-anywan";
+
+	aliases {
+		serial0 = &asc0;
+	};
+
+	chosen {
+		bootargs = "earlycon=lantiq,0x16600000 clk_ignore_unused";
+		stdout-path = "serial0";
+	};
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x0e000000>;
+	};
+};
diff --git a/arch/mips/boot/dts/intel-mips/xrx500.dtsi b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
new file mode 100644
index 000000000000..54c5f8f8b604
--- /dev/null
+++ b/arch/mips/boot/dts/intel-mips/xrx500.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "intel,xrx500";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "mti,interaptiv";
+			clocks = <&cgu CLK_CPU>;
+			reg = <0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "mti,interaptiv";
+			reg = <1>;
+		};
+	};
+
+	cpu_intc: interrupt-controller {
+		compatible = "mti,cpu-interrupt-controller";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	gic: gic@12320000 {
+		compatible = "mti,gic";
+		reg = <0x12320000 0x20000>;
+
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		/*
+		 * Declare the interrupt-parent even though the mti,gic
+		 * binding doesn't require it, such that the kernel can
+		 * figure out that cpu_intc is the root interrupt
+		 * controller & should be probed first.
+		 */
+		interrupt-parent = <&cpu_intc>;
+		mti,reserved-ipi-vectors = <56 8>;
+	};
+
+	cgu: cgu@16200000 {
+		compatible = "intel,grx500-cgu", "syscon";
+		reg = <0x16200000 0x200>;
+		#clock-cells = <1>;
+	};
+
+	asc0: serial@16600000 {
+		compatible = "lantiq,asc";
+		reg = <0x16600000 0x100000>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
+		clock-names = "freq", "asc";
+	};
+};
-- 
2.11.0
