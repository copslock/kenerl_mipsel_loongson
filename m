Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 17:54:02 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:55641 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993977AbdF1PxQUseB8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 17:53:16 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 95CF71A47F3;
        Wed, 28 Jun 2017 17:53:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 3F3221A47F1;
        Wed, 28 Jun 2017 17:53:09 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Douglas Leung <douglas.leung@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>, linux-kernel@vger.kernel.org,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 08/10] MIPS: Introduce check_legacy_ioport() interface
Date:   Wed, 28 Jun 2017 17:47:01 +0200
Message-Id: <1498664922-28493-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58868
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

Some drivers may try to probe some I/O ports which can lead to kernel
panic if the device is not present and mapped. This function should be
used to check for existence of such devices and return 0 for MIPS
boards which implement them, otherwise it should return -ENODEV and
the affected device driver should never try to read/write the
requested I/O port.

This is particularly useful for multiplaform kernels which are board
agnostic and this interface can be used to match drivers against
available devices on a specific board in runtime.

This patch just adds a no-op check_legacy_ioport() function which will
be enriched with logic in a later patch.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 arch/mips/include/asm/io.h |  5 +++++
 arch/mips/kernel/setup.c   | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index ecabc00..62b9f89 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -78,6 +78,11 @@ static inline void set_io_port_base(unsigned long base)
 }
 
 /*
+ * Check for existence of legacy devices
+ */
+extern int check_legacy_ioport(unsigned long base_port);
+
+/*
  * Thanks to James van Artsdalen for a better timing-fix than
  * the two short jumps: using outb's to a nonexistent port seems
  * to guarantee better timings even on fast machines.
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 01d1dbd..c22cde8 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -78,6 +78,31 @@ static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
 const unsigned long mips_io_port_base = -1;
 EXPORT_SYMBOL(mips_io_port_base);
 
+/*
+ * Check for existence of legacy devices
+ *
+ * Some drivers may try to probe some I/O ports which can lead to
+ * kernel panic if the device is not present and mapped. This method
+ * should check for existence of such devices and return 0 for MIPS
+ * boards which actually have them, otherwise it will return -ENODEV
+ * and the affected device driver should never try to read/write the
+ * requested I/O port.
+ */
+int check_legacy_ioport(unsigned long base_port)
+{
+	int ret = 0;
+
+	switch (base_port) {
+	default:
+		/* We will assume that the I/O device port exists if
+		 * not explicitly added to the blacklist match table
+		 */
+		break;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(check_legacy_ioport);
+
 static struct resource code_resource = { .name = "Kernel code", };
 static struct resource data_resource = { .name = "Kernel data", };
 
-- 
2.7.4
