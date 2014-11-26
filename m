Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 01:54:00 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62758 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013680AbaKZAvqOWQIW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 01:51:46 +0100
Received: by mail-pa0-f54.google.com with SMTP id fb1so1691961pad.27
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 16:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9isg7s2X3hADth82dVYLku2S4hkKhM1a1aSbM3PqymU=;
        b=z/rVVcH4QmL2jCqvb89oHmyXXvkx5wukdcOcjo725N7pqnh2Mxzpn1RhMlNhoWpHeN
         Rz2o4skxb7CAD+d9ySBS0plAPgTSp9Z9WAFUN9HR7F4OfUi+1m4D/AMWK/FFj+AvLKgL
         PrqnE9yDikBpdGpdzpa/zoW9Roep7yPLP/Ht3D7Cpk9nv62pf4xN3glYvo3w41ceCCV/
         FviXxp333NDYeWRge3JxFnebX7ZSVHbrlMj2Xdwn/eD3opkrTUWtiNGSOZYaF08B3y5P
         cSe/LhjGjFvnoExjmGFMcmMgTdCTIL5S6I13+BJotRJhZY7u+JMUhJMfUPDx9DXeOLYf
         ilRg==
X-Received: by 10.70.9.132 with SMTP id z4mr1126685pda.158.1416963099552;
        Tue, 25 Nov 2014 16:51:39 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id bj11sm2614439pdb.1.2014.11.25.16.51.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:51:38 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org,
        arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 9/9] usb: {ohci,ehci}-platform: Use new OF big-endian helper function
Date:   Tue, 25 Nov 2014 16:49:54 -0800
Message-Id: <1416962994-27095-10-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44462
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

This handles the existing "big-endian" case, and in addition, it also does
the right thing when "native-endian" is specified.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 Documentation/devicetree/bindings/usb/usb-ehci.txt | 2 ++
 Documentation/devicetree/bindings/usb/usb-ohci.txt | 2 ++
 drivers/usb/host/ehci-platform.c                   | 2 +-
 drivers/usb/host/ohci-platform.c                   | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
index 43c1a4e..9505c31 100644
--- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
@@ -12,6 +12,8 @@ Optional properties:
  - big-endian-regs : boolean, set this for hcds with big-endian registers
  - big-endian-desc : boolean, set this for hcds with big-endian descriptors
  - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
+ - native-endian : boolean, enables big-endian-regs + big-endian-desc
+   iff the kernel was compiled for big endian
  - clocks : a list of phandle + clock specifier pairs
  - phys : phandle + phy specifier pair
  - phy-names : "usb"
diff --git a/Documentation/devicetree/bindings/usb/usb-ohci.txt b/Documentation/devicetree/bindings/usb/usb-ohci.txt
index 19233b7..3bb9673 100644
--- a/Documentation/devicetree/bindings/usb/usb-ohci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ohci.txt
@@ -9,6 +9,8 @@ Optional properties:
 - big-endian-regs : boolean, set this for hcds with big-endian registers
 - big-endian-desc : boolean, set this for hcds with big-endian descriptors
 - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
+- native-endian : boolean, enables big-endian-regs + big-endian-desc
+  iff the kernel was compiled for big endian
 - no-big-frame-no : boolean, set if frame_no lives in bits [15:0] of HCCA
 - num-ports : u32, to override the detected port count
 - clocks : a list of phandle + clock specifier pairs
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 2f5b9ce..0da9d70 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -187,7 +187,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 		if (of_property_read_bool(dev->dev.of_node, "big-endian-desc"))
 			ehci->big_endian_desc = 1;
 
-		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
+		if (of_device_is_big_endian(dev->dev.of_node))
 			ehci->big_endian_mmio = ehci->big_endian_desc = 1;
 
 		priv->phy = devm_phy_get(&dev->dev, "usb");
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 7793c3c..029a606 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -157,7 +157,7 @@ static int ohci_platform_probe(struct platform_device *dev)
 		if (of_property_read_bool(dev->dev.of_node, "big-endian-desc"))
 			ohci->flags |= OHCI_QUIRK_BE_DESC;
 
-		if (of_property_read_bool(dev->dev.of_node, "big-endian"))
+		if (of_device_is_big_endian(dev->dev.of_node))
 			ohci->flags |= OHCI_QUIRK_BE_MMIO | OHCI_QUIRK_BE_DESC;
 
 		if (of_property_read_bool(dev->dev.of_node, "no-big-frame-no"))
-- 
2.1.0
