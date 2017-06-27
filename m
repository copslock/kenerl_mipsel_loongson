Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 14:51:17 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:47346 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993938AbdF0MvKNSX3I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Jun 2017 14:51:10 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E540596F;
        Tue, 27 Jun 2017 12:51:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Wolf <dev-NTEO@vplace.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 19/26] of: Add check to of_scan_flat_dt() before accessing initial_boot_params
Date:   Tue, 27 Jun 2017 14:49:56 +0200
Message-Id: <20170627124531.558809383@linuxfoundation.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170627124528.581163327@linuxfoundation.org>
References: <20170627124528.581163327@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Wolf <dev-NTEO@vplace.de>

commit 3ec754410cb3e931a6c4920b1a150f21a94a2bf4 upstream.

An empty __dtb_start to __dtb_end section might result in
initial_boot_params being null for arch/mips/ralink. This showed that the
boot process hangs indefinitely in of_scan_flat_dt().

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14605/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/fdt.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -632,9 +632,12 @@ int __init of_scan_flat_dt(int (*it)(uns
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
