Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 15:53:53 +0100 (BST)
Received: from fdy2.demon.co.uk ([IPv6:::ffff:80.177.11.33]:5131 "EHLO
	stimpy.fdy2.net") by linux-mips.org with ESMTP id <S8225519AbTIXOxv>;
	Wed, 24 Sep 2003 15:53:51 +0100
Received: by stimpy.fdy2.net (Postfix, from userid 100)
	id 69C24107; Wed, 24 Sep 2003 15:51:09 +0100 (BST)
From: Robert Swindells <rjs@fdy2.demon.co.uk>
To: linux-mips@linux-mips.org
Subject: Alchemy serial port patch
Message-Id: <20030924145109.69C24107@stimpy.fdy2.net>
Date: Wed, 24 Sep 2003 15:51:09 +0100 (BST)
Return-Path: <rjs@stimpy.fdy2.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjs@fdy2.demon.co.uk
Precedence: bulk
X-list: linux-mips


This seems to be needed to build drivers/serial/core.c for Alchemy
CPUs.

Robert Swindells

Index: Kconfig
===================================================================
RCS file: /home/cvs/linux/drivers/serial/Kconfig,v
retrieving revision 1.17
diff -u -r1.17 Kconfig
--- Kconfig     9 Sep 2003 16:41:03 -0000       1.17
+++ Kconfig     24 Sep 2003 14:50:36 -0000
@@ -459,7 +459,7 @@
 
 config SERIAL_CORE
        tristate
-       default m if SERIAL_AMBA!=y && SERIAL_CLPS711X!=y && SERIAL_21285!=y && 
!SERIAL_SA1100 && !SERIAL_ANAKIN && !SERIAL_UART00 && SERIAL_8250!=y && SERIAL_M
UX!=y && !SERIAL_ROCKETPORT && !SERIAL_SUNCORE && !V850E_UART && SERIAL_PMACZILO
G!=y && SERIAL_DZ!=y && SERIAL_IP22_ZILOG!=y || SERIAL_AU1X00!=y && (SERIAL_AMBA
=m || SERIAL_CLPS711X=m || SERIAL_21285=m || SERIAL_8250=m || SERIAL_MUX=m || SE
RIAL98=m || SERIAL_PMACZILOG=m || SERIAL_IP22_ZILOG=m)
+       default m if SERIAL_AMBA!=y && SERIAL_CLPS711X!=y && SERIAL_21285!=y && 
!SERIAL_SA1100 && !SERIAL_ANAKIN && !SERIAL_UART00 && SERIAL_8250!=y && SERIAL_M
UX!=y && !SERIAL_ROCKETPORT && !SERIAL_SUNCORE && !V850E_UART && SERIAL_PMACZILO
G!=y && SERIAL_DZ!=y && SERIAL_IP22_ZILOG!=y && SERIAL_AU1X00!=y && (SERIAL_AMBA
=m || SERIAL_CLPS711X=m || SERIAL_21285=m || SERIAL_8250=m || SERIAL_MUX=m || SE
RIAL98=m || SERIAL_PMACZILOG=m || SERIAL_IP22_ZILOG=m)
        default y if SERIAL_AMBA=y || SERIAL_CLPS711X=y || SERIAL_21285=y || SER
IAL_SA1100 || SERIAL_ANAKIN || SERIAL_UART00 || SERIAL_8250=y || SERIAL_MUX=y ||
 SERIAL_ROCKETPORT || SERIAL_SUNCORE || V850E_UART || SERIAL98=y || SERIAL_PMACZ
ILOG=y || SERIAL_DZ=y || SERIAL_IP22_ZILOG=y || SERIAL_AU1X00=y
 
 config SERIAL_CORE_CONSOLE
