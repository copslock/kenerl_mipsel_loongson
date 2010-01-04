Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2010 10:21:02 +0100 (CET)
Received: from mail-yw0-f182.google.com ([209.85.211.182]:60952 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493175Ab0ADJSR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2010 10:18:17 +0100
Received: by mail-yw0-f182.google.com with SMTP id 12so15942361ywh.21
        for <multiple recipients>; Mon, 04 Jan 2010 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=z875z+DDrW3DiHp2uLuyd/ZLP37LaoqyclvkwinhSjk=;
        b=k8Db7+mfpyyf6lGH1yPEpWm7DLdaEifR9ElCdAgON9GgJwgx7KUugtJ6OYzVrD0tE6
         hXStyjkyV3i+w5Ayx79H3fafAmQTVxyZzADtowvlFoiHoqVuqctdFtjV/JPW9xtznga0
         iuKwAhV/2N0s6CgUYR/OEWeh3X3c1ABHnf4Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TAQu6CmqsLkH7ccYejnGqY5ZYvtJcyntka2MUMxmxa8RF2zL6N/Pp0xKh1Sf4ri34f
         PlMzJTnyjqZL1BHC+2Pflz22WR/uwuyIY3Do/AD2pkss4qeqlwSzXXXeOVor8bZWr6ZO
         TQeip1e3w+pSAEf7T4sbKiTCgHslFAJvjpmHU=
Received: by 10.100.56.12 with SMTP id e12mr9691102ana.106.1262596696330;
        Mon, 04 Jan 2010 01:18:16 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 21sm6122077ywh.16.2010.01.04.01.18.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 01:18:15 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, yanh@lemote.com, huhb@lemote.com,
        zhangfx@lemote.com, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 09/10] Loongson: Change the Email address of Wu Zhangjin
Date:   Mon,  4 Jan 2010 17:16:51 +0800
Message-Id: <0e20c65b9bd040888cfc95401a5a84245e1e92de.1262596493.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.5.6
In-Reply-To: <d67be5cfd6f258043964e9c19c0467611e6d4ce3.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262586650.git.wuzhangjin@gmail.com>
 <f4aeb125cb030f10d34966febfe9715874d52ab2.1262596493.git.wuzhangjin@gmail.com>
 <669ff2f39fd2aa3849e472438d3d9d499c8f0e3a.1262596493.git.wuzhangjin@gmail.com>
 <9bcc0f00c46fdf5c832ce3bdd0df8d7f08b7a1be.1262596493.git.wuzhangjin@gmail.com>
 <dc64ae336edaf61405e56534e33fe40c49694378.1262596493.git.wuzhangjin@gmail.com>
 <a5bac10a774e405cffcf79edc430b31d6becb0d0.1262596493.git.wuzhangjin@gmail.com>
 <b36e03d26901b981248854fcaa645d8c8a0f23a8.1262596493.git.wuzhangjin@gmail.com>
 <0340ef8c9de1f84261bac07c74f435f719eaa65d.1262596493.git.wuzhangjin@gmail.com>
 <d67be5cfd6f258043964e9c19c0467611e6d4ce3.1262596493.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1262596493.git.wuzhangjin@gmail.com>
References: <cover.1262596493.git.wuzhangjin@gmail.com>
X-archive-position: 25507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2270

From: Wu Zhangjin <wuzhangjin@gmail.com>

