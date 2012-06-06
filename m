Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 00:59:38 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:40247 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903745Ab2FFW54 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 00:57:56 +0200
Received: by dadm1 with SMTP id m1so10178482dad.36
        for <multiple recipients>; Wed, 06 Jun 2012 15:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uPLCGrsTmmuS/58/KgkC4AcJUGKcPlU2jtLEvMUsKjg=;
        b=YPd3mRt4RN+o4mB9pKxlgFg/RmWzPtYe+gEmTQfUK9ZJTYA9MJ53xyrlWQ92wqM4WK
         tC/rrqQN1+a7ocKDa9tFsY5MR09pB2L/gpr5VNu1epprAbplaTuFe5mSmhCUKCwYotgb
         Vtc5IRB/40dkrsBZYLbd5hrKj5ZbqKUbxRK502Mmw2yLNgfbmt+eY97dAj/xLSYfTgcs
         p3u7bCZfigvcMH8M7obRxHlucPq5OhpNt3sEseaK+Gce5WinySKK8s4f17EGHL+JCV3s
         EWv9JVOL6l1YTOj8dK7SwuR+QgUZFHn89qdphrU1pJdeeDzFkXLimbu+AdXMXd+meG83
         EU0g==
Received: by 10.68.203.7 with SMTP id km7mr2858424pbc.7.1339023469644;
        Wed, 06 Jun 2012 15:57:49 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ve6sm1798980pbc.75.2012.06.06.15.57.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 15:57:46 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q56MvjSI020311;
        Wed, 6 Jun 2012 15:57:45 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q56MviOQ020310;
        Wed, 6 Jun 2012 15:57:44 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v8 2/4] MIPS: Octeon: Add device tree source files.
Date:   Wed,  6 Jun 2012 15:57:41 -0700
Message-Id: <1339023463-20267-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1339023463-20267-1-git-send-email-ddaney.cavm@gmail.com>
References: <1339023463-20267-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 33586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

The two device tree files octeon_3xxx.dts and octeon_68xx.dts are
trimmed by code in a subsequent patch to reflect the hardware actually
present on the board.  To this end several properties that are not
part of the declared bindings are added to aid in trimming off
unwanted nodes.  Since the device tree and the code that trims it are
bound into the kernel binary, these 'marker' properties never escape
into the wild, and are purely an implementation detail of the kernel
early boot process.  This is done for backwards compatibility with
existing boards (identified by a board type enumeration value by their
bootloaders).  New boards will always pass a device tree from the
bootloader, the built-in trees are ignored in this case.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 .../bindings/ata/cavium-compact-flash.txt          |   30 +
 .../bindings/gpio/cavium-octeon-gpio.txt           |   49 ++
 .../devicetree/bindings/i2c/cavium-i2c.txt         |   34 ++
 .../devicetree/bindings/mips/cavium/bootbus.txt    |  126 ++++
 .../devicetree/bindings/mips/cavium/ciu.txt        |   26 +
 .../devicetree/bindings/mips/cavium/ciu2.txt       |   27 +
 .../devicetree/bindings/mips/cavium/dma-engine.txt |   21 +
 .../devicetree/bindings/mips/cavium/uctl.txt       |   47 ++
 .../devicetree/bindings/net/cavium-mdio.txt        |   27 +
 .../devicetree/bindings/net/cavium-mix.txt         |   40 ++
 .../devicetree/bindings/net/cavium-pip.txt         |   98 +++
 .../devicetree/bindings/serial/cavium-uart.txt     |   19 +
 arch/mips/cavium-octeon/.gitignore                 |    2 +
 arch/mips/cavium-octeon/Makefile                   |   13 +
 arch/mips/cavium-octeon/octeon_3xxx.dts            |  571 ++++++++++++++++++
 arch/mips/cavium-octeon/octeon_68xx.dts            |  625 ++++++++++++++++++++
 16 files changed, 1755 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/cavium-compact-flash.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/cavium-octeon-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/cavium-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/bootbus.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/ciu.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/ciu2.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/dma-engine.txt
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/uctl.txt
 create mode 100644 Documentation/devicetree/bindings/net/cavium-mdio.txt
 create mode 100644 Documentation/devicetree/bindings/net/cavium-mix.txt
 create mode 100644 Documentation/devicetree/bindings/net/cavium-pip.txt
 create mode 100644 Documentation/devicetree/bindings/serial/cavium-uart.txt
 create mode 100644 arch/mips/cavium-octeon/.gitignore
 create mode 100644 arch/mips/cavium-octeon/octeon_3xxx.dts
 create mode 100644 arch/mips/cavium-octeon/octeon_68xx.dts

