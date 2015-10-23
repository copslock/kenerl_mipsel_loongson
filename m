Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 03:46:45 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34474 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011148AbbJWBpljZSXB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 03:45:41 +0200
Received: by padhk11 with SMTP id hk11so102652756pad.1;
        Thu, 22 Oct 2015 18:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=38Ylfi6IGv2PtM2v7OqRkiBscUIXnYh9OOGxRPgjnAg=;
        b=n7LV7ItvjroMvxMAKnPenEAyCFYH6b1L9UVI6lkAWsXKF4AiFqPuabSRxZponA6evh
         5kgbRuUxyGmzYfK8vmlq9uQT8K2U+Kr9gXtYiuEU+g8ZW4G35DanMGL+VgVOgmE1c8w1
         yiw77JvLKSFo262Zoxb3lDOgVQZ4XcbBP5uUz8uG0bYONOkf16FiCkqUQWcdKLsO7rQI
         mg8TfUL65uRXPvjrfOmxj0VNr17srJUPaJDewtdFyWjA81bSFPXmW1H9p4A/fB5ScuSo
         5FsOmc+kA9DRKW5MG9UmK6RgmWhac6mFDNQxpVYR1YYVCGc7FkZHgqn0QU+BGkdMoLN5
         lPbQ==
X-Received: by 10.66.221.6 with SMTP id qa6mr1666752pac.9.1445564736032;
        Thu, 22 Oct 2015 18:45:36 -0700 (PDT)
Received: from localhost.localdomain ([125.176.118.36])
        by smtp.gmail.com with ESMTPSA id u10sm15955594pbs.63.2015.10.22.18.45.32
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2015 18:45:35 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 05/10] phy: phy_brcmstb_sata: remove unused definitions
Date:   Fri, 23 Oct 2015 10:44:18 +0900
Message-Id: <1445564663-66824-6-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49646
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

Remove unused definitions.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/phy/phy-brcmstb-sata.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
index 8a2cb16a1937..0be55dafe9ea 100644
--- a/drivers/phy/phy-brcmstb-sata.c
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -26,8 +26,6 @@
 
 #define SATA_MDIO_BANK_OFFSET				0x23c
 #define SATA_MDIO_REG_OFFSET(ofs)			((ofs) * 4)
-#define SATA_MDIO_REG_SPACE_SIZE			0x1000
-#define SATA_MDIO_REG_LENGTH				0x1f00
 
 #define MAX_PORTS					2
 
-- 
2.6.2
