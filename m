Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 19:21:36 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:49405 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493077AbZH0RV3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Aug 2009 19:21:29 +0200
Received: by ewy25 with SMTP id 25so1397283ewy.33
        for <multiple recipients>; Thu, 27 Aug 2009 10:21:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=CR1+DfucO1IHOj8yF1O5mSiGkZpeiJn7Dz5pz9ViUNc=;
        b=UqVtNbj/HwnW8lHhyfNf4pizbvbUW5by1vA0/6f1SHO/JTUdIFmqKbJ8N6d0HGowdD
         8pTopu3KnJEgLxSLuf/OCtGA3YzDSt1TXbAUZY3U58XAhV5e0sSuC9XnCmOSbtHXY3pw
         88dNfRGhWrN0ZqMxSPpmIqYqIPpIzkdyMTAw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nR8cYJWRXwJEtNx0ouuFzdFhQik8i7+GGV53M0fPXRmeVk0udEW7m6yCJOcQT8q5kX
         HA2W/EeJ9sZmVimq5aHXlZC8zu2xLmgCvwL+YMRk13/h3i37uEfgUk61Ow+3Di76I+Rs
         fVw4ZVH1/wHix4qcO92a2T8i6PiuoiQj2ZAzE=
Received: by 10.216.6.198 with SMTP id 48mr1864567wen.200.1251393683295;
        Thu, 27 Aug 2009 10:21:23 -0700 (PDT)
Received: from localhost.localdomain (p5496E57B.dip.t-dialin.net [84.150.229.123])
        by mx.google.com with ESMTPS id g9sm1537564gvc.13.2009.08.27.10.21.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 10:21:22 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] Alchemy: override loops_per_jiffy detection
Date:	Thu, 27 Aug 2009 19:21:18 +0200
Message-Id: <1251393678-28607-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.4
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

loops_per_jiffy depends on coreclk speed;  preset it instead of
letting the kernel waste precious microseconds trying to approximate it.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
V2: no need to exclude MACH_ALCHEMY from GENERIC_CALIBRATE_DELAY
    setting preset_lpj early is enough.

As always, run-tested on DB1200 and another Au1200 system.

 arch/mips/alchemy/common/setup.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 3f036b3..6184baa 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -27,6 +27,7 @@
 
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/pm.h>
 
@@ -53,6 +54,9 @@ void __init plat_mem_setup(void)
 	printk(KERN_INFO "(PRId %08x) @ %lu.%02lu MHz\n", read_c0_prid(),
 	       est_freq / 1000000, ((est_freq % 1000000) * 100) / 1000000);
 
+	/* this is faster than wasting cycles trying to approximate it */
+	preset_lpj = (est_freq >> 1) / HZ;
+
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	pm_power_off = au1000_power_off;
-- 
1.6.4
