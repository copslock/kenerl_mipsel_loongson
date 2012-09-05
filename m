Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2012 00:35:13 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45222 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903465Ab2IFWfH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Sep 2012 00:35:07 +0200
Received: by pbbrq8 with SMTP id rq8so3220935pbb.36
        for <linux-mips@linux-mips.org>; Thu, 06 Sep 2012 15:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=oN1kcIxsdNp4Fri7MdRop0Fv9zzILV8i4SUGcrSoOYk=;
        b=PBVP4FpkEzk0ysZHjYO9wYFr/jR8V7xX+vtKaQl/TN05SbZAk6zBR1OXBVU+zavmdy
         Nk7I3yWxfH10gw5Jf1CDtE8023krt3una+d7fbawD+G6eDM9NnvosyqaSBQ+uk9oQ1PB
         ZFkPvBElpTAJIr+Zt++4ZGmXD4eXsBxrBTqQmM1D61oyG8EW3VXM803KDALWufUl8/8X
         8frIMNe14ACYtzs2Yf2peyc0tfY/hsAwC1PnlM26W1puyi5juzYEIeJNZlmw7NpZC44R
         jNwDcb64mZIto9i/WF2cPsAoi/OozeDLBJmuqvFZzr+5blbpEY96wtAsemNL0KgxpeLO
         jEjw==
Received: by 10.68.201.104 with SMTP id jz8mr6737845pbc.141.1346970900423;
        Thu, 06 Sep 2012 15:35:00 -0700 (PDT)
Received: from localhost.localdomain (50-76-62-73-ip-static.hfc.comcastbusiness.net. [50.76.62.73])
        by mx.google.com with ESMTPS id hc10sm2051739pbc.21.2012.09.06.15.34.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 15:34:59 -0700 (PDT)
From:   Charles Hardin <ckhardin@exablox.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Jeremy Fitzhardinge <jeremy@exablox.com>,
        Charles Hardin <ckhardin@exablox.com>
Subject: [PATCH] mips/octeon: 16-Bit NOR flash was not being detected during boot
Date:   Wed,  5 Sep 2012 06:54:53 -0700
Message-Id: <1346853293-9166-1-git-send-email-ckhardin@exablox.com>
X-Mailer: git-send-email 1.7.9.1
X-Gm-Message-State: ALoCoQmmtUIDztQGz5+0xzk2EoxNesJ8AtHon2ZBIgEe43Y8Brmiifj7nZFST0jxNDHeCkkNOdlk
X-archive-position: 34440
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

Signed-off-by: Charles Hardin <ckhardin@exablox.com>

diff --git a/arch/mips/cavium-octeon/flash_setup.c b/arch/mips/cavium-octeon/flash_setup.c
index e44a55b..9e46976 100644
--- a/arch/mips/cavium-octeon/flash_setup.c
+++ b/arch/mips/cavium-octeon/flash_setup.c
@@ -51,7 +51,17 @@ static int __init flash_init(void)
 		flash_map.name = "phys_mapped_flash";
 		flash_map.phys = region_cfg.s.base << 16;
 		flash_map.size = 0x1fc00000 - flash_map.phys;
-		flash_map.bankwidth = 1;
+		switch (region_cfg.s.width) {
+		default:
+		case 0:
+			/* 8-bit bus */
+			flash_map.bankwidth = 1;
+			break;
+		case 1:
+			/* 16-bit bus */
+			flash_map.bankwidth = 2;
+			break;
+		}
 		flash_map.virt = ioremap(flash_map.phys, flash_map.size);
 		pr_notice("Bootbus flash: Setting flash for %luMB flash at "
 			  "0x%08llx\n", flash_map.size >> 20, flash_map.phys);
