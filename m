Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Sep 2018 22:18:04 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:10008 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991783AbeIIUR2MkQK1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 9 Sep 2018 22:17:28 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id BD49B42068;
        Sun,  9 Sep 2018 22:17:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id QEalBPYW7qHh; Sun,  9 Sep 2018 22:17:21 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 net-next 3/6] dt-bindings: net: Add lantiq,xrx200-net DT bindings
Date:   Sun,  9 Sep 2018 22:16:44 +0200
Message-Id: <20180909201647.32727-4-hauke@hauke-m.de>
In-Reply-To: <20180909201647.32727-1-hauke@hauke-m.de>
References: <20180909201647.32727-1-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This adds the binding for the PMAC core between the CPU and the GSWIP
switch found on the xrx200 / VR9 Lantiq / Intel SoC.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/net/lantiq,xrx200-net.txt   | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt

diff --git a/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
new file mode 100644
index 000000000000..8a2fe5200cdc
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
@@ -0,0 +1,21 @@
+Lantiq xRX200 GSWIP PMAC Ethernet driver
+==================================
+
+Required properties:
+
+- compatible	: "lantiq,xrx200-net" for the PMAC of the embedded
+		: GSWIP in the xXR200
+- reg		: memory range of the PMAC core inside of the GSWIP core
+- interrupts	: TX and RX DMA interrupts. Use interrupt-names "tx" for
+		: the TX interrupt and "rx" for the RX interrupt.
+
+Example:
+
+eth0: eth@E10B308 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "lantiq,xrx200-net";
+	reg = <0xE10B308 0x30>;
+	interrupts = <73>, <72>;
+	interrupt-names = "tx", "rx";
+};
-- 
2.11.0
