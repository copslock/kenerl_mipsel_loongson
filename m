Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 16:33:29 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:13244 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1123891AbSJAOd1>; Tue, 1 Oct 2002 16:33:27 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA16649;
	Tue, 1 Oct 2002 16:33:53 +0200 (MET DST)
Date: Tue, 1 Oct 2002 16:33:53 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: [patch] A recent prom_printf() breakage
Message-ID: <Pine.GSO.3.96.1021001162700.13606I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Ralf,

 I don't think it is a good idea to force everyone to use a common
prom_printf() workaround for firmware limitations.  DECstations, for
example, already have a suitable function in their ROMs, which we use, and
the new prom_printf() implementation clashes with it.  Also the current
implementation relies on a presence of prom_putchar().  Therefore I
suggest the following change -- I enabled CONFIG_PROM_PRINTF for systems
that seem to provide prom_putchar() -- if there are any others, I see no
problem adding them. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20020930-prom_printf-0
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20020930.macro/arch/mips/config-shared.in linux-mips-2.4.20-pre6-20020930/arch/mips/config-shared.in
--- linux-mips-2.4.20-pre6-20020930.macro/arch/mips/config-shared.in	2002-09-29 02:56:21.000000000 +0000
+++ linux-mips-2.4.20-pre6-20020930/arch/mips/config-shared.in	2002-10-01 00:55:59.000000000 +0000
@@ -354,6 +354,7 @@ if [ "$CONFIG_SGI_IP22" = "y" ]; then
    define_bool CONFIG_ARC_CONSOLE y
    define_bool CONFIG_ARC_MEMORY y
    define_bool CONFIG_ARC_PROMLIB y
+   define_bool CONFIG_PROM_PRINTF y
    define_bool CONFIG_BOARD_SCACHE y
    define_bool CONFIG_BOOT_ELF32 y
    define_bool CONFIG_SWAP_IO_SPACE y
@@ -369,6 +370,7 @@ fi
 if [ "$CONFIG_SGI_IP27" = "y" ]; then
    define_bool CONFIG_BOOT_ELF64 y
    define_bool CONFIG_ARC64 y
+   define_bool CONFIG_PROM_PRINTF y
    #define_bool CONFIG_MAPPED_PCI_IO y
    define_bool CONFIG_NEW_IRQ y
    define_bool CONFIG_PCI y
@@ -378,6 +380,7 @@ fi
 if [ "$CONFIG_SGI_IP32" = "y" ]; then
    define_bool CONFIG_ARC_MEMORY y
    define_bool CONFIG_ARC_PROMLIB y
+   define_bool CONFIG_PROM_PRINTF y
    define_bool CONFIG_ARC32 y
    #define_bool CONFIG_BOARD_SCACHE y
    define_bool CONFIG_BOOT_ELF32 y
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20020930.macro/arch/mips/lib/Makefile linux-mips-2.4.20-pre6-20020930/arch/mips/lib/Makefile
--- linux-mips-2.4.20-pre6-20020930.macro/arch/mips/lib/Makefile	2002-09-29 02:56:23.000000000 +0000
+++ linux-mips-2.4.20-pre6-20020930/arch/mips/lib/Makefile	2002-10-01 00:50:00.000000000 +0000
@@ -7,9 +7,9 @@ USE_STANDARD_AS_RULE := true
 L_TARGET = lib.a
 
 obj-y				+= csum_partial.o csum_partial_copy.o \
-				   promlib.o rtc-std.o rtc-no.o memcpy.o \
-				   memset.o watch.o strlen_user.o \
-				   strncpy_user.o strnlen_user.o
+				   rtc-std.o rtc-no.o memcpy.o memset.o \
+				   watch.o strlen_user.o strncpy_user.o \
+				   strnlen_user.o
 
 ifeq ($(CONFIG_CPU_R3000)$(CONFIG_CPU_TX39XX),y)
   obj-y	+= r3k_dump_tlb.o
@@ -21,4 +21,6 @@ obj-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o 
 obj-$(CONFIG_IDE)		+= ide-std.o ide-no.o
 obj-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
 
