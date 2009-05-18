Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 23:10:21 +0100 (BST)
Received: from smtp5-g21.free.fr ([212.27.42.5]:49771 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024371AbZERWKP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 May 2009 23:10:15 +0100
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id D0451D480B3;
	Tue, 19 May 2009 00:10:10 +0200 (CEST)
Received: from [192.168.1.189] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp5-g21.free.fr (Postfix) with ESMTP id C52EBD48082;
	Tue, 19 May 2009 00:10:07 +0200 (CEST)
Message-ID: <4A11DCBF.9000700@free.fr>
Date:	Tue, 19 May 2009 00:10:07 +0200
From:	matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081204 Iceape/1.1.14 (Debian-1.1.14-1)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>,
	netdev@vger.kernel.org
Subject: [PATCH] bc47xx : export ssb_watchdog_timer_set
Content-Type: multipart/mixed;
 boundary="------------050308030502080801050508"
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050308030502080801050508
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch export ssb_watchdog_timer_set to allow to use it in a Linux 
watchdog driver.


Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>


--------------050308030502080801050508
Content-Type: text/x-diff;
 name="export_ssb_watchdog.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="export_ssb_watchdog.patch"

diff --git a/drivers/ssb/embedded.c b/drivers/ssb/embedded.c
index 7dc3a6b..a0e0d24 100644
--- a/drivers/ssb/embedded.c
+++ b/drivers/ssb/embedded.c
@@ -29,6 +29,7 @@ int ssb_watchdog_timer_set(struct ssb_bus *bus, u32 ticks)
 	}
 	return -ENODEV;
 }
+EXPORT_SYMBOL(ssb_watchdog_timer_set);
 
 u32 ssb_gpio_in(struct ssb_bus *bus, u32 mask)
 {

--------------050308030502080801050508--
