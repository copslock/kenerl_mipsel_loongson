Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 20:58:46 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:59662 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491058Ab1FLS5e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 20:57:34 +0200
Received: by wwb17 with SMTP id 17so3531527wwb.24
        for <multiple recipients>; Sun, 12 Jun 2011 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references;
        bh=lpLB0XWsFf7++ciTrjlbeDgbGDMtw4/54oFUMjSq0DM=;
        b=b9ZIWJweHQhRPScuLyAASLgu8KL3rb2l+OmLm1fpmoc42myFuOGzO4M033EUfARyaD
         vGDQPEAgv9ZcWSgF3+9hKN3A0YQc2IzGIv1TxAbeX/2ip98irETVn9RvNWqnFFIqA4p1
         qEPX/usptYVcEE+0lXkmqqerXSF4n2Rud/YsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=Zha/Nf81qqeDsZeNUqi32HcKe0mUFp4+cK7NEMw2qtivQsMKZA9yVomiBREmfSj8tc
         xXR6087yzeXmQBzAeL8Hdfm7W4aX1kJahKxA0gr6pH8SvAV5K4oGw8lTunvaPRv1U14T
         l1IvH0RnLh50t/ReYs8lAe03f63rSGXhsY9fs=
Received: by 10.227.24.146 with SMTP id v18mr4299801wbb.84.1307905048729;
        Sun, 12 Jun 2011 11:57:28 -0700 (PDT)
Received: from localhost.localdomain (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id et5sm3674911wbb.16.2011.06.12.11.57.27
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 11:57:28 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 4/5] MIPS: ar7: use linux/reboot.h instead of asm/reboot.h
Date:   Sun, 12 Jun 2011 20:57:20 +0200
Message-Id: <1307905041-18391-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1307905041-18391-1-git-send-email-florian@openwrt.org>
References: <1307905041-18391-1-git-send-email-florian@openwrt.org>
X-archive-position: 30358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10219

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/ar7/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ar7/setup.c b/arch/mips/ar7/setup.c
index f20b53e..819d47c 100644
--- a/arch/mips/ar7/setup.c
+++ b/arch/mips/ar7/setup.c
@@ -19,8 +19,8 @@
 #include <linux/ioport.h>
 #include <linux/pm.h>
 #include <linux/time.h>
+#include <linux/reboot.h>
 
-#include <asm/reboot.h>
 #include <asm/mach-ar7/ar7.h>
 #include <asm/mach-ar7/prom.h>
 #include <asm/mach-ar7/gpio.h>
-- 
1.7.4.1