+obj-$(CONFIG_PROM_PRINTF)	+= prom_printf.o
+
 include $(TOPDIR)/Rules.make
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20020930.macro/arch/mips/lib/prom_printf.c linux-mips-2.4.20-pre6-20020930/arch/mips/lib/prom_printf.c
--- linux-mips-2.4.20-pre6-20020930.macro/arch/mips/lib/prom_printf.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.20-pre6-20020930/arch/mips/lib/prom_printf.c	2002-09-28 22:28:38.000000000 +0000
@@ -0,0 +1,21 @@
+#include <stdarg.h>
+
+void prom_printf(char *fmt, ...)
+{
+	va_list args;
+	char ppbuf[1024];
+	char *bptr;
+
+	va_start(args, fmt);
+	vsprintf(ppbuf, fmt, args);
+
+	bptr = ppbuf;
+
+	while (*bptr != 0) {
+		if (*bptr == '\n')
+			prom_putchar('\r');
+
+		prom_putchar(*bptr++);
+	}
+	va_end(args);
+}
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20020930.macro/arch/mips/lib/promlib.c linux-mips-2.4.20-pre6-20020930/arch/mips/lib/promlib.c
--- linux-mips-2.4.20-pre6-20020930.macro/arch/mips/lib/promlib.c	2002-09-28 22:28:38.000000000 +0000
+++ linux-mips-2.4.20-pre6-20020930/arch/mips/lib/promlib.c	1970-01-01 00:00:00.000000000 +0000
@@ -1,21 +0,0 @@
-#include <stdarg.h>
-
-void prom_printf(char *fmt, ...)
-{
-	va_list args;
-	char ppbuf[1024];
-	char *bptr;
-
-	va_start(args, fmt);
-	vsprintf(ppbuf, fmt, args);
-
-	bptr = ppbuf;
-
-	while (*bptr != 0) {
-		if (*bptr == '\n')
-			prom_putchar('\r');
-
-		prom_putchar(*bptr++);
-	}
-	va_end(args);
-}
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20020930.macro/arch/mips64/lib/Makefile linux-mips-2.4.20-pre6-20020930/arch/mips64/lib/Makefile
--- linux-mips-2.4.20-pre6-20020930.macro/arch/mips64/lib/Makefile	2002-09-29 02:56:35.000000000 +0000
+++ linux-mips-2.4.20-pre6-20020930/arch/mips64/lib/Makefile	2002-10-01 00:51:31.000000000 +0000
@@ -6,12 +6,15 @@ USE_STANDARD_AS_RULE := true
 
 L_TARGET = lib.a
 
-obj-y	+= csum_partial.o csum_partial_copy.o dump_tlb.o promlib.o rtc-std.o \
-	  rtc-no.o memset.o memcpy.o strlen_user.o strncpy_user.o \
-	  strnlen_user.o watch.o
+obj-y				+= csum_partial.o csum_partial_copy.o \
+				   dump_tlb.o rtc-std.o rtc-no.o memset.o \
+				   memcpy.o strlen_user.o strncpy_user.o \
+				   strnlen_user.o watch.o
 
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy-no.o floppy-std.o
 obj-$(CONFIG_IDE)		+= ide-std.o ide-no.o
 obj-$(CONFIG_PC_KEYB)		+= kbd-std.o kbd-no.o
 
+obj-$(CONFIG_PROM_PRINTF)	+= prom_printf.o
+
 include $(TOPDIR)/Rules.make
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20020930.macro/arch/mips64/lib/prom_printf.c linux-mips-2.4.20-pre6-20020930/arch/mips64/lib/prom_printf.c
--- linux-mips-2.4.20-pre6-20020930.macro/arch/mips64/lib/prom_printf.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.20-pre6-20020930/arch/mips64/lib/prom_printf.c	2002-09-28 22:28:38.000000000 +0000
@@ -0,0 +1,21 @@
+#include <stdarg.h>
+
+void prom_printf(char *fmt, ...)
+{
+	va_list args;
+	char ppbuf[1024];
+	char *bptr;
+
+	va_start(args, fmt);
+	vsprintf(ppbuf, fmt, args);
+
+	bptr = ppbuf;
+
+	while (*bptr != 0) {
+		if (*bptr == '\n')
+			prom_putchar('\r');
+
+		prom_putchar(*bptr++);
+	}
+	va_end(args);
+}
diff -up --recursive --new-file linux-mips-2.4.20-pre6-20020930.macro/arch/mips64/lib/promlib.c linux-mips-2.4.20-pre6-20020930/arch/mips64/lib/promlib.c
--- linux-mips-2.4.20-pre6-20020930.macro/arch/mips64/lib/promlib.c	2002-09-28 22:28:38.000000000 +0000
+++ linux-mips-2.4.20-pre6-20020930/arch/mips64/lib/promlib.c	1970-01-01 00:00:00.000000000 +0000
@@ -1,21 +0,0 @@
-#include <stdarg.h>
-
-void prom_printf(char *fmt, ...)
-{
-	va_list args;
-	char ppbuf[1024];
-	char *bptr;
-
-	va_start(args, fmt);
-	vsprintf(ppbuf, fmt, args);
-
-	bptr = ppbuf;
-
-	while (*bptr != 0) {
-		if (*bptr == '\n')
-			prom_putchar('\r');
-
-		prom_putchar(*bptr++);
-	}
-	va_end(args);
-}
