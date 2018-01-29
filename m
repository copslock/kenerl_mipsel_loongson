Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2018 13:21:25 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:52162
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994667AbeA2MVSRNIUI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2018 13:21:18 +0100
Received: by mail-wm0-x244.google.com with SMTP id r71so13880558wmd.1
        for <linux-mips@linux-mips.org>; Mon, 29 Jan 2018 04:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=02c04p7+RK2gBlkjSs32bTAEpLN+JcE5YTT2VeTNPDY=;
        b=cAWu3dpX4fMdGi7H09yomwAl6j2V5yMub1SME7Y/5+MGisVEcNU6foWMa/ls5MbesU
         Y/aynS+POzeJjW4pB2N+A8WWdLm+Li1yXnY3MAwWB3w2ELG2NAOilRsNRc8O6FBEmhyM
         VwcuUe/jaCFQ2UUEjkdPtjUQrNnMgHIPvtyErviDemBXz4a2hjF25xe9/m9VPD8xzh1C
         usEgTIfMdiKfoPru2yIjbuKCVwCLXSCv51qz/JRDlhTa2/didMVy7dU8DxPaOOvIS215
         8Crm2pT5Vxbi1h2WP16jnFUaQS4OKvuqwU6wbEI17Rb7NwEJqjb2lgI9c1TW5WtBRXrX
         EDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=02c04p7+RK2gBlkjSs32bTAEpLN+JcE5YTT2VeTNPDY=;
        b=MhPjDlGzN9mGpDSG6NHTr4YCnSxI026ctP2YHhUvtn8eHxmrIxTZe4Obi/GS4Q+Xjf
         5bmi/KjgfXfc4f3oaZPp9Bea4MMdQJdZsCG37Kc81fuJHtrp5EdfUK6B0cWSvUSB2glK
         WB1WXJny9IG3bEpdrhzKf3arZHQifPruSCib0oKOn33A9IRKuQygQeXfLlCW8Wh3wp/5
         QUCla7xE/tWy1Bq/nvhpHG7WS1Q/oF/irQFXO8sihw17w1Lflos/rnyIS7YsboH1N+5o
         UN7DNHEbMW9mzok/kNggFIkBq4iW2rvoyPlFNcvRe13hIQuHC0FHOpllRcIg00S0nMkU
         O2jw==
X-Gm-Message-State: AKwxytc5ySOYWY9epxjkNbty2s5deqkZYDeqr479s7kQpif5Pu/L0JZr
        2KpdE2tc1/Dc5Bkd6WA7qnHsZA==
X-Google-Smtp-Source: AH8x226MPRTsPJCekGTE9bYS8RctqVTw6SxfTYjmYZd3u0PL1Zui76yKNhNjydGwHUhm3M+1ZhkSzQ==
X-Received: by 10.28.157.206 with SMTP id g197mr17375561wme.96.1517228472842;
        Mon, 29 Jan 2018 04:21:12 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y52sm26699218wrb.52.2018.01.29.04.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jan 2018 04:21:12 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     corbet@lwn.net, ralf@linux-mips.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] Documentation: mips: Update AU1xxx_IDE Kconfig dependencies
Date:   Mon, 29 Jan 2018 12:21:07 +0000
Message-Id: <1517228467-1444-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <clabbe@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clabbe@baylibre.com
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

IDEDMA_AUTO IDEDMA_PCI_AUTO was removed in commit 120b9cfddff2 ("ide: remove CONFIG_IDEDMA_{ICS,PCI}_AUTO config")
BLK_DEV_IDEDISK was removed in commit 806f80a6fc20 ("ide: add generic ATA/ATAPI disk driver")
BLK_DEV_IDE_AU1XXX_BURSTABLE_ON was removed in commit 8f29e650bffc ("ide: AU1200 IDE update")
Remove them from documentation

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/mips/AU1xxx_IDE.README | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/mips/AU1xxx_IDE.README b/Documentation/mips/AU1xxx_IDE.README
index 52844a58cc8a..ff675a1b1422 100644
--- a/Documentation/mips/AU1xxx_IDE.README
+++ b/Documentation/mips/AU1xxx_IDE.README
@@ -56,8 +56,6 @@ Following extra configs variables are introduced:
 
   CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA    - enable the PIO+DBDMA mode
   CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA  - enable the MWDMA mode
-  CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON - set Burstable FIFO in DBDMA
-                                           controller
 
 
 SUPPORTED IDE MODES
@@ -82,11 +80,9 @@ CONFIG_IDE_GENERIC=y
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_BLK_DEV_GENERIC=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_IDE_AU1XXX=y
 CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA=y
 CONFIG_BLK_DEV_IDEDMA=y
-CONFIG_IDEDMA_AUTO=y
 
 Also define 'IDE_AU1XXX_BURSTMODE' in 'drivers/ide/mips/au1xxx-ide.c' to enable
 the burst support on DBDMA controller.
@@ -94,16 +90,13 @@ the burst support on DBDMA controller.
 If the used system need the USB support enable the following kernel configs for
 high IDE to USB throughput.
 
-CONFIG_BLK_DEV_IDEDISK=y
 CONFIG_IDE_GENERIC=y
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_BLK_DEV_GENERIC=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_IDE_AU1XXX=y
 CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA=y
 CONFIG_BLK_DEV_IDEDMA=y
-CONFIG_IDEDMA_AUTO=y
 
 Also undefine 'IDE_AU1XXX_BURSTMODE' in 'drivers/ide/mips/au1xxx-ide.c' to
 disable the burst support on DBDMA controller.
-- 
2.13.6
