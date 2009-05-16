Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2009 14:15:50 +0100 (BST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:55354 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023645AbZEPNPn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 16 May 2009 14:15:43 +0100
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 49666E08026;
	Sat, 16 May 2009 15:15:38 +0200 (CEST)
Received: from [192.168.0.3] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 4254DE0806A;
	Sat, 16 May 2009 15:15:36 +0200 (CEST)
Message-ID: <4A0EBC77.2010806@free.fr>
Date:	Sat, 16 May 2009 15:15:35 +0200
From:	matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081204 Iceape/1.1.14 (Debian-1.1.14-1)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] fix gpio_direction_output for bcm47xx
Content-Type: multipart/mixed;
 boundary="------------050304090509060200010001"
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050304090509060200010001
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

gpio_direction_output should also set to a output value per gpio API.

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

--------------050304090509060200010001
Content-Type: text/x-diff;
 name="fix_bcm47xx_gpio_out.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_bcm47xx_gpio_out.diff"

diff --git a/arch/mips/include/asm/mach-bcm47xx/gpio.h b/arch/mips/include/asm/mach-bcm47xx/gpio.h
index 1784fde..9850414 100644
--- a/arch/mips/include/asm/mach-bcm47xx/gpio.h
+++ b/arch/mips/include/asm/mach-bcm47xx/gpio.h
@@ -37,6 +37,9 @@ static inline int gpio_direction_input(unsigned gpio)
 
 static inline int gpio_direction_output(unsigned gpio, int value)
 {
+	/* first set the gpio out value */
+	ssb_gpio_out(&ssb_bcm47xx, 1 << gpio, value ? 1 << gpio : 0);
+	/* then set the gpio mode */
 	ssb_gpio_outen(&ssb_bcm47xx, 1 << gpio, 1 << gpio);
 	return 0;
 }

--------------050304090509060200010001--
