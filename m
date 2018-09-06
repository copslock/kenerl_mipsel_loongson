Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 22:44:12 +0200 (CEST)
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:54618 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994646AbeIFUn4sVskQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 22:43:56 +0200
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 719F430C02C;
        Thu,  6 Sep 2018 13:43:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 719F430C02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1536266633;
        bh=svkBOHE0Tk81xGt2ZcccjJ+inXoilbJ7MdwFXYMAnwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXLNNWglGxTu+/iOwNBJybDXU7jGH7sxitAK4ua0yBswEUV72qUh/leKfEeeMXhac
         4gsKQOAq7BGCqEDUB9cwhXTr2cj5gIzs7vPEiOTIYKYV+hKlggHUHhDwO8519BCqeY
         GhWTg5+oPBhAj66iBLhQcYq+brtulkS3Xw5oxorQ=
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 2E711AC071C;
        Thu,  6 Sep 2018 13:43:49 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stefan Agner <stefan@agner.ch>, Eric Anholt <eric@anholt.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tony Lindgren <tony@atomide.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Dirk Hohndel (VMware)" <dirk@hohndel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Markus Mayer <markus.mayer@broadcom.com>,
        Gareth Powell <gpowell@broadcom.com>,
        Doug Berger <opendmb@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 02/12] dt-bindings: pci: add DT docs for Brcmstb PCIe device
Date:   Thu,  6 Sep 2018 16:42:51 -0400
Message-Id: <1536266581-7308-3-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66079
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

The DT bindings description of the Brcmstb PCIe device is described.
This node can be used by almost all Broadcom settop box chips, using
ARM, ARM64, or MIPS CPU architectures.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pci/brcmstb-pcie.txt       | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt b/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
new file mode 100644
index 0000000..a1a9ad5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
@@ -0,0 +1,59 @@
+Brcmstb PCIe Host Controller Device Tree Bindings
+
+Required Properties:
+- compatible
+  "brcm,bcm7425-pcie" -- for 7425 family MIPS-based SOCs.
+  "brcm,bcm7435-pcie" -- for 7435 family MIPS-based SOCs.
+  "brcm,bcm7445-pcie" -- for 7445 and later ARM based SOCs (not including
+      the 7278).
+  "brcm,bcm7278-pcie"  -- for 7278 family ARM-based SOCs.
+
+- reg -- the register start address and length for the PCIe reg block.
+- interrupts -- two interrupts are specified; the first interrupt is for
+     the PCI host controller and the second is for MSI if the built-in
+     MSI controller is to be used.
+- interrupt-names -- names of the interrupts (above): "pcie" and "msi".
+- #address-cells -- set to <3>.
+- #size-cells -- set to <2>.
+- #interrupt-cells: set to <1>.
+- interrupt-map-mask and interrupt-map, standard PCI properties to define the
+     mapping of the PCIe interface to interrupt numbers.
+- ranges: ranges for the PCI memory and I/O regions.
+- linux,pci-domain -- should be unique per host controller.
+
+Optional Properties:
+- clocks -- phandle of pcie clock.
+- clock-names -- set to "sw_pcie" if clocks is used.
+- dma-ranges -- Specifies the inbound memory mapping regions when
+     an "identity map" is not possible.
+- msi-controller -- this property is typically specified to have the
+     PCIe controller use its internal MSI controller.
+- msi-parent -- set to use an external MSI interrupt controller.
+- brcm,enable-ssc -- (boolean) indicates usage of spread-spectrum clocking.
+- max-link-speed --  (integer) indicates desired generation of link:
+     1 => 2.5 Gbps (gen1), 2 => 5.0 Gbps (gen2), 3 => 8.0 Gbps (gen3).
+
+Example Node:
+
+pcie0: pcie@f0460000 {
+		reg = <0x0 0xf0460000 0x0 0x9310>;
+		interrupts = <0x0 0x0 0x4>;
+		compatible = "brcm,bcm7445-pcie";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x02000000 0x00000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x08000000
+			  0x02000000 0x00000000 0x08000000 0x00000000 0xc8000000 0x00000000 0x08000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &intc 0 47 3
+				 0 0 0 2 &intc 0 48 3
+				 0 0 0 3 &intc 0 49 3
+				 0 0 0 4 &intc 0 50 3>;
+		clocks = <&sw_pcie0>;
+		clock-names = "sw_pcie";
+		msi-parent = <&pcie0>;  /* use PCIe's internal MSI controller */
+		msi-controller;         /* use PCIe's internal MSI controller */
+		brcm,ssc;
+		max-link-speed = <1>;
+		linux,pci-domain = <0>;
+	};
-- 
1.9.0.138.g2de3478
