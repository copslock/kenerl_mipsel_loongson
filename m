Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2012 16:43:02 +0200 (CEST)
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:4626 "EHLO
        smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903611Ab2C3Om4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2012 16:42:56 +0200
Received: from starbug-2.trinair2002 (dhcp-089-098-069-120.chello.nl [89.98.69.120])
        (authenticated bits=0)
        by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id q2UEgY7I036066;
        Fri, 30 Mar 2012 16:42:34 +0200 (CEST)
        (envelope-from maarten@treewalker.org)
Received: from hyperion.trinair2002 (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.trinair2002 (Postfix) with ESMTP id 08CA83DF2B;
        Fri, 30 Mar 2012 16:42:34 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org,
        =?UTF-8?q?Llu=C3=ADs=20Batlle=20i=20Rossell?= <viric@viric.name>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH] MIPS: Enable vmlinuz for JZ4740
Date:   Fri, 30 Mar 2012 16:48:05 +0200
Message-Id: <1333118885-17269-1-git-send-email-maarten@treewalker.org>
X-Mailer: git-send-email 1.7.7
In-Reply-To: <2122560.hRnRRue4n0@hyperion>
References: <2122560.hRnRRue4n0@hyperion>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by XS4ALL Virus Scanner
X-archive-position: 32831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Lluís Batlle i Rossell <viric@viric.name>

This patch adds support for building a compressed kernel for the JZ4740
architecture.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/Kconfig                      |    1 +
 arch/mips/boot/compressed/Makefile     |    4 ++++
 arch/mips/boot/compressed/uart-16550.c |    5 +++++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9f78fbe..03dd163 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -213,6 +213,7 @@ config MACH_JZ4740
 	select HAVE_CLK
 	select GENERIC_IRQ_CHIP
 	select CPU_SUPPORTS_CPUFREQ
+	select SYS_SUPPORTS_ZBOOT_UART16550
 
 config LANTIQ
 	bool "Lantiq based platforms"
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 5042d51..c2a3fb0 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -58,8 +58,12 @@ $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
 # Calculate the load address of the compressed kernel image
 hostprogs-y := calc_vmlinuz_load_addr
 
+ifeq ($(CONFIG_MACH_JZ4740),y)
+VMLINUZ_LOAD_ADDRESS := 0x80600000
+else
 VMLINUZ_LOAD_ADDRESS = $(shell $(obj)/calc_vmlinuz_load_addr \
 		$(obj)/vmlinux.bin $(VMLINUX_LOAD_ADDRESS))
+endif
 
 vmlinuzobjs-y += $(obj)/piggy.o
 
diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index c9caaf4..1c7b739 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -18,6 +18,11 @@
 #define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
 #endif
 
+#ifdef CONFIG_MACH_JZ4740
+#define UART0_BASE  0xB0030000
+#define PORT(offset) (UART0_BASE + (4 * offset))
+#endif
+
 #ifndef PORT
 #error please define the serial port address for your own machine
 #endif
-- 
1.7.7
