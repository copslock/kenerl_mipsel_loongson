Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 11:33:41 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50896 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816642Ab3HHJdiq5IlX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 11:33:38 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     John Crispin <blogic@openwrt.org>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 1/2] DT: Add documentation for ralink-wdt
Date:   Thu,  8 Aug 2013 11:26:16 +0200
Message-Id: <1375953976-28689-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37448
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

Describe ralink-wdt binding.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: devicetree-discuss@lists.ozlabs.org
---
 .../devicetree/bindings/watchdog/ralink-wdt.txt     |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/ralink-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt b/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
new file mode 100644
index 0000000..a70f0e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
@@ -0,0 +1,19 @@
+Ralink Watchdog Timers
+
+Required properties :
+- compatible: must be "ralink,rt2880-wdt"
+- reg: physical base address of the controller and length of the register range
+
+Optional properties :
+- interrupt-parent: phandle to the INTC device node
+- interrupts : Specify the INTC interrupt number
+
+Example:
+
+	watchdog@120 {
+		compatible = "ralink,mt7620a-wdt", "ralink,rt2880-wdt";
+		reg = <0x120 0x10>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <1>;
+	};
-- 
1.7.10.4
