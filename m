Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:57:39 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:41225 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133380AbVJTG4P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:56:15 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:55:59 -0700
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:55:57 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW10773; Wed, 19 Oct 2005 23:55:58 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA28164 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:55:58
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6tvov008691 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:55:57 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6tvv23945 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:55:57 -0700
Date:	Wed, 19 Oct 2005 23:55:57 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 3/12]  sibyte-header-cleanup
Message-ID: <20051020065557.GC23899@broadcom.com>
References: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20051020065320.GA23857@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F49E0F54NK4416010-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Update sibyte headers to match Broadcom internal copies:
 - comment cleanup and updates
 - fix LittleSur part number to match the board silkscreen

Signed-Off-By: Andy Isaacson <adi@broadcom.com>

 include/asm-mips/sibyte/sb1250_defs.h    |    2 --
 include/asm-mips/sibyte/sb1250_dma.h     |    5 ++---
 include/asm-mips/sibyte/sb1250_genbus.h  |    5 ++---
 include/asm-mips/sibyte/sb1250_int.h     |    2 --
 include/asm-mips/sibyte/sb1250_l2c.h     |    2 --
 include/asm-mips/sibyte/sb1250_ldt.h     |    2 --
 include/asm-mips/sibyte/sb1250_mac.h     |    2 --
 include/asm-mips/sibyte/sb1250_mc.h      |    2 --
 include/asm-mips/sibyte/sb1250_regs.h    |    2 --
 include/asm-mips/sibyte/sb1250_scd.h     |    2 --
 include/asm-mips/sibyte/sb1250_smbus.h   |    5 ++---
 include/asm-mips/sibyte/sb1250_syncser.h |    2 --
 include/asm-mips/sibyte/sb1250_uart.h    |    2 --
 include/asm-mips/sibyte/swarm.h          |    2 +-
 14 files changed, 7 insertions(+), 30 deletions(-)

Index: lmo/include/asm-mips/sibyte/sb1250_defs.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_defs.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_defs.h	2005-10-19 22:34:11.000000000 -0700
@@ -8,8 +8,6 @@
     *
     *  SB1250 specification level:  User's manual 1/02/02
     *
-    *  Author:  Mitch Lichtenberg
-    *
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
Index: lmo/include/asm-mips/sibyte/sb1250_dma.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_dma.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_dma.h	2005-10-19 22:34:11.000000000 -0700
@@ -7,9 +7,8 @@
     *  programming the SB1250's DMA controllers, both the data mover
     *  and the Ethernet DMA.
     *
-    *  SB1250 specification level:  User's manual 1/02/02
-    *
-    *  Author:  Mitch Lichtenberg
+    *  SB1250 specification level:  User's manual 10/21/02
+    *  BCM1280 specification level: User's manual 11/24/03
     *
     *********************************************************************
     *
Index: lmo/include/asm-mips/sibyte/sb1250_genbus.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_genbus.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_genbus.h	2005-10-19 22:34:11.000000000 -0700
@@ -6,9 +6,8 @@
     *  This module contains constants and macros useful for
     *  manipulating the SB1250's Generic Bus interface
     *
-    *  SB1250 specification level:  User's manual 1/02/02
-    *
-    *  Author:  Mitch Lichtenberg
+    *  SB1250 specification level:  User's manual 10/21/02
+    *  BCM1280 specification level: User's Manual 11/14/03
     *
     *********************************************************************
     *
Index: lmo/include/asm-mips/sibyte/sb1250_int.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_int.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_int.h	2005-10-19 22:34:11.000000000 -0700
@@ -8,8 +8,6 @@
     *
     *  SB1250 specification level:  User's manual 1/02/02
     *
-    *  Author:  Mitch Lichtenberg
-    *
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
Index: lmo/include/asm-mips/sibyte/sb1250_l2c.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_l2c.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_l2c.h	2005-10-19 22:34:11.000000000 -0700
@@ -8,8 +8,6 @@
     *
     *  SB1250 specification level:  User's manual 1/02/02
     *
