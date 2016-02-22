Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 23:23:55 +0100 (CET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:52541 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013422AbcBVWXG5HyPK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 23:23:06 +0100
Received: from localhost.localdomain (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 9186E4031;
        Tue, 23 Feb 2016 00:23:05 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/3] MIPS: OCTEON: initialize system type string after device tree init
Date:   Tue, 23 Feb 2016 00:22:56 +0200
Message-Id: <1456179777-6247-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1456179777-6247-1-git-send-email-aaro.koskinen@iki.fi>
References: <1456179777-6247-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52166
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

Initialize system type string after device tree init.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/setup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 5be2072..d9fb610 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -466,7 +466,7 @@ static void octeon_halt(void)
 
 static char __read_mostly octeon_system_type[80];
 
-static int __init init_octeon_system_type(void)
+static void __init init_octeon_system_type(void)
 {
 	char const *board_type;
 
@@ -476,10 +476,7 @@ static int __init init_octeon_system_type(void)
 
 	snprintf(octeon_system_type, sizeof(octeon_system_type), "%s (%s)",
 		 board_type, octeon_model_get_string(read_c0_prid()));
-
-	return 0;
 }
-early_initcall(init_octeon_system_type);
 
 /**
  * Return a string representing the system type
@@ -1122,6 +1119,7 @@ void __init device_tree_init(void)
 		pr_info("Using internal Device Tree.\n");
 	}
 	unflatten_and_copy_device_tree();
+	init_octeon_system_type();
 }
 
 static int __initdata disable_octeon_edac_p;
-- 
2.4.0
