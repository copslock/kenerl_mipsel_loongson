Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 14:08:46 +0100 (BST)
Received: from [IPv6:::ffff:85.21.88.6] ([IPv6:::ffff:85.21.88.6]:3348 "EHLO
	buildserver.ru.mvista.com") by linux-mips.org with ESMTP
	id <S8225204AbVINNIY>; Wed, 14 Sep 2005 14:08:24 +0100
Received: from [192.168.12.17] ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j8ED8Mt22013;
	Wed, 14 Sep 2005 18:08:22 +0500
Message-ID: <432820C6.2050906@ru.mvista.com>
Date:	Wed, 14 Sep 2005 17:08:22 +0400
From:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]  Fix module insertion fail for TX4927/TX4938 platforms
References: <20050913124544.GC3224@linux-mips.org>	<20050913133126.GO23161@lug-owl.de>	<20050913152038.GE3224@linux-mips.org> <17191.61757.80884.8289@mips.com> <43281DC3.8010602@ru.mvista.com> <43281F6E.3010807@ru.mvista.com> <43281FE6.4070102@ru.mvista.com>
In-Reply-To: <43281FE6.4070102@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------080609060704000107050501"
Return-Path: <vbarinov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbarinov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080609060704000107050501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello All!

This patch fixes module insertion fail for TX4927/TX4938 platforms for 
several drivers:
*** Warning: "__wbflush" [fs/reiserfs/reiserfs.ko] undefined!
*** Warning: "__wbflush" [fs/jbd/jbd.ko] undefined!
*** Warning: "__wbflush" [drivers/usb/gadget/net2280.ko] undefined!
*** Warning: "__wbflush" [drivers/usb/gadget/g_serial.ko] undefined!
*** Warning: "__wbflush" [drivers/net/ppp_generic.ko] undefined!

Does it makes sence to push it in?

Regards,
Vladimir


--------------080609060704000107050501
Content-Type: text/plain;
 name="pro_mips_tx4927_modules_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pro_mips_tx4927_modules_fix.patch"

Signed-off-by: Vladimir Barinov <vbarinov@ru.mvista.com>
Description:
	Fix module insertion fail on TX4927/TX4938 platforms

Index: linux-2.6.10/arch/mips/tx4927/common/tx4927_setup.c
===================================================================
--- linux-2.6.10.orig/arch/mips/tx4927/common/tx4927_setup.c
+++ linux-2.6.10/arch/mips/tx4927/common/tx4927_setup.c
@@ -231,3 +231,5 @@ void pk0(void)
 	printk("k0=[0x%08x]\n", val);
 }
 #endif
+
+EXPORT_SYMBOL(__wbflush);
Index: linux-2.6.10/arch/mips/tx4938/common/setup.c
===================================================================
--- linux-2.6.10.orig/arch/mips/tx4938/common/setup.c
+++ linux-2.6.10/arch/mips/tx4938/common/setup.c
@@ -89,3 +89,5 @@ void __init tx4938_timer_setup(struct ir
 	write_c0_compare(count);
 	c2 = read_c0_count();
 }
+
+EXPORT_SYMBOL(__wbflush);

--------------080609060704000107050501--
