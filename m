Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 17:41:40 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:40590 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225250AbTBTRlj>; Thu, 20 Feb 2003 17:41:39 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA01266;
	Thu, 20 Feb 2003 18:41:53 +0100 (MET)
Date: Thu, 20 Feb 2003 18:41:52 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [patch] Coalesce duplicated SiByte settings
Message-ID: <Pine.GSO.3.96.1030220183613.25777I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 There is quite a lot identical entries for SiByte board variations in the
top-level architecture Makefiles.  They look confusing and I don't think
they are necessary.  Following is a proposal to remove duplicated entries. 
OK? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-20030214-sibyte_board-0
diff -up --recursive --new-file linux-mips-2.4.20-20030214.macro/arch/mips/Makefile linux-mips-2.4.20-20030214/arch/mips/Makefile
--- linux-mips-2.4.20-20030214.macro/arch/mips/Makefile	2003-02-08 03:56:22.000000000 +0000
+++ linux-mips-2.4.20-20030214/arch/mips/Makefile	2003-02-15 10:51:13.000000000 +0000
@@ -464,9 +464,9 @@ LOADADDR	:= 0x88002000
 endif
 
 #
-# Sibyte SB1250 SOC
+# Sibyte SB1250 SOC and Broadcom (SiByte) BCM112x SOCs
 #
-ifdef CONFIG_SIBYTE_SB1250
+ifneq ($(CONFIG_SIBYTE_SB1250)$(CONFIG_SIBYTE_BCM112X),)
 # This is a LIB so that it links at the end, and initcalls are later
 # the sequence; but it is built as an object so that modules don't get
 # removed (as happens, even if they have __initcall/module_init)
@@ -476,67 +476,21 @@ LOADADDR	:= 0x80100000
 endif
 
 #
-# Sibyte SWARM board
+# Sibyte boards:
 #
-ifdef CONFIG_SIBYTE_SWARM
-LIBS		+= arch/mips/sibyte/swarm/sbswarm.a
-SUBDIRS		+= arch/mips/sibyte/swarm
-endif
-ifdef CONFIG_SIBYTE_SENTOSA
+# BCM91250A (SWARM),
+# BCM91250E (Sentosa),
+# BCM91120C (CRhine),
+# BCM91120x (Carmel),
+# BCM91125C (CRhone),
+# BCM91125E (Rhone).
+#
+ifdef CONFIG_SIBYTE_BOARD
 LIBS		+= arch/mips/sibyte/swarm/sbswarm.a
 SUBDIRS		+= arch/mips/sibyte/swarm
 endif
 
 #
-# Broadcom (SiByte) BCM112x SOCs
-# (In fact, this just uses the exact same support as the BCM1250.)
-#
-ifdef CONFIG_SIBYTE_BCM112X
-# This is a LIB so that it links at the end, and initcalls are later
-# the sequence; but it is built as an object so that modules don't get
-# removed (as happens, even if they have __initcall/module_init)
-LIBS		+= arch/mips/sibyte/sb1250/sb1250.o
-SUBDIRS		+= arch/mips/sibyte/sb1250
-LOADADDR	:= 0x80100000
-endif
-
-#
-# Sibyte BCM91120C (CRhine) board
-# (In fact, this just uses the exact same support as the BCM912500A (SWARM).)
-#
-ifdef CONFIG_SIBYTE_CRHINE
-LIBS          += arch/mips/sibyte/swarm/sbswarm.a
-SUBDIRS       += arch/mips/sibyte/swarm
-endif
-
-#
-# Sibyte BCM91120x (Carmel) board
-# (In fact, this just uses the exact same support as the BCM912500A (SWARM).)
-#
-ifdef CONFIG_SIBYTE_CARMEL
-LIBS          += arch/mips/sibyte/swarm/sbswarm.a
-SUBDIRS       += arch/mips/sibyte/swarm
-endif
-
-#
-# Sibyte BCM91125C (CRhone) board
-# (In fact, this just uses the exact same support as the BCM912500A (SWARM).)
-#
-ifdef CONFIG_SIBYTE_CRHONE
-LIBS          += arch/mips/sibyte/swarm/sbswarm.a
-SUBDIRS       += arch/mips/sibyte/swarm
-endif
-
-#
-# Sibyte BCM91125E (Rhone) board
-# (In fact, this just uses the exact same support as the BCM912500A (SWARM).)
-#
-ifdef CONFIG_SIBYTE_RHONE
-LIBS          += arch/mips/sibyte/swarm/sbswarm.a
-SUBDIRS       += arch/mips/sibyte/swarm
-endif
-
-#
 # Sibyte CFE firmware
 #
 ifdef CONFIG_SIBYTE_CFE
