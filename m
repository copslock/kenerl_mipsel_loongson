Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 12:49:15 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:52689 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835123Ab3DOKtOj98VK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Apr 2013 12:49:14 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [RFC] MIPS: ath79: make use of the new memory detection code
Date:   Mon, 15 Apr 2013 12:45:09 +0200
Message-Id: <1366022709-8485-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

There is now a generic function for detecting memory size. Use this instead of
the one found in the ath79 support.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
Hi Gabor,

I only compile tested this one inside a openwrt tree.

 arch/mips/ath79/setup.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index d5b3c90..a0233a2 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -51,20 +51,6 @@ static void ath79_halt(void)
 		cpu_wait();
 }
 
-static void __init ath79_detect_mem_size(void)
-{
-	unsigned long size;
-
-	for (size = ATH79_MEM_SIZE_MIN; size < ATH79_MEM_SIZE_MAX;
-	     size <<= 1) {
-		if (!memcmp(ath79_detect_mem_size,
-			    ath79_detect_mem_size + size, 1024))
-			break;
-	}
-
-	add_memory_region(0, size, BOOT_MEM_RAM);
-}
-
 static void __init ath79_detect_sys_type(void)
 {
 	char *chip = "????";
@@ -212,7 +198,7 @@ void __init plat_mem_setup(void)
 					 AR71XX_DDR_CTRL_SIZE);
 
 	ath79_detect_sys_type();
-	ath79_detect_mem_size();
+	detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
 	ath79_clocks_init();
 
 	_machine_restart = ath79_restart;
-- 
1.7.10.4
