Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Oct 2013 22:56:58 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:60482 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824790Ab3JMU44Wg0jc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Oct 2013 22:56:56 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id CA7408F62;
        Sun, 13 Oct 2013 22:56:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sw94kVRn-3Cr; Sun, 13 Oct 2013 22:56:52 +0200 (CEST)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 27FFC8F61;
        Sun, 13 Oct 2013 22:56:52 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: BCM47XX: move constant array from stack
Date:   Sun, 13 Oct 2013 22:56:50 +0200
Message-Id: <1381697810-31402-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Move the possible nvram sizes from the stack into the data segment

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/nvram.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index b4c585b..085a3ee 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -22,11 +22,11 @@
 #include <asm/mach-bcm47xx/bcm47xx.h>
 
 static char nvram_buf[NVRAM_SPACE];
+static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
 
 static u32 find_nvram_size(u32 end)
 {
 	struct nvram_header *header;
-	u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
-- 
1.7.10.4
