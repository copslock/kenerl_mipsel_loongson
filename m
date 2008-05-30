Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 22:37:06 +0100 (BST)
Received: from p549F7A8A.dip.t-dialin.net ([84.159.122.138]:22730 "EHLO
	p549F7A8A.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20022330AbYE3Vgz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 May 2008 22:36:55 +0100
Received: from isilmar.linta.de ([213.133.102.198]:21987 "EHLO linta.de")
	by lappi.linux-mips.net with ESMTP id S1109980AbYE3VdO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2008 23:33:14 +0200
Received: (qmail 9724 invoked from network); 30 May 2008 21:32:55 -0000
Received: from p54a074ee.dip.t-dialin.net (HELO comet.dominikbrodowski.net) (brodo@84.160.116.238)
  by isilmar.linta.de with (DHE-RSA-AES256-SHA encrypted) SMTP; 30 May 2008 21:32:55 -0000
Received: by comet.dominikbrodowski.net (Postfix, from userid 1000)
	id 14072457C8; Fri, 30 May 2008 23:31:19 +0200 (CEST)
From:	Dominik Brodowski <linux@dominikbrodowski.net>
To:	<linux-pcmcia@lists.infradead.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-mips@linux-mips.org
Subject: [PATCH 6/9] pcmcia: fix Alchemy warnings
Date:	Fri, 30 May 2008 23:31:16 +0200
Message-Id: <1212183079-30505-6-git-send-email-linux@dominikbrodowski.net>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <20080530212821.GA30197@comet.dominikbrodowski.net>
References: <20080530212821.GA30197@comet.dominikbrodowski.net>
Return-Path: <linux@dominikbrodowski.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@dominikbrodowski.net
Precedence: bulk
X-list: linux-mips

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Fix the following warnings:

drivers/pcmcia/au1000_generic.c: In function `au1x00_pcmcia_socket_probe':
drivers/pcmcia/au1000_generic.c:405: warning: integer constant is too large for
"long" type
drivers/pcmcia/au1000_generic.c:413: warning: integer constant is too large for
"long" type

by properly postfixing the socket constants. While at it, fix the lines over 80
characters long in the vicinity...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
CC: linux-mips@linux-mips.org
---
 drivers/pcmcia/au1000_generic.h |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pcmcia/au1000_generic.h b/drivers/pcmcia/au1000_generic.h
index 1e467bb..c62437d 100644
--- a/drivers/pcmcia/au1000_generic.h
+++ b/drivers/pcmcia/au1000_generic.h
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
-- 
1.5.4.3
