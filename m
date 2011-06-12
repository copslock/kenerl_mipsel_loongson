Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 20:58:00 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:55040 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491048Ab1FLS5b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 20:57:31 +0200
Received: by wwb17 with SMTP id 17so3531513wwb.24
        for <multiple recipients>; Sun, 12 Jun 2011 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references;
        bh=F3ytRTm5sE4wb6e/ZHycueXRmz12aU6SvTS5jUREg/8=;
        b=XoNFerrkTyI8ZAIx0KJctsUlGED/nVtxGkMLVbZV49wZSisv4DbLY+TJgp7RwBWb1X
         ugKaeRrAejHmE73edlpMaMjjiHEm8MtY7BrKwx4ezacZmQXtLFUzgDpiQUTG0l2UJ5Lm
         NmrYOOGVy84GJbgqM3JFJ9Dz2mjIik7aHI8lE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=SB/X/9kQGPDaKsLuKtBzvXpZ5nhOpJVS92jk0RKAafoF9+5n8tgCKqwGa6nRG68rpU
         pgCc5yIcmGWZMcC7QEr1EgguZSkQd4GNZqYCpXEYCVW3WjMFnDpPt7GgNZle1n+1PqnU
         kRcbrrl/3PnTv2jlJgjEEwu8/D1PVK1okuGdE=
Received: by 10.227.207.196 with SMTP id fz4mr4391615wbb.42.1307905046359;
        Sun, 12 Jun 2011 11:57:26 -0700 (PDT)
Received: from localhost.localdomain (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id et5sm3674911wbb.16.2011.06.12.11.57.25
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 11:57:25 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/5] MIPS: ar7: remove 'space before tabs' in platform.c
Date:   Sun, 12 Jun 2011 20:57:18 +0200
Message-Id: <1307905041-18391-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1307905041-18391-1-git-send-email-florian@openwrt.org>
References: <1307905041-18391-1-git-send-email-florian@openwrt.org>
X-archive-position: 30356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10217

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/ar7/platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index 7d2fab3..33ffecf 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -229,7 +229,7 @@ static struct resource cpmac_low_res[] = {
 		.name	= "irq",
 		.flags	= IORESOURCE_IRQ,
 		.start	= 27,
-		.end 	= 27,
+		.end	= 27,
 	},
 };
 
-- 
1.7.4.1
