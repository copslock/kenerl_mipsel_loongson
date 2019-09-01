Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6BDC3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4B521872
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfIAQMP (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:12:15 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:58630 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIAQMP (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:12:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 70D1D3F752
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:12:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YtAymFzjaPTx for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:12:12 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id C1A913F73E
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:12:12 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:12:12 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 072/120] MIPS: PS2: IOP: SIF printk command support
Message-ID: <53102a0102944d3c118f5cfc8cda3210284f59d6.1567326213.git.noring@nocrew.org>
References: <cover.1567326213.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567326213.git.noring@nocrew.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Allow IOP modules to print kernel messages, with kernel log levels. This
greatly simplifies debugging of subsequent IOP modules.

IOP messages are prefixed with "iop: " in the kernel log.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 drivers/ps2/iop-module.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/ps2/iop-module.c b/drivers/ps2/iop-module.c
index bb4814b5d3c4..18020b3673d3 100644
--- a/drivers/ps2/iop-module.c
+++ b/drivers/ps2/iop-module.c
@@ -892,6 +892,30 @@ int iop_module_request(const char *name, int version, const char *arg)
 }
 EXPORT_SYMBOL_GPL(iop_module_request);
 
+/**
+ * cmd_printk - IOP module kernel log printk command
+ * @header: SIF command header
+ * @void: message to print
+ * @arg: optional argument to sif_request_cmd, set to %NULL
+ *
+ * The command allows IOP modules to print kernel messages, with kernel log
+ * levels. This greatly simplifies debugging of subsequent IOP modules. IOP
+ * messages are prefixed with "iop: " in the kernel log.
+ */
+static void cmd_printk(const struct sif_cmd_header *header,
+	const void *data, void *arg)
+{
+	const char *msg = data;
+
+	if (msg[0] == KERN_SOH[0]) {
+		const char fmt[] = { msg[0], msg[1],
+			'i', 'o', 'p', ':', ' ', '%', 's', '\0' };
+
+		printk(fmt, &msg[2]);
+	} else
+		printk("iop: %s", msg);
+}
+
 static int __init iop_module_init(void)
 {
 	int err;
@@ -902,6 +926,12 @@ static int __init iop_module_init(void)
 		return -ENOMEM;
 	}
 
+	err = sif_request_cmd(SIF_CMD_PRINTK, cmd_printk, NULL);
+	if (err < 0) {
+		pr_err("iop-module: Failed request printk cmd with %d\n", err);
+		goto err_printk;
+	}
+
 	err = sif_rpc_bind(&load_file_rpc_client, SIF_SID_LOAD_MODULE);
 	if (err < 0) {
 		pr_err("iop-module: Failed to bind load module with %d\n", err);
@@ -910,6 +940,7 @@ static int __init iop_module_init(void)
 
 	return 0;
 
+err_printk:
 err_bind:
 	root_device_unregister(iop_module_device);
 
-- 
2.21.0