diff --git a/Documentation/devicetree/bindings/ata/cavium-compact-flash.txt b/Documentation/devicetree/bindings/ata/cavium-compact-flash.txt
new file mode 100644
index 0000000..93986a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cavium-compact-flash.txt
@@ -0,0 +1,30 @@
+* Compact Flash
+
+The Cavium Compact Flash device is connected to the Octeon Boot Bus,
+and is thus a child of the Boot Bus device.  It can read and write
+industry standard compact flash devices.
+
+Properties:
+- compatible: "cavium,ebt3000-compact-flash";
+
+  Compatibility with many Cavium evaluation boards.
+
+- reg: The base address of the the CF chip select banks.  Depending on
+  the device configuration, there may be one or two banks.
+
+- cavium,bus-width: The width of the connection to the CF devices.  Valid
+  values are 8 and 16.
+
+- cavium,true-ide: Optional, if present the CF connection is in True IDE mode.
+
+- cavium,dma-engine-handle: Optional, a phandle for the DMA Engine connected
+  to this device.
+
+Example:
+	compact-flash@5,0 {
+		compatible = "cavium,ebt3000-compact-flash";
+		reg = <5 0 0x10000>, <6 0 0x10000>;
+		cavium,bus-width = <16>;
+		cavium,true-ide;
+		cavium,dma-engine-handle = <&dma0>;
+	};
diff --git a/Documentation/devicetree/bindings/gpio/cavium-octeon-gpio.txt b/Documentation/devicetree/bindings/gpio/cavium-octeon-gpio.txt
new file mode 100644
index 0000000..9d6dcd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/cavium-octeon-gpio.txt
@@ -0,0 +1,49 @@
+* General Purpose Input Output (GPIO) bus.
+
+Properties:
+- compatible: "cavium,octeon-3860-gpio"
+
+  Compatibility with all cn3XXX, cn5XXX and cn6XXX SOCs.
+
+- reg: The base address of the GPIO unit's register bank.
+
+- gpio-controller: This is a GPIO controller.
+
+- #gpio-cells: Must be <2>.  The first cell is the GPIO pin.
+
+- interrupt-controller: The GPIO controller is also an interrupt
+  controller, many of its pins may be configured as an interrupt
+  source.
+
+- #interrupt-cells: Must be <2>.  The first cell is the GPIO pin
+   connected to the interrupt source.  The second cell is the interrupt
+   triggering protocol and may have one of four values:
+   1 - edge triggered on the rising edge.
+   2 - edge triggered on the falling edge
+   4 - level triggered active high.
+   8 - level triggered active low.
+
+- interrupts: Interrupt routing for each pin.
+
+Example:
+
+	gpio-controller@1070000000800 {
+		#gpio-cells = <2>;
+		compatible = "cavium,octeon-3860-gpio";
+		reg = <0x10700 0x00000800 0x0 0x100>;
+		gpio-controller;
+		/* Interrupts are specified by two parts:
+		 * 1) GPIO pin number (0..15)
+		 * 2) Triggering (1 - edge rising
+		 *		  2 - edge falling
+		 *		  4 - level active high
+		 *		  8 - level active low)
+		 */
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		/* The GPIO pin connect to 16 consecutive CUI bits */
+		interrupts = <0 16>, <0 17>, <0 18>, <0 19>,
+			     <0 20>, <0 21>, <0 22>, <0 23>,
+			     <0 24>, <0 25>, <0 26>, <0 27>,
+			     <0 28>, <0 29>, <0 30>, <0 31>;
+	};
diff --git a/Documentation/devicetree/bindings/i2c/cavium-i2c.txt b/Documentation/devicetree/bindings/i2c/cavium-i2c.txt
new file mode 100644
index 0000000..dced82e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/cavium-i2c.txt
@@ -0,0 +1,34 @@
+* Two Wire Serial Interface (TWSI) / I2C
+
+- compatible: "cavium,octeon-3860-twsi"
+
+  Compatibility with all cn3XXX, cn5XXX and cn6XXX SOCs.
+
+- reg: The base address of the TWSI/I2C bus controller register bank.
+
+- #address-cells: Must be <1>.
+
+- #size-cells: Must be <0>.  I2C addresses have no size component.
+
+- interrupts: A single interrupt specifier.
+
+- clock-frequency: The I2C bus clock rate in Hz.
+
+Example:
+	twsi0: i2c@1180000001000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "cavium,octeon-3860-twsi";
+		reg = <0x11800 0x00001000 0x0 0x200>;
+		interrupts = <0 45>;
+		clock-frequency = <100000>;
+
+		rtc@68 {
+			compatible = "dallas,ds1337";
+			reg = <0x68>;
+		};
+		tmp@4c {
+			compatible = "ti,tmp421";
+			reg = <0x4c>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/mips/cavium/bootbus.txt b/Documentation/devicetree/bindings/mips/cavium/bootbus.txt
new file mode 100644
index 0000000..6581478
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/cavium/bootbus.txt
@@ -0,0 +1,126 @@
+* Boot Bus
+
+The Octeon Boot Bus is a configurable parallel bus with 8 chip
+selects.  Each chip select is independently configurable.
+
+Properties:
+- compatible: "cavium,octeon-3860-bootbus"
+
+  Compatibility with all cn3XXX, cn5XXX and cn6XXX SOCs.
+
+- reg: The base address of the Boot Bus' register bank.
+
+- #address-cells: Must be <2>.  The first cell is the chip select
+   within the bootbus.  The second cell is the offset from the chip select.
+
+- #size-cells: Must be <1>.
+
+- ranges: There must be one one triplet of (child-bus-address,
+  parent-bus-address, length) for each active chip select.  If the
+  length element for any triplet is zero, the chip select is disabled,
+  making it inactive.
+
+The configuration parameters for each chip select are stored in child
+nodes.
+
+Configuration Properties:
+- compatible:  "cavium,octeon-3860-bootbus-config"
+
+- cavium,cs-index: A single cell indicating the chip select that
+  corresponds to this configuration.
+
+- cavium,t-adr: A cell specifying the ADR timing (in nS).
+
+- cavium,t-ce: A cell specifying the CE timing (in nS).
+
+- cavium,t-oe: A cell specifying the OE timing (in nS).
+
+- cavium,t-we: A cell specifying the WE timing (in nS).
+
+- cavium,t-rd-hld: A cell specifying the RD_HLD timing (in nS).
+
+- cavium,t-wr-hld: A cell specifying the WR_HLD timing (in nS).
+
+- cavium,t-pause: A cell specifying the PAUSE timing (in nS).
+
+- cavium,t-wait: A cell specifying the WAIT timing (in nS).
+
+- cavium,t-page: A cell specifying the PAGE timing (in nS).
+
+- cavium,t-rd-dly: A cell specifying the RD_DLY timing (in nS).
+
+- cavium,pages: A cell specifying the PAGES parameter (0 = 8 bytes, 1
+  = 2 bytes, 2 = 4 bytes, 3 = 8 bytes).
+
+- cavium,wait-mode: Optional.  If present, wait mode (WAITM) is selected.
+
+- cavium,page-mode: Optional.  If present, page mode (PAGEM) is selected.
+
+- cavium,bus-width: A cell specifying the WIDTH parameter (in bits) of
+  the bus for this chip select.
+
+- cavium,ale-mode: Optional.  If present, ALE mode is selected.
+
+- cavium,sam-mode: Optional.  If present, SAM mode is selected.
+
+- cavium,or-mode: Optional.  If present, OR mode is selected.
+
+Example:
+	bootbus: bootbus@1180000000000 {
+		compatible = "cavium,octeon-3860-bootbus";
+		reg = <0x11800 0x00000000 0x0 0x200>;
+		/* The chip select number and offset */
+		#address-cells = <2>;
+		/* The size of the chip select region */
+		#size-cells = <1>;
+		ranges = <0 0  0x0 0x1f400000  0xc00000>,
+			 <1 0  0x10000 0x30000000  0>,
+			 <2 0  0x10000 0x40000000  0>,
+			 <3 0  0x10000 0x50000000  0>,
+			 <4 0  0x0 0x1d020000  0x10000>,
+			 <5 0  0x0 0x1d040000  0x10000>,
+			 <6 0  0x0 0x1d050000  0x10000>,
+			 <7 0  0x10000 0x90000000  0>;
+
+			cavium,cs-config@0 {
+			compatible = "cavium,octeon-3860-bootbus-config";
+			cavium,cs-index = <0>;
+			cavium,t-adr  = <20>;
+			cavium,t-ce   = <60>;
+			cavium,t-oe   = <60>;
+			cavium,t-we   = <45>;
+			cavium,t-rd-hld = <35>;
+			cavium,t-wr-hld = <45>;
+			cavium,t-pause  = <0>;
+			cavium,t-wait   = <0>;
+			cavium,t-page   = <35>;
+			cavium,t-rd-dly = <0>;
+
+			cavium,pages     = <0>;
+			cavium,bus-width = <8>;
+		};
+		.
+		.
+		.
+		cavium,cs-config@6 {
+			compatible = "cavium,octeon-3860-bootbus-config";
+			cavium,cs-index = <6>;
+			cavium,t-adr  = <5>;
+			cavium,t-ce   = <300>;
+			cavium,t-oe   = <270>;
+			cavium,t-we   = <150>;
+			cavium,t-rd-hld = <100>;
+			cavium,t-wr-hld = <70>;
+			cavium,t-pause  = <0>;
+			cavium,t-wait   = <0>;
+			cavium,t-page   = <320>;
+			cavium,t-rd-dly = <0>;
+
+			cavium,pages     = <0>;
+			cavium,wait-mode;
+			cavium,bus-width = <16>;
+		};
+		.
+		.
+		.
+	};
diff --git a/Documentation/devicetree/bindings/mips/cavium/ciu.txt b/Documentation/devicetree/bindings/mips/cavium/ciu.txt
new file mode 100644
index 0000000..2c2d074
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/cavium/ciu.txt
@@ -0,0 +1,26 @@
+* Central Interrupt Unit
+
+Properties:
+- compatible: "cavium,octeon-3860-ciu"
+
+  Compatibility with all cn3XXX, cn5XXX and cn63XX SOCs.
+
+- interrupt-controller:  This is an interrupt controller.
+
+- reg: The base address of the CIU's register bank.
+
+- #interrupt-cells: Must be <2>.  The first cell is the bank within
+   the CIU and may have a value of 0 or 1.  The second cell is the bit
+   within the bank and may have a value between 0 and 63.
+
+Example:
+	interrupt-controller@1070000000000 {
+		compatible = "cavium,octeon-3860-ciu";
+		interrupt-controller;
+		/* Interrupts are specified by two parts:
+		 * 1) Controller register (0 or 1)
+		 * 2) Bit within the register (0..63)
+		 */
+		#interrupt-cells = <2>;
+		reg = <0x10700 0x00000000 0x0 0x7000>;
+	};
diff --git a/Documentation/devicetree/bindings/mips/cavium/ciu2.txt b/Documentation/devicetree/bindings/mips/cavium/ciu2.txt
new file mode 100644
index 0000000..0ec7ba8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/cavium/ciu2.txt
@@ -0,0 +1,27 @@
+* Central Interrupt Unit
+
+Properties:
+- compatible: "cavium,octeon-6880-ciu2"
+
+  Compatibility with 68XX SOCs.
+
+- interrupt-controller:  This is an interrupt controller.
+
+- reg: The base address of the CIU's register bank.
+
+- #interrupt-cells: Must be <2>.  The first cell is the bank within
+  the CIU and may have a value between 0 and 63.  The second cell is
+  the bit within the bank and may also have a value between 0 and 63.
+
+Example:
+	interrupt-controller@1070100000000 {
+		compatible = "cavium,octeon-6880-ciu2";
+		interrupt-controller;
+		/* Interrupts are specified by two parts:
+		 * 1) Controller register (0..63)
+		 * 2) Bit within the register (0..63)
+		 */
+		#address-cells = <0>;
+		#interrupt-cells = <2>;
+		reg = <0x10701 0x00000000 0x0 0x4000000>;
+	};
diff --git a/Documentation/devicetree/bindings/mips/cavium/dma-engine.txt b/Documentation/devicetree/bindings/mips/cavium/dma-engine.txt
new file mode 100644
index 0000000..cb4291e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/cavium/dma-engine.txt
@@ -0,0 +1,21 @@
+* DMA Engine.
+
+The Octeon DMA Engine transfers between the Boot Bus and main memory.
+The DMA Engine will be refered to by phandle by any device that is
+connected to it.
+
+Properties:
+- compatible: "cavium,octeon-5750-bootbus-dma"
+
+  Compatibility with all cn52XX, cn56XX and cn6XXX SOCs.
+
+- reg: The base address of the DMA Engine's register bank.
+
+- interrupts: A single interrupt specifier.
+
+Example:
+	dma0: dma-engine@1180000000100 {
+		compatible = "cavium,octeon-5750-bootbus-dma";
+		reg = <0x11800 0x00000100 0x0 0x8>;
+		interrupts = <0 63>;
+	};
diff --git a/Documentation/devicetree/bindings/mips/cavium/uctl.txt b/Documentation/devicetree/bindings/mips/cavium/uctl.txt
new file mode 100644
index 0000000..5dabe02
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/cavium/uctl.txt
@@ -0,0 +1,47 @@
+* UCTL USB controller glue
+
+Properties:
+- compatible: "cavium,octeon-6335-uctl"
+
+  Compatibility with all cn6XXX SOCs.
+
+- reg: The base address of the UCTL register bank.
+
+- #address-cells: Must be <2>.
+
+- #size-cells: Must be <2>.
+
+- ranges: Empty to signify direct mapping of the children.
+
+- refclk-frequency: A single cell containing the reference clock
+  frequency in Hz.
+
+- refclk-type: A string describing the reference clock connection
+  either "crystal" or "external".
+
+Example:
+	uctl@118006f000000 {
+		compatible = "cavium,octeon-6335-uctl";
+		reg = <0x11800 0x6f000000 0x0 0x100>;
+		ranges; /* Direct mapping */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		/* 12MHz, 24MHz and 48MHz allowed */
+		refclk-frequency = <24000000>;
+		/* Either "crystal" or "external" */
+		refclk-type = "crystal";
+
+		ehci@16f0000000000 {
+			compatible = "cavium,octeon-6335-ehci","usb-ehci";
+			reg = <0x16f00 0x00000000 0x0 0x100>;
+			interrupts = <0 56>;
+			big-endian-regs;
+		};
+		ohci@16f0000000400 {
+			compatible = "cavium,octeon-6335-ohci","usb-ohci";
+			reg = <0x16f00 0x00000400 0x0 0x100>;
+			interrupts = <0 56>;
+			big-endian-regs;
+		};
+	};
+
diff --git a/Documentation/devicetree/bindings/net/cavium-mdio.txt b/Documentation/devicetree/bindings/net/cavium-mdio.txt
new file mode 100644
index 0000000..04cb749
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/cavium-mdio.txt
@@ -0,0 +1,27 @@
+* System Management Interface (SMI) / MDIO
+
+Properties:
+- compatible: "cavium,octeon-3860-mdio"
+
+  Compatibility with all cn3XXX, cn5XXX and cn6XXX SOCs.
+
+- reg: The base address of the MDIO bus controller register bank.
+
+- #address-cells: Must be <1>.
+
+- #size-cells: Must be <0>.  MDIO addresses have no size component.
+
+Typically an MDIO bus might have several children.
+
+Example:
+	mdio@1180000001800 {
+		compatible = "cavium,octeon-3860-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x11800 0x00001800 0x0 0x40>;
+
+		ethernet-phy@0 {
+			...
+			reg = <0>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/net/cavium-mix.txt b/Documentation/devicetree/bindings/net/cavium-mix.txt
new file mode 100644
index 0000000..e4f9d3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/cavium-mix.txt
@@ -0,0 +1,40 @@
+* MIX Ethernet controller.
+
+Properties:
+- compatible: "cavium,octeon-5750-mix"
+
+  Compatibility with all cn5XXX and cn6XXX SOCs populated with MIX
+  devices.
+
+- reg: The base addresses of four separate register banks.  The first
+  bank contains the MIX registers.  The second bank the corresponding
+  AGL registers.  The third bank are the AGL registers shared by all
+  MIX devices present.  The fourth bank is the AGL_PRT_CTL shared by
+  all MIX devices present.
+
+- cell-index: A single cell specifying which portion of the shared
+  register banks corresponds to this MIX device.
+
+- interrupts: Two interrupt specifiers.  The first is the MIX
+  interrupt routing and the second the routing for the AGL interrupts.
+
+- mac-address: Optional, the MAC address to assign to the device.
+
+- local-mac-address: Optional, the MAC address to assign to the device
+  if mac-address is not specified.
+
+- phy-handle: Optional, a phandle for the PHY device connected to this device.
+
+Example:
+	ethernet@1070000100800 {
+		compatible = "cavium,octeon-5750-mix";
+		reg = <0x10700 0x00100800 0x0 0x100>, /* MIX */
+		      <0x11800 0xE0000800 0x0 0x300>, /* AGL */
+		      <0x11800 0xE0000400 0x0 0x400>, /* AGL_SHARED  */
+		      <0x11800 0xE0002008 0x0 0x8>;   /* AGL_PRT_CTL */
+		cell-index = <1>;
+		interrupts = <1 18>, < 1 46>;
+		local-mac-address = [ 00 0f b7 10 63 54 ];
+		phy-handle = <&phy1>;
+	};
+
diff --git a/Documentation/devicetree/bindings/net/cavium-pip.txt b/Documentation/devicetree/bindings/net/cavium-pip.txt
new file mode 100644
index 0000000..d4c53ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/cavium-pip.txt
@@ -0,0 +1,98 @@
+* PIP Ethernet nexus.
+
+The PIP Ethernet nexus can control several data packet input/output
+devices.  The devices have a two level grouping scheme.  There may be
+several interfaces, and each interface may have several ports.  These
+ports might be an individual Ethernet PHY.
+
+
+Properties for the PIP nexus:
+- compatible: "cavium,octeon-3860-pip"
+
+  Compatibility with all cn3XXX, cn5XXX and cn6XXX SOCs.
+
+- reg: The base address of the PIP's register bank.
+
+- #address-cells: Must be <1>.
+
+- #size-cells: Must be <0>.
+
+Properties for PIP interfaces which is a child the PIP nexus:
+- compatible: "cavium,octeon-3860-pip-interface"
+
+  Compatibility with all cn3XXX, cn5XXX and cn6XXX SOCs.
+
+- reg: The interface number.
+
+- #address-cells: Must be <1>.
+
+- #size-cells: Must be <0>.
+
+Properties for PIP port which is a child the PIP interface:
+- compatible: "cavium,octeon-3860-pip-port"
+
+  Compatibility with all cn3XXX, cn5XXX and cn6XXX SOCs.
+
+- reg: The port number within the interface group.
+
+- mac-address: Optional, the MAC address to assign to the device.
+
+- local-mac-address: Optional, the MAC address to assign to the device
+  if mac-address is not specified.
+
+- phy-handle: Optional, a phandle for the PHY device connected to this device.
+
+Example:
+
+	pip@11800a0000000 {
+		compatible = "cavium,octeon-3860-pip";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x11800 0xa0000000 0x0 0x2000>;
+
+		interface@0 {
+			compatible = "cavium,octeon-3860-pip-interface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>; /* interface */
+
+			ethernet@0 {
+				compatible = "cavium,octeon-3860-pip-port";
+				reg = <0x0>; /* Port */
+				local-mac-address = [ 00 0f b7 10 63 60 ];
+				phy-handle = <&phy2>;
+			};
+			ethernet@1 {
+				compatible = "cavium,octeon-3860-pip-port";
+				reg = <0x1>; /* Port */
+				local-mac-address = [ 00 0f b7 10 63 61 ];
+				phy-handle = <&phy3>;
+			};
+			ethernet@2 {
+				compatible = "cavium,octeon-3860-pip-port";
+				reg = <0x2>; /* Port */
+				local-mac-address = [ 00 0f b7 10 63 62 ];
+				phy-handle = <&phy4>;
+			};
+			ethernet@3 {
+				compatible = "cavium,octeon-3860-pip-port";
+				reg = <0x3>; /* Port */
+				local-mac-address = [ 00 0f b7 10 63 63 ];
+				phy-handle = <&phy5>;
+			};
+		};
+
+		interface@1 {
+			compatible = "cavium,octeon-3860-pip-interface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>; /* interface */
+
+			ethernet@0 {
+				compatible = "cavium,octeon-3860-pip-port";
+				reg = <0x0>; /* Port */
+				local-mac-address = [ 00 0f b7 10 63 64 ];
+				phy-handle = <&phy6>;
+			};
+		};
+	};
diff --git a/Documentation/devicetree/bindings/serial/cavium-uart.txt b/Documentation/devicetree/bindings/serial/cavium-uart.txt
new file mode 100644
index 0000000..87a6c37
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cavium-uart.txt
@@ -0,0 +1,19 @@
+* Universal Asynchronous Receiver/Transmitter (UART)
+
+- compatible: "cavium,octeon-3860-uart"
+
+  Compatibility with all cn3XXX, cn5XXX and cn6XXX SOCs.
+
+- reg: The base address of the UART register bank.
+
+- interrupts: A single interrupt specifier.
+
+- current-speed: Optional, the current bit rate in bits per second.
+
+Example:
+	uart1: serial@1180000000c00 {
+		compatible = "cavium,octeon-3860-uart","ns16550";
+		reg = <0x11800 0x00000c00 0x0 0x400>;
+		current-speed = <115200>;
+		interrupts = <0 35>;
+	};
diff --git a/arch/mips/cavium-octeon/.gitignore b/arch/mips/cavium-octeon/.gitignore
new file mode 100644
index 0000000..39c9686
--- /dev/null
+++ b/arch/mips/cavium-octeon/.gitignore
@@ -0,0 +1,2 @@
+*.dtb.S
+*.dtb
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 19eb043..1e37522 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -15,3 +15,16 @@ obj-y += octeon-memcpy.o
 obj-y += executive/
 
 obj-$(CONFIG_SMP)                     += smp.o
+
+DTS_FILES = octeon_3xxx.dts octeon_68xx.dts
+DTB_FILES = $(patsubst %.dts, %.dtb, $(DTS_FILES))
+
+obj-y += $(patsubst %.dts, %.dtb.o, $(DTS_FILES))
+
+$(obj)/%.dtb: $(src)/%.dts FORCE
+	$(call if_changed_dep,dtc)
+
+# Let's keep the .dtb files around in case we want to look at them.
+.SECONDARY:  $(addprefix $(obj)/, $(DTB_FILES))
+
+clean-files += $(DTB_FILES) $(patsubst %.dtb, %.dtb.S, $(DTB_FILES))
diff --git a/arch/mips/cavium-octeon/octeon_3xxx.dts b/arch/mips/cavium-octeon/octeon_3xxx.dts
new file mode 100644
index 0000000..f28b2d0
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon_3xxx.dts
@@ -0,0 +1,571 @@
+/dts-v1/;
+/*
+ * OCTEON 3XXX, 5XXX, 63XX device tree skeleton.
+ *
+ * This device tree is pruned and patched by early boot code before
+ * use.  Because of this, it contains a super-set of the available
+ * devices and properties.
+ */
+/ {
+	compatible = "cavium,octeon-3860";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&ciu>;
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges; /* Direct mapping */
+
+		ciu: interrupt-controller@1070000000000 {
+			compatible = "cavium,octeon-3860-ciu";
+			interrupt-controller;
+			/* Interrupts are specified by two parts:
+			 * 1) Controller register (0 or 1)
+			 * 2) Bit within the register (0..63)
+			 */
+			#interrupt-cells = <2>;
+			reg = <0x10700 0x00000000 0x0 0x7000>;
+		};
+
+		gpio: gpio-controller@1070000000800 {
+			#gpio-cells = <2>;
+			compatible = "cavium,octeon-3860-gpio";
+			reg = <0x10700 0x00000800 0x0 0x100>;
+			gpio-controller;
+			/* Interrupts are specified by two parts:
+			 * 1) GPIO pin number (0..15)
+			 * 2) Triggering (1 - edge rising
+			 *		  2 - edge falling
+			 *		  4 - level active high
+			 *		  8 - level active low)
+			 */
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			/* The GPIO pin connect to 16 consecutive CUI bits */
+			interrupts = <0 16>, <0 17>, <0 18>, <0 19>,
+				     <0 20>, <0 21>, <0 22>, <0 23>,
+				     <0 24>, <0 25>, <0 26>, <0 27>,
+				     <0 28>, <0 29>, <0 30>, <0 31>;
+		};
+
+		smi0: mdio@1180000001800 {
+			compatible = "cavium,octeon-3860-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x11800 0x00001800 0x0 0x40>;
+
+			phy0: ethernet-phy@0 {
+				compatible = "marvell,88e1118";
+				marvell,reg-init =
+					/* Fix rx and tx clock transition timing */
+					<2 0x15 0xffcf 0>, /* Reg 2,21 Clear bits 4, 5 */
+					/* Adjust LED drive. */
+					<3 0x11 0 0x442a>, /* Reg 3,17 <- 0442a */
+					/* irq, blink-activity, blink-link */
+					<3 0x10 0 0x0242>; /* Reg 3,16 <- 0x0242 */
+				reg = <0>;
+			};
+
+			phy1: ethernet-phy@1 {
+				compatible = "marvell,88e1118";
+				marvell,reg-init =
+					/* Fix rx and tx clock transition timing */
+					<2 0x15 0xffcf 0>, /* Reg 2,21 Clear bits 4, 5 */
+					/* Adjust LED drive. */
+					<3 0x11 0 0x442a>, /* Reg 3,17 <- 0442a */
+					/* irq, blink-activity, blink-link */
+					<3 0x10 0 0x0242>; /* Reg 3,16 <- 0x0242 */
+				reg = <1>;
+			};
+
+			phy2: ethernet-phy@2 {
+				reg = <2>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy3: ethernet-phy@3 {
+				reg = <3>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy4: ethernet-phy@4 {
+				reg = <4>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy5: ethernet-phy@5 {
+				reg = <5>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+
+			phy6: ethernet-phy@6 {
+				reg = <6>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy7: ethernet-phy@7 {
+				reg = <7>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy8: ethernet-phy@8 {
+				reg = <8>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy9: ethernet-phy@9 {
+				reg = <9>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+		};
+
+		smi1: mdio@1180000001900 {
+			compatible = "cavium,octeon-3860-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x11800 0x00001900 0x0 0x40>;
+
+			phy100: ethernet-phy@1 {
+				reg = <1>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <12 8>; /* Pin 12, active low */
+			};
+			phy101: ethernet-phy@2 {
+				reg = <2>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <12 8>; /* Pin 12, active low */
+			};
+			phy102: ethernet-phy@3 {
+				reg = <3>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <12 8>; /* Pin 12, active low */
+			};
+			phy103: ethernet-phy@4 {
+				reg = <4>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+				interrupt-parent = <&gpio>;
+				interrupts = <12 8>; /* Pin 12, active low */
+			};
+		};
+
+		mix0: ethernet@1070000100000 {
+			compatible = "cavium,octeon-5750-mix";
+			reg = <0x10700 0x00100000 0x0 0x100>, /* MIX */
+			      <0x11800 0xE0000000 0x0 0x300>, /* AGL */
+			      <0x11800 0xE0000400 0x0 0x400>, /* AGL_SHARED  */
+			      <0x11800 0xE0002000 0x0 0x8>;   /* AGL_PRT_CTL */
+			cell-index = <0>;
+			interrupts = <0 62>, <1 46>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-handle = <&phy0>;
+		};
+
+		mix1: ethernet@1070000100800 {
+			compatible = "cavium,octeon-5750-mix";
+			reg = <0x10700 0x00100800 0x0 0x100>, /* MIX */
+			      <0x11800 0xE0000800 0x0 0x300>, /* AGL */
+			      <0x11800 0xE0000400 0x0 0x400>, /* AGL_SHARED  */
+			      <0x11800 0xE0002008 0x0 0x8>;   /* AGL_PRT_CTL */
+			cell-index = <1>;
+			interrupts = <1 18>, < 1 46>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-handle = <&phy1>;
+		};
+
+		pip: pip@11800a0000000 {
+			compatible = "cavium,octeon-3860-pip";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x11800 0xa0000000 0x0 0x2000>;
+
+			interface@0 {
+				compatible = "cavium,octeon-3860-pip-interface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>; /* interface */
+
+				ethernet@0 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x0>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy2>;
+					cavium,alt-phy-handle = <&phy100>;
+				};
+				ethernet@1 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x1>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy3>;
+					cavium,alt-phy-handle = <&phy101>;
+				};
+				ethernet@2 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x2>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy4>;
+					cavium,alt-phy-handle = <&phy102>;
+				};
+				ethernet@3 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x3>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy5>;
+					cavium,alt-phy-handle = <&phy103>;
+				};
+				ethernet@4 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x4>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@5 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x5>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@6 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x6>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@7 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x7>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@8 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x8>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@9 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x9>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@a {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0xa>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@b {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0xb>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@c {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0xc>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@d {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0xd>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@e {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0xe>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+				ethernet@f {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0xf>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+			};
+
+			interface@1 {
+				compatible = "cavium,octeon-3860-pip-interface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>; /* interface */
+
+				ethernet@0 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x0>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy6>;
+				};
+				ethernet@1 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x1>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy7>;
+				};
+				ethernet@2 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x2>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy8>;
+				};
+				ethernet@3 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x3>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy9>;
+				};
+			};
+		};
+
+		twsi0: i2c@1180000001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "cavium,octeon-3860-twsi";
+			reg = <0x11800 0x00001000 0x0 0x200>;
+			interrupts = <0 45>;
+			clock-frequency = <100000>;
+
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+			};
+			tmp@4c {
+				compatible = "ti,tmp421";
+				reg = <0x4c>;
+			};
+		};
+
+		twsi1: i2c@1180000001200 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "cavium,octeon-3860-twsi";
+			reg = <0x11800 0x00001200 0x0 0x200>;
+			interrupts = <0 59>;
+			clock-frequency = <100000>;
+		};
+
+		uart0: serial@1180000000800 {
+			compatible = "cavium,octeon-3860-uart","ns16550";
+			reg = <0x11800 0x00000800 0x0 0x400>;
+			clock-frequency = <0>;
+			current-speed = <115200>;
+			reg-shift = <3>;
+			interrupts = <0 34>;
+		};
+
+		uart1: serial@1180000000c00 {
+			compatible = "cavium,octeon-3860-uart","ns16550";
+			reg = <0x11800 0x00000c00 0x0 0x400>;
+			clock-frequency = <0>;
+			current-speed = <115200>;
+			reg-shift = <3>;
+			interrupts = <0 35>;
+		};
+
+		uart2: serial@1180000000400 {
+			compatible = "cavium,octeon-3860-uart","ns16550";
+			reg = <0x11800 0x00000400 0x0 0x400>;
+			clock-frequency = <0>;
+			current-speed = <115200>;
+			reg-shift = <3>;
+			interrupts = <1 16>;
+		};
+
+		bootbus: bootbus@1180000000000 {
+			compatible = "cavium,octeon-3860-bootbus";
+			reg = <0x11800 0x00000000 0x0 0x200>;
+			/* The chip select number and offset */
+			#address-cells = <2>;
+			/* The size of the chip select region */
+			#size-cells = <1>;
+			ranges = <0 0  0x0 0x1f400000  0xc00000>,
+				 <1 0  0x10000 0x30000000  0>,
+				 <2 0  0x10000 0x40000000  0>,
+				 <3 0  0x10000 0x50000000  0>,
+				 <4 0  0x0 0x1d020000  0x10000>,
+				 <5 0  0x0 0x1d040000  0x10000>,
+				 <6 0  0x0 0x1d050000  0x10000>,
+				 <7 0  0x10000 0x90000000  0>;
+
+			cavium,cs-config@0 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <0>;
+				cavium,t-adr  = <20>;
+				cavium,t-ce   = <60>;
+				cavium,t-oe   = <60>;
+				cavium,t-we   = <45>;
+				cavium,t-rd-hld = <35>;
+				cavium,t-wr-hld = <45>;
+				cavium,t-pause  = <0>;
+				cavium,t-wait   = <0>;
+				cavium,t-page   = <35>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages     = <0>;
+				cavium,bus-width = <8>;
+			};
+			cavium,cs-config@4 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <4>;
+				cavium,t-adr  = <320>;
+				cavium,t-ce   = <320>;
+				cavium,t-oe   = <320>;
+				cavium,t-we   = <320>;
+				cavium,t-rd-hld = <320>;
+				cavium,t-wr-hld = <320>;
+				cavium,t-pause  = <320>;
+				cavium,t-wait   = <320>;
+				cavium,t-page   = <320>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages     = <0>;
+				cavium,bus-width = <8>;
+			};
+			cavium,cs-config@5 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <5>;
+				cavium,t-adr  = <5>;
+				cavium,t-ce   = <300>;
+				cavium,t-oe   = <125>;
+				cavium,t-we   = <150>;
+				cavium,t-rd-hld = <100>;
+				cavium,t-wr-hld = <30>;
+				cavium,t-pause  = <0>;
+				cavium,t-wait   = <30>;
+				cavium,t-page   = <320>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages     = <0>;
+				cavium,bus-width = <16>;
+			};
+			cavium,cs-config@6 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <6>;
+				cavium,t-adr  = <5>;
+				cavium,t-ce   = <300>;
+				cavium,t-oe   = <270>;
+				cavium,t-we   = <150>;
+				cavium,t-rd-hld = <100>;
+				cavium,t-wr-hld = <70>;
+				cavium,t-pause  = <0>;
+				cavium,t-wait   = <0>;
+				cavium,t-page   = <320>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages     = <0>;
+				cavium,wait-mode;
+				cavium,bus-width = <16>;
+			};
+
+			flash0: nor@0,0 {
+				compatible = "cfi-flash";
+				reg = <0 0 0x800000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+
+			led0: led-display@4,0 {
+				compatible = "avago,hdsp-253x";
+				reg = <4 0x20 0x20>, <4 0 0x20>;
+			};
+
+			cf0: compact-flash@5,0 {
+				compatible = "cavium,ebt3000-compact-flash";
+				reg = <5 0 0x10000>, <6 0 0x10000>;
+				cavium,bus-width = <16>;
+				cavium,true-ide;
+				cavium,dma-engine-handle = <&dma0>;
+			};
+		};
+
+		dma0: dma-engine@1180000000100 {
+			compatible = "cavium,octeon-5750-bootbus-dma";
+			reg = <0x11800 0x00000100 0x0 0x8>;
+			interrupts = <0 63>;
+		};
+		dma1: dma-engine@1180000000108 {
+			compatible = "cavium,octeon-5750-bootbus-dma";
+			reg = <0x11800 0x00000108 0x0 0x8>;
+			interrupts = <0 63>;
+		};
+
+		uctl: uctl@118006f000000 {
+			compatible = "cavium,octeon-6335-uctl";
+			reg = <0x11800 0x6f000000 0x0 0x100>;
+			ranges; /* Direct mapping */
+			#address-cells = <2>;
+			#size-cells = <2>;
+			/* 12MHz, 24MHz and 48MHz allowed */
+			refclk-frequency = <12000000>;
+			/* Either "crystal" or "external" */
+			refclk-type = "crystal";
+
+			ehci@16f0000000000 {
+				compatible = "cavium,octeon-6335-ehci","usb-ehci";
+				reg = <0x16f00 0x00000000 0x0 0x100>;
+				interrupts = <0 56>;
+				big-endian-regs;
+			};
+			ohci@16f0000000400 {
+				compatible = "cavium,octeon-6335-ohci","usb-ohci";
+				reg = <0x16f00 0x00000400 0x0 0x100>;
+				interrupts = <0 56>;
+				big-endian-regs;
+			};
+		};
+	};
+
+	aliases {
+		mix0 = &mix0;
+		mix1 = &mix1;
+		pip = &pip;
+		smi0 = &smi0;
+		smi1 = &smi1;
+		twsi0 = &twsi0;
+		twsi1 = &twsi1;
+		uart0 = &uart0;
+		uart1 = &uart1;
+		uart2 = &uart2;
+		flash0 = &flash0;
+		cf0 = &cf0;
+		uctl = &uctl;
+		led0 = &led0;
+	};
+ };
diff --git a/arch/mips/cavium-octeon/octeon_68xx.dts b/arch/mips/cavium-octeon/octeon_68xx.dts
new file mode 100644
index 0000000..1839468
--- /dev/null
+++ b/arch/mips/cavium-octeon/octeon_68xx.dts
@@ -0,0 +1,625 @@
+/dts-v1/;
+/*
+ * OCTEON 68XX device tree skeleton.
+ *
+ * This device tree is pruned and patched by early boot code before
+ * use.  Because of this, it contains a super-set of the available
+ * devices and properties.
+ */
+/ {
+	compatible = "cavium,octeon-6880";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&ciu2>;
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges; /* Direct mapping */
+
+		ciu2: interrupt-controller@1070100000000 {
+			compatible = "cavium,octeon-6880-ciu2";
+			interrupt-controller;
+			/* Interrupts are specified by two parts:
+			 * 1) Controller register (0 or 7)
+			 * 2) Bit within the register (0..63)
+			 */
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0x10701 0x00000000 0x0 0x4000000>;
+		};
+
+		gpio: gpio-controller@1070000000800 {
+			#gpio-cells = <2>;
+			compatible = "cavium,octeon-3860-gpio";
+			reg = <0x10700 0x00000800 0x0 0x100>;
+			gpio-controller;
+			/* Interrupts are specified by two parts:
+			 * 1) GPIO pin number (0..15)
+			 * 2) Triggering (1 - edge rising
+			 *		  2 - edge falling
+			 *		  4 - level active high
+			 *		  8 - level active low)
+			 */
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			/* The GPIO pins connect to 16 consecutive CUI bits */
+			interrupts = <7 0>,  <7 1>,  <7 2>,  <7 3>,
+				     <7 4>,  <7 5>,  <7 6>,  <7 7>,
+				     <7 8>,  <7 9>,  <7 10>, <7 11>,
+				     <7 12>, <7 13>, <7 14>, <7 15>;
+		};
+
+		smi0: mdio@1180000003800 {
+			compatible = "cavium,octeon-3860-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x11800 0x00003800 0x0 0x40>;
+
+			phy0: ethernet-phy@6 {
+				compatible = "marvell,88e1118";
+				marvell,reg-init =
+					/* Fix rx and tx clock transition timing */
+					<2 0x15 0xffcf 0>, /* Reg 2,21 Clear bits 4, 5 */
+					/* Adjust LED drive. */
+					<3 0x11 0 0x442a>, /* Reg 3,17 <- 0442a */
+					/* irq, blink-activity, blink-link */
+					<3 0x10 0 0x0242>; /* Reg 3,16 <- 0x0242 */
+				reg = <6>;
+			};
+
+			phy1: ethernet-phy@1 {
+				cavium,qlm-trim = "4,sgmii";
+				reg = <1>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy2: ethernet-phy@2 {
+				cavium,qlm-trim = "4,sgmii";
+				reg = <2>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy3: ethernet-phy@3 {
+				cavium,qlm-trim = "4,sgmii";
+				reg = <3>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy4: ethernet-phy@4 {
+				cavium,qlm-trim = "4,sgmii";
+				reg = <4>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+		};
+
+		smi1: mdio@1180000003880 {
+			compatible = "cavium,octeon-3860-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x11800 0x00003880 0x0 0x40>;
+
+			phy41: ethernet-phy@1 {
+				cavium,qlm-trim = "0,sgmii";
+				reg = <1>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy42: ethernet-phy@2 {
+				cavium,qlm-trim = "0,sgmii";
+				reg = <2>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy43: ethernet-phy@3 {
+				cavium,qlm-trim = "0,sgmii";
+				reg = <3>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy44: ethernet-phy@4 {
+				cavium,qlm-trim = "0,sgmii";
+				reg = <4>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+		};
+
+		smi2: mdio@1180000003900 {
+			compatible = "cavium,octeon-3860-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x11800 0x00003900 0x0 0x40>;
+
+			phy21: ethernet-phy@1 {
+				cavium,qlm-trim = "2,sgmii";
+				reg = <1>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy22: ethernet-phy@2 {
+				cavium,qlm-trim = "2,sgmii";
+				reg = <2>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy23: ethernet-phy@3 {
+				cavium,qlm-trim = "2,sgmii";
+				reg = <3>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy24: ethernet-phy@4 {
+				cavium,qlm-trim = "2,sgmii";
+				reg = <4>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+		};
+
+		smi3: mdio@1180000003980 {
+			compatible = "cavium,octeon-3860-mdio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x11800 0x00003980 0x0 0x40>;
+
+			phy11: ethernet-phy@1 {
+				cavium,qlm-trim = "3,sgmii";
+				reg = <1>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy12: ethernet-phy@2 {
+				cavium,qlm-trim = "3,sgmii";
+				reg = <2>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy13: ethernet-phy@3 {
+				cavium,qlm-trim = "3,sgmii";
+				reg = <3>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+			phy14: ethernet-phy@4 {
+				cavium,qlm-trim = "3,sgmii";
+				reg = <4>;
+				compatible = "marvell,88e1149r";
+				marvell,reg-init = <3 0x10 0 0x5777>,
+					<3 0x11 0 0x00aa>,
+					<3 0x12 0 0x4105>,
+					<3 0x13 0 0x0a60>;
+			};
+		};
+
+		mix0: ethernet@1070000100000 {
+			compatible = "cavium,octeon-5750-mix";
+			reg = <0x10700 0x00100000 0x0 0x100>, /* MIX */
+			      <0x11800 0xE0000000 0x0 0x300>, /* AGL */
+			      <0x11800 0xE0000400 0x0 0x400>, /* AGL_SHARED  */
+			      <0x11800 0xE0002000 0x0 0x8>;   /* AGL_PRT_CTL */
+			cell-index = <0>;
+			interrupts = <6 40>, <6 32>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			phy-handle = <&phy0>;
+		};
+
+		pip: pip@11800a0000000 {
+			compatible = "cavium,octeon-3860-pip";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x11800 0xa0000000 0x0 0x2000>;
+
+			interface@4 {
+				compatible = "cavium,octeon-3860-pip-interface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x4>; /* interface */
+
+				ethernet@0 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x0>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy1>;
+				};
+				ethernet@1 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x1>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy2>;
+				};
+				ethernet@2 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x2>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy3>;
+				};
+				ethernet@3 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x3>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy4>;
+				};
+			};
+
+			interface@3 {
+				compatible = "cavium,octeon-3860-pip-interface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x3>; /* interface */
+
+				ethernet@0 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x0>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy11>;
+				};
+				ethernet@1 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x1>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy12>;
+				};
+				ethernet@2 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x2>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy13>;
+				};
+				ethernet@3 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x3>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy14>;
+				};
+			};
+
+			interface@2 {
+				compatible = "cavium,octeon-3860-pip-interface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x2>; /* interface */
+
+				ethernet@0 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x0>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy21>;
+				};
+				ethernet@1 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x1>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy22>;
+				};
+				ethernet@2 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x2>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy23>;
+				};
+				ethernet@3 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x3>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy24>;
+				};
+			};
+
+			interface@1 {
+				compatible = "cavium,octeon-3860-pip-interface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1>; /* interface */
+
+				ethernet@0 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x0>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+				};
+			};
+
+			interface@0 {
+				compatible = "cavium,octeon-3860-pip-interface";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0>; /* interface */
+
+				ethernet@0 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x0>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy41>;
+				};
+				ethernet@1 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x1>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy42>;
+				};
+				ethernet@2 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x2>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy43>;
+				};
+				ethernet@3 {
+					compatible = "cavium,octeon-3860-pip-port";
+					reg = <0x3>; /* Port */
+					local-mac-address = [ 00 00 00 00 00 00 ];
+					phy-handle = <&phy44>;
+				};
+			};
+		};
+
+		twsi0: i2c@1180000001000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "cavium,octeon-3860-twsi";
+			reg = <0x11800 0x00001000 0x0 0x200>;
+			interrupts = <3 32>;
+			clock-frequency = <100000>;
+
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+			};
+			tmp@4c {
+				compatible = "ti,tmp421";
+				reg = <0x4c>;
+			};
+		};
+
+		twsi1: i2c@1180000001200 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "cavium,octeon-3860-twsi";
+			reg = <0x11800 0x00001200 0x0 0x200>;
+			interrupts = <3 33>;
+			clock-frequency = <100000>;
+		};
+
+		uart0: serial@1180000000800 {
+			compatible = "cavium,octeon-3860-uart","ns16550";
+			reg = <0x11800 0x00000800 0x0 0x400>;
+			clock-frequency = <0>;
+			current-speed = <115200>;
+			reg-shift = <3>;
+			interrupts = <3 36>;
+		};
+
+		uart1: serial@1180000000c00 {
+			compatible = "cavium,octeon-3860-uart","ns16550";
+			reg = <0x11800 0x00000c00 0x0 0x400>;
+			clock-frequency = <0>;
+			current-speed = <115200>;
+			reg-shift = <3>;
+			interrupts = <3 37>;
+		};
+
+		bootbus: bootbus@1180000000000 {
+			compatible = "cavium,octeon-3860-bootbus";
+			reg = <0x11800 0x00000000 0x0 0x200>;
+			/* The chip select number and offset */
+			#address-cells = <2>;
+			/* The size of the chip select region */
+			#size-cells = <1>;
+			ranges = <0 0  0       0x1f400000  0xc00000>,
+				 <1 0  0x10000 0x30000000  0>,
+				 <2 0  0x10000 0x40000000  0>,
+				 <3 0  0x10000 0x50000000  0>,
+				 <4 0  0       0x1d020000  0x10000>,
+				 <5 0  0       0x1d040000  0x10000>,
+				 <6 0  0       0x1d050000  0x10000>,
+				 <7 0  0x10000 0x90000000  0>;
+
+			cavium,cs-config@0 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <0>;
+				cavium,t-adr  = <10>;
+				cavium,t-ce   = <50>;
+				cavium,t-oe   = <50>;
+				cavium,t-we   = <35>;
+				cavium,t-rd-hld = <25>;
+				cavium,t-wr-hld = <35>;
+				cavium,t-pause  = <0>;
+				cavium,t-wait   = <300>;
+				cavium,t-page   = <25>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages     = <0>;
+				cavium,bus-width = <8>;
+			};
+			cavium,cs-config@4 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <4>;
+				cavium,t-adr  = <320>;
+				cavium,t-ce   = <320>;
+				cavium,t-oe   = <320>;
+				cavium,t-we   = <320>;
+				cavium,t-rd-hld = <320>;
+				cavium,t-wr-hld = <320>;
+				cavium,t-pause  = <320>;
+				cavium,t-wait   = <320>;
+				cavium,t-page   = <320>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages     = <0>;
+				cavium,bus-width = <8>;
+			};
+			cavium,cs-config@5 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <5>;
+				cavium,t-adr  = <0>;
+				cavium,t-ce   = <300>;
+				cavium,t-oe   = <125>;
+				cavium,t-we   = <150>;
+				cavium,t-rd-hld = <100>;
+				cavium,t-wr-hld = <300>;
+				cavium,t-pause  = <0>;
+				cavium,t-wait   = <300>;
+				cavium,t-page   = <310>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages     = <0>;
+				cavium,bus-width = <16>;
+			};
+			cavium,cs-config@6 {
+				compatible = "cavium,octeon-3860-bootbus-config";
+				cavium,cs-index = <6>;
+				cavium,t-adr  = <0>;
+				cavium,t-ce   = <30>;
+				cavium,t-oe   = <125>;
+				cavium,t-we   = <150>;
+				cavium,t-rd-hld = <100>;
+				cavium,t-wr-hld = <30>;
+				cavium,t-pause  = <0>;
+				cavium,t-wait   = <30>;
+				cavium,t-page   = <310>;
+				cavium,t-rd-dly = <0>;
+
+				cavium,pages     = <0>;
+				cavium,wait-mode;
+				cavium,bus-width = <16>;
+			};
+
+			flash0: nor@0,0 {
+				compatible = "cfi-flash";
+				reg = <0 0 0x800000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					label = "bootloader";
+					reg = <0 0x200000>;
+					read-only;
+				};
+				partition@200000 {
+					label = "kernel";
+					reg = <0x200000 0x200000>;
+				};
+				partition@400000 {
+					label = "cramfs";
+					reg = <0x400000 0x3fe000>;
+				};
+				partition@7fe000 {
+					label = "environment";
+					reg = <0x7fe000 0x2000>;
+					read-only;
+				};
+			};
+
+			led0: led-display@4,0 {
+				compatible = "avago,hdsp-253x";
+				reg = <4 0x20 0x20>, <4 0 0x20>;
+			};
+
+			compact-flash@5,0 {
+				compatible = "cavium,ebt3000-compact-flash";
+				reg = <5 0 0x10000>, <6 0 0x10000>;
+				cavium,bus-width = <16>;
+				cavium,true-ide;
+				cavium,dma-engine-handle = <&dma0>;
+			};
+		};
+
+		dma0: dma-engine@1180000000100 {
+			compatible = "cavium,octeon-5750-bootbus-dma";
+			reg = <0x11800 0x00000100 0x0 0x8>;
+			interrupts = <0 63>;
+		};
+		dma1: dma-engine@1180000000108 {
+			compatible = "cavium,octeon-5750-bootbus-dma";
+			reg = <0x11800 0x00000108 0x0 0x8>;
+			interrupts = <0 63>;
+		};
+
+		uctl: uctl@118006f000000 {
+			compatible = "cavium,octeon-6335-uctl";
+			reg = <0x11800 0x6f000000 0x0 0x100>;
+			ranges; /* Direct mapping */
+			#address-cells = <2>;
+			#size-cells = <2>;
+			/* 12MHz, 24MHz and 48MHz allowed */
+			refclk-frequency = <12000000>;
+			/* Either "crystal" or "external" */
+			refclk-type = "crystal";
+
+			ehci@16f0000000000 {
+				compatible = "cavium,octeon-6335-ehci","usb-ehci";
+				reg = <0x16f00 0x00000000 0x0 0x100>;
+				interrupts = <3 44>;
+				big-endian-regs;
+			};
+			ohci@16f0000000400 {
+				compatible = "cavium,octeon-6335-ohci","usb-ohci";
+				reg = <0x16f00 0x00000400 0x0 0x100>;
+				interrupts = <3 44>;
+				big-endian-regs;
+			};
+		};
+	};
+
+	aliases {
+		mix0 = &mix0;
+		pip = &pip;
+		smi0 = &smi0;
+		smi1 = &smi1;
+		smi2 = &smi2;
+		smi3 = &smi3;
+		twsi0 = &twsi0;
+		twsi1 = &twsi1;
+		uart0 = &uart0;
+		uart1 = &uart1;
+		uctl = &uctl;
+		led0 = &led0;
+		flash0 = &flash0;
+	};
+ };
-- 
1.7.2.3
