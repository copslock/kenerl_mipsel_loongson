Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 07:49:49 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33005 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011531AbbJ0Gszvk5E9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 07:48:55 +0100
Received: by pabla5 with SMTP id la5so20038811pab.0;
        Mon, 26 Oct 2015 23:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fcpueSb7fVd4HAjpM1zBBixX81CYwXkX+5htaUMTZ4E=;
        b=Q41XDcfbGUeDMxrHw1i6CLpm8exocbSWrehZo9zYE69u4l3GyAtOadXYYgGWj3AwFJ
         53wfaxgnLfHCaVE3TR8YB0OoDHOxWsPKhsTxaYPGtdpJ/hn2LjTuop/tEA2r16w9Icbg
         cQPwLFBRxPL/xmd1NweGSoWKmBeUNg0y5nRaAjM6Uc3xtVTfRmKemRB4ONYdWC0Q9h+z
         r5x8u0p7V/y6QnPTe6cqmHP0elXqPSzJU/SuwTtsBANVltjbZyKQ8EQuSIHWyxgAoY+T
         /7YCB0KdfrSP8rV+1iOZ0fq5AEkTAixNGAznycHY/7Ky50DVv91mXxgNrCuOy+XZGCrU
         E6ew==
X-Received: by 10.68.100.228 with SMTP id fb4mr26718352pbb.25.1445928529447;
        Mon, 26 Oct 2015 23:48:49 -0700 (PDT)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id tt7sm1564458pab.45.2015.10.26.23.48.45
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Oct 2015 23:48:49 -0700 (PDT)
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
Subject: [v2 04/10] ata: ahci_brcmstb: remove unused definitions
Date:   Tue, 27 Oct 2015 15:48:05 +0900
Message-Id: <1445928491-7320-5-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49708
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

The MIPS-based 40nm chipsets has different offset. The
SATA_TOP_CTRL_SATA_TP_OUT offset is 0x18 and the
SATA_TOP_CTRL_CLIENT_INIT_CTRL is not exist. So, To remove do to avoid
confusion.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index c61303f7c7dc..2d25a28f4f64 100644
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
