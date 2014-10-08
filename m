Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 17:09:47 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:53911
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27010972AbaJIPIHswSQ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 17:08:07 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 06/10] MIPS: ralink: allow manual memory override
Date:   Thu,  9 Oct 2014 01:53:01 +0200
Message-Id: <1412812385-64820-7-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
References: <1412812385-64820-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43142
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

RT5350 relies on the bootloader setting up the memc correctly. On some boards
the setup is incorrect leading to 32 MB being available but only 16 MB being
recognized. Allow these boards to manually override the memory range.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/of.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 7c4598c..7b3aa68 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -53,6 +53,17 @@ void __init device_tree_init(void)
 	unflatten_and_copy_device_tree();
 }
 
+static int memory_dtb;
+
+static int __init early_init_dt_find_memory(unsigned long node,
+				const char *uname, int depth, void *data)
+{
+	if (depth == 1 && !strcmp(uname, "memory@0"))
+		memory_dtb = 1;
+
+	return 0;
+}
+
 void __init plat_mem_setup(void)
 {
 	set_io_port_base(KSEG1);
@@ -63,7 +74,10 @@ void __init plat_mem_setup(void)
 	 */
 	__dt_setup_arch(__dtb_start);
 
-	if (soc_info.mem_size)
+	of_scan_flat_dt(early_init_dt_find_memory, NULL);
+	if (memory_dtb)
+		of_scan_flat_dt(early_init_dt_scan_memory, NULL);
+	else if (soc_info.mem_size)
 		add_memory_region(soc_info.mem_base, soc_info.mem_size * SZ_1M,
 				  BOOT_MEM_RAM);
 	else
-- 
1.7.10.4