Currently, The Email address wuzj@lemote.com is not usable, Change it by
wuzhangjin@gmail.com.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile                 |    2 +-
 arch/mips/boot/compressed/decompress.c             |    4 ++--
 arch/mips/include/asm/ftrace.h                     |    2 +-
 .../asm/mach-loongson/cpu-feature-overrides.h      |    2 +-
 .../include/asm/mach-loongson/cs5536/cs5536_vsm.h  |    2 +-
 arch/mips/include/asm/mach-loongson/loongson.h     |    3 +--
 arch/mips/include/asm/mach-loongson/machine.h      |    4 ++--
 arch/mips/include/asm/mach-loongson/mem.h          |    2 +-
 arch/mips/include/asm/mach-loongson/pci.h          |   13 +------------
 arch/mips/kernel/ftrace.c                          |    2 +-
 arch/mips/kernel/mcount.S                          |    2 +-
 arch/mips/loongson/common/cmdline.c                |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_acc.c      |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_ehci.c     |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_ide.c      |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_isa.c      |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_mfgpt.c    |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_ohci.c     |    2 +-
 arch/mips/loongson/common/cs5536/cs5536_pci.c      |    2 +-
 arch/mips/loongson/common/early_printk.c           |    2 +-
 arch/mips/loongson/common/env.c                    |    4 ++--
 arch/mips/loongson/common/init.c                   |    2 +-
 arch/mips/loongson/common/machtype.c               |    2 +-
 arch/mips/loongson/common/platform.c               |    2 +-
 arch/mips/loongson/common/pm.c                     |    2 +-
 arch/mips/loongson/common/reset.c                  |    2 +-
 arch/mips/loongson/common/serial.c                 |    2 +-
 arch/mips/loongson/common/time.c                   |    4 ++--
 arch/mips/loongson/common/uart_base.c              |    2 +-
 arch/mips/loongson/fuloong-2e/reset.c              |    4 ++--
 arch/mips/loongson/lemote-2f/machtype.c            |    2 +-
 arch/mips/loongson/lemote-2f/pm.c                  |    2 +-
 arch/mips/loongson/lemote-2f/reset.c               |    2 +-
 arch/mips/oprofile/op_model_loongson2.c            |    2 +-
 arch/mips/pci/ops-loongson2.c                      |    4 +---
 arch/mips/power/cpu.c                              |    4 ++--
 arch/mips/power/hibernate.S                        |    4 ++--
 drivers/staging/sm7xx/smtc2d.c                     |    2 +-
 drivers/staging/sm7xx/smtc2d.h                     |    2 +-
 drivers/staging/sm7xx/smtcfb.c                     |    2 +-
 drivers/staging/sm7xx/smtcfb.h                     |    2 +-
 41 files changed, 48 insertions(+), 62 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index e27f40b..2a768c6 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -9,7 +9,7 @@
 # modified by Cort (cort@cs.nmt.edu)
 #
 # Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University
-# Author: Wu Zhangjin <wuzj@lemote.com>
+# Author: Wu Zhangjin <wuzhangjin@gmail.com>
 #
 
 # compressed kernel load addr: VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 67330c2..9125138 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -5,8 +5,8 @@
  * Author: Matt Porter <mporter@mvista.com> Derived from
  * arch/ppc/boot/prep/misc.c
  *
- * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
- * Author: Wu Zhangjin <wuzj@lemote.com>
+ * Copyright (C) 2009 Lemote, Inc.
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index 3986cd8..ce35c9a 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -4,7 +4,7 @@
  * more details.
  *
  * Copyright (C) 2009 DSLab, Lanzhou University, China
- * Author: Wu Zhangjin <wuzj@lemote.com>
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  */
 
 #ifndef _ASM_MIPS_FTRACE_H
diff --git a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
index 9947e57..16210ce 100644
--- a/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson/cpu-feature-overrides.h
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2009 Wu Zhangjin <wuzj@lemote.com>
+ * Copyright (C) 2009 Wu Zhangjin <wuzhangjin@gmail.com>
  * Copyright (C) 2009 Philippe Vachon <philippe@cowpig.ca>
  * Copyright (C) 2009 Zhang Le <r0bertz@gentoo.org>
  *
diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_vsm.h b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_vsm.h
index 6305bea..21c4ece 100644
--- a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_vsm.h
+++ b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_vsm.h
@@ -2,7 +2,7 @@
  * the read/write interfaces for Virtual Support Module(VSM)
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin <wuzj@lemote.com>
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  */
 
 #ifndef	_CS5536_VSM_H
diff --git a/arch/mips/include/asm/mach-loongson/loongson.h b/arch/mips/include/asm/mach-loongson/loongson.h
index a6eac0f..1cf7b14 100644
--- a/arch/mips/include/asm/mach-loongson/loongson.h
+++ b/arch/mips/include/asm/mach-loongson/loongson.h
@@ -1,12 +1,11 @@
 /*
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin <wuzj@lemote.com>
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
- *
  */
 
 #ifndef __ASM_MACH_LOONGSON_LOONGSON_H
