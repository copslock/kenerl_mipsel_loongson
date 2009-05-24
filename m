Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2009 18:49:06 +0100 (BST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:40271 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022610AbZEXRs7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 24 May 2009 18:48:59 +0100
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id EC9DD4C80E7;
	Sun, 24 May 2009 19:48:54 +0200 (CEST)
Received: from [192.168.1.189] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp4-g21.free.fr (Postfix) with ESMTP id D81824C8099;
	Sun, 24 May 2009 19:48:51 +0200 (CEST)
Message-ID: <4A198883.3070801@free.fr>
Date:	Sun, 24 May 2009 19:48:51 +0200
From:	matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081204 Iceape/1.1.14 (Debian-1.1.14-1)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org
Subject: [PATCH] bcm47xx : fix gpio_direction_output
References: <4A0EBC77.2010806@free.fr> <20090521094054.GB22500@hall.aurel32.net>
In-Reply-To: <20090521094054.GB22500@hall.aurel32.net>
Content-Type: multipart/mixed;
 boundary="------------010008010802030501070906"
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010008010802030501070906
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit




--------------010008010802030501070906
Content-Type: text/x-diff;
 name="fix_bcm47xx_gpio_out.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_bcm47xx_gpio_out.diff"

gpio_direction_output should also set an output value according to the API.

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr> 
Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Index: linux-2.6/arch/mips/include/asm/mach-bcm47xx/gpio.h
===================================================================
--- linux-2.6.orig/arch/mips/include/asm/mach-bcm47xx/gpio.h	2009-05-24 19:43:55.000000000 +0200
+++ linux-2.6/arch/mips/include/asm/mach-bcm47xx/gpio.h	2009-05-24 19:44:56.000000000 +0200
@@ -37,6 +37,9 @@
 
 static inline int gpio_direction_output(unsigned gpio, int value)
 {
+	/* first set the gpio out value */
+	ssb_gpio_out(&ssb_bcm47xx, 1 << gpio, value ? 1 << gpio : 0);
+	/* then set the gpio mode */
 	ssb_gpio_outen(&ssb_bcm47xx, 1 << gpio, 1 << gpio);
 	return 0;
 }

--------------010008010802030501070906--
