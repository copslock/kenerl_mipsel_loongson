Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2015 21:52:41 +0200 (CEST)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34551 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007919AbbJPTwkc6Tvj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2015 21:52:40 +0200
Received: by pacez2 with SMTP id ez2so13008586pac.1;
        Fri, 16 Oct 2015 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nQecRZavosOwsT4+uo2vuoyJ+pFyoTXbjIN7e2I8mn8=;
        b=hvC+yra/SzyUym0fyYQnoIde6isXug9Tg1hsdXvmwPf29g2tgR3fiU8gx2Vb6ujSJp
         0Al/R8LYexufqw/BHPe1FEtZnPkxujomiZOPauzrtJwpsZUZ7EKUA4sUB0txU/4wgTV9
         sFfgHjASDxJMAyYJPMtt8XLQjuCBYdrpR1znskwj2U55283u9EyQ1SFwF0HkfAh11dex
         MoRPJ8XOKN+hn9zIRWxDNjK27Q3SKhoCLl67HDUarHOuNpkTvUiy8ZZqsg0AoflMCIzY
         kDoB6rU1GEXiqN4iVEHHSkQpVOPoNIfGb2rmFhCu77OXfePg/VFplz7y+MNvRRHd1ycH
         YKWg==
X-Received: by 10.68.96.67 with SMTP id dq3mr18372842pbb.161.1445025152481;
        Fri, 16 Oct 2015 12:52:32 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id ci2sm22684599pbc.66.2015.10.16.12.52.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Oct 2015 12:52:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>, ralf@linux-mips.org,
        blogic@openwrt.org, cernekee@gmail.com, jogo@openwrt.org,
        dragan.stancevic@gmail.com
Subject: [PATCH] MIPS: BMIPS: Enable GZIP ramdisk and timed printks
Date:   Fri, 16 Oct 2015 12:51:58 -0700
Message-Id: <1445025118-13290-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49570
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

Update bmips_be_defconfig and bmips_stb_defconfig to have GZIP ramdisk
support enabled by default as well was timed printks.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/configs/bmips_be_defconfig  | 3 ++-
 arch/mips/configs/bmips_stb_defconfig | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
index f5585c8f35ad..24dcb90b0f64 100644
--- a/arch/mips/configs/bmips_be_defconfig
+++ b/arch/mips/configs/bmips_be_defconfig
@@ -8,7 +8,7 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_SWAP is not set
 CONFIG_NO_HZ=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_GZIP is not set
+CONFIG_RD_GZIP=y
 CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
@@ -33,6 +33,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_PRINTK_TIME=y
 CONFIG_BRCMSTB_GISB_ARB=y
 CONFIG_MTD=y
 CONFIG_MTD_CFI=y
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 400a47ec1ef1..aa273d5d5825 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -9,7 +9,7 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_SWAP is not set
 CONFIG_NO_HZ=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_RD_GZIP is not set
+CONFIG_RD_GZIP=y
 CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
@@ -34,6 +34,7 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_PRINK_TIME=y
 CONFIG_BRCMSTB_GISB_ARB=y
 CONFIG_MTD=y
 CONFIG_MTD_CFI=y
-- 
2.1.0
