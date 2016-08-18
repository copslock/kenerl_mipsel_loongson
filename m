Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 15:47:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18638 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993267AbcHRNoOdmmlI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 15:44:14 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3C11212F52CFD;
        Thu, 18 Aug 2016 14:43:55 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 18 Aug 2016 14:43:58 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>
CC:     <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH V2 09/10] MIPS: xilfpga: Add DT node for AXI emaclite
Date:   Thu, 18 Aug 2016 14:43:23 +0100
Message-ID: <1471527804-26175-10-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1471527804-26175-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1471527804-26175-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54634
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

The xilfpga platform has a Xilinx AXI emaclite block.

Add the DT node to use it.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V1 -> V2

Removed accidental local-mac-address entry
---
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
index 3658e21..1f25d0a 100644
--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -42,6 +42,32 @@
 		xlnx,tri-default = <0xffffffff>;
 	} ;
 
+	axi_ethernetlite: ethernet@10e00000 {
+		compatible = "xlnx,xps-ethernetlite-3.00.a";
+		device_type = "network";
+		interrupt-parent = <&axi_intc>;
+		interrupts = <1>;
+		phy-handle = <&phy0>;
+		reg = <0x10e00000 0x10000>;
+		xlnx,duplex = <0x1>;
+		xlnx,include-global-buffers = <0x1>;
+		xlnx,include-internal-loopback = <0x0>;
+		xlnx,include-mdio = <0x1>;
+		xlnx,instance = "axi_ethernetlite_inst";
+		xlnx,rx-ping-pong = <0x1>;
+		xlnx,s-axi-id-width = <0x1>;
+		xlnx,tx-ping-pong = <0x1>;
+		xlnx,use-internal = <0x0>;
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy0: phy@1 {
+				device_type = "ethernet-phy";
+				reg = <1>;
+			};
+		};
+	};
+
 	axi_uart16550: serial@10400000 {
 		compatible = "ns16550a";
 		reg = <0x10400000 0x10000>;
-- 
1.9.1
