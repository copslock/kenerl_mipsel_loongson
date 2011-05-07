Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2011 14:30:12 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45569 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491133Ab1EGM2P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 May 2011 14:28:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 3B8A78ACA;
        Sat,  7 May 2011 14:28:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ofcW9B8Rw1Ux; Sat,  7 May 2011 14:28:12 +0200 (CEST)
Received: from localhost.localdomain (dyndsl-085-016-167-129.ewe-ip-backbone.de [85.16.167.129])
        by hauke-m.de (Postfix) with ESMTPSA id 7534A8ACD;
        Sat,  7 May 2011 14:28:06 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] MIPS: BCM47xx: Fix mac address parsing.
Date:   Sat,  7 May 2011 14:27:43 +0200
Message-Id: <1304771263-10937-6-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1304771263-10937-1-git-send-email-hauke@hauke-m.de>
References: <1304771263-10937-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

Some devices like the Netgear WGT634u are using minuses between the
blocks of the mac address and other devices are using colons to
separate them.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/include/asm/mach-bcm47xx/nvram.h |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm47xx/nvram.h b/arch/mips/include/asm/mach-bcm47xx/nvram.h
index 9759588..fcdeca7 100644
--- a/arch/mips/include/asm/mach-bcm47xx/nvram.h
+++ b/arch/mips/include/asm/mach-bcm47xx/nvram.h
@@ -39,8 +39,15 @@ extern int nvram_getenv(char *name, char *val, size_t val_len);
 
 static inline void nvram_parse_macaddr(char *buf, u8 *macaddr)
 {
-	sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0], &macaddr[1],
-	       &macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
+	if (strchr(buf, ':')) {
+		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0], &macaddr[1],
+			&macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
+	} else if (strchr(buf, '-')) {
+		sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx", &macaddr[0], &macaddr[1],
+			&macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
+	} else {
+		printk(KERN_WARNING "Can not parse mac address: %s\n", buf);
+	}
 }
 
 #endif
-- 
1.7.4.1
