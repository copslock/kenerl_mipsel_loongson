Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2004 03:10:40 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:19951 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225283AbUJZCKf>; Tue, 26 Oct 2004 03:10:35 +0100
Received: from prometheus.mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 11A9F1834E; Mon, 25 Oct 2004 19:10:33 -0700 (PDT)
Subject: [PATCH]2.6.10-rc1 on Sibyte
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Content-Type: text/plain
Organization: 
Message-Id: <1098756632.4266.49.camel@prometheus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Oct 2004 19:10:33 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

Attached patch for getting 2.6.10-rc1 running on the Broadcom Sibyte.
tested on the SWARM board

Thanks
Manish Lachwani

--- drivers/char/sb1250_duart.c.orig	2004-10-25 18:42:10.000000000 -0700
+++ drivers/char/sb1250_duart.c	2004-10-25 18:41:52.000000000 -0700
@@ -660,10 +660,7 @@
 	unsigned int line = tty->index;
 	unsigned long flags;
 
-	MOD_INC_USE_COUNT;
-
 	if ((line >= tty->driver->num) || !sb1250_duart_present[line]) {
-		MOD_DEC_USE_COUNT;
 		return -ENODEV;
 	}
 
@@ -709,7 +706,6 @@
 
 	spin_lock_irqsave(&open_lock, flags);
 	if (tty_hung_up_p(filp)) {
-		MOD_DEC_USE_COUNT;
 		spin_unlock_irqrestore(&open_lock, flags);
 		return;
 	}
@@ -739,7 +735,6 @@
 		tty->ldisc.flush_buffer(tty);
 	tty->closing = 0;
 
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -834,7 +829,6 @@
 MODULE_DESCRIPTION("SB1250 Duart serial driver");
 MODULE_AUTHOR("Justin Carlson, Broadcom Corp.");
 
-
 #ifdef CONFIG_SIBYTE_SB1250_DUART_CONSOLE
 
 /*