diff --git a/arch/mips/include/asm/mach-loongson/machine.h b/arch/mips/include/asm/mach-loongson/machine.h
index acf8359..4321338 100644
--- a/arch/mips/include/asm/mach-loongson/machine.h
+++ b/arch/mips/include/asm/mach-loongson/machine.h
@@ -1,6 +1,6 @@
 /*
- * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
- * Author: Wu Zhangjin <wuzj@lemote.com>
+ * Copyright (C) 2009 Lemote, Inc.
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/include/asm/mach-loongson/mem.h b/arch/mips/include/asm/mach-loongson/mem.h
index e9960f3..3b23ee8 100644
--- a/arch/mips/include/asm/mach-loongson/mem.h
+++ b/arch/mips/include/asm/mach-loongson/mem.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin <wuzj@lemote.com>
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/include/asm/mach-loongson/pci.h b/arch/mips/include/asm/mach-loongson/pci.h
index a199a4f..bc99dab 100644
--- a/arch/mips/include/asm/mach-loongson/pci.h
+++ b/arch/mips/include/asm/mach-loongson/pci.h
@@ -1,23 +1,12 @@
 /*
  * Copyright (c) 2008 Zhang Le <r0bertz@gentoo.org>
- * Copyright (c) 2009 Wu Zhangjin <wuzj@lemote.com>
+ * Copyright (c) 2009 Wu Zhangjin <wuzhangjin@gmail.com>
  *
  * This program is free software; you can redistribute it
  * and/or modify it under the terms of the GNU General
  * Public License as published by the Free Software
  * Foundation; either version 2 of the License, or (at your
  * option) any later version.
- *
- * This program is distributed in the hope that it will be
- * useful, but WITHOUT ANY WARRANTY; without even the implied
- * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
- * PURPOSE.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the Free
- * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
- * 02139, USA.
  */
 
 #ifndef __ASM_MACH_LOONGSON_PCI_H_
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 68b0670..e9e64e0 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2007-2008 Steven Rostedt <srostedt@redhat.com>
  * Copyright (C) 2009 DSLab, Lanzhou University, China
- * Author: Wu Zhangjin <wuzj@lemote.com>
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
  * Thanks goes to Steven Rostedt for writing the original x86 version.
  */
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 0a9cfdb..6851fc9 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -6,7 +6,7 @@
  * more details.
  *
  * Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University, China
- * Author: Wu Zhangjin <wuzj@lemote.com>
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  */
 
 #include <asm/regdef.h>
diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
index 9e32837..1a06def 100644
--- a/arch/mips/loongson/common/cmdline.c
+++ b/arch/mips/loongson/common/cmdline.c
@@ -10,7 +10,7 @@
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
  * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/cs5536/cs5536_acc.c b/arch/mips/loongson/common/cs5536/cs5536_acc.c
index b49485f..b3fd5ea 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_acc.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_acc.c
@@ -5,7 +5,7 @@
  * Author : jlliu, liujl@lemote.com
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/cs5536/cs5536_ehci.c b/arch/mips/loongson/common/cs5536/cs5536_ehci.c
index 74f9c59..eaf8b86 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_ehci.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_ehci.c
@@ -5,7 +5,7 @@
  * Author : jlliu, liujl@lemote.com
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/cs5536/cs5536_ide.c b/arch/mips/loongson/common/cs5536/cs5536_ide.c
index 3f61594..9a96b56 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_ide.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_ide.c
@@ -5,7 +5,7 @@
  * Author : jlliu, liujl@lemote.com
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/cs5536/cs5536_isa.c b/arch/mips/loongson/common/cs5536/cs5536_isa.c
index b6f17f5..f5c0818 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_isa.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_isa.c
@@ -5,7 +5,7 @@
  * Author : jlliu, liujl@lemote.com
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
index 6cb44db..8c807c9 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_mfgpt.c
@@ -5,7 +5,7 @@
  * Author: Yanhua, yanh@lemote.com
  *
  * Copyright (C) 2009 Lemote Inc.
- * Author: Wu zhangjin, wuzj@lemote.com
+ * Author: Wu zhangjin, wuzhangjin@gmail.com
  *
  * Reference: AMD Geode(TM) CS5536 Companion Device Data Book
  *
diff --git a/arch/mips/loongson/common/cs5536/cs5536_ohci.c b/arch/mips/loongson/common/cs5536/cs5536_ohci.c
index 8fdb02b..db5900a 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_ohci.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_ohci.c
@@ -5,7 +5,7 @@
  * Author : jlliu, liujl@lemote.com
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/cs5536/cs5536_pci.c b/arch/mips/loongson/common/cs5536/cs5536_pci.c
index e23f3d7..6dfeab1 100644
--- a/arch/mips/loongson/common/cs5536/cs5536_pci.c
+++ b/arch/mips/loongson/common/cs5536/cs5536_pci.c
@@ -5,7 +5,7 @@
  * Author : jlliu, liujl@lemote.com
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/early_printk.c b/arch/mips/loongson/common/early_printk.c
index 23e7a8f..a71736f 100644
--- a/arch/mips/loongson/common/early_printk.c
+++ b/arch/mips/loongson/common/early_printk.c
@@ -2,7 +2,7 @@
  *
  *  Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
  *  Copyright (c) 2009 Lemote Inc.
