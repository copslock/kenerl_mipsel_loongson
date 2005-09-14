Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 13:55:48 +0100 (BST)
Received: from [IPv6:::ffff:85.21.88.6] ([IPv6:::ffff:85.21.88.6]:788 "EHLO
	buildserver.ru.mvista.com") by linux-mips.org with ESMTP
	id <S8225201AbVINMzd>; Wed, 14 Sep 2005 13:55:33 +0100
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j8ECtVt21738;
	Wed, 14 Sep 2005 17:55:31 +0500
Message-ID: <43281DC3.8010602@ru.mvista.com>
Date:	Wed, 14 Sep 2005 16:55:31 +0400
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Ethernet for TX4927(37) platform
References: <20050913124544.GC3224@linux-mips.org>	<20050913133126.GO23161@lug-owl.de>	<20050913152038.GE3224@linux-mips.org> <17191.61757.80884.8289@mips.com>
In-Reply-To: <17191.61757.80884.8289@mips.com>
Content-Type: multipart/mixed;
 boundary="------------090403010504010608020707"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------090403010504010608020707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello All!

This as a patch to add ethernet support for TX4927 platform.
Does it makes sence to push it in?

Regards,
Vladimir


--------------090403010504010608020707
Content-Type: text/plain;
 name="pro_mips_tx4927_ethernet.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pro_mips_tx4927_ethernet.patch"

 Signed-off-by: Vladimir Barinov <vbarinov@ru.mvista.com>
 Description:
        Ethernet support for TX4927/37 platform in 2.6.
                                                                                                                                                             
Index: linux-2.6.10/drivers/net/ne.c
===================================================================
--- linux-2.6.10.orig/drivers/net/ne.c
+++ linux-2.6.10/drivers/net/ne.c
@@ -54,7 +54,9 @@ static const char version2[] =
 #include <asm/system.h>
 #include <asm/io.h>
 
-#if defined(CONFIG_TOSHIBA_RBTX4927) || defined(CONFIG_TOSHIBA_RBTX4938)
+#if defined(CONFIG_TOSHIBA_RBTX4927)
+#include <asm/tx4927/toshiba_rbtx4927.h>
+#elif defined(CONFIG_TOSHIBA_RBTX4938)
 #include <asm/tx4938/rbtx4938.h>
 #endif
 
@@ -237,6 +239,10 @@ struct net_device * __init ne_probe(int 
 	dev->base_addr = 0x07f20280;
 	dev->irq = RBTX4938_RTL_8019_IRQ;
 #endif
+#ifdef CONFIG_TOSHIBA_RBTX4927
+	dev->base_addr = RBTX4927_RTL_8019_BASE;
+	dev->irq = RBTX4927_RTL_8019_IRQ;
+#endif
 	err = do_ne_probe(dev);
 	if (err)
 		goto out;

--------------090403010504010608020707--
