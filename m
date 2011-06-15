Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2011 19:12:34 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:43802 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491154Ab1FORLm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2011 19:11:42 +0200
Received: by mail-ww0-f43.google.com with SMTP id 17so593173wwb.24
        for <linux-mips@linux-mips.org>; Wed, 15 Jun 2011 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=x4xmLIThWryR5X96TcEYtzZ/2UsF+LFuyzI5l64awwI=;
        b=cAPBxGx+PAKPcHaXyKX3biODrP9wpVJVi1jw2GZesl5egZV+RYnJB8WtwRH2KOon/b
         FWGxaJcgmTbDbe8OypQvYMyf8q707nHPH5MJkEAgTZ1RCtxsPlqkaG81ggWayzCqgUnL
         qF+GbPqzXPL3S+H5j6bB+wfmT6cvC8Qubci20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=Et+pTSLhKxyNBAY5aIitBLzbOHpc3hC7mKrssDS/Aad/HJCBV9BLRnV3wTiIwx8vMZ
         VkUPF3pBsK+nF3fmhqHuq1sYn8ZB8YayvWnlUmLu1Vwr/0PcsNZJGc8Mk8lZBlhz3e8E
         ruSCbg83mz1NgR5tMVeVvF6nr0SwAfy5n1WH0=
Received: by 10.227.57.82 with SMTP id b18mr843347wbh.74.1308157902660;
        Wed, 15 Jun 2011 10:11:42 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id gb6sm507213wbb.17.2011.06.15.10.11.41
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 10:11:41 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 5/5 v3] WATCHDOG: mtx1-wdt: remove unused variable 'tmp'
Date:   Wed, 15 Jun 2011 19:15:58 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106151915.58905.florian@openwrt.org>
X-archive-position: 30421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12533


Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes in v1, v2 and v3

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 03cab33..ac37bb8 100644
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
