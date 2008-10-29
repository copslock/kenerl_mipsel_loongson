Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 00:27:40 +0000 (GMT)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:27088 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S22681877AbYJ2VWJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 21:22:09 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9TLLZBl009841
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Oct 2008 14:21:36 -0700
Received: from localhost.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9TLLYjd019910;
	Wed, 29 Oct 2008 14:21:34 -0700
Message-Id: <200810292121.m9TLLYjd019910@imap1.linux-foundation.org>
Subject: [patch 3/3] drivers/rtc/rtc-m48t35.c is borked too
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, akpm@linux-foundation.org,
	alessandro.zummo@towertech.it, tsbogend@alpha.franken.de
From:	akpm@linux-foundation.org
Date:	Wed, 29 Oct 2008 14:21:34 -0700
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

From: Andrew Morton <akpm@linux-foundation.org>

drivers/rtc/rtc-m48t35.c: In function 'm48t35_read_time':
drivers/rtc/rtc-m48t35.c:59: error: implicit declaration of function 'readb'
drivers/rtc/rtc-m48t35.c:60: error: implicit declaration of function 'writeb'
drivers/rtc/rtc-m48t35.c: In function 'm48t35_probe':
drivers/rtc/rtc-m48t35.c:168: error: implicit declaration of function 'ioremap'
drivers/rtc/rtc-m48t35.c:168: warning: assignment makes pointer from integer without a cast
drivers/rtc/rtc-m48t35.c:188: error: implicit declaration of function 'iounmap'

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/rtc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/rtc/Kconfig~drivers-rtc-rtc-m48t35c-is-borked-too drivers/rtc/Kconfig
--- a/drivers/rtc/Kconfig~drivers-rtc-rtc-m48t35c-is-borked-too
+++ a/drivers/rtc/Kconfig
@@ -432,6 +432,7 @@ config RTC_DRV_M48T86
 
 config RTC_DRV_M48T35
 	tristate "ST M48T35"
+	depends on MIPS
 	help
 	  If you say Y here you will get support for the
 	  ST M48T35 RTC chip.
_
