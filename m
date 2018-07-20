Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 14:25:44 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:47170 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993849AbeGTMYIISIr3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 14:24:08 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH V2 11/25] dt-bindings: PCI: qcom,ar7240: adds binding doc
Date:   Fri, 20 Jul 2018 13:58:28 +0200
Message-Id: <20180720115842.8406-12-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
References: <20180720115842.8406-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

With the driver being converted from platform_data to pure OF, we need to
also add some docs.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: John Crispin <john@phrozen.org>
---
 .../devicetree/bindings/pci/qcom,ar7240-pci.txt    | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt b/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
new file mode 100644
index 000000000000..5379affd4615
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,ar7240-pci.txt
@@ -0,0 +1,42 @@
+* Qualcomm Atheros AR724X PCI express root complex
+
+Required properties:
+- compatible: should contain "qcom,ar7240-pci" to identify the core.
+- reg: Should contain the register ranges as listed in the reg-names property.
+- reg-names: Definition: Must include the following entries
+	- "crp_base"	Configuration registers
+	- "ctrl_base"	Control registers
+	- "cfg_base"	IO Memory
+- #address-cells: set to <3>
+- #size-cells: set to <2>
+- ranges: ranges for the PCI memory and I/O regions
+- interrupt-map-mask and interrupt-map: standard PCI
+	properties to define the mapping of the PCIe interface to interrupt
+	numbers.
+- #interrupt-cells: set to <1>
+- interrupt-parent: phandle to the MIPS IRQ controller
+
+Optional properties:
+- interrupt-controller: define to enable the builtin IRQ cascade.
+
+* Example for qca9557
+	pcie-controller@180c0000 {
+		compatible = "qcom,ar7240-pci";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0x0>;
+		reg = <0x180c0000 0x1000>,
+		      <0x180f0000 0x100>,
+		      <0x14000000 0x1000>;
+		reg-names = "crp_base", "ctrl_base", "cfg_base";
+		ranges = <0x2000000 0 0x10000000 0x10000000 0 0x04000000
+			  0x1000000 0 0x00000000 0x00000000 0 0x00000001>;
+		interrupt-parent = <&intc2>;
+		interrupts = <1>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-map-mask = <0 0 0 1>;
+		interrupt-map = <0 0 0 0 &pcie0 0>;
+	};
-- 
2.11.0
