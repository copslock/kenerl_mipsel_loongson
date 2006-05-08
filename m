Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 May 2006 21:02:08 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:8147 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133517AbWEHUB4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 8 May 2006 21:01:56 +0100
Received: (qmail 25379 invoked from network); 9 May 2006 00:07:29 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 9 May 2006 00:07:29 -0000
Message-ID: <445FA36E.3080500@ru.mvista.com>
Date:	Tue, 09 May 2006 00:00:46 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Jeff Garzik <jgarzik@pobox.com>
CC:	linux-mips@linux-mips.org, linux-net@vger.kernel.org
Subject: [PATCH] Fix RTL8019AS init for Toshiba RBTX49xx boards
References: <444291E9.2070407@ru.mvista.com>	<20060417.110945.59031594.nemoto@toshiba-tops.co.jp>	<444392CF.7070808@ru.mvista.com> <20060418.000918.95064811.anemo@mba.ocn.ne.jp> <4443BD39.4030200@ru.mvista.com> <4443BE71.6090908@ru.mvista.com>
In-Reply-To: <4443BE71.6090908@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------040703070604020900060909"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040703070604020900060909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    Ensure that 8-bit mode is selected for the on-board Realtek RTL8019AS chip 
on Toshiba RBHMA4x00, get rid of the duplicate #ifdef's when setting
ei_status.word16.
    The chip's datasheet says that the PSTOP register shouldn't exceed 0x60 in
8-bit mode -- ensure this too.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------040703070604020900060909
Content-Type: text/plain;
 name="RBTX49xx-RTL8019AS-init-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RBTX49xx-RTL8019AS-init-fix.patch"

Index: linus/drivers/net/ne.c
===================================================================
--- linus.orig/drivers/net/ne.c
+++ linus/drivers/net/ne.c
@@ -139,8 +139,9 @@ bad_clone_list[] __initdata = {
 
 #if defined(CONFIG_PLAT_MAPPI)
 #  define DCR_VAL 0x4b
-#elif defined(CONFIG_PLAT_OAKS32R)
-#  define DCR_VAL 0x48
+#elif defined(CONFIG_PLAT_OAKS32R)  || \
+   defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
+#  define DCR_VAL 0x48		/* 8-bit mode */
 #else
 #  define DCR_VAL 0x49
 #endif
@@ -396,10 +397,22 @@ static int __init ne_probe1(struct net_d
 		/* We must set the 8390 for word mode. */
 		outb_p(DCR_VAL, ioaddr + EN0_DCFG);
 		start_page = NESM_START_PG;
-		stop_page = NESM_STOP_PG;
+
+		/*
+		 * Realtek RTL8019AS datasheet says that the PSTOP register
+		 * shouldn't exceed 0x60 in 8-bit mode.
+		 * This chip can be identified by reading the signature from
+		 * the  remote byte count registers (otherwise write-only)...
+		 */
+		if ((DCR_VAL & 0x01) == 0 &&		/* 8-bit mode */
+		    inb(ioaddr + EN0_RCNTLO) == 0x50 &&
+		    inb(ioaddr + EN0_RCNTHI) == 0x70)
+			stop_page = 0x60;
+		else
+			stop_page = NESM_STOP_PG;
 	} else {
 		start_page = NE1SM_START_PG;
-		stop_page = NE1SM_STOP_PG;
+		stop_page  = NE1SM_STOP_PG;
 	}
 
 #if  defined(CONFIG_PLAT_MAPPI) || defined(CONFIG_PLAT_OAKS32R)
@@ -509,15 +522,9 @@ static int __init ne_probe1(struct net_d
 	ei_status.name = name;
 	ei_status.tx_start_page = start_page;
 	ei_status.stop_page = stop_page;
-#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
-	wordlength = 1;
-#endif
 
-#ifdef CONFIG_PLAT_OAKS32R
-	ei_status.word16 = 0;
-#else
-	ei_status.word16 = (wordlength == 2);
-#endif
+	/* Use 16-bit mode only if this wasn't overridden by DCR_VAL */
+	ei_status.word16 = (wordlength == 2 && (DCR_VAL & 0x01));
 
 	ei_status.rx_start_page = start_page + TX_PAGES;
 #ifdef PACKETBUF_MEMSIZE



--------------040703070604020900060909--