-    *  Author:  Mitch Lichtenberg
-    *
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
Index: lmo/include/asm-mips/sibyte/sb1250_ldt.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_ldt.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_ldt.h	2005-10-19 22:34:11.000000000 -0700
@@ -8,8 +8,6 @@
     *
     *  SB1250 specification level:  User's manual 1/02/02
     *
-    *  Author:  Mitch Lichtenberg
-    *
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
Index: lmo/include/asm-mips/sibyte/sb1250_mac.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_mac.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_mac.h	2005-10-19 22:34:11.000000000 -0700
@@ -8,8 +8,6 @@
     *
     *  SB1250 specification level:  User's manual 1/02/02
     *
-    *  Author:  Mitch Lichtenberg
-    *
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
Index: lmo/include/asm-mips/sibyte/sb1250_mc.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_mc.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_mc.h	2005-10-19 22:34:11.000000000 -0700
@@ -8,8 +8,6 @@
     *
     *  SB1250 specification level:  User's manual 1/02/02
     *
-    *  Author:  Mitch Lichtenberg
-    *
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
Index: lmo/include/asm-mips/sibyte/sb1250_regs.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_regs.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_regs.h	2005-10-19 22:34:11.000000000 -0700
@@ -8,8 +8,6 @@
     *
     *  SB1250 specification level:  01/02/2002
     *
-    *  Author:  Mitch Lichtenberg
-    *
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
Index: lmo/include/asm-mips/sibyte/sb1250_scd.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_scd.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_scd.h	2005-10-19 22:34:11.000000000 -0700
@@ -8,8 +8,6 @@
     *
     *  SB1250 specification level:  User's manual 1/02/02
     *
-    *  Author:  Mitch Lichtenberg
-    *
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
Index: lmo/include/asm-mips/sibyte/sb1250_smbus.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_smbus.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_smbus.h	2005-10-19 22:34:11.000000000 -0700
@@ -6,9 +6,8 @@
     *  This module contains constants and macros useful for
     *  manipulating the SB1250's SMbus devices.
     *
-    *  SB1250 specification level:  01/02/2002
-    *
-    *  Author:  Mitch Lichtenberg
+    *  SB1250 specification level:  10/21/02
+    *  BCM1280 specification level:  11/24/03
     *
     *********************************************************************
     *
Index: lmo/include/asm-mips/sibyte/sb1250_syncser.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_syncser.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_syncser.h	2005-10-19 22:34:11.000000000 -0700
@@ -8,8 +8,6 @@
     *
     *  SB1250 specification level:  User's manual 1/02/02
     *
-    *  Author:  Mitch Lichtenberg
-    *
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
Index: lmo/include/asm-mips/sibyte/sb1250_uart.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/sb1250_uart.h	2005-10-19 22:34:11.000000000 -0700
+++ lmo/include/asm-mips/sibyte/sb1250_uart.h	2005-10-19 22:34:11.000000000 -0700
@@ -8,8 +8,6 @@
     *
     *  SB1250 specification level:  User's manual 1/02/02
     *
-    *  Author:  Mitch Lichtenberg
-    *
     *********************************************************************
     *
     *  Copyright 2000,2001,2002,2003
Index: lmo/include/asm-mips/sibyte/swarm.h
===================================================================
--- lmo.orig/include/asm-mips/sibyte/swarm.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/sibyte/swarm.h	2005-10-19 22:34:11.000000000 -0700
@@ -34,7 +34,7 @@
 #define SIBYTE_DEFAULT_CONSOLE "ttyS0,115200"
 #endif
 #ifdef CONFIG_SIBYTE_LITTLESUR
-#define SIBYTE_BOARD_NAME "BCM1250C2 (LittleSur)"
+#define SIBYTE_BOARD_NAME "BCM91250C2 (LittleSur)"
 #define SIBYTE_HAVE_PCMCIA 0
 #define SIBYTE_HAVE_IDE    1
 #define SIBYTE_DEFAULT_CONSOLE "cfe0"
