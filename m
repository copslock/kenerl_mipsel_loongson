Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 01:52:03 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:48551 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007132AbaKZAvcq1f-x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 01:51:32 +0100
Received: by mail-pd0-f181.google.com with SMTP id z10so1649750pdj.12
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 16:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CfjnIm90dWMFgsyvnVommghu0mkWg3ixdFU3df3nT48=;
        b=e+7i6e/3wa0Kq2QSoG/bKTKmfaIr7MDVF9wPVfvpfOIcTqx54Da0L+B4Bm+O62OiCD
         p4eEv5iUPH7KVbKrNdqaJK1ONzvWNE0ZEoHMoMurYOHjY6W9bV4CMszDpgi72D4Yn6rh
         RLmfixP3co0Fdbu0zlLOvwPK4u+M/BjneU+Izf0EH3Ye87QFGQtvlbuOoS5mOxFlQGty
         P51YoBuFj2VuFYAd/B9npTAI+hS7VDPLKp1Vhui2JH4tsjptYETJnsFISHCiC41lOZWB
         Xq+TOxMTbSimynunm6gbCvGRrzL8o1+2evSLo9KXwUiNpIBZOvcRI7QJYZBULY/saJ0Z
         0fxw==
X-Received: by 10.68.255.195 with SMTP id as3mr48840636pbd.38.1416963087150;
        Tue, 25 Nov 2014 16:51:27 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id bj11sm2614439pdb.1.2014.11.25.16.51.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:51:26 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org,
        arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 2/9] power/reset: brcmstb: Use the DT "compatible" string to indicate bit positions
Date:   Tue, 25 Nov 2014 16:49:47 -0800
Message-Id: <1416962994-27095-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Some of the older chips used different bits to arm and trigger the reset.
Add the infrastructure needed to specify this through the "compatible"
string.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/power/reset/brcmstb-reboot.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 3306241..4e61c3f 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -11,6 +11,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -34,13 +35,20 @@ static struct regmap *regmap;
 static u32 rst_src_en;
 static u32 sw_mstr_rst;
 
+struct reset_reg_mask {
+	u32 rst_src_en_mask;
+	u32 sw_mstr_rst_mask;
+};
+
+static const struct reset_reg_mask *reset_masks;
+
 static int brcmstb_restart_handler(struct notifier_block *this,
 				   unsigned long mode, void *cmd)
 {
 	int rc;
 	u32 tmp;
 
-	rc = regmap_write(regmap, rst_src_en, 1);
+	rc = regmap_write(regmap, rst_src_en, reset_masks->rst_src_en_mask);
 	if (rc) {
 		pr_err("failed to write rst_src_en (%d)\n", rc);
 		return NOTIFY_DONE;
@@ -52,7 +60,7 @@ static int brcmstb_restart_handler(struct notifier_block *this,
 		return NOTIFY_DONE;
 	}
 
-	rc = regmap_write(regmap, sw_mstr_rst, 1);
+	rc = regmap_write(regmap, sw_mstr_rst, reset_masks->sw_mstr_rst_mask);
 	if (rc) {
 		pr_err("failed to write sw_mstr_rst (%d)\n", rc);
 		return NOTIFY_DONE;
@@ -75,10 +83,28 @@ static struct notifier_block brcmstb_restart_nb = {
 	.priority = 128,
 };
 
+static const struct reset_reg_mask reset_bits_40nm = {
+	.rst_src_en_mask = BIT(0),
+	.sw_mstr_rst_mask = BIT(0),
+};
+
+static const struct of_device_id of_match[] = {
+	{ .compatible = "brcm,brcmstb-reboot", .data = &reset_bits_40nm },
+	{},
+};
+
 static int brcmstb_reboot_probe(struct platform_device *pdev)
 {
 	int rc;
 	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+
+	of_id = of_match_node(of_match, np);
+	if (!of_id) {
+		pr_err("failed to look up compatible string\n");
+		return -EINVAL;
+	}
+	reset_masks = of_id->data;
 
 	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
 	if (IS_ERR(regmap)) {
@@ -108,11 +134,6 @@ static int brcmstb_reboot_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id of_match[] = {
-	{ .compatible = "brcm,brcmstb-reboot", },
-	{},
-};
-
 static struct platform_driver brcmstb_reboot_driver = {
 	.probe = brcmstb_reboot_probe,
 	.driver = {
-- 
2.1.0
