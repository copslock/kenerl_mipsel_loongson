Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Dec 2013 17:49:42 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:18600 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832668Ab3LBQtATORj2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Dec 2013 17:49:00 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/3] MIPS: Malta: use generic 8250 early console
Date:   Mon, 2 Dec 2013 16:48:38 +0000
Message-ID: <1386002918-32270-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1386002918-32270-1-git-send-email-paul.burton@imgtec.com>
References: <1386002918-32270-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.152.22]
X-SEF-Processed: 7_3_0_01192__2013_12_02_16_48_53
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38629
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

This patch switches Malta from using the MIPS implementation of early
printk with Malta's prom_putchar to using the generic 8250_early
implementation. This offers a couple of advantages:

  - We duplicate less generic code.

  - The UART can be initialised rather than being reliant upon
    inheriting a valid setup from the bootloader.

The Malta console_config function is extended to initialise the early
console if no earlycon= kernel parameter is provided, inheriting the
modetty0 bootloader environment if present and falling back to a
default 38400n8r setup if not. This matches the behaviour used for the
regular console= parameter.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/Kconfig                   |  1 -
 arch/mips/mti-malta/Makefile        |  2 --
 arch/mips/mti-malta/malta-console.c | 47 ------------------------------
 arch/mips/mti-malta/malta-init.c    | 58 +++++++++++++++++++++----------------
 4 files changed, 33 insertions(+), 75 deletions(-)
 delete mode 100644 arch/mips/mti-malta/malta-console.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 17cc7ff..e1ad78a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -321,7 +321,6 @@ config MIPS_MALTA
 	select SYS_HAS_CPU_MIPS64_R2
 	select SYS_HAS_CPU_NEVADA
 	select SYS_HAS_CPU_RM7000
-	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index 72fdedb..eae0ba3 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -9,7 +9,5 @@ obj-y				:= malta-amon.o malta-display.o malta-init.o \
 				   malta-int.o malta-memory.o malta-platform.o \
 				   malta-reset.o malta-setup.o malta-time.o
 
-obj-$(CONFIG_EARLY_PRINTK)	+= malta-console.o
-
 # FIXME FIXME FIXME
 obj-$(CONFIG_MIPS_MT_SMTC)	+= malta-smtc.o
diff --git a/arch/mips/mti-malta/malta-console.c b/arch/mips/mti-malta/malta-console.c
deleted file mode 100644
index 43bcfb4..0000000
--- a/arch/mips/mti-malta/malta-console.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- *
- *  This program is free software; you can distribute it and/or modify it
- *  under the terms of the GNU General Public License (Version 2) as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope it will be useful, but WITHOUT
- *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- *  for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Putting things on the screen/serial line using YAMONs facilities.
- */
-#include <linux/console.h>
-#include <linux/init.h>
-#include <linux/serial_reg.h>
-#include <asm/io.h>
-
-
-#define PORT(offset) (0x3f8 + (offset))
-
-
-static inline unsigned int serial_in(int offset)
-{
-	return inb(PORT(offset));
-}
-
-static inline void serial_out(int offset, int value)
-{
-	outb(value, PORT(offset));
-}
-
-int prom_putchar(char c)
-{
-	while ((serial_in(UART_LSR) & UART_LSR_THRE) == 0)
-		;
-
-	serial_out(UART_TX, c);
-
-	return 1;
-}
diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
index ff8caff..fcebfce 100644
--- a/arch/mips/mti-malta/malta-init.c
+++ b/arch/mips/mti-malta/malta-init.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/serial_8250.h>
 
 #include <asm/cacheflush.h>
 #include <asm/smp-ops.h>
@@ -44,32 +45,39 @@ static void __init console_config(void)
 	char parity = '\0', bits = '\0', flow = '\0';
 	char *s;
 
-	if ((strstr(fw_getcmdline(), "console=")) == NULL) {
-		s = fw_getenv("modetty0");
-		if (s) {
-			while (*s >= '0' && *s <= '9')
-				baud = baud*10 + *s++ - '0';
-			if (*s == ',')
-				s++;
-			if (*s)
-				parity = *s++;
-			if (*s == ',')
-				s++;
-			if (*s)
-				bits = *s++;
-			if (*s == ',')
-				s++;
-			if (*s == 'h')
-				flow = 'r';
-		}
-		if (baud == 0)
-			baud = 38400;
-		if (parity != 'n' && parity != 'o' && parity != 'e')
-			parity = 'n';
-		if (bits != '7' && bits != '8')
-			bits = '8';
-		if (flow == '\0')
+	s = fw_getenv("modetty0");
+	if (s) {
+		while (*s >= '0' && *s <= '9')
+			baud = baud*10 + *s++ - '0';
+		if (*s == ',')
+			s++;
+		if (*s)
+			parity = *s++;
+		if (*s == ',')
+			s++;
+		if (*s)
+			bits = *s++;
+		if (*s == ',')
+			s++;
+		if (*s == 'h')
 			flow = 'r';
+	}
+	if (baud == 0)
+		baud = 38400;
+	if (parity != 'n' && parity != 'o' && parity != 'e')
+		parity = 'n';
+	if (bits != '7' && bits != '8')
+		bits = '8';
+	if (flow == '\0')
+		flow = 'r';
+
+	if ((strstr(fw_getcmdline(), "earlycon=")) == NULL) {
+		sprintf(console_string, "uart8250,io,0x3f8,%d%c%c", baud,
+			parity, bits);
+		setup_early_serial8250_console(console_string);
+	}
+
+	if ((strstr(fw_getcmdline(), "console=")) == NULL) {
 		sprintf(console_string, " console=ttyS0,%d%c%c%c", baud,
 			parity, bits, flow);
 		strcat(fw_getcmdline(), console_string);
-- 
1.8.4.2
