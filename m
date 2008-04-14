Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2008 14:28:10 +0100 (BST)
Received: from rtsoft3.corbina.net ([85.21.88.6]:55090 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28573721AbYDNN2I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Apr 2008 14:28:08 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id DCDDA8810; Mon, 14 Apr 2008 18:28:06 +0500 (SAMST)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	linux-pcmcia@lists.infradead.org
Subject: [PATCH] Alchemy: fix PCMCIA warnings
Date:	Mon, 14 Apr 2008 17:27:30 +0400
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804141727.30170.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Fix the following warnings:

drivers/pcmcia/au1000_generic.c: In function `au1x00_pcmcia_socket_probe':
drivers/pcmcia/au1000_generic.c:405: warning: integer constant is too large for
"long" type
drivers/pcmcia/au1000_generic.c:413: warning: integer constant is too large for
"long" type

by properly postfixing the socket constants. While at it, fix the lines over 80
characters long in the vicinity...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/pcmcia/au1000_generic.h |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/pcmcia/au1000_generic.h
===================================================================
--- linux-2.6.orig/drivers/pcmcia/au1000_generic.h
+++ linux-2.6/drivers/pcmcia/au1000_generic.h
@@ -34,9 +34,9 @@
 #define AU1000_PCMCIA_IO_SPEED       (255)
 #define AU1000_PCMCIA_MEM_SPEED      (300)
 
-#define AU1X_SOCK0_IO        0xF00000000
-#define AU1X_SOCK0_PHYS_ATTR 0xF40000000
-#define AU1X_SOCK0_PHYS_MEM  0xF80000000
+#define AU1X_SOCK0_IO        0xF00000000ULL
+#define AU1X_SOCK0_PHYS_ATTR 0xF40000000ULL
+#define AU1X_SOCK0_PHYS_MEM  0xF80000000ULL
 /* pseudo 32 bit phys addresses, which get fixed up to the
  * real 36 bit address in fixup_bigphys_addr() */
 #define AU1X_SOCK0_PSEUDO_PHYS_ATTR 0xF4000000
@@ -45,16 +45,20 @@
 /* pcmcia socket 1 needs external glue logic so the memory map
  * differs from board to board.
  */
-#if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_PB1550) || defined(CONFIG_MIPS_PB1200)
-#define AU1X_SOCK1_IO        0xF08000000
-#define AU1X_SOCK1_PHYS_ATTR 0xF48000000
-#define AU1X_SOCK1_PHYS_MEM  0xF88000000
+#if defined(CONFIG_MIPS_PB1000) || defined(CONFIG_MIPS_PB1100) || \
+    defined(CONFIG_MIPS_PB1500) || defined(CONFIG_MIPS_PB1550) || \
+    defined(CONFIG_MIPS_PB1200)
+#define AU1X_SOCK1_IO        0xF08000000ULL
+#define AU1X_SOCK1_PHYS_ATTR 0xF48000000ULL
+#define AU1X_SOCK1_PHYS_MEM  0xF88000000ULL
 #define AU1X_SOCK1_PSEUDO_PHYS_ATTR 0xF4800000
 #define AU1X_SOCK1_PSEUDO_PHYS_MEM  0xF8800000
-#elif defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || defined(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550) || defined(CONFIG_MIPS_DB1200)
-#define AU1X_SOCK1_IO        0xF04000000
-#define AU1X_SOCK1_PHYS_ATTR 0xF44000000
-#define AU1X_SOCK1_PHYS_MEM  0xF84000000
+#elif defined(CONFIG_MIPS_DB1000) || defined(CONFIG_MIPS_DB1100) || \
+      defined(CONFIG_MIPS_DB1500) || defined(CONFIG_MIPS_DB1550) || \
+      defined(CONFIG_MIPS_DB1200)
+#define AU1X_SOCK1_IO        0xF04000000ULL
+#define AU1X_SOCK1_PHYS_ATTR 0xF44000000ULL
+#define AU1X_SOCK1_PHYS_MEM  0xF84000000ULL
 #define AU1X_SOCK1_PSEUDO_PHYS_ATTR 0xF4400000
 #define AU1X_SOCK1_PSEUDO_PHYS_MEM  0xF8400000
 #endif
