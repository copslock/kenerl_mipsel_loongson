Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 15:01:58 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33734 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011872AbbJ3OBnvXzI0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2015 15:01:43 +0100
Received: by padhy1 with SMTP id hy1so69584593pad.0;
        Fri, 30 Oct 2015 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xkpHI4ZCnPos/6AhXzjlEjQMCa8Pt9S4Amfjm2k46Wo=;
        b=TdoTitw4FUK6py5NoyT5FBjaVjQBE5RMTiAx6S8ym02FzAqFwc2q2oFKwbfJfEDM7l
         1olKEsFax2ZAGrXRBamNIskzuy61uIsMnTBnJF+kjTVZxLd74TzJEMrs2e3sPodHeJvj
         s5FCg+3TXuAdagM0Du2CWqWzlq2fmz3pL6J4JbnLA004ZamJEn5FpxImcGoDYfheOWSi
         8bvqIqpEQVIbNu2t1daFQRNo5gVMu4rw3uoaY7YY3cmTdIHSidsacBW0atwtvOgWZOcK
         5schkQTDv7mrhxzDJskkptzlPqo85pwJqifxoH9IRlR4391s2CMHB7t5viyzsTQ898wO
         L6VA==
X-Received: by 10.66.124.161 with SMTP id mj1mr8938144pab.43.1446213698165;
        Fri, 30 Oct 2015 07:01:38 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id zk3sm8473164pbb.41.2015.10.30.07.01.34
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 07:01:37 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 01/10] ata: ahci_brcmstb: add support MIPS-based platforms
Date:   Fri, 30 Oct 2015 23:01:15 +0900
Message-Id: <1446213684-2625-2-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49789
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

The BCM7xxx ARM-based and MIPS-based platforms share a similar hardware
block for AHCI SATA3.

The BCM7425 is main chipset of MIPS-based 40nm class. The others have
same AHCI block. The compatible string may be use brcm,bcm7425-ahci.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt | 4 +++-
 drivers/ata/Kconfig                                         | 2 +-
 drivers/ata/ahci_brcmstb.c                                  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
index 20ac9bbfa1fd..60872838f1ad 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
@@ -4,7 +4,9 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
 Required properties:
-- compatible         : compatible list, may contain "brcm,bcm7445-ahci" and/or
+- compatible         : should be one or more of
+                       "brcm,bcm7425-ahci"
+                       "brcm,bcm7445-ahci"
                        "brcm,sata3-ahci"
 - reg                : register mappings for AHCI and SATA_TOP_CTRL
 - reg-names          : "ahci" and "top-ctrl"
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 15e40ee62a94..8f535a88a0c7 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -100,7 +100,7 @@ config SATA_AHCI_PLATFORM
 
 config AHCI_BRCMSTB
 	tristate "Broadcom STB AHCI SATA support"
-	depends on ARCH_BRCMSTB
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  This option enables support for the AHCI SATA3 controller found on
 	  STB SoC's.
diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 14b7305d2ba0..73e3b0b2a3c2 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -300,6 +300,7 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ahci_of_match[] = {
+	{.compatible = "brcm,bcm7425-ahci"},
 	{.compatible = "brcm,bcm7445-ahci"},
 	{},
 };
-- 
2.6.2
