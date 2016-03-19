Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Mar 2016 18:29:05 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:38974 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007246AbcCSR3DoJ4PK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Mar 2016 18:29:03 +0100
Received: from hauke-desktop.fritz.box (p20030062465D04006DFE28B1EAF19207.dip0.t-ipconnect.de [IPv6:2003:62:465d:400:6dfe:28b1:eaf1:9207])
        by hauke-m.de (Postfix) with ESMTPSA id 1160B1001AC;
        Sat, 19 Mar 2016 18:29:03 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] MIPS: lantiq: add support for device tree file from boot loader
Date:   Sat, 19 Mar 2016 18:28:51 +0100
Message-Id: <1458408532-9259-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.7.0
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This fetches the device tree file like it is specified in the MIPS UHI
interface if one was found. This is also used when the device tree file
was appended to the kernel image with cat.
This code is copied from arch/mips/bmips/setup.c.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/prom.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 297bcaa..a5c7fec 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -65,6 +65,8 @@ static void __init prom_init_cmdline(void)
 
 void __init plat_mem_setup(void)
 {
+	void *dtb;
+
 	ioport_resource.start = IOPORT_RESOURCE_START;
 	ioport_resource.end = IOPORT_RESOURCE_END;
 	iomem_resource.start = IOMEM_RESOURCE_START;
@@ -72,11 +74,18 @@ void __init plat_mem_setup(void)
 
 	set_io_port_base((unsigned long) KSEG1);
 
+	if (fw_arg0 == -2) /* UHI interface */
+		dtb = (void *)fw_arg1;
+	else if (__dtb_start != __dtb_end)
+		dtb = (void *)__dtb_start;
+	else
+		panic("no dtb found");
+
 	/*
-	 * Load the builtin devicetree. This causes the chosen node to be
+	 * Load the devicetree. This causes the chosen node to be
 	 * parsed resulting in our memory appearing
 	 */
-	__dt_setup_arch(__dtb_start);
+	__dt_setup_arch(dtb);
 }
 
 void __init device_tree_init(void)
-- 
2.7.0
