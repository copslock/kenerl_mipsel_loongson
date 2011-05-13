Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:29:00 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:46378 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491839Ab1EMP25 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 17:28:57 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
        id F33C780C2A; Fri, 13 May 2011 16:28:55 +0100 (BST)
Date:   Fri, 13 May 2011 16:28:55 +0100
From:   Alexander Clouter <alex@digriz.org.uk>
To:     linux-mips@linux-mips.org
Cc:     florian@openwrt.org
Subject: [PATCH] MIPS: AR7: Fix GCC 4.6.0 build error.
Message-ID: <20110513152855.GM25017@chipmunk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: diGriz
X-URL:  http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <alex@digriz.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

  CC      arch/mips/ar7/gpio.o
arch/mips/ar7/gpio.c: In function 'ar7_gpio_init':
arch/mips/ar7/gpio.c:318:11: error: variable 'size' set but not used [-Werror=unused-but-set-variable]
cc1: all warnings being treated as errors

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/mips/ar7/gpio.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index 425dfa5..6917427 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -314,16 +314,8 @@ static void titan_gpio_init(void)
 int __init ar7_gpio_init(void)
 {
 	int ret;
-	struct ar7_gpio_chip *gpch;
-	unsigned size;
-
-	if (!ar7_is_titan()) {
-		gpch = &ar7_gpio_chip;
-		size = 0x10;
-	} else {
-		gpch = &titan_gpio_chip;
-		size = 0x1f;
-	}
+	struct ar7_gpio_chip *gpch = (!ar7_is_titan())
+		? &ar7_gpio_chip : &titan_gpio_chip;
 
 	gpch->regs = ioremap_nocache(AR7_REGS_GPIO,
 					AR7_REGS_GPIO + 0x10);
-- 
1.7.5.1
