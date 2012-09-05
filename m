Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2012 23:22:01 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36464 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903438Ab2IGVVy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Sep 2012 23:21:54 +0200
Received: by pbbrq8 with SMTP id rq8so196063pbb.36
        for <linux-mips@linux-mips.org>; Fri, 07 Sep 2012 14:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=9gyWPalzI7zkVcaOtmp0vfvBzTT5542/KgbuYdIeQHc=;
        b=N2qhoJ+OLN9TCLcr04/VQY9wHu4mntSUWU464hxyYjVBsbNXXWuRwIzgo3zMKr356y
         fYc6bewiQT2KFDuaK2xyj7HqXKxvlHNvwZY+wiMalN4cNLG1kF2KjxVqevLhC94xLLGf
         J7Oq7sGk1kLrs8o+dE5yBWz10tcyx1AbMXUOoOFXKaiEsfsExECURVqwR6U6SCZR49Z9
         rtODA9D6DbqA3nZYisTFOtWz/l5YdyL9BC95CYNfqbq0lRq7VL4QLL+Se9gh8+ZD8EeI
         2Fhk5usFN1wBjy0S9dcJYy7YRc0ZMe7sdrHRntBACDexD40NQjbEC3GLnWQjevDfKcrf
         2x0Q==
Received: by 10.68.211.105 with SMTP id nb9mr11680388pbc.67.1347052907335;
        Fri, 07 Sep 2012 14:21:47 -0700 (PDT)
Received: from localhost.localdomain (50-76-62-73-ip-static.hfc.comcastbusiness.net. [50.76.62.73])
        by mx.google.com with ESMTPS id to6sm3793135pbc.12.2012.09.07.14.21.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2012 14:21:46 -0700 (PDT)
From:   Charles Hardin <ckhardin@exablox.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Jeremy Fitzhardinge <jeremy@exablox.com>,
        Charles Hardin <ckhardin@exablox.com>
Subject: [PATCH] mips/octeon: 16-Bit NOR flash was not being detected during boot
Date:   Wed,  5 Sep 2012 13:19:48 -0700
Message-Id: <1346876388-25839-1-git-send-email-ckhardin@exablox.com>
X-Mailer: git-send-email 1.7.9.1
X-Gm-Message-State: ALoCoQmn0BwqYR7S51FD7gq8a3+JJrAHJ6QcTS1f6SI2b5+PmIAJhDrMc5G2vz2iP7zxU8a+4FyB
X-archive-position: 34442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ckhardin@exablox.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

The cavium code assumed that all NOR on the boot bus was
an 8-bit NOR part and hardcoded the bankwidth. The simple
solution was to add the code that queries the configuration
register for the width of the bus that has been hardware strapped
to the Cavium. This allows both 8-bit and 16-bit parts to be
discovered during boot.

Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Charles Hardin <ckhardin@exablox.com>

diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
index e44a55b..237e5b1 100644
--- a/arch/mips/cavium-octeon/flash_setup.c
+++ b/arch/mips/cavium-octeon/flash_setup.c
@@ -51,7 +51,8 @@ static int __init flash_init(void)
 		flash_map.name = "phys_mapped_flash";
 		flash_map.phys = region_cfg.s.base << 16;
 		flash_map.size = 0x1fc00000 - flash_map.phys;
-		flash_map.bankwidth = 1;
+		/* 8-bit bus (0 + 1) or 16-bit bus (1 + 1) */
+		flash_map.bankwidth = region_cfg.s.width + 1;
 		flash_map.virt = ioremap(flash_map.phys, flash_map.size);
 		pr_notice("Bootbus flash: Setting flash for %luMB flash at "
 			  "0x%08llx\n", flash_map.size >> 20, flash_map.phys);
