Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 21:14:39 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34731 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011816AbcA0UOXvlazA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 21:14:23 +0100
Received: by mail-pa0-f66.google.com with SMTP id yy13so857118pab.1;
        Wed, 27 Jan 2016 12:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pXarlBg7+PLgNBAyR3b7l0rhjnbEWbx8Xowqwz1F0Go=;
        b=di5Dwxl/dd318RaMbnDX1bwspQmXL4qSujq+IlaajKx3h5o5jkG470Gx7R0Ts3HG/D
         efA52aHGve9L+ipXBgze9iKxtYDLChnF+Hzc1Oyg/PoVjFoMwh9mqKwnOwDLer+T3H0C
         8d4Ht9F2EW1ZOEJDrdAS1JhwjEbRjq/pFkz8J8HDwAJk93W+dFIPv4MmIezwogwP/sP0
         e8w2V/5iIXZ9qL47xA0D6vsW8MFnLRCii+VMNl7SRJhgg8IIiLxiJmcrhf+J8fAUOvpQ
         MuX0eLedBcczeRpOxyXbHrW/ueYEorBC2Gnuwtd3iXz2WISmhlTP1L9EPsQdbeIIEmyP
         trIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pXarlBg7+PLgNBAyR3b7l0rhjnbEWbx8Xowqwz1F0Go=;
        b=AA9egVgAzOfvSxscc00zzuYs5ftP2eOuI5a6mk4o93kON75a1KUoXE3UneZUAaq7RE
         /GaBCy9kyt9h/LgPiXypgEopCmTjwrPYdca5YL62IqDIMKOOjqU54J4l8hyRXhUHSa08
         VB8mRyJ95h5vCF6TPngbVpm80iOGeyTITvSofMrAb0V1fcu1YevZlhQxn4fpZGWT4Yyk
         5//btLMdGnDSHSgPhrkcTHuJbtqyIS1ONmzTKUa6ZtfQajLFqEDFTtLybXxo3kfqqjr2
         ZpHC7yS0hbFDCIlR4nKDvRKMUQ3KDaBiuf8UB8cxCSGbqkVh8QKkmh7FBfQuuTYTBt44
         iwyQ==
X-Gm-Message-State: AG10YORkKkj0ERmQrtrFI0cbCDP/mjoVvO2ax10b6nGMBz1J8FZYhl6GFFweVzB40sxYbg==
X-Received: by 10.66.236.103 with SMTP id ut7mr44758786pac.4.1453925658180;
        Wed, 27 Jan 2016 12:14:18 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id 75sm10987965pfj.20.2016.01.27.12.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 12:14:17 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, computersforpeace@gmail.com,
        cernekee@gmail.com, jogo@openwrt.org, simon@fire.lp0.eu,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] MIPS: BCM63xx: Enable partition parser in defconfig
Date:   Wed, 27 Jan 2016 12:13:15 -0800
Message-Id: <1453925596-24661-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1453925596-24661-1-git-send-email-f.fainelli@gmail.com>
References: <1453925596-24661-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51485
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

Enable CONFIG_MTD_BCM63XX_PARTS in arch/mips/configs/bcm63xx_defconfig
since this is a necessary option to parse the built-in flash partition
table on BCM63xx SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/configs/bcm63xx_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/bcm63xx_defconfig b/arch/mips/configs/bcm63xx_defconfig
index 3fec26410f34..5599a9f1e3c6 100644
--- a/arch/mips/configs/bcm63xx_defconfig
+++ b/arch/mips/configs/bcm63xx_defconfig
@@ -44,6 +44,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 CONFIG_MTD=y
+CONFIG_MTD_BCM63XX_PARTS=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-- 
2.1.0
