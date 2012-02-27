Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2012 01:01:00 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:58135 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903786Ab2B0X6J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2012 00:58:09 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 04DDA8F68;
        Tue, 28 Feb 2012 00:58:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ocnxs6D0-M8y; Tue, 28 Feb 2012 00:57:55 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id C87DC8F69;
        Tue, 28 Feb 2012 00:57:01 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linville@tuxdriver.com
Cc:     zajec5@gmail.com, b43-dev@lists.infradead.org,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        arend@broadcom.com, m@bues.ch, ralf@linux-mips.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 09/11] MIPS: BCM47XX: fix signature of nvram_parse_macaddr
Date:   Tue, 28 Feb 2012 00:56:12 +0100
Message-Id: <1330386974-4056-10-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1330386974-4056-1-git-send-email-hauke@hauke-m.de>
References: <1330386974-4056-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 32565
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
