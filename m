Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 14:39:50 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36854 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011342AbbJ3NjfwYpd0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2015 14:39:35 +0100
Received: by pacfv9 with SMTP id fv9so78233551pac.3;
        Fri, 30 Oct 2015 06:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xkpHI4ZCnPos/6AhXzjlEjQMCa8Pt9S4Amfjm2k46Wo=;
        b=T2egSYG+SxtBwci7ZZSd13Hz+IP6cqUR7ed97cFemI/T6GD5E0K/5qj/BefEfX24Mz
         72XaT9DI3Q1c0LxicKTxDSfNjOH1PwwtdJQkbdppaedpziu7pHaJH70nVxcmVMn04uEB
         fjCQjWIIRS4WYfuoZlxZPMTxJqY9xsTDoV4hP44EGdk72C1i3uBEba5lEzsSUyyzjCP5
         cMX/I/EHP4arHvkmcbfo+wQv4pOFrZPQ3p8i7DGay+WVJ4EX237DgGgtXNPhMGAIrWM1
         fqBL+udpDSBr45OyDHf0TUDEmPqHj7RuEp6rjRvwdIl2WFDLCQUS9skBug3F0f+5toSq
         qnTA==
X-Received: by 10.66.221.6 with SMTP id qa6mr9077588pac.9.1446212369995;
        Fri, 30 Oct 2015 06:39:29 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id d13sm8391293pbu.20.2015.10.30.06.39.26
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 06:39:29 -0700 (PDT)
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
Subject: [v3 01/10] ata: ahci_brcmstb: add support MIPS-based platforms
Date:   Fri, 30 Oct 2015 22:38:50 +0900
Message-Id: <1446212339-1210-2-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49776
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
