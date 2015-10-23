Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 03:46:10 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36717 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011130AbbJWBpdzMLkB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 03:45:33 +0200
Received: by pacfv9 with SMTP id fv9so107290483pac.3;
        Thu, 22 Oct 2015 18:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jN5RhVUq0FexCWHNwMz4vPsZmiiovUjHAmG7OfbrZOs=;
        b=PubilsJPyyeDobg9b1ckkqdQvPcL11Uso0/0genLYjM2V/7yLx7veyuhNPvErH2y8D
         Hr7ijFe01/S0DX0EUZwPyCanUoTs6+N+ShQNXqp7uAWzrQeTllltk11dkgidt4w6d54+
         pi42KYlBA1mkh6Gf+TeU1oRURL6P5rXrkPKMtoskmR6MbVaNLr3KDH61I01C15r9/IPR
         kqijfhNE3mqkxJCpLIxNsRZbn4ytGaaZNxA9ANB9q04OIDID/fk84vz5tpgZjPDSslWF
         K/vGq/0gphHqBEwxRH80EL4gAj2PJwgRMYHPFqwkHzgOIUCqYfyKpSUf0n5XQCxLv/oj
         Wgyw==
X-Received: by 10.68.135.1 with SMTP id po1mr1953468pbb.23.1445564727282;
        Thu, 22 Oct 2015 18:45:27 -0700 (PDT)
Received: from localhost.localdomain ([125.176.118.36])
        by smtp.gmail.com with ESMTPSA id u10sm15955594pbs.63.2015.10.22.18.45.23
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2015 18:45:26 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 03/10] ata: ahci_brcmstb: add support 40nm platforms
Date:   Fri, 23 Oct 2015 10:44:16 +0900
Message-Id: <1445564663-66824-4-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49644
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

Add offsets for 40nm BMIPS based set-top box platforms.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 8cf6f7d4798f..59eb526cf4f6 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -50,7 +50,8 @@
   #define SATA_TOP_CTRL_2_SW_RST_RX			BIT(2)
   #define SATA_TOP_CTRL_2_SW_RST_TX			BIT(3)
   #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET		BIT(14)
- #define SATA_TOP_CTRL_PHY_OFFS				0x8
+ #define SATA_TOP_CTRL_28NM_PHY_OFFS			0x8
+ #define SATA_TOP_CTRL_40NM_PHY_OFFS			0x4
  #define SATA_TOP_MAX_PHYS				2
 #define SATA_TOP_CTRL_SATA_TP_OUT			0x1c
 #define SATA_TOP_CTRL_CLIENT_INIT_CTRL			0x20
@@ -237,7 +238,13 @@ static int brcm_ahci_resume(struct device *dev)
 
 static const struct of_device_id ahci_of_match[] = {
 	{.compatible = "brcm,bcm7445-ahci",
-			.data = (void *)SATA_TOP_CTRL_PHY_OFFS},
+			.data = (void *)SATA_TOP_CTRL_28NM_PHY_OFFS},
+	{.compatible = "brcm,bcm7346-ahci",
+			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
+	{.compatible = "brcm,bcm7360-ahci",
+			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
+	{.compatible = "brcm,bcm7362-ahci",
+			.data = (void *)SATA_TOP_CTRL_40NM_PHY_OFFS},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
2.6.2
