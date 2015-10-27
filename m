Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 07:49:14 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35943 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011526AbbJ0GsrYOIY9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 07:48:47 +0100
Received: by pacfv9 with SMTP id fv9so222581236pac.3;
        Mon, 26 Oct 2015 23:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VMpBEHbEf6dcEa1YeAJ9H+QdvpEqbmRnQ0T4cOgXy5w=;
        b=wONA+JxW9gxFiBhhzJt4AhR2LgQTwhKAUZ0id9ok+Mmt6zsmMb66vJyHOSGLre4Htr
         OAb2/uYh1odFteE9EkQDPqdTn7hpSMD0jYwcoQJHesg9QV/x63t2z3gGeYtH5sED7U7g
         tw7RzMbkuZ+zaTWdgHYtVcmZNFKOtQ514s65FO8+q+H6PmyYqR3vccxEbU7uNoPswR4q
         68U8NZwJ9yT/K7KwRd/mNJB6hLLXMCbrlUA7Z0NMXDY8ZofE18GslItWnDs1T7hS1uqt
         nVy7d/k1UzHng3vdm5vswueXomPoo+0grEIe21LT4ohk+FH8h5AOXuRvDZ+QQs2dOtOF
         tadQ==
X-Received: by 10.66.192.106 with SMTP id hf10mr26689018pac.16.1445928521683;
        Mon, 26 Oct 2015 23:48:41 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id tt7sm1564458pab.45.2015.10.26.23.48.38
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Oct 2015 23:48:41 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v2 02/10] ata: ahci_brcmstb: add support MIPS-based platforms
Date:   Tue, 27 Oct 2015 15:48:03 +0900
Message-Id: <1445928491-7320-3-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49706
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

The BCM7425 is flagship chipset of 40nm class. Other MIPS-based 40nm
chipsets has same hardware block. so the compatible string may be use
brcm,bcm7425-ahci.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt | 4 ++--
 drivers/ata/Kconfig                                         | 2 +-
 drivers/ata/ahci_brcmstb.c                                  | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
index 4650c0aff6b3..488a383ce202 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
@@ -4,8 +4,8 @@ SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
 Required properties:
-- compatible         : compatible list, may contain "brcm,bcm7445-ahci" and/or
-                       "brcm,sata3-ahci"
+- compatible         : compatible list, may contain "brcm,bcm7445-ahci" or
+                       "brcm,bcm7425-ahci" or "brcm,sata3-ahci"
 - reg                : register mappings for AHCI and SATA_TOP_CTRL
 - reg-names          : "ahci" and "top-ctrl"
 - interrupts         : interrupt mapping for SATA IRQ
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
index a2df76698adb..e53962cb48ee 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -343,6 +343,7 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 
 static const struct of_device_id ahci_of_match[] = {
 	{.compatible = "brcm,bcm7445-ahci"},
+	{.compatible = "brcm,bcm7425-ahci"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
2.6.2
