Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 10:15:01 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:53092 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903392Ab2FOINH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 10:13:07 +0200
Received: by mail-pz0-f49.google.com with SMTP id m1so3729829dad.36
        for <multiple recipients>; Fri, 15 Jun 2012 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RRG3tp1QF/0piBDT+rSfd4xD2BwWMF655GNe9wLSZqo=;
        b=oegZ2c48NcT4kZZP088fzjbsktbRTwTHRQ8GgUdY7wtGBvhN6x7rcOxObecFtiehtj
         j1DaQCzWO+3xrvew3mYHvOeSqXK48U10bWig/AOP5F1xOCyxuAaUjjh6caySBCyessvE
         +qJNmnE6vLqZRUoZf5lD51pA7F6zKoDO95vA+J5uGAfE079vX7BCHe+hEyAGo4JWe4aL
         Z9PXEwG0oNMXBjj8rJrdDfhVqD7aK7L70qxDXytMHCPTouT3ZSvwKfWKre2J1mHzLhc8
         QPHiwy2PqWtz4J16/rfqGGzNDoLjhS+QPfbRGHuhDJax4No3whcwO4n6utGzjpWHupkp
         +5dw==
Received: by 10.68.225.6 with SMTP id rg6mr17619714pbc.100.1339747986120;
        Fri, 15 Jun 2012 01:13:06 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nh8sm12437247pbc.60.2012.06.15.01.13.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 01:13:05 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
Date:   Fri, 15 Jun 2012 16:09:56 +0800
Message-Id: <1339747801-28691-10-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 drivers/ata/ahci.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ebaf67e..3e3cfd8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_info[] = {
 	},
 	[board_ahci_sb700] =	/* for SB700 and SB800 */
 	{
+#ifndef CONFIG_CPU_LOONGSON3
 		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL),
+#else
+		AHCI_HFLAGS	(AHCI_HFLAG_IGN_SERR_INTERNAL |
+						AHCI_HFLAG_32BIT_ONLY),
+#endif
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
-- 
1.7.7.3
