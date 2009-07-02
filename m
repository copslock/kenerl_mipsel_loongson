Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 17:24:20 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:49946 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492196AbZGBPYN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 17:24:13 +0200
Received: by ewy10 with SMTP id 10so2093309ewy.0
        for <multiple recipients>; Thu, 02 Jul 2009 08:18:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8+9KmVDvJ2rAQPBA4FihJPrCl/XrQKisFG4GgmwVtBQ=;
        b=amSH/VKK1fVDusz5NxqV/cA0X8JW7x42W8oOv3OjccrSvM4hRAVs/qQHM/0x6V6kcQ
         OTWAOUnHxlqMWfRVbkT4C0glGEbBeKZx78uIF7I/ZmHuNYTFCU4o5yvpok6ZG9phMMi8
         UWQcarK+VK47yFHxSV61h4XJJIn+Pz0XRSBPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QagfQsN1/I8QfpyrRM/Cm8Hsa13QIB3lzhoncHBSXC8Wyv2ujRIPpnx39FxnL0PwDF
         JQBQe5zzR/H4MvY/X3qFDps45TGqA59VJLIkFO7dMfgznUybBZt4ubsUR+C3R6Lf46Eu
         FO9Bxb1DWArWDBCZCNVukkpGP8CnhNjjZnqwg=
Received: by 10.210.133.2 with SMTP id g2mr1116297ebd.23.1246547902095;
        Thu, 02 Jul 2009 08:18:22 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 24sm3146677eyx.23.2009.07.02.08.18.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 08:18:21 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Jason Wessel <jason.wessel@windriver.com>
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH v4 01/16] [loongson] eary_printk: Remove existing implementation
Date:	Thu,  2 Jul 2009 23:18:09 +0800
Message-Id: <5ba055de70110a166fdffb2871d3207c9abb4d48.1246546684.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1246546684.git.wuzhangjin@gmail.com>
References: <cover.1246546684.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23613
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
