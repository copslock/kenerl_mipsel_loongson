Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:54:46 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32912 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992316AbcIAQvxa9Es2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:51:53 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5B40FF49EDC09;
        Thu,  1 Sep 2016 17:51:34 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:51:37 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     <soren.brinkmann@xilinx.com>, <Zubair.Kakakhel@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <michal.simek@xilinx.com>, <netdev@vger.kernel.org>
Subject: [Patch v4 08/12] MIPS: Xilfpga: Add DT node for AXI I2C
Date:   Thu, 1 Sep 2016 17:51:01 +0100
Message-ID: <1472748665-47774-9-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54946
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

The xilfpga platform has an AXI I2C Bus master with a temperature
sensor connected to it.

Add the device tree node to use them.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V3 -> V4
changed compatible string from "adt7420" to "adi,adt7420"

V2 -> V3
No change

V1 -> V2

No change
---
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
index d285c8d..f5ebab8 100644
--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -54,6 +54,28 @@
 		interrupt-parent = <&axi_intc>;
 		interrupts = <0>;
 	};
+
+	axi_i2c: i2c@10A00000 {
+	    compatible = "xlnx,xps-iic-2.00.a";
+	    interrupt-parent = <&axi_intc>;
+	    interrupts = <4>;
+	    reg = < 0x10A00000 0x10000 >;
+	    clocks = <&ext>;
+	    xlnx,clk-freq = <0x5f5e100>;
+	    xlnx,family = "Artix7";
+	    xlnx,gpo-width = <0x1>;
+	    xlnx,iic-freq = <0x186a0>;
+	    xlnx,scl-inertial-delay = <0x0>;
+	    xlnx,sda-inertial-delay = <0x0>;
+	    xlnx,ten-bit-adr = <0x0>;
+	    #address-cells = <1>;
+	    #size-cells = <0>;
+
+	    ad7420@4B {
+		compatible = "adi,adt7420";
+		reg = <0x4B>;
+	    };
+	} ;
 };
 
 &ext {
-- 
1.9.1
