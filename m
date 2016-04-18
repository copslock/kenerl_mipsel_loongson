Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 16:25:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3743 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007834AbcDROZNLz2No (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 16:25:13 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id AE016700F8B5D;
        Mon, 18 Apr 2016 15:25:03 +0100 (IST)
Received: from leopard.hh.imgtec.org (192.168.167.31) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 18 Apr 2016 15:25:06 +0100
From:   James Hartley <james.hartley@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Jonas Gorski <jogo@openwrt.org>,
        James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>
Subject: [PATCH] mips: pistachio: Determine SoC revision during boot
Date:   Mon, 18 Apr 2016 15:24:49 +0100
Message-ID: <1460989489-30469-1-git-send-email-james.hartley@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.31]
Return-Path: <James.Hartley@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hartley@imgtec.com
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

Now that there are different revisions of the Pistachio SoC
in circulation, add this information to the boot log to make
it easier for users to determine which hardware they have.

Signed-off-by: James Hartley <james.hartley@imgtec.com>
Signed-off-by: Ionela Voinescu <ionela.voinescu@imgtec.com>

diff --git a/arch/mips/pistachio/init.c b/arch/mips/pistachio/init.c
index 96ba2cc..48f8755 100644
--- a/arch/mips/pistachio/init.c
+++ b/arch/mips/pistachio/init.c
@@ -2,6 +2,7 @@
  * Pistachio platform setup
  *
  * Copyright (C) 2014 Google, Inc.
+ * Copyright (C) 2016 Imagination Technologies
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -9,6 +10,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
@@ -24,9 +26,28 @@
 #include <asm/smp-ops.h>
 #include <asm/traps.h>
 
+/*
+ * Core revision register decoding
+ * Bits 23 to 20: Major rev
+ * Bits 15 to 8: Minor rev
+ * Bits 7 to 0: Maintenance rev
+ */
+#define PISTACHIO_CORE_REV_REG	0xB81483D0
+#define PISTACHIO_CORE_REV_A1	0x00100006
+#define PISTACHIO_CORE_REV_B0	0x00100106
+
 const char *get_system_type(void)
 {
-	return "IMG Pistachio SoC";
+	u32 core_rev;
+
+	core_rev = __raw_readl((const void *)PISTACHIO_CORE_REV_REG);
+
+	if (core_rev == PISTACHIO_CORE_REV_B0)
+		return "IMG Pistachio SoC (B0)";
+	else if (core_rev == PISTACHIO_CORE_REV_A1)
+		return "IMG_Pistachio SoC (A1)";
+	else
+		return "IMG_Pistachio SoC";
 }
 
 static void __init plat_setup_iocoherency(void)
@@ -109,6 +130,8 @@ void __init prom_init(void)
 	mips_cm_probe();
 	mips_cpc_probe();
 	register_cps_smp_ops();
+
+	pr_info("SoC Type: %s\n", get_system_type());
 }
 
 void __init prom_free_prom_memory(void)
-- 
2.5.0