- *  Author: Wu Zhangjin, wuzj@lemote.com
+ *  Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/env.c b/arch/mips/loongson/common/env.c
index 8c01df5..ae4cff9 100644
--- a/arch/mips/loongson/common/env.c
+++ b/arch/mips/loongson/common/env.c
@@ -9,8 +9,8 @@
  * Copyright (C) 2007 Lemote Inc. & Insititute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
index a2abd93..19d3415 100644
--- a/arch/mips/loongson/common/init.c
+++ b/arch/mips/loongson/common/init.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/machtype.c b/arch/mips/loongson/common/machtype.c
index 3799098..853f184 100644
--- a/arch/mips/loongson/common/machtype.c
+++ b/arch/mips/loongson/common/machtype.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * Copyright (c) 2009 Zhang Le <r0bertz@gentoo.org>
  *
diff --git a/arch/mips/loongson/common/platform.c b/arch/mips/loongson/common/platform.c
index be81777..ed007a2 100644
--- a/arch/mips/loongson/common/platform.c
+++ b/arch/mips/loongson/common/platform.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/pm.c b/arch/mips/loongson/common/pm.c
index b625fec..6c1fd90 100644
--- a/arch/mips/loongson/common/pm.c
+++ b/arch/mips/loongson/common/pm.c
@@ -2,7 +2,7 @@
  * loongson-specific suspend support
  *
  *  Copyright (C) 2009 Lemote Inc.
- *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *  Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/arch/mips/loongson/common/reset.c b/arch/mips/loongson/common/reset.c
index 5833f9f..33dff18 100644
--- a/arch/mips/loongson/common/reset.c
+++ b/arch/mips/loongson/common/reset.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Zhangjin Wu, wuzj@lemote.com
+ * Author: Zhangjin Wu, wuzhangjin@gmail.com
  */
 #include <linux/init.h>
 #include <linux/pm.h>
diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index 23b66a5..7580873 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -7,7 +7,7 @@
  *
  * Copyright (C) 2009 Lemote, Inc.
  * Author: Yan hua (yanhua@lemote.com)
- * Author: Wu Zhangjin (wuzj@lemote.com)
+ * Author: Wu Zhangjin (wuzhangjin@gmail.com)
  */
 
 #include <linux/io.h>
