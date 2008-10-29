Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 00:28:56 +0000 (GMT)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58293 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S22681875AbYJ2VWI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 21:22:08 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9TLLYVH009839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Oct 2008 14:21:35 -0700
Received: from localhost.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9TLLXQF019907;
	Wed, 29 Oct 2008 14:21:33 -0700
Message-Id: <200810292121.m9TLLXQF019907@imap1.linux-foundation.org>
Subject: [patch 2/3] drivers/rtc/rtc-ds1286.c is borked
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, akpm@linux-foundation.org,
	alessandro.zummo@towertech.it, tsbogend@alpha.franken.de
From:	akpm@linux-foundation.org
Date:	Wed, 29 Oct 2008 14:21:33 -0700
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

From: Andrew Morton <akpm@linux-foundation.org>

drivers/rtc/rtc-ds1286.c: In function 'ds1286_rtc_read':
drivers/rtc/rtc-ds1286.c:33: error: implicit declaration of function '__raw_readl'
drivers/rtc/rtc-ds1286.c: In function 'ds1286_rtc_write':
drivers/rtc/rtc-ds1286.c:38: error: implicit declaration of function '__raw_writel'
drivers/rtc/rtc-ds1286.c: In function 'ds1286_probe':
drivers/rtc/rtc-ds1286.c:345: error: implicit declaration of function 'ioremap'
drivers/rtc/rtc-ds1286.c:345: warning: assignment makes pointer from integer without a cast
drivers/rtc/rtc-ds1286.c:365: error: implicit declaration of function 'iounmap'

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/rtc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/rtc/Kconfig~drivers-rtc-rtc-ds1286c-is-borked drivers/rtc/Kconfig
--- a/drivers/rtc/Kconfig~drivers-rtc-rtc-ds1286c-is-borked
+++ a/drivers/rtc/Kconfig
@@ -373,6 +373,7 @@ config RTC_DRV_DS1216
 
 config RTC_DRV_DS1286
 	tristate "Dallas DS1286"
+	depends on MIPS
 	help
 	  If you say yes here you get support for the Dallas DS1286 RTC chips.
 
_
