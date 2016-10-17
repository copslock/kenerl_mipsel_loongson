Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 18:58:04 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:27174 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992999AbcJQQxRI2IMz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 18:53:17 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 68F8F9F7F0A71;
        Mon, 17 Oct 2016 17:53:07 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Oct 2016
 17:53:11 +0100
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 17 Oct 2016 17:53:10 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <alistair@popple.id.au>, <mporter@kernel.crashing.org>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
        <paulus@samba.org>, <benh@kernel.crashing.org>
Subject: [Patch v5 11/12] MIPS: xilfpga: Add DT node for AXI emaclite
Date:   Mon, 17 Oct 2016 17:52:55 +0100
Message-ID: <1476723176-39891-12-git-send-email-Zubair.Kakakhel@imgtec.com>
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
X-archive-position: 55477
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
V3 -> V4
No change

V2 -> V3
No change

V1 -> V2
Removed accidental local-mac-address entry
---
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
index f5ebab8..09a62f2 100644
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
