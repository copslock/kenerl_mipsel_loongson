Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 17:33:20 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:62210 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492214AbZGBPdK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 17:33:10 +0200
Received: by mail-ew0-f214.google.com with SMTP id 10so2101362ewy.0
        for <multiple recipients>; Thu, 02 Jul 2009 08:27:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uzVk24w4HMBH7OPtI9aIFtXGGeRoQt1SJVCI3+FvZtY=;
        b=I38+W09OEnFrscHwpxlqd3aloc6eoY/oSScriEfmZ1DFT4u/i1pjIoHEKQIPzSQje/
         XuAumUsIal/11lA3zJVLjpQp4UOv+JS+V11h/jyL4HbBiE5SIdehLpGT9xieyrLMLONi
         7leeZXQImkINGEjoia/nQiFXC6Lo415a679RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RajVVNhuN/ZvurP8zfcK0ZRI0GBP/bpfZ/xgP7Hw0+YoDdEgvLmGGXmQMSr8jK+QbN
         fQPZr76dDsZsFq61fRZLcfcfuJKpulWsQ3poy6gJhHDPTFhAznVgB8IgcQme1idXW9qs
         3EmyRVjyP1f/beSpZGi/r7QqsLoj8glfQJV3c=
Received: by 10.216.16.212 with SMTP id h62mr43068weh.201.1246548444943;
        Thu, 02 Jul 2009 08:27:24 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id p10sm5885401gvf.19.2009.07.02.08.27.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Jul 2009 08:27:23 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH v4 14/16] [loongson] add a machtype kernel command line argument
Date:	Thu,  2 Jul 2009 23:27:12 +0800
Message-Id: <d97ad699b3ad3974110bf5e813682962ee075a84.1246546684.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1246546684.git.wuzhangjin@gmail.com>
References: <cover.1246546684.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

the difference between some loongson-based machines is very small, so,
if there is no necessary to add new kernel config options to cope with
	this difference, it will be better to share the same kernel
	image file between them, benefit from this, the linux
	distribution developers only have a need to compile the kernel
	one time.

this machtype kernel command line argument will be used later to share
the same kernel image file between two different machines(menglong &
yeeloong) made by lemote.

thanks very much to Zhang Le for cleaning up the machtype
implementation.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 Documentation/kernel-parameters.txt           |    4 +++
 arch/mips/include/asm/bootinfo.h              |   12 ++++++++
 arch/mips/include/asm/mach-loongson/machine.h |    2 +-
 arch/mips/loongson/common/Makefile            |    2 +-
 arch/mips/loongson/common/machtype.c          |   35 ++++++++++++++++++++++++-
 arch/mips/loongson/fuloong-2e/Makefile        |    2 +-
 6 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index d77fbd8..3e95d29 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1243,6 +1243,10 @@ and is between 256 and 4096 characters. It is defined in the file
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
 
+	machtype=	[Loongson] Share the same kernel image file between different
+			 yeeloong laptop.
+			Example: machtype=lemote-yeeloong-2f-7inch
+
 	max_addr=nn[KMG]	[KNL,BOOT,ia64] All physical memory greater
 			than or equal to this physical address is ignored.
 
diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
index 610fe3a..f5dfaf6 100644
--- a/arch/mips/include/asm/bootinfo.h
+++ b/arch/mips/include/asm/bootinfo.h
@@ -7,6 +7,7 @@
  * Copyright (C) 1995, 1996 Andreas Busse
  * Copyright (C) 1995, 1996 Stoned Elipot
  * Copyright (C) 1995, 1996 Paul M. Antoine.
+ * Copyright (C) 2009       Zhang Le
  */
 #ifndef _ASM_BOOTINFO_H
 #define _ASM_BOOTINFO_H
@@ -57,6 +58,17 @@
 #define	MACH_MIKROTIK_RB532	0	/* Mikrotik RouterBoard 532 	*/
 #define MACH_MIKROTIK_RB532A	1	/* Mikrotik RouterBoard 532A 	*/
 
+/*
+ * Valid machtype for Loongson family
+ */
+#define MACH_LOONGSON_UNKNOWN  0
+#define MACH_LEMOTE_FL2E       1
+#define MACH_LEMOTE_FL2F       2
+#define MACH_LEMOTE_ML2F7      3
+#define MACH_LEMOTE_YL2F89     4
+#define MACH_DEXXON_GDIUM2F10  5
+#define MACH_LOONGSON_END      6
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 extern char *system_type;
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index 8e60d36..206ea20 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -15,7 +15,7 @@
 
 #define LOONGSON_UART_BASE (BONITO_PCIIO_BASE + 0x3f8)
 
-#define LOONGSON_MACHNAME "lemote-fuloong-2e-box"
+#define LOONGSON_MACHTYPE MACH_LEMOTE_FL2E
 
 #endif
 
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index 4e3889d..656b3cc 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y += setup.o init.o cmdline.o env.o time.o reset.o irq.o \
-    pci.o bonito-irq.o mem.o
+    pci.o bonito-irq.o mem.o machtype.o
 
 #
 # Early printk support
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 845b3fb..7b34824 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -2,16 +2,49 @@
  * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
  * Author: Wu Zhangjin, wuzj@lemote.com
  *
+ * Copyright (c) 2009 Zhang Le <r0bertz@gentoo.org>
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
+#include <linux/errno.h>
+#include <asm/bootinfo.h>
 
+#include <loongson.h>
 #include <machine.h>
 
+static const char *system_types[] = {
+	[MACH_LOONGSON_UNKNOWN]         "unknown loongson machine",
+	[MACH_LEMOTE_FL2E]              "lemote-fuloong-2e-box",
+	[MACH_LEMOTE_FL2F]              "lemote-fuloong-2f-box",
+	[MACH_LEMOTE_ML2F7]             "lemote-mengloong-2f-7inches",
+	[MACH_LEMOTE_YL2F89]            "lemote-yeeloong-2f-8.9inches",
+	[MACH_DEXXON_GDIUM2F10]         "dexxon-gidum-2f-10inches",
+	[MACH_LOONGSON_END]             NULL,
+};
+
 const char *get_system_type(void)
 {
-	return LOONGSON_MACHNAME;
+	if (mips_machtype == MACH_UNKNOWN)
+		mips_machtype = LOONGSON_MACHTYPE;
+
+	return system_types[mips_machtype];
 }
 
+static __init int machtype_setup(char *str)
+{
+	int machtype = MACH_LEMOTE_FL2E;
+
+	if (!str)
+		return -EINVAL;
+
+	for (; system_types[machtype]; machtype++)
+		if (strstr(system_types[machtype], str)) {
+			mips_machtype = machtype;
+			break;
+		}
+	return 0;
+}
+__setup("machtype=", machtype_setup);
diff --git a/arch/mips/loongson/fuloong-2e/Makefile b/arch/mips/loongson/fuloong-2e/Makefile
index 96e45c1..3aba5fc 100644
--- a/arch/mips/loongson/fuloong-2e/Makefile
+++ b/arch/mips/loongson/fuloong-2e/Makefile
@@ -2,6 +2,6 @@
 # Makefile for Lemote Fuloong2e mini-PC board.
 #
 
-obj-y += irq.o reset.o machtype.o
+obj-y += irq.o reset.o
 
 EXTRA_CFLAGS += -Werror
-- 
1.6.2.1
