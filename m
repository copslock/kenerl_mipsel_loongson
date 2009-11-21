Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2009 12:06:40 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:43257 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492279AbZKULFp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2009 12:05:45 +0100
Received: by mail-px0-f173.google.com with SMTP id 3so2973133pxi.22
        for <multiple recipients>; Sat, 21 Nov 2009 03:05:44 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=+ey1dWPjERL8jNkFcXjSdjfKyxlVDOGBtzovgVJNKG8=;
        b=BlnBb/5mTSk3d4FLcGrDaI1gmJHqY13cYYbZki1GBAT9jO/eb1LNbryEGE8wWyWLyT
         Cy3vLa+h+2oPL6GlB3a1AzsKfemv649TyWW7hNQ+HTncYS7rOKjssjk2f2af5L9lCKhE
         hR5CHwHSjmTV3cHj7pgsyYcHLyXUmx5PI7KvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QdM0FfuuxHe0qhP/9uWGOVWkPjDoT8+U0FVZK/JicXS1m0zfEnTyw9dDJ4h4itUvOP
         WfdYGAwkAGuzQBRGN7e0toNhoSZO1i+8SGcJXuVzczx1gqQm6y1Svo5tA4W8jCmW2IZ9
         S7LnshH1y1QoU/Wu4HKpRHjF634+jS94h1hnk=
Received: by 10.114.50.17 with SMTP id x17mr3496218wax.168.1258801544696;
        Sat, 21 Nov 2009 03:05:44 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1508374pxi.4.2009.11.21.03.05.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 03:05:44 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 4/4] [loongson] yeeloong2f: cleanup the reset logic with ec_write function
Date:	Sat, 21 Nov 2009 19:05:25 +0800
Message-Id: <6dcb6241dda22fe6255b1f74e784f8b20214413c.1258800842.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <b983b517f93e13dda9d76c3d1719999b0593b9d3.1258800842.git.wuzhangjin@gmail.com>
References: <cover.1258800842.git.wuzhangjin@gmail.com>
 <cd8541a74bab41734a44dfedcbc63688d165e35e.1258800842.git.wuzhangjin@gmail.com>
 <be09037e3ccaae045f2832f8428d5aa098cc7480.1258800842.git.wuzhangjin@gmail.com>
 <b983b517f93e13dda9d76c3d1719999b0593b9d3.1258800842.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258800842.git.wuzhangjin@gmail.com>
References: <cover.1258800842.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25015
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
