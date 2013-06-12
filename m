Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jun 2013 20:12:06 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4859 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826578Ab3FLSMD4EMUn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Jun 2013 20:12:03 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 12 Jun 2013 11:08:09 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 12 Jun 2013 11:09:13 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 12 Jun 2013 11:09:13 -0700
Received: from dhcp-10-12-153-184.broadcom.com (gregory-irv-00
 [10.12.152.56]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 60BC2F2D73; Wed, 12 Jun 2013 11:09:13 -0700 (PDT)
Received: by dhcp-10-12-153-184.broadcom.com (Postfix, from userid 1000)
 id 276F52E231B; Wed, 12 Jun 2013 11:09:13 -0700 (PDT)
From:   "Gregory Fong" <gregory.0xf0@gmail.com>
To:     linux-mips@linux-mips.org
cc:     "Filippo Arcidiacono" <filippo.arcidiacono@st.com>,
        "Carmelo Amoroso" <carmelo.amoroso@st.com>,
        "Gregory Fong" <gregory.0xf0@gmail.com>
Subject: [PATCH] MIPS: initial stack protector support
Date:   Wed, 12 Jun 2013 11:08:54 -0700
Message-ID: <1371060534-9912-1-git-send-email-gregory.0xf0@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7DA6668331W35398740-05-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <gregory@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregory.0xf0@gmail.com
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

Implements basic stack protector support based on ARM version in
c743f38013aeff58ef6252601e397b5ba281c633 , with Kconfig option,
constant canary value set at boot time, and script to check if
compiler actually supports stack protector.

Tested by creating a kernel module that writes past end of char[].

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 arch/mips/Kconfig                      |   13 +++++++++++
 arch/mips/Makefile                     |    4 ++++
 arch/mips/include/asm/stackprotector.h |   40 ++++++++++++++++++++++++++++++++
 arch/mips/kernel/process.c             |    6 +++++
 4 files changed, 63 insertions(+)
 create mode 100644 arch/mips/include/asm/stackprotector.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7a58ab9..a241588 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2381,6 +2381,19 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config CC_STACKPROTECTOR
+	bool "Enable -fstack-protector buffer overflow detection (EXPERIMENTAL)"
+	help
+	  This option turns on the -fstack-protector GCC feature. This
+	  feature puts, at the beginning of functions, a canary value on
+	  the stack just before the return address, and validates
+	  the value just before actually returning.  Stack based buffer
+	  overflows (that need to overwrite this return address) now also
+	  overwrite the canary, which gets detected and the attack is then
+	  neutralized via a kernel panic.
+
+	  This feature requires gcc version 4.2 or above.
+
 config USE_OF
 	bool
 	select OF
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index dd58a04..37f9ef3 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -227,6 +227,10 @@ KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
 
 LDFLAGS			+= -m $(ld-emul)
 
+ifdef CONFIG_CC_STACKPROTECTOR
+  KBUILD_CFLAGS += -fstack-protector
+endif
+
 ifdef CONFIG_MIPS
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	egrep -vw '__GNUC_(|MINOR_|PATCHLEVEL_)_' | \
diff --git a/arch/mips/include/asm/stackprotector.h b/arch/mips/include/asm/stackprotector.h
new file mode 100644
index 0000000..eb9b103
--- /dev/null
+++ b/arch/mips/include/asm/stackprotector.h
@@ -0,0 +1,40 @@
+/*
+ * GCC stack protector support.
+ *
+ * (This is directly adopted from the ARM implementation)
+ *
+ * Stack protector works by putting predefined pattern at the start of
+ * the stack frame and verifying that it hasn't been overwritten when
+ * returning from the function.  The pattern is called stack canary
+ * and gcc expects it to be defined by a global variable called
+ * "__stack_chk_guard" on MIPS.  This unfortunately means that on SMP
+ * we cannot have a different canary value per task.
+ */
+
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H 1
+
+#include <linux/random.h>
+#include <linux/version.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= LINUX_VERSION_CODE;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index c6a041d..7d62894 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -201,6 +201,12 @@ int dump_task_fpu(struct task_struct *t, elf_fpregset_t *fpr)
 	return 1;
 }
 
+#ifdef CONFIG_CC_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 /*
  *
  */
-- 
1.7.9.5
