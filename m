Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 20:57:39 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:53644 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491046Ab1FLS5a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 20:57:30 +0200
Received: by wwb17 with SMTP id 17so3531508wwb.24
        for <multiple recipients>; Sun, 12 Jun 2011 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer;
        bh=1w5Ou9sjb4ECFOd6DnLOxqb4/c/ObyZQEz6+NPPR8dM=;
        b=wDtVFH4UTbSgsKHkx8Nel4xD0Rfg8PnqzCltg7J1nJ47u4sa0fHlU7ap+5r+fC/IYx
         uohEmEu/YzpGI5Vh+FJ+CZRSjAvHmilZGnNSL2Z6RRtT+XE/egZXqkg67dqbYBIy7Zhr
         eQ3We4oVVRNrO1PENYUE02DUFvpYdKfI1ixLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=wPhOUZe4sctojdIDDVeviGYyPAJTBmtTSubYSZdfxJ8Ei2ztZ5UzHGJyCdc9ZJff6P
         ZxmKMgpsHOLpN526BzjvT88BKmreDvaBihQbSmTelEwgc0fOl3fCgLd7L+bAQNbiseAT
         6Dvn5RF21THIyas0yf1y9I1Q0L172gR+wlIts=
Received: by 10.227.12.18 with SMTP id v18mr4302795wbv.89.1307905045128;
        Sun, 12 Jun 2011 11:57:25 -0700 (PDT)
Received: from localhost.localdomain (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id et5sm3674911wbb.16.2011.06.12.11.57.23
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 11:57:24 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/5] MIPS: ar7: remove trailing semicolon in clock.c
Date:   Sun, 12 Jun 2011 20:57:17 +0200
Message-Id: <1307905041-18391-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
X-archive-position: 30355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10216

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/ar7/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ar7/clock.c b/arch/mips/ar7/clock.c
index 2ca4ada..2460f9d 100644
--- a/arch/mips/ar7/clock.c
+++ b/arch/mips/ar7/clock.c
@@ -443,7 +443,7 @@ struct clk *clk_get(struct device *dev, const char *id)
 		return &vbus_clk;
 	if (!strcmp(id, "cpu"))
 		return &cpu_clk;
-	if (!strcmp(id, "dsp"));
+	if (!strcmp(id, "dsp"))
 		return &dsp_clk;
 	if (!strcmp(id, "vbus"))
 		return &vbus_clk;
-- 
1.7.4.1
