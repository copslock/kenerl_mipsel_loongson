Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 05:05:07 +0200 (CEST)
Received: from mga06.intel.com ([134.134.136.31]:33397 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994552AbeHCDELqRbAH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Aug 2018 05:04:11 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:04:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="61696583"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga007.jf.intel.com with ESMTP; 02 Aug 2018 20:04:03 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 08/18] serial: intel: Get serial id from dts
Date:   Fri,  3 Aug 2018 11:02:27 +0800
Message-Id: <20180803030237.3366-9-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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

Get serial id from dts.

"#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
macro is defined in lantiq_soc.h.
lantiq_soc.h is in arch path for legacy product support.

arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h

If "#ifdef preprocessor" is changed to
"if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
code using LTQ_EARLY_ASC is compiled.
Compilation will fail for no LTQ_EARLY_ASC defined.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2: None

 drivers/tty/serial/lantiq.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 044128277248..836ca51460f2 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2007 Felix Fietkau <nbd@openwrt.org>
  * Copyright (C) 2007 John Crispin <john@phrozen.org>
  * Copyright (C) 2010 Thomas Langer, <thomas.langer@lantiq.com>
+ * Copyright (C) 2018 Intel Corporation.
  */
 
 #include <linux/slab.h>
@@ -688,7 +689,7 @@ lqasc_probe(struct platform_device *pdev)
 	struct ltq_uart_port *ltq_port;
 	struct uart_port *port;
 	struct resource *mmres, irqres[3];
-	int line = 0;
+	int line;
 	int ret;
 
 	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -699,9 +700,19 @@ lqasc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* check if this is the console port */
-	if (mmres->start != CPHYSADDR(LTQ_EARLY_ASC))
-		line = 1;
+	/* get serial id */
+	line = of_alias_get_id(node, "serial");
+	if (line < 0) {
+#ifdef CONFIG_LANTIQ
+		if (mmres->start == CPHYSADDR(LTQ_EARLY_ASC))
+			line = 0;
+		else
+			line = 1;
+#else
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", line);
+		return line;
+#endif
+	}
 
 	if (lqasc_port[line]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", line);
-- 
2.11.0
