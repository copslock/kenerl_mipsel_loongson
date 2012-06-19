Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 08:57:22 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:56349 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903562Ab2FSG5R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 08:57:17 +0200
Received: by pbbrq13 with SMTP id rq13so9842677pbb.36
        for <multiple recipients>; Mon, 18 Jun 2012 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=a31830jXnnt13N19MjJvevkkwwauZ7koV5Gic6FXk84=;
        b=00bZKadi7X0Dvrmf2aSLY2Eti1HMhCEt/FulPEIoBHgLb6duHER3AkB+PjYLssLgQt
         dH2in7UrVSs/nr0TX6s10PoEsHZ4nXbx4XWESas0I0/kzaOrHVhZp0znoyUE8h2NQ5lG
         BnB9R5O8Q/v3/p//GZeGmFGdy9vnwEwyvwp1bXpf5qNb+gleC3pHiMXmun5/Mea2cUSG
         L8QIzMAervww0bWs1UTZdsf3/G1KGV2XIQyGOElggVad7Oh3J9llR7G7SgC2ai1Ych8P
         s52lo5dc0wr8CpJrylRGcJZJto/YAMmvah5FW/bFuN5WCKGSsatd3nd7qPIIw7ZgS8eS
         ih+w==
Received: by 10.68.241.232 with SMTP id wl8mr60356859pbc.106.1340089031241;
        Mon, 18 Jun 2012 23:57:11 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id gk3sm20156319pbc.1.2012.06.18.23.57.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2012 23:57:10 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH V2 11/16] ata: Use 32-bit DMA in AHCI for Loongson-3.
Date:   Tue, 19 Jun 2012 14:50:19 +0800
Message-Id: <1340088624-25550-12-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33701
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

This is a workaround because Loongson-3 has a hardware bug that it
doesn't support DMA address above 4GB.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Cc: linux-ide@vger.kernel.org
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
