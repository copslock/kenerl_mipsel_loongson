Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 10:40:16 +0100 (CET)
Received: from h1.direct-netware.de ([5.45.107.14]:55640 "EHLO
        h1.direct-netware.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990864AbcKWJkJckIM9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 10:40:09 +0100
Received: from odin.home.local (p54B04C52.dip0.t-ipconnect.de [84.176.76.82])
        by h1.direct-netware.de (Postfix) with ESMTPA id 0F13FFF866;
        Wed, 23 Nov 2016 10:40:09 +0100 (CET)
Received: from loki.localnet (unknown [172.16.255.1])
        by odin.home.local (Postfix) with ESMTPSA id 28D6863B4C8;
        Wed, 23 Nov 2016 10:40:08 +0100 (CET)
From:   Tobias Wolf <dev-NTEO@vplace.de>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 2/2 v3] of: Add check to of_scan_flat_dt() before accessing initial_boot_params
Date:   Wed, 23 Nov 2016 10:40:07 +0100
Message-ID: <14509742.WUbz5chXyR@loki>
User-Agent: KMail/5.3.3 (Linux/4.8.8-2-ARCH; KDE/5.28.0; x86_64; ; )
In-Reply-To: <d6072e00-1ca4-d461-e15d-3b7b92a7b998@cogentembedded.com>
References: <3700342.djbc9u0nWG@loki> <6667110.cBpoIbUc5V@loki> <d6072e00-1ca4-d461-e15d-3b7b92a7b998@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <dev-NTEO@vplace.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55867
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

An empty __dtb_start to __dtb_end section might result in initial_boot_params 
being null for arch/mips/ralink. This showed that the boot process hangs 
indefinitely in of_scan_flat_dt().

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
---
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -738,9 +738,12 @@
 	const char *pathp;
 	int offset, rc = 0, depth = -1;
 
-        for (offset = fdt_next_node(blob, -1, &depth);
-             offset >= 0 && depth >= 0 && !rc;
-             offset = fdt_next_node(blob, offset, &depth)) {
+	if (!blob)
+		return 0;
+
+	for (offset = fdt_next_node(blob, -1, &depth);
+	     offset >= 0 && depth >= 0 && !rc;
+	     offset = fdt_next_node(blob, offset, &depth)) {
 
 		pathp = fdt_get_name(blob, offset, NULL);
 		if (*pathp == '/')

Dear Sergei,

Missed that warning completely during compilation of a testable image for my 
device. I regenerated the patch based on your input (for 4.9-rc6 this time) 
and based the check on the local blob variable this time.

Haven't seen any warnings this time.

Hope it's correct that I reference the new patch version each time in the 
subject line.

Best regards
Tobias

Btw.: Last e-mail I wanted to list occurrences EINVAL would break existing 
code. One is kernel/prom.c in arch/microblaze.
