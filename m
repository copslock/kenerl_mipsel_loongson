Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jun 2013 23:39:02 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:54367 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816671Ab3FWVi7lEFdF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Jun 2013 23:38:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 00A5E5A6DAF;
        Mon, 24 Jun 2013 00:38:59 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id fjY9M6WrZfuo; Mon, 24 Jun 2013 00:38:54 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with ESMTP id 069435BC010;
        Mon, 24 Jun 2013 00:38:54 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 1/2] MIPS: cavium-octeon: cvmx-helper-board: print unknown board warning only once
Date:   Mon, 24 Jun 2013 00:38:43 +0300
Message-Id: <1372023524-17333-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.3.1
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

When booting a new board for the first time, the console is flooded with
"Unknown board" messages. This is not really helpful. Board type is not
going to change after the boot, so it's sufficient to print the warning
only once.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---

	v2: Adjust indentation.

 arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
index 7c64977..9838c0e 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
@@ -31,6 +31,8 @@
  * network ports from the rest of the cvmx-helper files.
  */
 
+#include <linux/printk.h>
+
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-bootinfo.h>
 
@@ -184,9 +186,8 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
 	}
 
 	/* Some unknown board. Somebody forgot to update this function... */
-	cvmx_dprintf
-	    ("cvmx_helper_board_get_mii_address: Unknown board type %d\n",
-	     cvmx_sysinfo_get()->board_type);
+	pr_warn_once("%s: Unknown board type %d\n", __func__,
+		     cvmx_sysinfo_get()->board_type);
 	return -1;
 }
 
-- 
1.8.3.1
