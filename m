Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 03:46:27 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33338 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011140AbbJWBphUFUvB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 03:45:37 +0200
Received: by pabrc13 with SMTP id rc13so102323656pab.0;
        Thu, 22 Oct 2015 18:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=81jJMFmvKSWHKRpxKEVuRSiMQqBvn2ddwOXfYFCH8/Q=;
        b=kUPHpLBbVBHdLo22XzOYcZf5HTvUaAr0YYgXSIC6RGx2wyNwtJee+LxZ4eOTFy9t2J
         Vs6uTfNXpPz77PWFZZGPZ0MlEi7iNoYijKbGGEBJP8m8q4r8rT/EkAQqfI+HhISpwsri
         YBT7c271sMT1K9dL9K4VzXV1DE/Gn73zohCgNAMl3+hhZMRDPC4bbZZJTUWi0hHV4fHa
         BH8srnfr/A1FoFweahC/SE01glPMmRegW/Z2Oawh/gkEwX3eRnyjrihjL0p+q/wK2sV5
         FG8mAIlm9c4elAxyM9Us3oSYNi8z5GXrg2uXFh9i9uFSzdhxWM0qkZGxLP8Jal5la8zd
         w6RQ==
X-Received: by 10.66.154.165 with SMTP id vp5mr1682802pab.90.1445564731706;
        Thu, 22 Oct 2015 18:45:31 -0700 (PDT)
Received: from localhost.localdomain ([125.176.118.36])
        by smtp.gmail.com with ESMTPSA id u10sm15955594pbs.63.2015.10.22.18.45.27
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2015 18:45:31 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 04/10] phy: phy_brcmstb_sata: make the driver buildable on BMIPS_GENERIC
Date:   Fri, 23 Oct 2015 10:44:17 +0900
Message-Id: <1445564663-66824-5-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
SATA3 PHY.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 47da573d0bab..c83e48661fd7 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -364,11 +364,11 @@ config PHY_TUSB1210
 
 config PHY_BRCMSTB_SATA
 	tristate "Broadcom STB SATA PHY driver"
-	depends on ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
 	depends on OF
 	select GENERIC_PHY
 	help
-	  Enable this to support the SATA3 PHY on 28nm Broadcom STB SoCs.
+	  Enable this to support the SATA3 PHY on 28nm or 40nm Broadcom STB SoCs.
 	  Likely useful only with CONFIG_SATA_BRCMSTB enabled.
 
 endmenu
-- 
2.6.2
