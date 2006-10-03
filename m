Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 16:20:16 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:57093 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038893AbWJCPTA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 16:19:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id D84B6F62F5;
	Tue,  3 Oct 2006 17:18:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id psjVJwuej2BF; Tue,  3 Oct 2006 17:18:52 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B455DF62F0;
	Tue,  3 Oct 2006 17:18:52 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.1) with ESMTP id k93FJ0CF005160;
	Tue, 3 Oct 2006 17:19:00 +0200
Date:	Tue, 3 Oct 2006 16:18:55 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Andy Fleming <afleming@freescale.com>
cc:	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: [patch 5/6] 2.6.18: sb1250-mac: Interrupt wiring for PHYs
Message-ID: <Pine.LNX.4.64N.0610031602050.4642@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1984/Tue Oct  3 12:01:28 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 This patch defines the wiring for the PHY interrupt lines for the 
supported Broadcom SiByte boards for which documentation is available.

 Please consider.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-mips-2.6.18-20060920-sibyte-phy-irq-15
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/asm-mips/sibyte/sentosa.h linux-mips-2.6.18-20060920/include/asm-mips/sibyte/sentosa.h
--- linux-mips-2.6.18-20060920.macro/include/asm-mips/sibyte/sentosa.h	2006-09-20 20:51:12.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/asm-mips/sibyte/sentosa.h	2006-09-25 21:08:37.000000000 +0000
@@ -37,4 +37,8 @@
 /* GPIOs */
 #define K_GPIO_DBG_LED  0
 
+#ifdef CONFIG_SIBYTE_SENTOSA
+#define K_INT_PHY	K_INT_PCI_INTD
+#endif
+
 #endif /* __ASM_SIBYTE_SENTOSA_H */
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/asm-mips/sibyte/swarm.h linux-mips-2.6.18-20060920/include/asm-mips/sibyte/swarm.h
--- linux-mips-2.6.18-20060920.macro/include/asm-mips/sibyte/swarm.h	2006-09-20 20:51:12.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/asm-mips/sibyte/swarm.h	2006-09-25 21:56:49.000000000 +0000
@@ -67,4 +67,9 @@
 #define K_INT_PC_READY  (K_INT_GPIO_0 + K_GPIO_PC_READY)
 #endif
 
+#ifdef CONFIG_SIBYTE_SWARM
+#define K_GPIO_PHY	2
+#define K_INT_PHY	(K_INT_GPIO_0 + K_GPIO_PHY)
+#endif
+
 #endif /* __ASM_SIBYTE_SWARM_H */
