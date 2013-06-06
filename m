Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jun 2013 16:01:18 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:52977 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831903Ab3FFOBJGgd5n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Jun 2013 16:01:09 +0200
From:   John Crispin <blogic@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH] MIPS: ralink: add missing SZ_1M multiplier
Date:   Thu,  6 Jun 2013 15:55:53 +0200
Message-Id: <1370526953-17122-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36716
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

On RT5350 the memory size is set to Bytes and not MegaBytes due to a missing
multiplier.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/of.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index f916774..b25c1f2 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -88,7 +88,7 @@ void __init plat_mem_setup(void)
 	__dt_setup_arch(&__dtb_start);
 
 	if (soc_info.mem_size)
-		add_memory_region(soc_info.mem_base, soc_info.mem_size,
+		add_memory_region(soc_info.mem_base, soc_info.mem_size * SZ_1M,
 				  BOOT_MEM_RAM);
 	else
 		detect_memory_region(soc_info.mem_base,
-- 
1.7.10.4
