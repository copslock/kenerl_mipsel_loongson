Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 11:36:24 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:56321 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492446AbZKFKfy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Nov 2009 11:35:54 +0100
Received: by pxi26 with SMTP id 26so296442pxi.21
        for <multiple recipients>; Fri, 06 Nov 2009 02:35:47 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=dHdF0lr83O7PBM9D1BXChl4X9xhnovCCOBawyPlNbeg=;
        b=taq501b9LMLRAYjKfy5E5HH1qjxLa97SNAdKg+DY/Pwt9fNDgTsnTmHpSbTlG4eiy+
         mHvyBfC12h4kh3U0m08fTJ5SpWKA60J75omutV6TbyT9vs4MkQ2TV9luyYOFzAM1x4z1
         aawGk/Vde1QWAG+bt7k67qd+jedDDNEdQyBx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QqDn68oJ3kvy5ZDRfdq2KxCFdkkMwPa9DZr5HhOM6rgjxcUD/O63MEbj1vXYcz2hoe
         Te8vxaXGkwanq64MpaqJEi/1YLbQWaym2pAVAfuOZoxyieDT1OJ5ohlBER2qcglT2X+4
         jC+Pf3jRMGieSrp2W/6V1MeXQqV1s+RvMQPt4=
Received: by 10.115.132.5 with SMTP id j5mr6459474wan.129.1257503747123;
        Fri, 06 Nov 2009 02:35:47 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1679219pzk.10.2009.11.06.02.35.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 02:35:46 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 1/2] [loongson] Cleanup the machtype support
Date:	Fri,  6 Nov 2009 18:35:33 +0800
Message-Id: <905f2e99289a26852bf8d413f0e56ef2235cac99.1257503696.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257503025.git.wuzhangjin@gmail.com>
References: <cover.1257503025.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257503696.git.wuzhangjin@gmail.com>
References: <cover.1257503696.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

We need to initialize mips_machtype as early as we can, So, we can
choose corresponding code for different machines via it.

This patch moves the initialization of mips_machtype to prom_init().

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/mach-loongson/loongson.h |    1 +
 arch/mips/loongson/common/cmdline.c            |    4 +++-
 arch/mips/loongson/common/machtype.c           |   17 ++++++++++-------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index e6869aa..efb2344 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -29,6 +29,7 @@ extern unsigned long memsize, highmemsize;
 /* loongson-specific command line, env and memory initialization */
 extern void __init prom_init_memory(void);
 extern void __init prom_init_cmdline(void);
+extern void __init prom_init_machtype(void);
 extern void __init prom_init_env(void);
 
 /* irq operation functions */
diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
index 75f1b24..7ad47f2 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -9,7 +9,7 @@
  * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzj@lemote.com
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -49,4 +49,6 @@ void __init prom_init_cmdline(void)
 		strcat(arcs_cmdline, " console=ttyS0,115200");
 	if ((strstr(arcs_cmdline, "root=")) == NULL)
 		strcat(arcs_cmdline, " root=/dev/hda1");
+
+	prom_init_machtype();
 }
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 7b34824..87b502f 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -27,24 +27,27 @@ static const char *system_types[] = {
 
 const char *get_system_type(void)
 {
-	if (mips_machtype == MACH_UNKNOWN)
-		mips_machtype = LOONGSON_MACHTYPE;
-
 	return system_types[mips_machtype];
 }
 
-static __init int machtype_setup(char *str)
+void __init prom_init_machtype(void)
 {
+	char *str, *p;
 	int machtype = MACH_LEMOTE_FL2E;
 
+	mips_machtype = LOONGSON_MACHTYPE;
+
+	str = strstr(arcs_cmdline, "machtype=");
 	if (!str)
-		return -EINVAL;
+		return;
+	str += strlen("machtype=");
+	p = strstr(str, " ");
+	if (p)
+		*p++ = '\0';
 
 	for (; system_types[machtype]; machtype++)
 		if (strstr(system_types[machtype], str)) {
 			mips_machtype = machtype;
 			break;
 		}
-	return 0;
 }
-__setup("machtype=", machtype_setup);
-- 
1.6.2.1
