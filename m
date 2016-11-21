Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2016 17:23:39 +0100 (CET)
Received: from h1.direct-netware.de ([5.45.107.14]:53153 "EHLO
        h1.direct-netware.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993010AbcKUQXG5oABv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2016 17:23:06 +0100
Received: from odin.home.local (p54B048AB.dip0.t-ipconnect.de [84.176.72.171])
        by h1.direct-netware.de (Postfix) with ESMTPA id 655A9FFD62
        for <linux-mips@linux-mips.org>; Mon, 21 Nov 2016 17:23:01 +0100 (CET)
Received: from loki.localnet (unknown [172.16.255.1])
        by odin.home.local (Postfix) with ESMTPSA id 0649D62C774
        for <linux-mips@linux-mips.org>; Mon, 21 Nov 2016 17:22:56 +0100 (CET)
From:   Tobias Wolf <t.wolf@vplace.de>
To:     linux-mips@linux-mips.org
Subject: [PATCH 1/2] ralink: Introduce fw_passed_dtb to arch/mips/ralink
Date:   Mon, 21 Nov 2016 17:22:55 +0100
Message-ID: <3474561.VuB59jlCmQ@loki>
User-Agent: KMail/5.3.3 (Linux/4.8.8-2-ARCH; KDE/5.28.0; x86_64; ; )
In-Reply-To: <3700342.djbc9u0nWG@loki>
References: <3700342.djbc9u0nWG@loki>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <t.wolf@vplace.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: t.wolf@vplace.de
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
+	void *dtb;
+
 	set_io_port_base(KSEG1);
 
 	/*
 	 * Load the builtin devicetree. This causes the chosen node to be
 	 * parsed resulting in our memory appearing
 	 */
-	__dt_setup_arch(__dtb_start);
+	if (fw_passed_dtb) /* used by CONFIG_MIPS_APPENDED_RAW_DTB as well */
+		dtb = (void *)fw_passed_dtb;
+	else if (__dtb_start != __dtb_end)
+		dtb = (void *)__dtb_start;
+
+	if (dtb)
+		__dt_setup_arch(dtb);
 
 	of_scan_flat_dt(early_init_dt_find_memory, NULL);
 	if (memory_dtb)
