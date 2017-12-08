Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2017 16:50:43 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:40712 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991770AbdLHPrtybhsP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2017 16:47:49 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 50AEF2092F; Fri,  8 Dec 2017 16:47:44 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id D3AAC2093A;
        Fri,  8 Dec 2017 16:47:25 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 07/13] dt-bindings: power: reset: Document ocelot-reset binding
Date:   Fri,  8 Dec 2017 16:46:12 +0100
Message-Id: <20171208154618.20105-8-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Add binding documentation for the Microsemi Ocelot reset block.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/power/reset/ocelot-reset.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt

diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
new file mode 100644
index 000000000000..1bcf276b04cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
@@ -0,0 +1,17 @@
+Microsemi Ocelot reset controller
+
+The DEVCPU_GCB:CHIP_REGS have a SOFT_RST register that can be used to reset the
+SoC MIPS core.
+
+Required Properties:
+ - compatible: "mscc,ocelot-chip-reset"
+
+Example:
+	syscon@71070000 {
+		compatible = "mscc,ocelot-chip-regs", "simple-mfd", "syscon";
+		reg = <0x71070000 0x1c>;
+
+		reset {
+			compatible = "mscc,ocelot-chip-reset";
+		};
+	};
-- 
2.15.1
