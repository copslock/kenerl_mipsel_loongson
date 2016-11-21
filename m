Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2016 17:24:07 +0100 (CET)
Received: from h1.direct-netware.de ([5.45.107.14]:53153 "EHLO
        h1.direct-netware.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993015AbcKUQXHHM86v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2016 17:23:07 +0100
Received: from odin.home.local (p54B048AB.dip0.t-ipconnect.de [84.176.72.171])
        by h1.direct-netware.de (Postfix) with ESMTPA id 85964FFE9E
        for <linux-mips@linux-mips.org>; Mon, 21 Nov 2016 17:23:04 +0100 (CET)
Received: from loki.localnet (unknown [172.16.255.1])
        by odin.home.local (Postfix) with ESMTPSA id 44B5B62C77A
        for <linux-mips@linux-mips.org>; Mon, 21 Nov 2016 17:23:04 +0100 (CET)
From:   Tobias Wolf <t.wolf@vplace.de>
To:     linux-mips@linux-mips.org
Subject: [PATCH 2/2] of: Add check to of_scan_flat_dt() before accessing initial_boot_params
Date:   Mon, 21 Nov 2016 17:23:03 +0100
Message-ID: <2281020.GC1GkRyGht@loki>
User-Agent: KMail/5.3.3 (Linux/4.8.8-2-ARCH; KDE/5.28.0; x86_64; ; )
In-Reply-To: <2966402.rBqcQZDeOh@loki>
References: <3700342.djbc9u0nWG@loki> <2966402.rBqcQZDeOh@loki>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <t.wolf@vplace.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55841
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

An empty __dtb_start to __dtb_end section might result in initial_boot_params 
being null for arch/mips/ralink. This showed that the boot process hangs 
indefinitely in of_scan_flat_dt().

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
---
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -628,6 +628,9 @@
 				     void *data),
 			   void *data)
 {
+	if (!initial_boot_params)
+		return;
+
 	const void *blob = initial_boot_params;
 	const char *pathp;
 	int offset, rc = 0, depth = -1;
