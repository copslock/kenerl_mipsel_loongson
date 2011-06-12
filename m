Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jun 2011 18:58:01 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:37876 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491120Ab1FLQ4h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 Jun 2011 18:56:37 +0200
Received: by mail-ww0-f43.google.com with SMTP id 17so3489562wwb.24
        for <linux-mips@linux-mips.org>; Sun, 12 Jun 2011 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=jsLD7CxHEq+1UuaFFW4Dp5mHjMA/YXBYSUoYLRc4yvg=;
        b=XWTPWLCmCttw2w5AWlsNlnB7jGtS9fST83w+WyWxUBcQPOqWWT+inQxPsLxhaOeBd0
         PQsVkt78aN0OrFnB20oNfVmclidJATMsdo8AaGvsgBf18Pehyp93nUFzsJGz0xlcON/W
         XkxQ00UeF8B1u4hXkMMjXnYxbCoRPcHO6s8wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=LCDnGTSZMAZgyEEAjGe12OmsnSsiitkVsOYzB8RcQaUxt8Py1DhgbrzSYz8ffZIATC
         HHLjxzqe91DZQLZKUiOdLv2hFhKb8klx8vLdjgCZlIauzSmOA5UMtruxSAdaW061wQih
         gUrNzZQzD9Qdiig1JRgaZ50iZFQq8suohO/JI=
Received: by 10.227.7.18 with SMTP id b18mr4275042wbb.103.1307897797011;
        Sun, 12 Jun 2011 09:56:37 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id m8sm3606020wbh.11.2011.06.12.09.56.35
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 09:56:36 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 5/5 v2] WATCHDOG: mtx1-wdt: remove unused variable 'tmp'
Date:   Sun, 12 Jun 2011 18:56:34 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106121856.34703.florian@openwrt.org>
X-archive-position: 30352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10186


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes since v1

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index c5f6e72..3abf265 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -71,8 +71,6 @@ static struct {
 
 static void mtx1_wdt_trigger(unsigned long unused)
 {
-	u32 tmp;
-
 	spin_lock(&mtx1_wdt_device.lock);
 	if (mtx1_wdt_device.running)
 		ticks--;
-- 
1.7.4.1
