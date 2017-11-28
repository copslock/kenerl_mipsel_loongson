Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 16:31:21 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:39365 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991986AbdK1P2Ai-qcY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 16:28:00 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 23F3220743; Tue, 28 Nov 2017 16:27:54 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 78EEF2073C;
        Tue, 28 Nov 2017 16:27:43 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 08/13] dt-bindings: mips: Add bindings for Microsemi SoCs
Date:   Tue, 28 Nov 2017 16:26:38 +0100
Message-Id: <20171128152643.20463-9-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61147
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

Add bindings for Microsemi SoCs. Currently only Ocelot is supported.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org

 Documentation/devicetree/bindings/mips/mscc.txt | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt

diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Documentation/devicetree/bindings/mips/mscc.txt
new file mode 100644
index 000000000000..2c52e76b7142
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/mscc.txt
@@ -0,0 +1,6 @@
+* Microsemi MIPS CPUs
+
+Required properties:
+- compatible: "brcm,ocelot"
+
+- mips-hpt-frequency: CPU counter frequency.
-- 
2.15.0
