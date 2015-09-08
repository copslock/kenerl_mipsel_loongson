Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Sep 2015 11:11:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25686 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013483AbbIHJLPJ2y0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Sep 2015 11:11:15 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 660591B26E979;
        Tue,  8 Sep 2015 10:11:07 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 8 Sep 2015 10:11:09 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.115) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Sep 2015 10:11:08 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mtd@lists.infradead.org>
CC:     Alex Smith <alex@alex-smith.me.uk>,
        Alex Smith <alex.smith@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH v5 4/4] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND device tree nodes
Date:   Tue, 8 Sep 2015 10:10:53 +0100
Message-ID: <1441703453-2838-5-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1441703453-2838-1-git-send-email-alex.smith@imgtec.com>
References: <1441703453-2838-1-git-send-email-alex.smith@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.115]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

Add device tree nodes for the NEMC and BCH to the JZ4780 device tree,
and make use of them in the Ci20 device tree to add a node for the
board's NAND.

Note that since the pinctrl driver is not yet upstream, this includes
neither pin configuration nor busy/write-protect GPIO pins for the
NAND. Use of the NAND relies on the boot loader to have left the pins
configured in a usable state, which should be the case when booted
from the NAND.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
v4 -> v5:
 - New patch adding DT nodes for the NAND so that the driver can be
   tested.
---
 arch/mips/boot/dts/ingenic/ci20.dts    | 51 ++++++++++++++++++++++++++++++++++
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 26 +++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 9fcb9e7d1f57..c0c8a64a3522 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -42,3 +42,54 @@
 &uart4 {
 	status = "okay";
 };
+
+&nemc {
+	status = "okay";
+
+	nand: nand@1 {
+		compatible = "ingenic,jz4780-nand";
+		reg = <1 0 0x1000000>;
+
+		ingenic,nemc-tAS = <10>;
+		ingenic,nemc-tAH = <5>;
+		ingenic,nemc-tBP = <10>;
+		ingenic,nemc-tAW = <15>;
+		ingenic,nemc-tSTRV = <100>;
+
+		ingenic,bch-controller = <&bch>;
+		ingenic,ecc-size = <1024>;
+		ingenic,ecc-strength = <24>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		partition@0 {
+			label = "u-boot-spl";
+			reg = <0x0 0x0 0x0 0x800000>;
+		};
+
+		partition@0x800000 {
+			label = "u-boot";
+			reg = <0x0 0x800000 0x0 0x200000>;
+		};
+
+		partition@0xa00000 {
+			label = "u-boot-env";
+			reg = <0x0 0xa00000 0x0 0x200000>;
+		};
+
+		partition@0xc00000 {
+			label = "boot";
+			reg = <0x0 0xc00000 0x0 0x4000000>;
+		};
+
+		partition@0x8c00000 {
+			label = "system";
+			reg = <0x0 0x4c00000 0x1 0xfb400000>;
+		};
+	};
+};
+
+&bch {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 65389f602733..b868b429add2 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -108,4 +108,30 @@
 
 		status = "disabled";
 	};
+
+	nemc: nemc@13410000 {
+		compatible = "ingenic,jz4780-nemc";
+		reg = <0x13410000 0x10000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <1 0 0x1b000000 0x1000000
+			  2 0 0x1a000000 0x1000000
+			  3 0 0x19000000 0x1000000
+			  4 0 0x18000000 0x1000000
+			  5 0 0x17000000 0x1000000
+			  6 0 0x16000000 0x1000000>;
+
+		clocks = <&cgu JZ4780_CLK_NEMC>;
+
+		status = "disabled";
+	};
+
+	bch: bch@134d0000 {
+		compatible = "ingenic,jz4780-bch";
+		reg = <0x134d0000 0x10000>;
+
+		clocks = <&cgu JZ4780_CLK_BCH>;
+
+		status = "disabled";
+	};
 };
-- 
2.5.0
