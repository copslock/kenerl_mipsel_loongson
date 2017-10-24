Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2017 20:19:13 +0200 (CEST)
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:41199 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991978AbdJXSQ4qrVgV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2017 20:16:56 +0200
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 4058A30C027;
        Tue, 24 Oct 2017 11:16:55 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id CD0B981EAE;
        Tue, 24 Oct 2017 11:16:52 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: [PATCH 7/8] MIPS: BMIPS: add PCI bindings for 7425, 7435
Date:   Tue, 24 Oct 2017 14:15:48 -0400
Message-Id: <1508868949-16652-8-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

Adds the PCIe nodes for the Broadcom STB PCIe root complex.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7425.dtsi     | 25 +++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm7435.dtsi     | 26 ++++++++++++++++++++++++++
 arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
 arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
 4 files changed, 59 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index f56fb25..2c416f6 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -494,4 +494,29 @@
 			status = "disabled";
 		};
 	};
+
+	pcie: pcie@10410000 {
+		reg = <0x10410000 0x830c>;
+		compatible = "brcm,bcm7425-pcie", "brcm,pci-plat-dev";
+		interrupts = <37>, <37>;
+		interrupt-names = "pcie", "msi";
+		interrupt-parent = <&periph_intc>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		linux,pci-domain = <0>;
+		brcm,ssc;
+		msi-controller;
+		#interrupt-cells = <1>;
+		/* 4x128mb windows */
+		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0 0x08000000>,
+			 <0x2000000 0x0 0xd8000000 0xd8000000 0 0x08000000>,
+			 <0x2000000 0x0 0xe0000000 0xe0000000 0 0x08000000>,
+			 <0x2000000 0x0 0xe8000000 0xe8000000 0 0x08000000>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &periph_intc 33
+				 0 0 0 2 &periph_intc 34
+				 0 0 0 3 &periph_intc 35
+				 0 0 0 4 &periph_intc 36>;
+	};
+
 };
diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index f2cead2..2f869e5 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -509,4 +509,30 @@
 			status = "disabled";
 		};
 	};
+
+	pcie: pcie@10410000 {
+		reg = <0x10410000 0x930c>;
+		interrupts = <0x27>, <0x27>;
+		interrupt-names = "pcie", "msi";
+		interrupt-parent = <&periph_intc>;
+		compatible = "brcm,bcm7435-pcie", "brcm,pci-plat-dev";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		linux,pci-domain = <0>;
+		brcm,ssc;
+		msi-controller;
+		#interrupt-cells = <1>;
+		/* 4x128mb windows */
+		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0 0x08000000>,
+			 <0x2000000 0x0 0xd8000000 0xd8000000 0 0x08000000>,
+			 <0x2000000 0x0 0xe0000000 0xe0000000 0 0x08000000>,
+			 <0x2000000 0x0 0xe8000000 0xe8000000 0 0x08000000>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &periph_intc 35
+				 0 0 0 2 &periph_intc 36
+				 0 0 0 3 &periph_intc 37
+				 0 0 0 4 &periph_intc 38>;
+		status = "disabled";
+	};
+
 };
diff --git a/arch/mips/boot/dts/brcm/bcm97425svmb.dts b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
index 73aa006..3a87ac5 100644
--- a/arch/mips/boot/dts/brcm/bcm97425svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97425svmb.dts
@@ -143,3 +143,7 @@
 &mspi {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
index 0a915f3..456d024 100644
--- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -119,3 +119,7 @@
 &mspi {
 	status = "okay";
 };
+
+&pcie {
+	status = "okay";
+};
-- 
1.9.0.138.g2de3478
