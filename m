Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 19:25:01 +0200 (CEST)
Received: from smtp3-g21.free.fr ([212.27.42.3]:34645 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012142AbbHCRYzFKy-b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 19:24:55 +0200
Received: from localhost.localdomain (unknown [176.4.89.174])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 145C8A61EF;
        Mon,  3 Aug 2015 19:24:41 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 1/3] devicetree: Add bindings for the ATH79 reset controller
Date:   Mon,  3 Aug 2015 19:23:51 +0200
Message-Id: <1438622633-9407-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1438622633-9407-1-git-send-email-albeu@free.fr>
References: <1438622633-9407-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 .../devicetree/bindings/reset/ath79-reset.txt        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/ath79-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/ath79-reset.txt b/Documentation/devicetree/bindings/reset/ath79-reset.txt
new file mode 100644
index 0000000..4c56330
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/ath79-reset.txt
@@ -0,0 +1,20 @@
+Binding for Qualcomm Atheros AR7xxx/AR9XXX reset controller
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required Properties:
+- compatible: has to be "qca,<soctype>-reset", "qca,ar7100-reset"
+              as fallback
+- reg: Base address and size of the controllers memory area
+- #reset-cells : Specifies the number of cells needed to encode reset
+                 line, should be 1
+
+Example:
+
+	reset-controller@1806001c {
+		compatible = "qca,ar9132-reset", "qca,ar7100-reset";
+		reg = <0x1806001c 0x4>;
+
+		#reset-cells = <1>;
+	};
-- 
2.0.0
