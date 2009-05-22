Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 21:26:52 +0100 (BST)
Received: from smtp3-g21.free.fr ([212.27.42.3]:42311 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022558AbZEVUZN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 May 2009 21:25:13 +0100
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 635B5818109;
	Fri, 22 May 2009 22:25:07 +0200 (CEST)
Received: from [192.168.1.189] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 362E3818120;
	Fri, 22 May 2009 22:25:05 +0200 (CEST)
Message-ID: <4A170A20.5050608@free.fr>
Date:	Fri, 22 May 2009 22:25:04 +0200
From:	matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081204 Iceape/1.1.14 (Debian-1.1.14-1)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] bc47xx : export ssb_watchdog_timer_set
Content-Type: multipart/mixed;
 boundary="------------090004090509030509080700"
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090004090509030509080700
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------090004090509030509080700
Content-Type: text/x-diff;
 name="export_ssb_watchdog.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="export_ssb_watchdog.diff"

this patch export ssb_watchdog_timer_set to allow to use it in a Linux 
watchdog driver.


Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
Acked-by : Michael Buesch <mb@bu3sch.de>
Index: linux-2.6/drivers/ssb/embedded.c
===================================================================
--- linux-2.6.orig/drivers/ssb/embedded.c	2009-05-22 21:45:50.000000000 +0200
+++ linux-2.6/drivers/ssb/embedded.c	2009-05-22 21:46:07.000000000 +0200
@@ -29,6 +29,7 @@
 	}
 	return -ENODEV;
 }
+EXPORT_SYMBOL(ssb_watchdog_timer_set);
 
 u32 ssb_gpio_in(struct ssb_bus *bus, u32 mask)
 {

--------------090004090509030509080700--
