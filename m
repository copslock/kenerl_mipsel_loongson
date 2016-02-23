Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 23:53:06 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:33995 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013849AbcBWWwLr1nqR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 23:52:11 +0100
Received: from localhost.localdomain (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 5A81523405D;
        Wed, 24 Feb 2016 00:52:11 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 3/3] MIPS: OCTEON: device_tree_init: fill mac addresses when using appended dtb
Date:   Wed, 24 Feb 2016 00:52:07 +0200
Message-Id: <1456267927-2492-4-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1456267927-2492-1-git-send-email-aaro.koskinen@iki.fi>
References: <1456267927-2492-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52184
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

Fill MAC addresses from bootinfo when using appended DTB.

Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/setup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index ed3063f..f2df1d9 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1089,11 +1089,13 @@ void __init device_tree_init(void)
 {
 	const void *fdt;
 	bool do_prune;
+	bool fill_mac;
 
 #ifdef CONFIG_MIPS_ELF_APPENDED_DTB
 	if (!fdt_check_header(&__appended_dtb)) {
 		fdt = &__appended_dtb;
 		do_prune = false;
+		fill_mac = true;
 		pr_info("Using appended Device Tree.\n");
 	} else
 #endif
@@ -1102,22 +1104,26 @@ void __init device_tree_init(void)
 		if (fdt_check_header(fdt))
 			panic("Corrupt Device Tree passed to kernel.");
 		do_prune = false;
+		fill_mac = false;
 		pr_info("Using passed Device Tree.\n");
 	} else if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
 		fdt = &__dtb_octeon_68xx_begin;
 		do_prune = true;
+		fill_mac = true;
 	} else {
 		fdt = &__dtb_octeon_3xxx_begin;
 		do_prune = true;
+		fill_mac = true;
 	}
 
 	initial_boot_params = (void *)fdt;
 
 	if (do_prune) {
 		octeon_prune_device_tree();
-		octeon_fill_mac_addresses();
 		pr_info("Using internal Device Tree.\n");
 	}
+	if (fill_mac)
+		octeon_fill_mac_addresses();
 	unflatten_and_copy_device_tree();
 }
 
-- 
2.4.0
