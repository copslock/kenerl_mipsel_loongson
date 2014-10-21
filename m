Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:32:29 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57450 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011997AbaJUE26nf3HC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:58 +0200
Received: by mail-pa0-f43.google.com with SMTP id lf10so532155pab.2
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/toQr60eiF3UlkLWbUMFFlwrL8r84SOwW6exv/99JSM=;
        b=LOHGSwjtsecNBGY2yg5R3dUNNAFlI5fwJkgCRxifsZiU9cosmp4kyh1lSOm4isoMy7
         F22t/vXJufQOZqTgxzhBGQ+CePYTWJGohwbasFf0dJW5E58GMfPj4qKDDJt9P34ZfILo
         be2DUz3jtQl4FL6+9AArq9iYPvvbQKN7CdkQ+0pRm6dlR2e1oDvMa9Fy3oIqmbBRqnip
         XHvCP50IQfD/s9A3xU9NkWBNNOgHTmmdyDt03i5QrbjE0L/t8gtIPdHGjQeMEHE0BWqL
         a4/vLhveWst8XXPGvMFUU8nzq9PmZRFS7D3JpCLYIgLwl0gJU0IRztzDw3H2xH4iHpKn
         keLg==
X-Received: by 10.66.159.33 with SMTP id wz1mr31642580pab.58.1413865732492;
        Mon, 20 Oct 2014 21:28:52 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:51 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 13/17] Documentation: DT: Add entries for BCM3384 and its peripherals
Date:   Mon, 20 Oct 2014 21:28:03 -0700
Message-Id: <1413865687-15255-14-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This covers the new "brcm,*" devices added in the upcoming bcm3384 commit.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 .../devicetree/bindings/mips/brcm/bcm3384-intc.txt | 37 ++++++++++++++++++++++
 .../devicetree/bindings/mips/brcm/bmips.txt        |  8 +++++
 .../devicetree/bindings/mips/brcm/cm-dsl.txt       | 11 +++++++
 .../devicetree/bindings/mips/brcm/usb.txt          | 11 +++++++
 4 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/bcm3384-intc.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/bmips.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt
 create mode 100644 Documentation/devicetree/bindings/mips/brcm/usb.txt

diff --git a/Documentation/devicetree/bindings/mips/brcm/bcm3384-intc.txt b/Documentation/devicetree/bindings/mips/brcm/bcm3384-intc.txt
new file mode 100644
index 0000000..d4e0141
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/brcm/bcm3384-intc.txt
@@ -0,0 +1,37 @@
+* Interrupt Controller
+
+Properties:
+- compatible: "brcm,bcm3384-intc"
+
+  Compatibility with BCM3384 and possibly other BCM33xx/BCM63xx SoCs.
+
+- reg: Address/length pairs for each mask/status register set.  Length must
+  be 8.  If multiple register sets are specified, the first set will
+  handle IRQ offsets 0..31, the second set 32..63, and so on.
+
+- interrupt-controller: This is an interrupt controller.
+
+- #interrupt-cells: Must be <1>.  Just a simple IRQ offset; no level/edge
+  or polarity configuration is possible with this controller.
+
+- interrupt-parent: This controller is cascaded from a MIPS CPU HW IRQ, or
+  from another INTC.
+
+- interrupts: The IRQ on the parent controller.
+
+Example:
+	periph_intc: periph_intc@14e00038 {
+		compatible = "brcm,bcm3384-intc";
+
+		/*
+		 * IRQs 0..31:  mask reg 0x14e00038, status reg 0x14e0003c
+		 * IRQs 32..63: mask reg 0x14e00340, status reg 0x14e00344
+		 */
+		reg = <0x14e00038 0x8 0x14e00340 0x8>;
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&cpu_intc>;
+		interrupts = <4>;
+	};
diff --git a/Documentation/devicetree/bindings/mips/brcm/bmips.txt b/Documentation/devicetree/bindings/mips/brcm/bmips.txt
new file mode 100644
index 0000000..8ef71b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/brcm/bmips.txt
@@ -0,0 +1,8 @@
+* Broadcom MIPS (BMIPS) CPUs
+
+Required properties:
+- compatible: "brcm,bmips3300", "brcm,bmips4350", "brcm,bmips4380",
+  "brcm,bmips5000"
+
+- mips-hpt-frequency: This is common to all CPUs in the system so it lives
+  under the "cpus" node.
diff --git a/Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt b/Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt
new file mode 100644
index 0000000..8a139cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/brcm/cm-dsl.txt
@@ -0,0 +1,11 @@
+* Broadcom cable/DSL platforms
+
+SoCs:
+
+Required properties:
+- compatible: "brcm,bcm3384", "brcm,bcm33843"
+
+Boards:
+
+Required properties:
+- compatible: "brcm,bcm93384wvg"
diff --git a/Documentation/devicetree/bindings/mips/brcm/usb.txt b/Documentation/devicetree/bindings/mips/brcm/usb.txt
new file mode 100644
index 0000000..452c45c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/brcm/usb.txt
@@ -0,0 +1,11 @@
+* Broadcom USB controllers
+
+Required properties:
+- compatible: "brcm,bcm3384-ohci", "brcm,bcm3384-ehci"
+
+  These currently use the generic-ohci and generic-ehci drivers.  On some
+  systems, special handling may be needed in the following cases:
+
+  - Restoring state after systemwide power save modes
+  - Sharing PHYs with the USBD (UDC) hardware
+  - Figuring out which controllers are disabled on ASIC bondout variants
-- 
2.1.1
