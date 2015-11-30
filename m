Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:27:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46609 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007213AbbK3Q0OjE3Re (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:26:14 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 8712EC2AD045C;
        Mon, 30 Nov 2015 16:26:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 30 Nov 2015 16:26:08 +0000
Received: from localhost (10.100.200.236) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 30 Nov
 2015 16:26:08 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <rtc-linux@googlegroups.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 16/28] rtc: m41t80: add devicetree probe support
Date:   Mon, 30 Nov 2015 16:21:41 +0000
Message-ID: <1448900513-20856-17-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.236]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Allow the m41t80 RTC driver to be probed via devicetree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/rtc/rtc-m41t80.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index a82937e..d3b29fc 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
@@ -85,6 +86,14 @@ static const struct i2c_device_id m41t80_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, m41t80_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id m41t80_of_match[] = {
+	{ .compatible = "st,m41t81s", .name = "m41t81s" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, m41t80_of_match);
+#endif
+
 struct m41t80_data {
 	u8 features;
 	struct rtc_device *rtc;
@@ -637,6 +646,22 @@ static int m41t80_probe(struct i2c_client *client,
 	struct rtc_device *rtc = NULL;
 	struct rtc_time tm;
 	struct m41t80_data *clientdata = NULL;
+	const struct of_device_id *of_id;
+
+	if (!id && client->dev.of_node) {
+		of_id = of_match_node(of_match_ptr(m41t80_of_match),
+				      client->dev.of_node);
+		for (id = m41t80_id; id->name[0]; id++) {
+			if (strcmp(of_id->name, id->name) == 0)
+				break;
+		}
+		if (!id->name[0])
+			id = NULL;
+	}
+	if (!id) {
+		dev_err(&client->dev, "No i2c_device_id found\n");
+		return -EINVAL;
+	}
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C
 				     | I2C_FUNC_SMBUS_BYTE_DATA))
@@ -728,6 +753,7 @@ static int m41t80_remove(struct i2c_client *client)
 static struct i2c_driver m41t80_driver = {
 	.driver = {
 		.name = "rtc-m41t80",
+		.of_match_table = of_match_ptr(m41t80_of_match),
 	},
 	.probe = m41t80_probe,
 	.remove = m41t80_remove,
-- 
2.6.2
