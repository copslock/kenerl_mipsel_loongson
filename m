Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2011 15:45:03 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:50460 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491851Ab1FBNog (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2011 15:44:36 +0200
Received: by wyb28 with SMTP id 28so855066wyb.36
        for <linux-mips@linux-mips.org>; Thu, 02 Jun 2011 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=4PRTOUTKqfkSZLqLbvFiSZWBLbRNUr742d1N4VZn5UQ=;
        b=m9ugtW2MSDiD8fT+BgwbzaZgHEi3S/ziK5gSwCYyAiArfJfoKte0hiX9G+GUMEPC5w
         IV+0waN7wg3m4zjzONv9zF4OYFg674eDXezuYF3VHR3qA8ILtGy0FS0c5XoN88G76zRn
         LqGTpVL6BVyeIeCcQD2xwGetzh7Q9KadsyFco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=K+pOptDzTrtjYUQAvQ9HhXTj0gl3FkuwZ8s6ripPYMYfz2w3KW4FlG5XTP/6CTjCHa
         earauSJNOlwsQK5ThhCT3t4yQT1/wKHcoweguwwTtTU1cAgRRjwu2de3LuAA0NY2yLnm
         nbE3z3XyqF8PnSS81Z3yLdz8/l0aPegOQAWn8=
Received: by 10.216.239.67 with SMTP id b45mr282132wer.44.1307022270920;
        Thu, 02 Jun 2011 06:44:30 -0700 (PDT)
Received: from bender.localnet (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id a1sm331049wek.46.2011.06.02.06.44.29
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 06:44:30 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/2] WATCHDOG: mtx1-wdt: remove unused variable 'tmp'
Date:   Thu, 2 Jun 2011 15:44:28 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-9-generic; KDE/4.6.2; x86_64; ; )
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106021544.28512.florian@openwrt.org>
X-archive-position: 30196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1773


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index f313d3b..913d499 100644
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
