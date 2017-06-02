Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 21:33:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29700 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993971AbdFBTceO5-dn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 21:32:34 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id AF277F85FC1E4;
        Fri,  2 Jun 2017 20:32:23 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 20:32:27
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Keng Koh <keng.koh@imgtec.com>
Subject: [PATCH 7/9] MIPS: SEAD-3: Set interrupt-parent per-device, not at root node
Date:   Fri, 2 Jun 2017 12:29:57 -0700
Message-ID: <20170602192959.25435-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602192959.25435-1-paul.burton@imgtec.com>
References: <20170602192959.25435-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The SEAD-3 board may be configured with or without a MIPS Global
Interrupt Controller (GIC). Because of this we have a device tree with a
default case of a GIC present, and code to fixup the device tree based
upon a configuration register that indicates the presence of the GIC.

In order to keep this DT fixup code simple, the interrupt-parent
property was specified at the root node of the SEAD-3 DT, allowing the
fixup code to simply change this property to the phandle of the CPU
interrupt controller if a GIC is not present & affect all
interrupt-using devices at once. This however causes a problem if we do
have a GIC & the device tree is used as-is, because the interrupt-parent
property of the root node applies to the CPU interrupt controller node.
This causes a cycle when of_irq_init() attempts to probe interrupt
controllers in order and boots fail due to a lack of configured
interrupts, with this message printed on the kernel console:

[    0.000000] OF: of_irq_init: children remain, but no parents

Fix this by removing the interrupt-parent property from the DT root node
& instead setting it for each device which uses interrupts, ensuring
that the CPU interrupt controller node has no interrupt-parent &
allowing of_irq_init() to identify it as the root interrupt controller.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reported-by: Keng Koh <keng.koh@imgtec.com>
Cc: Keng Koh <keng.koh@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/boot/dts/mti/sead3.dts |  5 ++++-
 arch/mips/generic/board-sead3.c  | 26 ++++++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index c1dbf16708bd..193b1f352336 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -11,7 +11,6 @@
 	#size-cells = <1>;
 	compatible = "mti,sead-3";
 	model = "MIPS SEAD-3";
-	interrupt-parent = <&gic>;
 
 	chosen {
 		stdout-path = "serial1:115200";
@@ -65,6 +64,7 @@
 		compatible = "generic-ehci";
 		reg = <0x1b200000 0x1000>;
 
+		interrupt-parent = <&gic>;
 		interrupts = <0>; /* GIC 0 or CPU 6 */
 
 		has-transaction-translator;
@@ -227,6 +227,7 @@
 
 		clock-frequency = <14745600>;
 
+		interrupt-parent = <&gic>;
 		interrupts = <3>; /* GIC 3 or CPU 4 */
 
 		no-loopback-test;
@@ -241,6 +242,7 @@
 
 		clock-frequency = <14745600>;
 
+		interrupt-parent = <&gic>;
 		interrupts = <2>; /* GIC 2 or CPU 4 */
 
 		no-loopback-test;
@@ -251,6 +253,7 @@
 		reg = <0x1f010000 0x10000>;
 		reg-io-width = <4>;
 
+		interrupt-parent = <&gic>;
 		interrupts = <0>; /* GIC 0 or CPU 6 */
 
 		phy-mode = "mii";
diff --git a/arch/mips/generic/board-sead3.c b/arch/mips/generic/board-sead3.c
index 39e11bd249cf..f109a6b9fdd0 100644
--- a/arch/mips/generic/board-sead3.c
+++ b/arch/mips/generic/board-sead3.c
@@ -87,14 +87,16 @@ static __init int remove_gic(void *fdt)
 		return -EINVAL;
 	}
 
-	err = fdt_setprop_u32(fdt, 0, "interrupt-parent", cpu_phandle);
-	if (err) {
-		pr_err("unable to set root interrupt-parent: %d\n", err);
-		return err;
-	}
-
 	uart_off = fdt_node_offset_by_compatible(fdt, -1, "ns16550a");
 	while (uart_off >= 0) {
+		err = fdt_setprop_u32(fdt, uart_off, "interrupt-parent",
+				      cpu_phandle);
+		if (err) {
+			pr_warn("unable to set UART interrupt-parent: %d\n",
+				err);
+			return err;
+		}
+
 		err = fdt_setprop_u32(fdt, uart_off, "interrupts",
 				      cpu_uart_int);
 		if (err) {
@@ -117,6 +119,12 @@ static __init int remove_gic(void *fdt)
 		return eth_off;
 	}
 
+	err = fdt_setprop_u32(fdt, eth_off, "interrupt-parent", cpu_phandle);
+	if (err) {
+		pr_err("unable to set ethernet interrupt-parent: %d\n", err);
+		return err;
+	}
+
 	err = fdt_setprop_u32(fdt, eth_off, "interrupts", cpu_eth_int);
 	if (err) {
 		pr_err("unable to set ethernet interrupts property: %d\n", err);
@@ -129,6 +137,12 @@ static __init int remove_gic(void *fdt)
 		return ehci_off;
 	}
 
+	err = fdt_setprop_u32(fdt, ehci_off, "interrupt-parent", cpu_phandle);
+	if (err) {
+		pr_err("unable to set EHCI interrupt-parent: %d\n", err);
+		return err;
+	}
+
 	err = fdt_setprop_u32(fdt, ehci_off, "interrupts", cpu_ehci_int);
 	if (err) {
 		pr_err("unable to set EHCI interrupts property: %d\n", err);
-- 
2.13.0
