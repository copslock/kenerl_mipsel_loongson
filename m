Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2011 23:34:00 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45943 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491078Ab1EJVc0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 May 2011 23:32:26 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id BEF3D8ACA;
        Tue, 10 May 2011 23:32:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id adc7WX0E0B2q; Tue, 10 May 2011 23:32:21 +0200 (CEST)
Received: from localhost.localdomain (host-091-097-255-123.ewe-ip-backbone.de [91.97.255.123])
        by hauke-m.de (Postfix) with ESMTPSA id 31CE28ACE;
        Tue, 10 May 2011 23:32:19 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 5/5] MIPS: BCM47xx: Fix mac address parsing.
Date:   Tue, 10 May 2011 23:31:34 +0200
Message-Id: <1305063094-26656-6-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1305063094-26656-1-git-send-email-hauke@hauke-m.de>
References: <1305063094-26656-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29917
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
v2: * fix some checkpatch errors and warnings

 arch/mips/include/asm/mach-bcm47xx/nvram.h |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm47xx/nvram.h b/arch/mips/include/asm/mach-bcm47xx/nvram.h
index 9759588..184d5ec 100644
--- a/arch/mips/include/asm/mach-bcm47xx/nvram.h
+++ b/arch/mips/include/asm/mach-bcm47xx/nvram.h
@@ -39,8 +39,16 @@ extern int nvram_getenv(char *name, char *val, size_t val_len);
 
 static inline void nvram_parse_macaddr(char *buf, u8 *macaddr)
 {
-	sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0], &macaddr[1],
-	       &macaddr[2], &macaddr[3], &macaddr[4], &macaddr[5]);
+	if (strchr(buf, ':'))
+		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0],
+			&macaddr[1], &macaddr[2], &macaddr[3], &macaddr[4],
+			&macaddr[5]);
+	else if (strchr(buf, '-'))
+		sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx", &macaddr[0],
+			&macaddr[1], &macaddr[2], &macaddr[3], &macaddr[4],
+			&macaddr[5]);
+	else
+		printk(KERN_WARNING "Can not parse mac address: %s\n", buf);
 }
 
 #endif
-- 
1.7.4.1
