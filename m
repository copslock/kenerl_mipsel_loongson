Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:52:30 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58806 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993301AbdFSPt5i889H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:49:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 157751A46EF;
        Mon, 19 Jun 2017 17:49:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id EA7D41A472F;
        Mon, 19 Jun 2017 17:49:46 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 09/10] MIPS: i8042: Probe this device only if it exists
Date:   Mon, 19 Jun 2017 17:49:39 +0200
Message-Id: <1497887380-13718-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

This driver is enabled by default for all MIPS platforms
including the MIPS_GENERIC multiplaform kernel.

If this driver probes the I8042_DATA_REG not knowing if
the device exists it can cause a kernel to crash.
Using check_legacy_ioport() interface we can selectively
enable this driver only for the MIPS boards which actually
have the i8042 controller.

New "Ranchu" virtual platform does not support i8042 controller
so it's added to the blacklist match table.

Each MIPS machine should update this table with it's compatible strings
if it does not support i8042 controller.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/kernel/setup.c       | 18 ++++++++++++++++++
 drivers/input/serio/i8042-io.h |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c22cde8..ccea90f 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -79,6 +79,15 @@ const unsigned long mips_io_port_base = -1;
 EXPORT_SYMBOL(mips_io_port_base);
 
 /*
+ * Here we blacklist all MIPS boards which do not have i8042 controller
+ */
+static const struct of_device_id i8042_blacklist_of_match[] = {
+	{ .compatible = "mti,ranchu", },
+	{},
+};
+#define I8042_DATA_REG	0x60
+
+/*
  * Check for existence of legacy devices
  *
  * Some drivers may try to probe some I/O ports which can lead to
@@ -90,9 +99,18 @@ EXPORT_SYMBOL(mips_io_port_base);
  */
 int check_legacy_ioport(unsigned long base_port)
 {
+	const struct of_device_id *match;
+	struct device_node *np;
 	int ret = 0;
 
 	switch (base_port) {
+	case I8042_DATA_REG:
+		np = of_find_matching_node_and_match(NULL,
+			i8042_blacklist_of_match, &match);
+		if (np)
+			ret = -ENODEV;
+		of_node_put(np);
+		break;
 	default:
 		/* We will assume that the I/O device port exists if
 		 * not explicitly added to the blacklist match table
diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index 34da81c..ec5fe9e 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -72,7 +72,7 @@ static inline int i8042_platform_init(void)
  * On some platforms touching the i8042 data register region can do really
  * bad things. Because of this the region is always reserved on such boxes.
  */
-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PPC) || defined(CONFIG_MIPS)
 	if (check_legacy_ioport(I8042_DATA_REG))
 		return -ENODEV;
 #endif
-- 
2.7.4
