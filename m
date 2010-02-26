Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2010 17:22:04 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:33584 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492421Ab0BZQVN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2010 17:21:13 +0100
Received: by bwz7 with SMTP id 7so214548bwz.24
        for <multiple recipients>; Fri, 26 Feb 2010 08:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JlWIolN4kAjzBspD4o/okgLbjxHq0S45v8Ux3BX+MB0=;
        b=rWcHvUpX3ML1ZLF/pJTzlCzwfxDkXqd9YWTf4X+4TToyQrfciGYHArYJlKWvEm+ctu
         i3Ev0PMYCGBlszxOguHGrYu0tHSjulVdsEun35QQ88UhY89Arqxyzputd51Yy4MjEDIC
         4+1Y8VHBu+wTJAMIOe0E55JLSfxRt3BMHOJeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vYS1xKIrVBnFFl7Mo+2LblVOcJDHjOEgbVHdM/iHmaeMT45drcQQk9XLU8uJ0CRfSq
         uho/xeCxRy5+MzjVwNBEPl0Sa4ZSRw8/EH+fGcv4Q7VfAduZrB64SdipGUqHnmcDzkpm
         zzBbbTPMzRQZpHwn2ndc03z7oBkWvtlbS7LiE=
Received: by 10.204.3.10 with SMTP id 10mr455639bkl.35.1267201266927;
        Fri, 26 Feb 2010 08:21:06 -0800 (PST)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 15sm147563bwz.8.2010.02.26.08.21.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 08:21:05 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/2] MIPS: Alchemy: fix Au1100 ethernet build failure
Date:   Fri, 26 Feb 2010 17:22:02 +0100
Message-Id: <1267201322-28069-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267201322-28069-1-git-send-email-manuel.lauss@gmail.com>
References: <1267201322-28069-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

don't define platform info for second mac on au1100 (which only
has a single mac).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/platform.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 3fbe30c..2580e77 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -357,15 +357,6 @@ static struct resource au1xxx_eth0_resources[] = {
 #endif
 };
 
-static struct resource au1xxx_eth1_resources[] = {
-#if defined(CONFIG_SOC_AU1000)
-	MAC_RES(AU1000_ETH1_BASE, AU1000_MAC1_ENABLE, AU1000_MAC1_DMA_INT),
-#elif defined(CONFIG_SOC_AU1550)
-	MAC_RES(AU1550_ETH1_BASE, AU1550_MAC1_ENABLE, AU1550_MAC1_DMA_INT),
-#elif defined(CONFIG_SOC_AU1500)
-	MAC_RES(AU1500_ETH1_BASE, AU1500_MAC1_ENABLE, AU1500_MAC1_DMA_INT),
-#endif
-};
 
 static struct au1000_eth_platform_data au1xxx_eth0_platform_data = {
 	.phy1_search_mac0 = 1,
@@ -380,6 +371,16 @@ static struct platform_device au1xxx_eth0_device = {
 };
 
 #ifndef CONFIG_SOC_AU1100
+static struct resource au1xxx_eth1_resources[] = {
+#if defined(CONFIG_SOC_AU1000)
+	MAC_RES(AU1000_ETH1_BASE, AU1000_MAC1_ENABLE, AU1000_MAC1_DMA_INT),
+#elif defined(CONFIG_SOC_AU1550)
+	MAC_RES(AU1550_ETH1_BASE, AU1550_MAC1_ENABLE, AU1550_MAC1_DMA_INT),
+#elif defined(CONFIG_SOC_AU1500)
+	MAC_RES(AU1500_ETH1_BASE, AU1500_MAC1_ENABLE, AU1500_MAC1_DMA_INT),
+#endif
+};
+
 static struct au1000_eth_platform_data au1xxx_eth1_platform_data = {
 	.phy1_search_mac0 = 1,
 };
-- 
1.7.0
