Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 21:15:36 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:44451 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994650AbeBQUORFJKsG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 21:14:17 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 20:14:08 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018
 12:09:33 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     <netdev@vger.kernel.org>
CC:     Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 03/14] dt-bindings: net: Document Intel pch_gbe binding
Date:   Sat, 17 Feb 2018 12:10:26 -0800
Message-ID: <20180217201037.3006-4-paul.burton@mips.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180217201037.3006-1-paul.burton@mips.com>
References: <20180217201037.3006-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1518898437-298552-4261-69366-6
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190134
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Introduce documentation for a device tree binding for the Intel Platform
Controller Hub (PCH) GigaBit Ethernet (GBE) device. Although this is a
PCIe device & thus largely auto-detectable, this binding will be used to
provide the driver with the PHY reset GPIO.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: netdev@vger.kernel.org

---

Changes in v5:
- Use standard gpio & ethernet node names in example.
- Remove bus number from example unit addresses.

Changes in v4: None
Changes in v3:
- New patch.

Changes in v2: None

 Documentation/devicetree/bindings/net/pch_gbe.txt | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pch_gbe.txt

diff --git a/Documentation/devicetree/bindings/net/pch_gbe.txt b/Documentation/devicetree/bindings/net/pch_gbe.txt
new file mode 100644
index 000000000000..cff2687e6e75
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pch_gbe.txt
@@ -0,0 +1,25 @@
+Intel Platform Controller Hub (PCH) GigaBit Ethernet (GBE)
+
+Required properties:
+- compatible:		Should be the PCI vendor & device ID, eg. "pci8086,8802".
+- reg:			Should be a PCI device number as specified by the PCI bus
+			binding to IEEE Std 1275-1994.
+- phy-reset-gpios:	Should be a GPIO list containing a single GPIO that
+			resets the attached PHY when active.
+
+Example:
+
+	ethernet@0,1 {
+		compatible = "pci8086,8802";
+		reg = <0x00020100 0 0 0 0>;
+		phy-reset-gpios = <&eg20t_gpio 6
+				   GPIO_ACTIVE_LOW>;
+	};
+
+	eg20t_gpio: gpio@0,2 {
+		compatible = "pci8086,8803";
+		reg = <0x00020200 0 0 0 0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
-- 
2.16.1
