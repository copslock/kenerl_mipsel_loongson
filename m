Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2014 21:54:34 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:56001 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009457AbaLUUyOfFEpe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2014 21:54:14 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 2E53956F3DA;
        Sun, 21 Dec 2014 22:54:14 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id YgDZgU9rmkEI; Sun, 21 Dec 2014 22:54:07 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 861BF5BC009;
        Sun, 21 Dec 2014 22:54:07 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/5] MIPS: OCTEON: add crypto helper functions
Date:   Sun, 21 Dec 2014 22:53:58 +0200
Message-Id: <1419195242-546-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
References: <1419195242-546-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Add crypto helper functions which are needed for kernel level usage.
The code for these has been extracted from the EdgeRouter Pro GPL tarball.

While at it, also delete duplicate definitions of the functions.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/cavium-octeon/Makefile               |  1 +
 arch/mips/cavium-octeon/crypto/Makefile        |  5 ++
 arch/mips/cavium-octeon/crypto/octeon-crypto.c | 66 ++++++++++++++++++++++++++
 arch/mips/cavium-octeon/crypto/octeon-crypto.h | 17 +++++++
 arch/mips/include/asm/octeon/octeon.h          |  5 --
 5 files changed, 89 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/crypto/Makefile
 create mode 100644 arch/mips/cavium-octeon/crypto/octeon-crypto.c
 create mode 100644 arch/mips/cavium-octeon/crypto/octeon-crypto.h

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 42f5f1a..69a8a8d 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -16,6 +16,7 @@ obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
 obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
 obj-y += executive/
+obj-y += crypto/
 
 obj-$(CONFIG_MTD)		      += flash_setup.o
 obj-$(CONFIG_SMP)		      += smp.o
diff --git a/arch/mips/cavium-octeon/crypto/Makefile b/arch/mips/cavium-octeon/crypto/Makefile
new file mode 100644
index 0000000..739b803
--- /dev/null
+++ b/arch/mips/cavium-octeon/crypto/Makefile
@@ -0,0 +1,5 @@
+#
+# OCTEON-specific crypto modules.
+#
+
+obj-y += octeon-crypto.o
diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.c b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
new file mode 100644
index 0000000..7c82ff4
--- /dev/null
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.c
@@ -0,0 +1,66 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2004-2012 Cavium Networks
+ */
+
+#include <asm/cop2.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+
+#include "octeon-crypto.h"
+
+/**
+ * Enable access to Octeon's COP2 crypto hardware for kernel use. Wrap any
+ * crypto operations in calls to octeon_crypto_enable/disable in order to make
+ * sure the state of COP2 isn't corrupted if userspace is also performing
+ * hardware crypto operations. Allocate the state parameter on the stack.
+ * Preemption must be disabled to prevent context switches.
+ *
+ * @state: Pointer to state structure to store current COP2 state in.
+ *
+ * Returns: Flags to be passed to octeon_crypto_disable()
+ */
+unsigned long octeon_crypto_enable(struct octeon_cop2_state *state)
+{
+	int status;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	status = read_c0_status();
+	write_c0_status(status | ST0_CU2);
+	if (KSTK_STATUS(current) & ST0_CU2) {
+		octeon_cop2_save(&(current->thread.cp2));
+		KSTK_STATUS(current) &= ~ST0_CU2;
+		status &= ~ST0_CU2;
+	} else if (status & ST0_CU2) {
+		octeon_cop2_save(state);
+	}
+	local_irq_restore(flags);
+	return status & ST0_CU2;
+}
+EXPORT_SYMBOL_GPL(octeon_crypto_enable);
+
+/**
+ * Disable access to Octeon's COP2 crypto hardware in the kernel. This must be
+ * called after an octeon_crypto_enable() before any context switch or return to
+ * userspace.
+ *
+ * @state:	Pointer to COP2 state to restore
+ * @flags:	Return value from octeon_crypto_enable()
+ */
+void octeon_crypto_disable(struct octeon_cop2_state *state,
+			   unsigned long crypto_flags)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (crypto_flags & ST0_CU2)
+		octeon_cop2_restore(state);
+	else
+		write_c0_status(read_c0_status() & ~ST0_CU2);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(octeon_crypto_disable);
diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.h b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
new file mode 100644
index 0000000..5ca86d4
--- /dev/null
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
@@ -0,0 +1,17 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012-2013 Cavium Inc., All Rights Reserved.
+ */
+#ifndef __LINUX_OCTEON_CRYPTO_H
+#define __LINUX_OCTEON_CRYPTO_H
+
+#include <linux/sched.h>
+
+extern unsigned long octeon_crypto_enable(struct octeon_cop2_state *state);
+extern void octeon_crypto_disable(struct octeon_cop2_state *state,
+				  unsigned long flags);
+
+#endif /* __LINUX_OCTEON_CRYPTO_H */
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index d781f9e..6dfefd2 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -44,11 +44,6 @@ extern int octeon_get_boot_num_arguments(void);
 extern const char *octeon_get_boot_argument(int arg);
 extern void octeon_hal_setup_reserved32(void);
 extern void octeon_user_io_init(void);
-struct octeon_cop2_state;
-extern unsigned long octeon_crypto_enable(struct octeon_cop2_state *state);
-extern void octeon_crypto_disable(struct octeon_cop2_state *state,
-				  unsigned long flags);
-extern asmlinkage void octeon_cop2_restore(struct octeon_cop2_state *task);
 
 extern void octeon_init_cvmcount(void);
 extern void octeon_setup_delays(void);
-- 
2.2.0
