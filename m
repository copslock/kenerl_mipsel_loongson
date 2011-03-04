Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2011 20:44:03 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11806 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491985Ab1CDTmq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2011 20:42:46 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d7140e80002>; Fri, 04 Mar 2011 11:43:36 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 4 Mar 2011 11:42:42 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 4 Mar 2011 11:42:42 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p24Jga31017331;
        Fri, 4 Mar 2011 11:42:36 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p24JgZt7017330;
        Fri, 4 Mar 2011 11:42:35 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [RFC PATCH v2 02/12] of: Allow scripts/dtc/libfdt to be used from kernel code
Date:   Fri,  4 Mar 2011 11:42:14 -0800
Message-Id: <1299267744-17278-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
References: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 04 Mar 2011 19:42:42.0403 (UTC) FILETIME=[53B4A330:01CBDAA4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 include/linux/libfdt.h      |    3 +++
 lib/Kconfig                 |    6 ++++++
 lib/Makefile                |    2 ++
 lib/libfdt/Makefile         |    7 +++++++
 lib/libfdt/libfdt_env.h     |   21 +++++++++++++++++++++
 scripts/dtc/libfdt/libfdt.h |    4 ++--
 6 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/libfdt.h
 create mode 100644 lib/libfdt/Makefile
 create mode 100644 lib/libfdt/libfdt_env.h

diff --git a/include/linux/libfdt.h b/include/linux/libfdt.h
new file mode 100644
index 0000000..10bce91
--- /dev/null
+++ b/include/linux/libfdt.h
@@ -0,0 +1,3 @@
+#include "../../lib/libfdt/libfdt_env.h"
+#include "../../scripts/dtc/libfdt/fdt.h"
+#include "../../scripts/dtc/libfdt/libfdt.h"
diff --git a/lib/Kconfig b/lib/Kconfig
index 0ee67e0..e8a2638 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -219,4 +219,10 @@ config LRU_CACHE
 config AVERAGE
 	bool
 
+#
+# The Flattened Device Tree manipulation library
+#
+config LIBFDT
+	bool
+
 endmenu
diff --git a/lib/Makefile b/lib/Makefile
index cbb774f..5840115 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -110,6 +110,8 @@ obj-$(CONFIG_ATOMIC64_SELFTEST) += atomic64_test.o
 
 obj-$(CONFIG_AVERAGE) += average.o
 
+obj-$(CONFIG_LIBFDT) += libfdt/
+
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
diff --git a/lib/libfdt/Makefile b/lib/libfdt/Makefile
new file mode 100644
index 0000000..6c1a496
--- /dev/null
+++ b/lib/libfdt/Makefile
@@ -0,0 +1,7 @@
+obj-y = fdt.o fdt_wip.o fdt_ro.o
+
+EXTRA_CFLAGS += -include $(src)/libfdt_env.h -I$(src)/../../scripts/dtc/libfdt
+
+$(obj)/%.o: $(src)/../../scripts/dtc/libfdt/%.c FORCE
+	$(call cmd,force_checksrc)
+	$(call if_changed_rule,cc_o_c)
diff --git a/lib/libfdt/libfdt_env.h b/lib/libfdt/libfdt_env.h
new file mode 100644
index 0000000..d977b8b
--- /dev/null
+++ b/lib/libfdt/libfdt_env.h
@@ -0,0 +1,21 @@
+#ifndef _LIBFDT_ENV_H
+#define _LIBFDT_ENV_H
+
+#include <linux/string.h>
+
+#define _B(n)	((unsigned long long)((uint8_t *)&x)[n])
+static inline uint32_t fdt32_to_cpu(uint32_t x)
+{
+	return (_B(0) << 24) | (_B(1) << 16) | (_B(2) << 8) | _B(3);
+}
+#define cpu_to_fdt32(x) fdt32_to_cpu(x)
+
+static inline uint64_t fdt64_to_cpu(uint64_t x)
+{
+	return (_B(0) << 56) | (_B(1) << 48) | (_B(2) << 40) | (_B(3) << 32)
+		| (_B(4) << 24) | (_B(5) << 16) | (_B(6) << 8) | _B(7);
+}
+#define cpu_to_fdt64(x) fdt64_to_cpu(x)
+#undef _B
+
+#endif /* _LIBFDT_ENV_H */
diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
index ce80e4f..33a0c4d 100644
--- a/scripts/dtc/libfdt/libfdt.h
+++ b/scripts/dtc/libfdt/libfdt.h
@@ -51,8 +51,8 @@
  *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#include <libfdt_env.h>
-#include <fdt.h>
+#include "libfdt_env.h"
+#include "fdt.h"
 
 #define FDT_FIRST_SUPPORTED_VERSION	0x10
 #define FDT_LAST_SUPPORTED_VERSION	0x11
-- 
1.7.2.3
