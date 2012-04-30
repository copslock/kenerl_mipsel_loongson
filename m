Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 13:37:02 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56986 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903713Ab2D3Lef (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Apr 2012 13:34:35 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: [PATCH 07/14] MIPS: remove unused prototype kgdb_config
Date:   Mon, 30 Apr 2012 13:33:02 +0200
Message-Id: <1335785589-32532-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Trivial fix that removes an orphaned prototype.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/include/asm/mips-boards/generic.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index 46c0856..6e23ceb 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -93,8 +93,4 @@ extern void mips_pcibios_init(void);
 #define mips_pcibios_init() do { } while (0)
 #endif
 
-#ifdef CONFIG_KGDB
-extern void kgdb_config(void);
-#endif
-
 #endif  /* __ASM_MIPS_BOARDS_GENERIC_H */
-- 
1.7.9.1
