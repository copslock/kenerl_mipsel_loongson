Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 18:35:05 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:44470 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494065AbZKSReh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 18:34:37 +0100
Received: by mail-pw0-f45.google.com with SMTP id 15so1593489pwi.24
        for <multiple recipients>; Thu, 19 Nov 2009 09:34:37 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+ey1dWPjERL8jNkFcXjSdjfKyxlVDOGBtzovgVJNKG8=;
        b=UjpKP1iJBdQKuZxczUydeMRQt5f5z4K6sUyWYjwO/uDiprWJJP4lSYntPk1enJX99T
         4TOS/sSbFKx+nabrMDMq45utdT3uE/jq9Nx9b2autRAdyKn5/KZOCEh3eDTnjYmDeCtW
         TACgl5wxzuZlAD9hlRdCVyXBTVuS2xUBsewPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OglhZFmwdoF28cBY2f0Ym11x+qvDjGHW5qiDb/u7K4yALSyDkJ3A1iiCjhF6dEdoRs
         CzSseCukQhZjvb+37VOobwi/c32qhqOePk6/9bQ3Yovm5X5LSbK7ifvndm2fNO6SRL34
         VpneIiDcLHzCU6Dl1OHQK0aD8XGTN2tUz5iLc=
Received: by 10.114.188.21 with SMTP id l21mr254402waf.138.1258652077071;
        Thu, 19 Nov 2009 09:34:37 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm480365pxi.10.2009.11.19.09.34.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 09:34:36 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
	huhb@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 4/5] [loongson] yeeloong2f: cleanup the reset logic with ec_write function
Date:	Fri, 20 Nov 2009 01:34:27 +0800
Message-Id: <783e2d9ff87ec5f62ffe308124ea17aa4acdee22.1258651050.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1258651050.git.wuzhangjin@gmail.com>
References: <cover.1258651050.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

A commen ec_read/ec_write function is defined in "[loongson] yeeloong2f:
add basic ec operations", So, we can use it here to cleanup the reset
logic of yeeloong2f netbook.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/lemote-2f/reset.c |   21 ++-------------------
 1 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/reset.c b/arch/mips/loongson/lemote-2f/reset.c
index 44bb984..51d1a60 100644
--- a/arch/mips/loongson/lemote-2f/reset.c
+++ b/arch/mips/loongson/lemote-2f/reset.c
@@ -20,6 +20,7 @@
 #include <loongson.h>
 
 #include <cs5536/cs5536.h>
+#include "ec_kb3310b.h"
 
 static void reset_cpu(void)
 {
@@ -75,30 +76,12 @@ static void fl2f_shutdown(void)
 
 /* reset support for yeeloong2f and mengloong2f notebook */
 
-/*
- * The following registers are determined by the EC index configuration.
- * 1. fill the PORT_HIGH as EC register high part.
- * 2. fill the PORT_LOW as EC register low part.
- * 3. fill the PORT_DATA as EC register write data or get the data from it.
- */
-
-#define	EC_IO_PORT_HIGH	0x0381
-#define	EC_IO_PORT_LOW	0x0382
-#define	EC_IO_PORT_DATA	0x0383
-#define	REG_RESET_HIGH	0xF4	/* reset the machine auto-clear : rd/wr */
-#define REG_RESET_LOW	0xEC
-#define	BIT_RESET_ON	(1 << 0)
-
 void ml2f_reboot(void)
 {
 	reset_cpu();
 
 	/* sending an reset signal to EC(embedded controller) */
-	outb(REG_RESET_HIGH, EC_IO_PORT_HIGH);
-	outb(REG_RESET_LOW, EC_IO_PORT_LOW);
-	mmiowb();
-	outb(BIT_RESET_ON, EC_IO_PORT_DATA);
-	mmiowb();
+	ec_write(REG_RESET, BIT_RESET_ON);
 }
 
 #define yl2f89_reboot ml2f_reboot
-- 
1.6.2.1