diff --git a/arch/mips/loongson/common/time.c b/arch/mips/loongson/common/time.c
index 35f0b66..9fdd01f 100644
--- a/arch/mips/loongson/common/time.c
+++ b/arch/mips/loongson/common/time.c
@@ -2,8 +2,8 @@
  * Copyright (C) 2007 Lemote, Inc. & Institute of Computing Technology
  * Author: Fuxin Zhang, zhangfx@lemote.com
  *
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/common/uart_base.c b/arch/mips/loongson/common/uart_base.c
index 78ff66a..d69ea54 100644
--- a/arch/mips/loongson/common/uart_base.c
+++ b/arch/mips/loongson/common/uart_base.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/fuloong-2e/reset.c b/arch/mips/loongson/fuloong-2e/reset.c
index fc16c67..bc39ec6 100644
--- a/arch/mips/loongson/fuloong-2e/reset.c
+++ b/arch/mips/loongson/fuloong-2e/reset.c
@@ -1,8 +1,8 @@
 /* Board-specific reboot/shutdown routines
  * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
  *
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/lemote-2f/machtype.c b/arch/mips/loongson/lemote-2f/machtype.c
index 610f431..e860a27 100644
--- a/arch/mips/loongson/lemote-2f/machtype.c
+++ b/arch/mips/loongson/lemote-2f/machtype.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/loongson/lemote-2f/pm.c b/arch/mips/loongson/lemote-2f/pm.c
index d7af2e6..cac4d38 100644
--- a/arch/mips/loongson/lemote-2f/pm.c
+++ b/arch/mips/loongson/lemote-2f/pm.c
@@ -2,7 +2,7 @@
  *  Lemote loongson2f family machines' specific suspend support
  *
  *  Copyright (C) 2009 Lemote Inc.
- *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *  Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff --git a/arch/mips/loongson/lemote-2f/reset.c b/arch/mips/loongson/lemote-2f/reset.c
index 51d1a60..36020a0 100644
--- a/arch/mips/loongson/lemote-2f/reset.c
+++ b/arch/mips/loongson/lemote-2f/reset.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2009 Philippe Vachon <philippe@cowpig.ca>
  *
  * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index 475ff46..c25fb9b 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2009 Lemote Inc.
  * Author: Yanhua <yanh@lemote.com>
- * Author: Wu Zhangjin <wuzj@lemote.com>
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
diff --git a/arch/mips/pci/ops-loongson2.c b/arch/mips/pci/ops-loongson2.c
index aa5d3da..2bb4057 100644
--- a/arch/mips/pci/ops-loongson2.c
+++ b/arch/mips/pci/ops-loongson2.c
@@ -1,13 +1,11 @@
 /*
- * fuloong2e specific PCI support.
- *
  * Copyright (C) 1999, 2000, 2004  MIPS Technologies, Inc.
  *	All rights reserved.
  *	Authors: Carsten Langgaard <carstenl@mips.com>
  *		 Maciej W. Rozycki <macro@mips.com>
  *
  * Copyright (C) 2009 Lemote Inc.
- * Author: Wu Zhangjin <wuzj@lemote.com>
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
diff --git a/arch/mips/power/cpu.c b/arch/mips/power/cpu.c
index 7995df4..26a6ef1 100644
--- a/arch/mips/power/cpu.c
+++ b/arch/mips/power/cpu.c
@@ -3,9 +3,9 @@
  *
  * Licensed under the GPLv2
  *
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Copyright (C) 2009 Lemote Inc.
  * Author: Hu Hongbing <huhb@lemote.com>
- *         Wu Zhangjin <wuzj@lemote.com>
+ *         Wu Zhangjin <wuzhangjin@gmail.com>
  */
 #include <asm/suspend.h>
 #include <asm/fpu.h>
diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
index 0cf86fb..dbb5c7b 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -3,9 +3,9 @@
  *
  * Licensed under the GPLv2
  *
- * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+ * Copyright (C) 2009 Lemote Inc.
  * Author: Hu Hongbing <huhb@lemote.com>
- *         Wu Zhangjin <wuzj@lemote.com>
+ *         Wu Zhangjin <wuzhangjin@gmail.com>
  */
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
diff --git a/drivers/staging/sm7xx/smtc2d.c b/drivers/staging/sm7xx/smtc2d.c
index 133b86c..2fff0a0 100644
--- a/drivers/staging/sm7xx/smtc2d.c
+++ b/drivers/staging/sm7xx/smtc2d.c
@@ -5,7 +5,7 @@
  * Author: Boyod boyod.yang@siliconmotion.com.cn
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
diff --git a/drivers/staging/sm7xx/smtc2d.h b/drivers/staging/sm7xx/smtc2d.h
index 38d0c33..02b4fa2 100644
--- a/drivers/staging/sm7xx/smtc2d.h
+++ b/drivers/staging/sm7xx/smtc2d.h
@@ -5,7 +5,7 @@
  * Author: Ge Wang, gewang@siliconmotion.com
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
diff --git a/drivers/staging/sm7xx/smtcfb.c b/drivers/staging/sm7xx/smtcfb.c
index 161dbc9..a4f6f49 100644
--- a/drivers/staging/sm7xx/smtcfb.c
+++ b/drivers/staging/sm7xx/smtcfb.c
@@ -6,7 +6,7 @@
  * 	    Boyod boyod.yang@siliconmotion.com.cn
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
diff --git a/drivers/staging/sm7xx/smtcfb.h b/drivers/staging/sm7xx/smtcfb.h
index 7f2c341..7ee565c 100644
--- a/drivers/staging/sm7xx/smtcfb.h
+++ b/drivers/staging/sm7xx/smtcfb.h
@@ -6,7 +6,7 @@
  *	 	Boyod boyod.yang@siliconmotion.com.cn
  *
  * Copyright (C) 2009 Lemote, Inc.
- * Author: Wu Zhangjin, wuzj@lemote.com
+ * Author: Wu Zhangjin, wuzhangjin@gmail.com
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
-- 
1.6.5.6
