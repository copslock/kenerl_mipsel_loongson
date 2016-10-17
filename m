Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 18:56:20 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:39163 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992991AbcJQQxQGWjRz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 18:53:16 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 31E16BAE92B38;
        Mon, 17 Oct 2016 17:53:05 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 17:53:08 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 17 Oct 2016 17:53:08 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <alistair@popple.id.au>, <mporter@kernel.crashing.org>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <paulus@samba.org>, <benh@kernel.crashing.org>
Subject: [Patch v5 08/12] MIPS: xilfpga: Use Xilinx Interrupt Controller
Date:   Mon, 17 Oct 2016 17:52:52 +0100
Message-ID: <1476723176-39891-9-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55473
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
V4 -> V5
Rebase to v4.9-rc1
Renamed XILINX_AXI_INTC to XILINX_INTC

V3 -> V4
No change

V2 -> V3
No change

V1 -> V2
Renamed select XILINX_INTC to select XILINX_AXI_INTC
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
1.9.1
