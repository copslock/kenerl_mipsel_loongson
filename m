Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 19:36:43 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:35873 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903593Ab2BSSd7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2012 19:33:59 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id C9E728F68;
        Sun, 19 Feb 2012 19:33:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SZrtObMg0s+P; Sun, 19 Feb 2012 19:33:45 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 57F4B8F69;
        Sun, 19 Feb 2012 19:32:50 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/11] MIPS: BCM47XX: fix signature of nvram_parse_macaddr
Date:   Sun, 19 Feb 2012 19:32:23 +0100
Message-Id: <1329676345-15856-10-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Explicitly enforce an char array of 6 bytes for the mac address.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/include/asm/mach-bcm47xx/nvram.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm47xx/nvram.h b/arch/mips/include/asm/mach-bcm47xx/nvram.h
index 184d5ec..69ef3ef 100644
--- a/arch/mips/include/asm/mach-bcm47xx/nvram.h
+++ b/arch/mips/include/asm/mach-bcm47xx/nvram.h
@@ -37,7 +37,7 @@ struct nvram_header {
 
 extern int nvram_getenv(char *name, char *val, size_t val_len);
 
-static inline void nvram_parse_macaddr(char *buf, u8 *macaddr)
+static inline void nvram_parse_macaddr(char *buf, u8 macaddr[6])
 {
 	if (strchr(buf, ':'))
 		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0],
-- 
1.7.5.4
