Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 18:53:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34253 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993120AbcKVRwzkgwWE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2016 18:52:55 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 83D9FA5EDB5DE;
        Tue, 22 Nov 2016 17:52:46 +0000 (GMT)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 22 Nov 2016 17:52:49 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     <Zubair.Kakakhel@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] MIPS: xilfpga: Use Xilinx Interrupt Controller
Date:   Tue, 22 Nov 2016 17:52:39 +0000
Message-ID: <20161122175243.8853-3-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161122175243.8853-1-Zubair.Kakakhel@imgtec.com>
References: <20161122175243.8853-1-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55849
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

IRQs from peripherals such as i2c/uart/ethernet come via
the AXI Interrupt controller.

Select it in Kconfig for xilfpga and add the DT node

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 arch/mips/Kconfig                        |  1 +
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..3d681c6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -478,6 +478,7 @@ config MACH_XILFPGA
 	select SYS_SUPPORTS_ZBOOT_UART16550
 	select USE_OF
 	select USE_GENERIC_EARLY_PRINTK_8250
+	select XILINX_INTC
 	help
 	  This enables support for the IMG University Program MIPSfpga platform.
 
diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
index 48d2112..8db660b 100644
--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -17,6 +17,18 @@
 		compatible = "mti,cpu-interrupt-controller";
 	};
 
+	axi_intc: interrupt-controller@10200000 {
+		#interrupt-cells = <1>;
+		compatible = "xlnx,xps-intc-1.00.a";
+		interrupt-controller;
+		reg = <0x10200000 0x10000>;
+		xlnx,kind-of-intr = <0x0>;
+		xlnx,num-intr-inputs = <0x6>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <6>;
+	};
+
 	axi_gpio: gpio@10600000 {
 		#gpio-cells = <1>;
 		compatible = "xlnx,xps-gpio-1.00.a";
-- 
2.10.2
