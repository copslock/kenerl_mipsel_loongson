Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jun 2004 14:25:19 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:9163 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225285AbUF1NZM>; Mon, 28 Jun 2004 14:25:12 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id BAAFD47392; Mon, 28 Jun 2004 15:25:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id AC27544F05; Mon, 28 Jun 2004 15:25:04 +0200 (CEST)
Date: Mon, 28 Jun 2004 15:25:04 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] Incorrect mapping of serial ports to lines
Message-ID: <Pine.LNX.4.55.0406281513120.23162@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 Onboard PC-compatible serial ports of the 8250 family are expected to be
assigned to lines 0 - 3.  Unfortunately for MIPS this is not guaranteed as
EXTRA_SERIAL_PORT_DEFNS and HUB6_SERIAL_PORT_DFNS precede
STD_SERIAL_PORT_DEFNS on the port list and their definitions change
depending on CONFIG_SERIAL_MANY_PORTS and CONFIG_HUB6 which are user
settable.  As a result, they may get different assignments depending on
configuration -- e.g. my last build for the Malta board resulted in its
onboard ports being assigned to lines 28 and 29.

 This can be fixed with a correct ordering of entries on the port list, 
like the following.  OK to apply?

  Maciej

patch-mips-2.4.26-20040531-mips-serial-0
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/include/asm-mips/serial.h linux-mips-2.4.26-20040531/include/asm-mips/serial.h
--- linux-mips-2.4.26-20040531.macro/include/asm-mips/serial.h	2004-06-13 23:16:56.000000000 +0000
+++ linux-mips-2.4.26-20040531/include/asm-mips/serial.h	2004-06-27 12:49:23.000000000 +0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1999 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2004  Maciej W. Rozycki
  */
 #ifndef _ASM_SERIAL_H
 #define _ASM_SERIAL_H
@@ -410,14 +411,25 @@
 #define DDB5477_SERIAL_PORT_DEFNS
 #endif
 
+/*
+ * The order matters here and should be as follows:
+ *
+ * 1. STD_SERIAL_PORT_DEFNS
+ * 2. board-specific ports (please keep sorted)
+ * 3. EXTRA_SERIAL_PORT_DEFNS
+ * 4. HUB6_SERIAL_PORT_DFNS
+ *
+ * otherwise serial line numbers may change across
+ * kernel builds if configuration changes. --macro
+ */
 #define SERIAL_PORT_DFNS			\
+	STD_SERIAL_PORT_DEFNS			\
+						\
 	ATLAS_SERIAL_PORT_DEFNS			\
 	AU1000_SERIAL_PORT_DEFNS		\
 	COBALT_SERIAL_PORT_DEFNS		\
 	DDB5477_SERIAL_PORT_DEFNS		\
 	EV96100_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS			\
-	HUB6_SERIAL_PORT_DFNS			\
 	ITE_SERIAL_PORT_DEFNS           	\
 	IVR_SERIAL_PORT_DEFNS           	\
 	JAZZ_SERIAL_PORT_DEFNS			\
@@ -426,8 +438,10 @@
 	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS	\
 	MOMENCO_JAGUAR_ATX_SERIAL_PORT_DEFNS	\
 	SEAD_SERIAL_PORT_DEFNS			\
-	STD_SERIAL_PORT_DEFNS			\
 	TITAN_SERIAL_PORT_DEFNS			\
-	TXX927_SERIAL_PORT_DEFNS
+	TXX927_SERIAL_PORT_DEFNS		\
+						\
+	EXTRA_SERIAL_PORT_DEFNS			\
+	HUB6_SERIAL_PORT_DFNS
 
 #endif /* _ASM_SERIAL_H */
diff -up --recursive --new-file linux-mips-2.4.26-20040531.macro/include/asm-mips64/serial.h linux-mips-2.4.26-20040531/include/asm-mips64/serial.h
--- linux-mips-2.4.26-20040531.macro/include/asm-mips64/serial.h	2003-12-18 03:57:25.000000000 +0000
+++ linux-mips-2.4.26-20040531/include/asm-mips64/serial.h	2004-06-27 12:52:51.000000000 +0000
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1999 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
+ * Copyright (C) 2004  Maciej W. Rozycki
  */
 #ifndef _ASM_SERIAL_H
 #define _ASM_SERIAL_H
@@ -146,12 +147,22 @@
 #define IP27_SERIAL_PORT_DEFNS
 #endif /* CONFIG_SGI_IP27 */
 
+/*
+ * The order matters here and should be as follows:
+ *
+ * 1. STD_SERIAL_PORT_DEFNS
+ * 2. board-specific ports (please keep sorted)
+ *
+ * otherwise serial line numbers may change across
+ * kernel builds if configuration changes. --macro
+ */
 #define SERIAL_PORT_DFNS				\
+	STD_SERIAL_PORT_DEFNS				\
+							\
 	IP27_SERIAL_PORT_DEFNS				\
 	MOMENCO_OCELOT_C_SERIAL_PORT_DEFNS		\
 	MOMENCO_JAGUAR_ATX_SERIAL_PORT_DEFNS		\
 	SEAD_SERIAL_PORT_DEFNS				\
-	STD_SERIAL_PORT_DEFNS				\
 	TITAN_SERIAL_PORT_DEFNS
 
 #define RS_TABLE_SIZE	64
