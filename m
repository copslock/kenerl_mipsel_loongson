Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 17:40:33 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:52138 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993983AbdF1PgthrqG8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 17:36:49 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 8B7501A47E0
        for <linux-mips@linux-mips.org>; Wed, 28 Jun 2017 17:36:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 5AEB41A47EC
        for <linux-mips@linux-mips.org>; Wed, 28 Jun 2017 17:36:38 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH v2 09/10] MIPS: i8042: Probe this device only if it exists
Date:   Wed, 28 Jun 2017 17:36:26 +0200
Message-Id: <1498664187-27995-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498664187-27995-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498664187-27995-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58859
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

ARCH_MIGHT_HAVE_PC_SERIO is selected by default for MIPS platforms.
As a consequence SERIO_I8042 would be automatically selected for any
MIPS board which wants to enable input support like keyboard
(INPUT_KEYBOARD) regardless of i8042 controller existence.

The dependency is as follows :

config ARCH_MIGHT_HAVE_PC_SERIO [=y]
    Defined at drivers/input/serio/Kconfig:19
    Depends on: !UML
    Selected by: MIPS [=y]

config SERIO
    Defined at drivers/input/serio/Kconfig:4
    default y
    Depends on: !UML
    Selected by: KEYBOARD_ATKBD [=y] && !UML && INPUT [=y] &&
                 INPUT_KEYBOARD [=y]

config SERIO_I8042
    Defined at drivers/input/serio/Kconfig:28
    tristate "i8042 PC Keyboard controller"
    default y
    Depends on: !UML && SERIO [=y] && ARCH_MIGHT_HAVE_PC_SERIO [=y]
    Selected by: KEYBOARD_ATKBD [=y] && !UML && INPUT [=y] &&
                 INPUT_KEYBOARD [=y] && ARCH_MIGHT_HAVE_PC_SERIO [=y]

If this driver probes the I8042_DATA_REG not knowing if the device
exists it can cause a kernel to crash. Using check_legacy_ioport()
interface we can selectively enable this driver only for the MIPS
boards which actually have the i8042 controller.

New "Ranchu" virtual platform does not support i8042 controller
so it's added to the blacklist match table.

Each MIPS machine should update this table with it's compatible strings
if it does not support i8042 controller.

In order to utilize this mechanism, each MIPS machine that do not
have i8042 controller should update the blacklist table with its
compatible strings.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/kernel/setup.c       | 16 ++++++++++++++++
 drivers/input/serio/i8042-io.h |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c22cde8..c3e0d2b 100644
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
@@ -90,9 +99,16 @@ EXPORT_SYMBOL(mips_io_port_base);
  */
 int check_legacy_ioport(unsigned long base_port)
 {
+	struct device_node *np;
 	int ret = 0;
 
 	switch (base_port) {
+	case I8042_DATA_REG:
+		np = of_find_matching_node(NULL, i8042_blacklist_of_match);
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