diff -up --recursive --new-file linux-mips-2.4.20-20030214.macro/arch/mips64/Makefile linux-mips-2.4.20-20030214/arch/mips64/Makefile
--- linux-mips-2.4.20-20030214.macro/arch/mips64/Makefile	2003-02-08 03:56:27.000000000 +0000
+++ linux-mips-2.4.20-20030214/arch/mips64/Makefile	2003-02-15 10:50:41.000000000 +0000
@@ -192,9 +192,9 @@ LOADADDR	:= 0x80002000
 endif
 
 #
-# Sibyte SB1250 SOC
+# Sibyte SB1250 SOC and Broadcom (SiByte) BCM112x SOCs
 #
-ifdef CONFIG_SIBYTE_SB1250
+ifneq ($(CONFIG_SIBYTE_SB1250)$(CONFIG_SIBYTE_BCM112X),)
 # This is a LIB so that it links at the end, and initcalls are later
 # the sequence; but it is built as an object so that modules don't get
 # removed (as happens, even if they have __initcall/module_init)
@@ -208,71 +208,21 @@ endif
 endif
 
 #
-# Sibyte SWARM board
+# Sibyte boards:
 #
-ifdef CONFIG_SIBYTE_SWARM
-LIBS		+= arch/mips/sibyte/swarm/sbswarm.a
-SUBDIRS		+= arch/mips/sibyte/swarm
-endif
-ifdef CONFIG_SIBYTE_SENTOSA
+# BCM91250A (SWARM),
+# BCM91250E (Sentosa),
+# BCM91120C (CRhine),
+# BCM91120x (Carmel),
+# BCM91125C (CRhone),
+# BCM91125E (Rhone).
+#
+ifdef CONFIG_SIBYTE_BOARD
 LIBS		+= arch/mips/sibyte/swarm/sbswarm.a
 SUBDIRS		+= arch/mips/sibyte/swarm
 endif
 
 #
-# Broadcom (SiByte) BCM112x SOCs
-# (In fact, this just uses the exact same support as the BCM1250.)
-#
-ifdef CONFIG_SIBYTE_BCM112X
-# This is a LIB so that it links at the end, and initcalls are later
-# the sequence; but it is built as an object so that modules don't get
-# removed (as happens, even if they have __initcall/module_init)
-LIBS		+= arch/mips/sibyte/sb1250/sb1250.o
-SUBDIRS		+= arch/mips/sibyte/sb1250
-ifdef CONFIG_MIPS_UNCACHED
-LOADADDR	:= 0xa0100000
-else
-LOADADDR	:= 0x80100000
-endif
-endif
-
-#
-# Sibyte BCM91120C (CRhine) board
-# (In fact, this just uses the exact same support as the BCM912500A (SWARM).)
-#
-ifdef CONFIG_SIBYTE_CRHINE
-LIBS          += arch/mips/sibyte/swarm/sbswarm.a
-SUBDIRS       += arch/mips/sibyte/swarm
-endif
-
-#
-# Sibyte BCM91120x (Carmel) board
-# (In fact, this just uses the exact same support as the BCM912500A (SWARM).)
-#
-ifdef CONFIG_SIBYTE_CARMEL
-LIBS          += arch/mips/sibyte/swarm/sbswarm.a
-SUBDIRS       += arch/mips/sibyte/swarm
-endif
-
-#
-# Sibyte BCM91125C (CRhone) board
-# (In fact, this just uses the exact same support as the BCM912500A (SWARM).)
-#
-ifdef CONFIG_SIBYTE_CRHONE
-LIBS          += arch/mips/sibyte/swarm/sbswarm.a
-SUBDIRS       += arch/mips/sibyte/swarm
-endif
-
-#
-# Sibyte BCM91125E (Rhone) board
-# (In fact, this just uses the exact same support as the BCM912500A (SWARM).)
-#
-ifdef CONFIG_SIBYTE_RHONE
-LIBS          += arch/mips/sibyte/swarm/sbswarm.a
-SUBDIRS       += arch/mips/sibyte/swarm
-endif
-
-#
 # Sibyte CFE firmware
 #
 ifdef CONFIG_SIBYTE_CFE
