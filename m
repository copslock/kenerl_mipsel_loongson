Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 11:46:55 +0100 (CET)
Received: from h1.direct-netware.de ([5.45.107.14]:34785 "EHLO
        h1.direct-netware.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992183AbcLMKqrox8qS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Dec 2016 11:46:47 +0100
Received: from odin.localnet (p54B042F4.dip0.t-ipconnect.de [84.176.66.244])
        by h1.direct-netware.de (Postfix) with ESMTPA id 81892FF958
        for <linux-mips@linux-mips.org>; Tue, 13 Dec 2016 11:46:47 +0100 (CET)
Received: from loki.localnet (unknown [172.16.255.8])
        by odin.localnet (Postfix) with ESMTPSA id 1B23167E43
        for <linux-mips@linux-mips.org>; Tue, 13 Dec 2016 11:46:46 +0100 (CET)
From:   Tobias Wolf <dev-NTEO@vplace.de>
To:     linux-mips@linux-mips.org
Subject: [PATCH 1/2 v2] ralink: Introduce fw_passed_dtb to arch/mips/ralink
Date:   Tue, 13 Dec 2016 11:46:41 +0100
Message-ID: <1602859.QGKdh4otrC@loki>
User-Agent: KMail/5.3.3 (Linux/4.8.12-3-ARCH; KDE/5.28.0; x86_64; ; )
In-Reply-To: <3700342.djbc9u0nWG@loki>
References: <3700342.djbc9u0nWG@loki>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <dev-NTEO@vplace.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev-NTEO@vplace.de
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

This patch adds fw_passed_dtb to arch/mips/ralink to support 
CONFIG_MIPS_RAW_APPENDED_DTB. Furthermore it adds a check that __dtb_start is 
not the same address as __dtb_end.

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
---
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -66,13 +66,21 @@
 
 void __init plat_mem_setup(void)
 {
+	void *dtb = NULL;
+
 	set_io_port_base(KSEG1);
 
 	/*
 	 * Load the builtin devicetree. This causes the chosen node to be
-	 * parsed resulting in our memory appearing
+	 * parsed resulting in our memory appearing. fw_passed_dtb is used
+	 * by CONFIG_MIPS_APPENDED_RAW_DTB as well.
 	 */
-	__dt_setup_arch(__dtb_start);
+	if (fw_passed_dtb)
+		dtb = (void *)fw_passed_dtb;
+	else if (__dtb_start != __dtb_end)
+		dtb = (void *)__dtb_start;
+
+	__dt_setup_arch(dtb);
 
 	of_scan_flat_dt(early_init_dt_find_memory, NULL);
 	if (memory_dtb)

---
This version has been cleaned up based on feedback [1] of John Crispin for the 
LEDE Project.

[1] https://github.com/lede-project/source/pull/582#discussion_r90778573

Best regards
Tobias
