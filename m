Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2017 01:42:15 +0100 (CET)
Received: from mail-qk0-x243.google.com ([IPv6:2607:f8b0:400d:c09::243]:33440
        "EHLO mail-qk0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993875AbdBOAmIo5j4W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Feb 2017 01:42:08 +0100
Received: by mail-qk0-x243.google.com with SMTP id 11so21308787qkl.0
        for <linux-mips@linux-mips.org>; Tue, 14 Feb 2017 16:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M13fm6qZCGsrBy+G44jsQlu040gNNGlyfN8M9f2qFsQ=;
        b=vGunmmEtf+dcBIBOj2BZsBt9e/djhmpS/be1HfWasX5Qx+BPOyRB4HnITYNIBuDI5o
         qJCEcBDIM1J5ouGop+eBNI9syFAggwfGe7WBAi04N/WKo4xJVsJEf4l3ZMrRYZhjWLyb
         PnvbdXQRslJ6fPpOOfWaoSWrS2eRnUPrJVUGqHkEyqFZWpA7WiQyeywHe1+4adFcvUZH
         txh2DJZfeNOBCQyMQ6FQyAWYac9LzKpkpIybRdMEdpJns/CQYIoaKQhmekBNYi4sy6im
         2CwIXzIdj+wtAJD60HpfXDZflSJ2F3uFngC/XQGpiHr0CMemKOQY1t8Lmgp08pLn3Y8M
         08RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M13fm6qZCGsrBy+G44jsQlu040gNNGlyfN8M9f2qFsQ=;
        b=uG2KDjJ7j0vuJwYfnFR3FPE/xBa2JPiDZ/fKAHzFMKBXFi2NvOwmbC8VFWhVZ7hEqx
         XzFBI8fwZnnZ9lJKHOorJzcuSLE35p7dFYI54wdI60/QWeaiWievUFRymq7iuc1HIt1A
         KKh0d4U77cv+DzYXRB4Viq6kkVSYYtw405ncpUKPWuQvxJVLMii4a81mI3oCvQzStpSj
         dfin6Wik24fdk+LvLT/MTN/TPXakUi9e9SBJUYCYwtzWt+ZCT62AN6uLhL1nrBQFZNzC
         IgwjG7pPDSHH9M0+tOVVT+0O1E322SYsQPNQhbQ3Ul18EGyW5wHa6iPWrPADduhR1bo1
         +hVQ==
X-Gm-Message-State: AMke39kvjrXH0/NDpnT6kjNA11LvILPyrOx5oC4hTkRTqjD0s2irHTiImH38xnAgcY8V1g==
X-Received: by 10.55.75.143 with SMTP id y137mr29116330qka.39.1487119323009;
        Tue, 14 Feb 2017 16:42:03 -0800 (PST)
Received: from stb-bld-03.irv.broadcom.com ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id n68sm1340608qkn.11.2017.02.14.16.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 16:42:02 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
X-Google-Original-From: Florian Fainelli <florian.fainelli@broadcom.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Justin Chen <justin.chen@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] soc: bcm: brcmstb: Match additional compatible strings
Date:   Tue, 14 Feb 2017 16:41:57 -0800
Message-Id: <20170215004159.11096-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Florian Fainelli <f.fainelli@gmail.com>

Match all known sun-top-ctrl compatible strings from our MIPS chips
counterparts. This allows us to properly report the SoC information to
user-space through our SoC driver.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Ralf, James,

I usually take patches touching this file through an ARM SoC pull request,
posting to linux-mips for people working on BMIPS STB to get a chance to review
this.

Thanks!

 drivers/soc/bcm/brcmstb/common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index 94e7335553f4..b6195fdf0d00 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -41,6 +41,15 @@ bool soc_is_brcmstb(void)
 }
 
 static const struct of_device_id sun_top_ctrl_match[] = {
+	{ .compatible = "brcm,bcm7125-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7346-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7358-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7360-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7362-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7420-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7425-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7429-sun-top-ctrl", },
+	{ .compatible = "brcm,bcm7425-sun-top-ctrl", },
 	{ .compatible = "brcm,brcmstb-sun-top-ctrl", },
 	{ }
 };
-- 
2.11.0
