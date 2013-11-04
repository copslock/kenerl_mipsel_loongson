Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2013 09:42:41 +0100 (CET)
Received: from gerard.telenet-ops.be ([195.130.132.48]:51353 "EHLO
        gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822679Ab3KDImiYlF-d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Nov 2013 09:42:38 +0100
Received: from ayla.of.borg ([84.193.72.141])
        by gerard.telenet-ops.be with bizsmtp
        id lLid1m00H32ts5g0HLidfC; Mon, 04 Nov 2013 09:42:37 +0100
Received: from geert by ayla.of.borg with local (Exim 4.76)
        (envelope-from <geert@linux-m68k.org>)
        id 1VdFk3-0005Xf-4w; Mon, 04 Nov 2013 09:42:35 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-fbdev@vger.kernel.org,
        linux-mips@linux-mips.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] video/logo: Remove MIPS-specific include section
Date:   Mon,  4 Nov 2013 09:42:30 +0100
Message-Id: <1383554550-20901-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38444
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

Since commit 41702d9a4fffa9e25b2ad9d4af09b3013fa155e1 ("logo.c: get rid of
mips_machgroup") there's no longer a need to include <asm/bootinfo.h> on
MIPS.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/logo/logo.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 080c35b34bbb..b670cbda38e3 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -17,10 +17,6 @@
 #include <asm/setup.h>
 #endif
 
-#ifdef CONFIG_MIPS
-#include <asm/bootinfo.h>
-#endif
-
 static bool nologo;
 module_param(nologo, bool, 0);
 MODULE_PARM_DESC(nologo, "Disables startup logo");
-- 
1.7.9.5
