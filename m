Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 20:58:24 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:61863 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491054Ab1FLS5c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 20:57:32 +0200
Received: by wwi18 with SMTP id 18so2042260wwi.0
        for <multiple recipients>; Sun, 12 Jun 2011 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references;
        bh=BEU/uwMHUZ6e+ZXJyD1u4OHVH0WWBWUPVEFVEveCJ1g=;
        b=Wd6sLVhjIIgKMlQd79ddiMIGwW7bsNwlTn3of3LWQm7hLJRUFdEGkTN3dp0EdP9VWD
         PHf03sRTR5JStkTV+GNBnisf5Uu79/xx8q2jIHvuFruPWorB8Ga46SABJ1FTBBPo2tZt
         hq8egGA4EdO1ARoXU8dO1dnyLtR1LLwaJ/H/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=uFRr8YzpxfgscyUFq2Rmh4jPIlAG7KAVZgNgrW6qONwC+zNJxP7rMd5cS3cROQvA39
         HVYdluVOIRGIbjgF6YFXB/68kCwuvPbhkZHj4d0EU6ov7njlgCmJTBSFO7punRx2LYUY
         N6hDG+LV6cvMR6cMcBF/DE8uDAes2CaZj622M=
Received: by 10.227.19.132 with SMTP id a4mr4237045wbb.100.1307905047546;
        Sun, 12 Jun 2011 11:57:27 -0700 (PDT)
Received: from localhost.localdomain (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id et5sm3674911wbb.16.2011.06.12.11.57.26
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 11:57:27 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/5] MIPS: ar7: replace __attribute__((__packed__)) with __packed
Date:   Sun, 12 Jun 2011 20:57:19 +0200
Message-Id: <1307905041-18391-3-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1307905041-18391-1-git-send-email-florian@openwrt.org>
References: <1307905041-18391-1-git-send-email-florian@openwrt.org>
X-archive-position: 30357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10218

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/ar7/prom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 23818d2..8088c6f 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -77,7 +77,7 @@ struct psp_env_chunk {
 	u16	csum;
 	u8	len;
 	char	data[11];
-} __attribute__ ((packed));
+} __packed;
 
 struct psp_var_map_entry {
 	u8	num;
-- 
1.7.4.1
