Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 14:40:41 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35081 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011806AbbJ3Njq0Rz70 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2015 14:39:46 +0100
Received: by pasz6 with SMTP id z6so75127724pas.2;
        Fri, 30 Oct 2015 06:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T3hijmFqYx+A9wC7VdNp3uENj8QnYFc/OtbV+fDOVt8=;
        b=RnRQk8ZtJAsendxPpWTH3tsVT0OkHeO2ZLRG50vYTbg5PDsL5O4ltNh68fKYxz0Guz
         mrhfAbL7zrTJ5ogU2U5DZvynd2vQFX1SdXCCHMEmn1vjIVFCH/qsNJCd1GVrp8vOxq5c
         tbJNoOqZUrNABOl8tZEdlL0AHvNmef7/GzTWY/fPuIKdQxwgZuWAIYVDp6mwtCIrL+J6
         Gsro+RPzgLSANgJlI+HoaJrMLzUo/xBYVsEBuJh4kL1lW3zPE6wKhNCApDGx0EjtWUNS
         Kj7ef+nVZUD4+/VUq2+ocaBstnyHp9p3LIWRMt4GkrufK7K/E/jGfUa5XBzAqn+ZMiEB
         Jcuw==
X-Received: by 10.68.197.99 with SMTP id it3mr9056202pbc.108.1446212380499;
        Fri, 30 Oct 2015 06:39:40 -0700 (PDT)
Received: from localhost.localdomain ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id d13sm8391293pbu.20.2015.10.30.06.39.37
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Oct 2015 06:39:40 -0700 (PDT)
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
Subject: [v3 04/10] ata: ahci_brcmstb: remove unused definitions
Date:   Fri, 30 Oct 2015 22:38:53 +0900
Message-Id: <1446212339-1210-5-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49779
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

Remove unused definitions, and this is to avoid confusion with MIPS-based
chipsets.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index 5098e6c041ac..a9050a95ce42 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -52,8 +52,6 @@
   #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET		BIT(14)
  #define SATA_TOP_CTRL_PHY_OFFS				0x8
  #define SATA_TOP_MAX_PHYS				2
-#define SATA_TOP_CTRL_SATA_TP_OUT			0x1c
-#define SATA_TOP_CTRL_CLIENT_INIT_CTRL			0x20
 
 /* On big-endian MIPS, buses are reversed to big endian, so switch them back */
 #if defined(CONFIG_MIPS) && defined(__BIG_ENDIAN)
-- 
2.6.2
