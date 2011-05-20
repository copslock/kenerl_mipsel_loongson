Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2011 00:26:23 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2104 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491142Ab1ETWZ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2011 00:25:56 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dd6eab10000>; Fri, 20 May 2011 15:26:57 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 20 May 2011 15:25:54 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 20 May 2011 15:25:54 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p4KMPnqn031302;
        Fri, 20 May 2011 15:25:49 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p4KMPmQ8031301;
        Fri, 20 May 2011 15:25:48 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH v4 1/6] of: Allow scripts/dtc/libfdt to be used from kernel code
Date:   Fri, 20 May 2011 15:25:38 -0700
Message-Id: <1305930343-31259-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1305930343-31259-1-git-send-email-ddaney@caviumnetworks.com>
References: <1305930343-31259-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 20 May 2011 22:25:54.0392 (UTC) FILETIME=[E1FE5580:01CC173C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

To use it you need to do this in your Kconfig:

	select LIBFDT

And in the Makefile of the code using libfdt something like:

ccflags-y := -include linux/libfdt_env.h -I$(src)/../../../scripts/dtc/libfdt

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/of/Kconfig          |    3 +++
 drivers/of/Makefile         |    2 ++
 drivers/of/libfdt/Makefile  |    3 +++
 drivers/of/libfdt/fdt.c     |    2 ++
 drivers/of/libfdt/fdt_ro.c  |    2 ++
 drivers/of/libfdt/fdt_wip.c |    2 ++
 include/linux/libfdt.h      |    8 ++++++++
 include/linux/libfdt_env.h  |   13 +++++++++++++
 8 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100644 drivers/of/libfdt/Makefile
 create mode 100644 drivers/of/libfdt/fdt.c
 create mode 100644 drivers/of/libfdt/fdt_ro.c
 create mode 100644 drivers/of/libfdt/fdt_wip.c
 create mode 100644 include/linux/libfdt.h
 create mode 100644 include/linux/libfdt_env.h

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index d06a637..9b0474e 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -4,6 +4,9 @@ config DTC
 config OF
 	bool
 
+config LIBFDT
+	bool
+
 menu "Device Tree and Open Firmware support"
 	depends on OF
 
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index f7861ed..a8dec2f 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_OF_NET)	+= of_net.o
 obj-$(CONFIG_OF_SPI)	+= of_spi.o
 obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
+
+obj-$(CONFIG_LIBFDT) += libfdt/
diff --git a/drivers/of/libfdt/Makefile b/drivers/of/libfdt/Makefile
new file mode 100644
index 0000000..f6bc1c90
--- /dev/null
+++ b/drivers/of/libfdt/Makefile
@@ -0,0 +1,3 @@
+ccflags-y := -I$(src)/../../../scripts/dtc/libfdt
+
+obj-y = fdt.o fdt_wip.o fdt_ro.o
diff --git a/drivers/of/libfdt/fdt.c b/drivers/of/libfdt/fdt.c
new file mode 100644
index 0000000..91495cd
--- /dev/null
+++ b/drivers/of/libfdt/fdt.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../../../scripts/dtc/libfdt/fdt.c"
diff --git a/drivers/of/libfdt/fdt_ro.c b/drivers/of/libfdt/fdt_ro.c
new file mode 100644
index 0000000..547e723
--- /dev/null
+++ b/drivers/of/libfdt/fdt_ro.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../../../scripts/dtc/libfdt/fdt_ro.c"
diff --git a/drivers/of/libfdt/fdt_wip.c b/drivers/of/libfdt/fdt_wip.c
new file mode 100644
index 0000000..bbe19ec
--- /dev/null
+++ b/drivers/of/libfdt/fdt_wip.c
@@ -0,0 +1,2 @@
+#include <linux/libfdt_env.h>
+#include "../../../scripts/dtc/libfdt/fdt_wip.c"
diff --git a/include/linux/libfdt.h b/include/linux/libfdt.h
new file mode 100644
index 0000000..4c0306c
--- /dev/null
+++ b/include/linux/libfdt.h
@@ -0,0 +1,8 @@
+#ifndef _INCLUDE_LIBFDT_H_
+#define _INCLUDE_LIBFDT_H_
+
+#include <linux/libfdt_env.h>
+#include "../../scripts/dtc/libfdt/fdt.h"
+#include "../../scripts/dtc/libfdt/libfdt.h"
+
+#endif /* _INCLUDE_LIBFDT_H_ */
diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
new file mode 100644
index 0000000..01508c7
--- /dev/null
+++ b/include/linux/libfdt_env.h
@@ -0,0 +1,13 @@
+#ifndef _LIBFDT_ENV_H
+#define _LIBFDT_ENV_H
+
+#include <linux/string.h>
+
+#include <asm/byteorder.h>
+
+#define fdt32_to_cpu(x) be32_to_cpu(x)
+#define cpu_to_fdt32(x) cpu_to_be32(x)
+#define fdt64_to_cpu(x) be64_to_cpu(x)
+#define cpu_to_fdt64(x) cpu_to_be64(x)
+
+#endif /* _LIBFDT_ENV_H */
-- 
1.7.2.3
