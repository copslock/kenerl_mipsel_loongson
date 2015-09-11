Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Sep 2015 16:50:02 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:37539 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013764AbbIKOtoUdqVk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Sep 2015 16:49:44 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id t8BEnc5l006382
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 11 Sep 2015 14:49:39 GMT
Received: from localhost.localdomain ([10.144.44.120])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id t8BEnbHc008588;
        Fri, 11 Sep 2015 16:49:38 +0200
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: OCTEON: support APPENDED_DTB
Date:   Fri, 11 Sep 2015 17:46:15 +0300
Message-Id: <1441982775-9703-2-git-send-email-aaro.koskinen@nokia.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1441982775-9703-1-git-send-email-aaro.koskinen@nokia.com>
References: <1441982775-9703-1-git-send-email-aaro.koskinen@nokia.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1609
X-purgate-ID: 151667::1441982979-00004C14-49D83DCB/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

Use appended DTB when available.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/mips/cavium-octeon/setup.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 89a6284..7d6f6d3 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -1081,6 +1081,7 @@ void __init prom_free_prom_memory(void)
 
 int octeon_prune_device_tree(void);
 
+extern const char __appended_dtb;
 extern const char __dtb_octeon_3xxx_begin;
 extern const char __dtb_octeon_68xx_begin;
 void __init device_tree_init(void)
@@ -1088,11 +1089,19 @@ void __init device_tree_init(void)
 	const void *fdt;
 	bool do_prune;
 
+#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
+	if (!fdt_check_header(&__appended_dtb)) {
+		fdt = &__appended_dtb;
+		do_prune = false;
+		pr_info("Using appended Device Tree.\n");
+	} else
+#endif
 	if (octeon_bootinfo->minor_version >= 3 && octeon_bootinfo->fdt_addr) {
 		fdt = phys_to_virt(octeon_bootinfo->fdt_addr);
 		if (fdt_check_header(fdt))
 			panic("Corrupt Device Tree passed to kernel.");
 		do_prune = false;
+		pr_info("Using passed Device Tree.\n");
 	} else if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
 		fdt = &__dtb_octeon_68xx_begin;
 		do_prune = true;
@@ -1106,8 +1115,6 @@ void __init device_tree_init(void)
 	if (do_prune) {
 		octeon_prune_device_tree();
 		pr_info("Using internal Device Tree.\n");
-	} else {
-		pr_info("Using passed Device Tree.\n");
 	}
 	unflatten_and_copy_device_tree();
 }
-- 
2.4.3
