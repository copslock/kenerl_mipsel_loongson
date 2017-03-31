Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 11:01:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60851 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992155AbdCaJBDzWfeq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 11:01:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E16DF5AF775AF;
        Fri, 31 Mar 2017 10:00:54 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 31 Mar 2017 10:00:57 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <Zubair.Kakakhel@imgtec.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: generic: Add support for MIPSfpga
Date:   Fri, 31 Mar 2017 10:00:41 +0100
Message-ID: <20170331090042.29168-2-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170331090042.29168-1-Zubair.Kakakhel@imgtec.com>
References: <20170331090042.29168-1-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Add support for the MIPSfpga platform to generic kernel.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 arch/mips/boot/dts/xilfpga/Makefile            |  2 +-
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts       |  8 ++++++++
 arch/mips/configs/generic/board-xilfpga.config | 19 +++++++++++++++++++
 arch/mips/generic/Kconfig                      |  6 ++++++
 arch/mips/generic/vmlinux.its.S                | 25 +++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/configs/generic/board-xilfpga.config

diff --git a/arch/mips/boot/dts/xilfpga/Makefile b/arch/mips/boot/dts/xilfpga/Makefile
index 913a752..bbf8fb6 100644
--- a/arch/mips/boot/dts/xilfpga/Makefile
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_XILFPGA_NEXYS4DDR)	+= nexys4ddr.dtb
+dtb-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= nexys4ddr.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
index 09a62f2..8050e84 100644
--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -4,6 +4,14 @@
 
 / {
 	compatible = "digilent,nexys4ddr";
+
+	aliases {
+		serial0 = &axi_uart16550;
+	};
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = "serial0:115200n8";
+	};
 
 	memory {
 		device_type = "memory";
diff --git a/arch/mips/configs/generic/board-xilfpga.config b/arch/mips/configs/generic/board-xilfpga.config
new file mode 100644
index 0000000..786d387
--- /dev/null
+++ b/arch/mips/configs/generic/board-xilfpga.config
@@ -0,0 +1,19 @@
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_XILINX=y
+CONFIG_PANIC_ON_OOPS=y
+CONFIG_FIT_IMAGE_FDT_XILFPGA=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_XILINX=y
+CONFIG_SENSORS_ADT7410=y
+CONFIG_TMPFS=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_NETDEVICES=y
+CONFIG_XILINX_EMACLITE=y
+CONFIG_SMSC_PHY=y
diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
index a606b3f..26201e2 100644
--- a/arch/mips/generic/Kconfig
+++ b/arch/mips/generic/Kconfig
@@ -16,4 +16,10 @@ config LEGACY_BOARD_SEAD3
 	  Enable this to include support for booting on MIPS SEAD-3 FPGA-based
 	  development boards, which boot using a legacy boot protocol.
 
+config FIT_IMAGE_FDT_XILFPGA
+	bool "Include FDT for Xilfpga"
+	help
+	  Enable this to include the FDT for the MIPSfpga platform
+	  from Imagination Technologies in the FIT kernel image.
+
 endif
diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
index f67fbf1..b2daa7e 100644
--- a/arch/mips/generic/vmlinux.its.S
+++ b/arch/mips/generic/vmlinux.its.S
@@ -29,3 +29,28 @@
 		};
 	};
 };
+
+#ifdef CONFIG_FIT_IMAGE_FDT_XILFPGA
+/ {
+	images {
+		fdt@xilfpga {
+			description = "MIPSfpga (xilfpga) Device Tree";
+			data = /incbin/("boot/dts/xilfpga/nexys4ddr.dtb");
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
+		conf@xilfpga {
+			description = "MIPSfpga Linux kernel";
+			kernel = "kernel@0";
+			fdt = "fdt@xilfpga";
+		};
+	};
+};
+#endif /* CONFIG_FIT_IMAGE_FDT_XILFPGA */
-- 
2.10.2
