Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Aug 2013 21:07:51 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50421 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6865310Ab3HITHo650V0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Aug 2013 21:07:44 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     John Crispin <blogic@openwrt.org>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH V3 1/2] DT: Add documentation for rt2880-wdt
Date:   Fri,  9 Aug 2013 21:00:31 +0200
Message-Id: <1376074831-29561-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

This document describes the binding of the watchdog core found ralink wireless
SoC.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: devicetree-discuss@lists.ozlabs.org
---
Changes in V3:
* renamed file to rt2880-wdt.txt

 .../devicetree/bindings/watchdog/rt2880-wdt.txt     |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt b/Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt
new file mode 100644
index 0000000..a654dd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/rt2880-wdt.txt
@@ -0,0 +1,19 @@
+Ralink Watchdog Timers
+
+Required properties :
+- compatible: must be "ralink,rt2880-wdt"
+- reg: physical base address of the controller and length of the register range
+
+Optional properties :
+- interrupt-parent: phandle to the INTC device node
+- interrupts: Specify the INTC interrupt number
+
+Example:
+
+	watchdog@120 {
+		compatible = "ralink,rt2880-wdt";
+		reg = <0x120 0x10>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <1>;
+	};
-- 
1.7.10.4
