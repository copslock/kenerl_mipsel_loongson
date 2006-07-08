Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2006 18:35:33 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:46600 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S8133557AbWGHRfX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Jul 2006 18:35:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 5EE067F4028
	for <linux-mips@linux-mips.org>; Sat,  8 Jul 2006 19:35:17 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09040-07 for <linux-mips@linux-mips.org>;
	Sat, 8 Jul 2006 19:35:17 +0200 (CEST)
Received: from [192.168.4.4] (port-212-202-198-187.dynamic.qsc.de [212.202.198.187])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTP id F2C587F4024
	for <linux-mips@linux-mips.org>; Sat,  8 Jul 2006 19:35:16 +0200 (CEST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Transfer-Encoding: 7bit
Message-Id: <B4CE0C51-47B5-4F72-8008-08549262B4F0@caiaq.de>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To:	linux-mips@linux-mips.org
From:	Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] remove double entry of FB_AU1200 in drivers/video/Kconfig
Date:	Sat, 8 Jul 2006 19:35:12 +0200
X-Mailer: Apple Mail (2.752.2)
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips

Signed-off-by: Daniel Mack <daniel@caiaq.de>


diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 335d37a..a810581 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1353,17 +1353,6 @@ config FB_AU1200
           various panels and CRTs by passing in kernel cmd line option
           au1200fb:panel=<name>.
-config FB_AU1200
-       bool "Au1200 LCD Driver"
-       depends on FB && MIPS && SOC_AU1200
-       select FB_CFB_FILLRECT
-       select FB_CFB_COPYAREA
-       select FB_CFB_IMAGEBLIT
-       help
-         This is the framebuffer driver for the AMD Au1200 SOC.  It  
can drive
-         various panels and CRTs by passing in kernel cmd line option
-         au1200fb:panel=<name>.
-
source "drivers/video/geode/Kconfig"
config FB_FFB
