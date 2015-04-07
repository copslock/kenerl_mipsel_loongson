Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 00:04:46 +0200 (CEST)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:33269 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014864AbbDGWE0JS1Kn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2015 00:04:26 +0200
Received: by iebtr6 with SMTP id tr6so3856201ieb.0
        for <linux-mips@linux-mips.org>; Tue, 07 Apr 2015 15:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BUHHKECJ8xu8slBB6aftCY7xXNY8enWZHQbAR7EytOU=;
        b=TxvzLtbgbVQdsIfJ2UODETmbwqamHbhkMY/bjN+f5UzpBbKf5spcuvx8PaCG+1iUD5
         PNcdxklUvEP4LzPMC2uEJPDKmUprcCJ/7DGWzHRGkELfjb6Gm9eqXUXUYRDEj6Xt48dy
         tr2ivyt9pRCq4OmL6IBQzYAuafqoO1ov2JVS96yY5Djvhnp+BjWkTokkbin9gwtdSibH
         rbq2EfNUy9W+d8RMQ3VlxqSkIoFKKAW+UEC+KBHBGEF/r9PLlzwtMnFG88+wATk8Osf1
         JcsdSx/DkKs3vTwClXtChmqZSVn90Fhd1003bS+vXPGAj4TlEhH9lQ0WGxowIvNmxtTI
         8XEA==
X-Gm-Message-State: ALoCoQnX4187XYSsXlDey4ICzVfEPLfrHKDN2RARxVupYQFC62QAFOjNX6VdsyULhoxWbVqOytko
X-Received: by 10.42.204.75 with SMTP id fl11mr28179566icb.16.1428444261279;
        Tue, 07 Apr 2015 15:04:21 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 40si401921yho.6.2015.04.07.15.04.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2015 15:04:21 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id ZBTl5NHs.1; Tue, 07 Apr 2015 15:04:21 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id EA14522069B; Tue,  7 Apr 2015 15:04:19 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: [PATCH V2 1/3] phy: Add binding document for Pistachio USB2.0 PHY
Date:   Tue,  7 Apr 2015 15:04:16 -0700
Message-Id: <1428444258-25852-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Add a binding document for the USB2.0 PHY found on the IMG Pistachio SoC.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
No changes from v1.
---
 .../devicetree/bindings/phy/pistachio-usb-phy.txt  | 29 ++++++++++++++++++++++
 include/dt-bindings/phy/phy-pistachio-usb.h        | 16 ++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
 create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h

diff --git a/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
new file mode 100644
index 0000000..afbc7e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
@@ -0,0 +1,29 @@
+IMG Pistachio USB PHY
+=====================
+
+Required properties:
+--------------------
+ - compatible: Must be "img,pistachio-usb-phy".
+ - #phy-cells: Must be 0.  See ./phy-bindings.txt for details.
+ - clocks: Must contain an entry for each entry in clock-names.
+   See ../clock/clock-bindings.txt for details.
+ - clock-names: Must include "usb_phy".
+ - img,cr-top: Must constain a phandle to the CR_TOP syscon node.
+ - img,refclk: Indicates the reference clock source for the USB PHY.
+   See <dt-bindings/phy/phy-pistachio-usb.h> for a list of valid values.
+
+Optional properties:
+--------------------
+ - phy-supply: USB VBUS supply.  Must supply 5.0V.
+
+Example:
+--------
+usb_phy: usb-phy {
+	compatible = "img,pistachio-usb-phy";
+	clocks = <&clk_core CLK_USB_PHY>;
+	clock-names = "usb_phy";
+	phy-supply = <&usb_vbus>;
+	img,refclk = <REFCLK_CLK_CORE>;
+	img,cr-top = <&cr_top>;
+	#phy-cells = <0>;
+};
diff --git a/include/dt-bindings/phy/phy-pistachio-usb.h b/include/dt-bindings/phy/phy-pistachio-usb.h
new file mode 100644
index 0000000..d1877aa
--- /dev/null
+++ b/include/dt-bindings/phy/phy-pistachio-usb.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2015 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_PHY_PISTACHIO
+#define _DT_BINDINGS_PHY_PISTACHIO
+
+#define REFCLK_XO_CRYSTAL	0x0
+#define REFCLK_X0_EXT_CLK	0x1
+#define REFCLK_CLK_CORE		0x2
+
+#endif /* _DT_BINDINGS_PHY_PISTACHIO */
-- 
2.2.0.rc0.207.ga3a616c
