Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 22:46:07 +0100 (CET)
Received: from andre.telenet-ops.be ([IPv6:2a02:1800:120:4::f00:15]:52540 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991112AbeKFVo1v7VJT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 22:44:27 +0100
Received: from ramsan.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id wlkM1y00G3XaVaC01lkM05; Tue, 06 Nov 2018 22:44:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gK993-0002DL-7f; Tue, 06 Nov 2018 22:44:21 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gK993-0002xn-4j; Tue, 06 Nov 2018 22:44:21 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH next] mtd: maps: physmap: Fix infinite loop crash in ROM type probing
Date:   Tue,  6 Nov 2018 22:44:16 +0100
Message-Id: <20181106214416.11342-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Toshiba RBTX4927, where map_probe is supposed to fail:

    Creating 2 MTD partitions on "physmap-flash.0":
    0x000000c00000-0x000001000000 : "boot"
    0x000000000000-0x000000c00000 : "user"
    physmap-flash physmap-flash.1: physmap platform flash device: [mem 0x1e000000-0x1effffff]
    CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == 80320f40, ra == 80321004
    ...
    Call Trace:
    [<80320f40>] get_mtd_chip_driver+0x30/0x8c
    [<80321004>] do_map_probe+0x20/0x90
    [<80328448>] physmap_flash_probe+0x484/0x4ec

The access to rom_probe_types[] was changed from a sentinel-based loop
to an infinite loop, causing a crash when reaching the sentinel.

Fix this by:
  - Removing the no longer needed sentinel,
  - Limiting the number of loop iterations to the actual number of ROM
    types.

Fixes: c7afe08496fa463e ("mtd: maps: physmap: Invert logic on if/else branch")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mtd/maps/physmap-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index 33b77bd9022ce251..e8c3b250d8421edc 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -396,7 +396,7 @@ static int physmap_flash_of_init(struct platform_device *dev)
 #endif /* IS_ENABLED(CONFIG_MTD_PHYSMAP_OF) */
 
 static const char * const rom_probe_types[] = {
-	"cfi_probe", "jedec_probe", "qinfo_probe", "map_rom", NULL
+	"cfi_probe", "jedec_probe", "qinfo_probe", "map_rom",
 };
 
 static const char * const part_probe_types[] = {
@@ -524,7 +524,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 		} else {
 			int j;
 
-			for (j = 0; ARRAY_SIZE(rom_probe_types); j++) {
+			for (j = 0; j < ARRAY_SIZE(rom_probe_types); j++) {
 				info->mtds[i] = do_map_probe(rom_probe_types[j],
 							     &info->maps[i]);
 				if (info->mtds[i])
-- 
2.17.1
