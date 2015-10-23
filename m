Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 03:45:36 +0200 (CEST)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34168 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011125AbbJWBpVgeLjB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 03:45:21 +0200
Received: by padhk11 with SMTP id hk11so102644715pad.1;
        Thu, 22 Oct 2015 18:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ohNaLpD103hyLmn5BLcFsEZCGYcZUBwkPZrdUbAT1DE=;
        b=LEEkGhARkjQRnnnJaWFHBlI72SKJ/CleCTMlZ/hObKQAlELenJdoj6PSLTvLd1I4ev
         TPNCtZHg4s8P5h9zvLzQ/mtdLVxxZS+kEfxnmxuUxlWgtOycyfH06VqngcuS0KuWCSce
         LfYcZk1hDI++qz5I857dONTXqFcXp02yiwiF++VkjwFFoQNBjXWEY3RqD8B0VjdhKBd+
         Bo9BaDse5hAS4TIRbn35drvvLc4oBtV6f59LBGzYdyehqP7uYO33OlrXfREbrY8DBABv
         18H3R5ye1CYQqghnVhRf0Ln/S19Rwmk0P8MhjX/q487eWRVOz6vZd460YNbrocMiD/BW
         nerA==
X-Received: by 10.66.132.37 with SMTP id or5mr20756859pab.5.1445564715678;
        Thu, 22 Oct 2015 18:45:15 -0700 (PDT)
Received: from localhost.localdomain ([125.176.118.36])
        by smtp.gmail.com with ESMTPSA id u10sm15955594pbs.63.2015.10.22.18.45.11
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2015 18:45:15 -0700 (PDT)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 01/10] ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
Date:   Fri, 23 Oct 2015 10:44:14 +0900
Message-Id: <1445564663-66824-2-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49642
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
SATA3.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.6.2
