Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Sep 2009 08:22:08 +0200 (CEST)
Received: from mail-pz0-f175.google.com ([209.85.222.175]:42054 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491851AbZIEGWB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Sep 2009 08:22:01 +0200
Received: by pzk5 with SMTP id 5so1297646pzk.10
        for <multiple recipients>; Fri, 04 Sep 2009 23:21:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=8+9KmVDvJ2rAQPBA4FihJPrCl/XrQKisFG4GgmwVtBQ=;
        b=sm3XkjjBcgSjndic93NxpohN3+UPzNPSreivNL1JkFk3DumE2CDl+RFTdmGVIkRzMz
         QR64bNTdZP4Dn9qI3ay4UyAavuWY14yeitSkc1JsclPD6NHQjwu8eYzVESfL4B2GofIO
         TzifJ/W5FKfiBZ+UF1yknWx2xMbmCOdb2rxqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SfFsu/P4kbqex5+0e07NrkZSaTqfKFttjBKuCGhObFs1DECLqlCHgkULFED0ip1/gM
         wEi7hSJ2ytzQwFlhne+LCyB6g+26zBJr8fwelzsV1pq6oydlQRJmVlILMMsptAflWd5+
         32WnsqKoHihueeY5ff5yUAefkIWwZohh1ZZdw=
Received: by 10.115.113.9 with SMTP id q9mr11215090wam.224.1252131712619;
        Fri, 04 Sep 2009 23:21:52 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm687173pzk.14.2009.09.04.23.21.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Sep 2009 23:21:51 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, Jason Wessel <jason.wessel@windriver.com>,
	Zhang Le <r0bertz@gentoo.org>,
	Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH 1/3] [loongson] eary_printk: Remove existing implementation
Date:	Sat,  5 Sep 2009 14:21:33 +0800
Message-Id: <1252131693-27424-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

This patch will remove the existing implementation of early_printk in
fulong. for this old implementation is based on the board-specific
source code(dbg_io.c), but dbg_io.c is out-of-date:

as the commit: 8d60a903d986ffa26c41f0092320a3b9da20bfaf shows, dbg_io.c
is not needed. it will be removed in the next patch, and the new
implementation of early_printk will be added later.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/lemote/lm2e/prom.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/mips/lemote/lm2e/prom.c b/arch/mips/lemote/lm2e/prom.c
index 7edc15d..d78cedf 100644
--- a/arch/mips/lemote/lm2e/prom.c
+++ b/arch/mips/lemote/lm2e/prom.c
@@ -21,7 +21,6 @@
 extern unsigned long bus_clock;
 extern unsigned long cpu_clock_freq;
 extern unsigned int memsize, highmemsize;
-extern int putDebugChar(unsigned char byte);
 
 static int argc;
 /* pmon passes arguments in 32bit pointers */
@@ -90,8 +89,3 @@ do {									\
 void __init prom_free_prom_memory(void)
 {
 }
-
-void prom_putchar(char c)
-{
-	putDebugChar(c);
-}
-- 
1.6.2.1
