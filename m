Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 11:59:37 +0200 (CEST)
Received: from mail-qy0-f192.google.com ([209.85.221.192]:62054 "EHLO
        mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492424Ab0EDJzo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 11:55:44 +0200
Received: by mail-qy0-f192.google.com with SMTP id 30so5119599qyk.16
        for <linux-mips@linux-mips.org>; Tue, 04 May 2010 02:55:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.224.45.29 with SMTP id c29mr4141995qaf.92.1272966943963; Tue, 
        04 May 2010 02:55:43 -0700 (PDT)
Received: by 10.229.212.206 with HTTP; Tue, 4 May 2010 02:55:43 -0700 (PDT)
Date:   Tue, 4 May 2010 17:55:43 +0800
Message-ID: <m2j180e2c241005040255r8e89fd33hd821a0852120ee57@mail.gmail.com>
Subject: [PATCH 11/12] start the panel which is enabled earlier than other 
        panel.
From:   yajin <yajinzhou@vm-kernel.org>
To:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com, vince@simtec.co.uk,
        ben@simtec.co.uk
Content-Type: text/plain; charset=UTF-8
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

SM501 has two panels, one is LCD panel and the other is CRT panel. We
need to start the panel which is enabled earlier than the other panel.

Signed-off-by: yajin <yajin@vm-kernel.org>
---
 drivers/video/sm501fb.c |   42 +++++++++++++++++++++++++++++-------------
 1 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index f2c69ca..c3b717b 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -1895,7 +1895,11 @@ static int __devinit sm501fb_probe(struct
platform_device *pdev)
 {
 	struct sm501fb_info *info;
 	struct device *dev = &pdev->dev;
+	unsigned int panel_enabled, head[2];
+	char *driver_name[2];
+	unsigned long ctrl;
 	int ret;
+	int i;

 	/* allocate our framebuffers */

@@ -1946,23 +1950,37 @@ static int __devinit sm501fb_probe(struct
platform_device *pdev)
 		goto err_probed_panel;
 	}

-	ret = sm501fb_start_one(info, HEAD_CRT, driver_name_crt);
-	if (ret) {
-		dev_err(dev, "failed to start CRT\n");
-		goto err_started;
+	ctrl = readl(info->regs + SM501_DC_PANEL_CONTROL);
+	panel_enabled = (ctrl & SM501_DC_PANEL_CONTROL_EN) ? 1 : 0;
+	if (panel_enabled) {
+		head[0] = HEAD_PANEL;
+		driver_name[0] = driver_name_pnl;
+		head[1] = HEAD_CRT;
+		driver_name[1] = driver_name_crt;
+	} else {
+		head[0] = HEAD_CRT;
+		driver_name[0] = driver_name_crt;
+		head[1] = HEAD_PANEL;
+		driver_name[1] = driver_name_pnl;
 	}

-	ret = sm501fb_start_one(info, HEAD_PANEL, driver_name_pnl);
-	if (ret) {
-		dev_err(dev, "failed to start Panel\n");
-		goto err_started_crt;
+	for (i = 0; i < ARRAY_SIZE(head); i++) {
+		ret = sm501fb_start_one(info, head[i], driver_name[i]);
+		if (ret) {
+			dev_err(dev, "failed to start %s\n", driver_name[i]);
+			if (i == 1) {
+				unregister_framebuffer(info->fb[head[0]]);
+				sm501_free_init_fb(info, head[0]);
+			}
+			goto err_start_one;
+		}
 	}

 	/* create device files */

 	ret = device_create_file(dev, &dev_attr_crt_src);
 	if (ret)
-		goto err_started_panel;
+		goto err_started;

 	ret = device_create_file(dev, &dev_attr_fbregs_pnl);
 	if (ret)
@@ -1981,15 +1999,13 @@ err_attached_pnlregs_file:
 err_attached_crtsrc_file:
 	device_remove_file(dev, &dev_attr_crt_src);

-err_started_panel:
+err_started:
 	unregister_framebuffer(info->fb[HEAD_PANEL]);
 	sm501_free_init_fb(info, HEAD_PANEL);
-
-err_started_crt:
 	unregister_framebuffer(info->fb[HEAD_CRT]);
 	sm501_free_init_fb(info, HEAD_CRT);

-err_started:
+err_start_one:
 	sm501fb_stop(info);

 err_probed_panel:
-- 
1.5.6.5
