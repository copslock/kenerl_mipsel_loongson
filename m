Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Dec 2007 21:14:07 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.185]:1449 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20025982AbXLAVNe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Dec 2007 21:13:34 +0000
Received: by mu-out-0910.google.com with SMTP id g7so1556288muf
        for <linux-mips@linux-mips.org>; Sat, 01 Dec 2007 13:13:33 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xlZi7R9X35y9cLmby02SPm62fCqBFY/yrZaPe67uqzY=;
        b=uOpK7vHSaZ+FPEUTbYoIeBmOybPxl++rocEB99go1qB8rnjHnmpODY+lNzRrM5Y/lqvX9DVPstgWxwVieArlNaRM9hLEBVZ84NpxZXta0/Ijy6jEASQdEfRlNpSvP1c+jpsOpcoedq3C118j4yo8eNTYPb37EfIerAYAHQjDn8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kpVHqkRiin6wU27V1Bd/cuEqVc/RxQecahTki6sGxyjNlhu+UmnGKb95+thovVp92jwW3RhLOg1+yyD4htKdHSQ8GKY6bZIAhHAybLmUKFm9tz4NplN7kH6gWBz+t3CI4HcXt5ztPNQsVm/9ierOEylR8GaHPvBjM2xVcVLRgho=
Received: by 10.86.100.7 with SMTP id x7mr8724082fgb.1196543612441;
        Sat, 01 Dec 2007 13:13:32 -0800 (PST)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id p9sm11677479fkb.2007.12.01.13.13.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2007 13:13:31 -0800 (PST)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	linux-arch@vger.kernel.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 1/2] Yet another __initxxx annotations: __initbss/__exitbss
Date:	Sat,  1 Dec 2007 22:13:05 +0100
Message-Id: <1196543586-6698-2-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1196543586-6698-1-git-send-email-fbuihuu@gmail.com>
References: <1196543586-6698-1-git-send-email-fbuihuu@gmail.com>
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Currently we can mark an initialized data to belong to the init.data
section, this data being discarded after the boot process and the
memory space used is taken back by the kernel. For _uninitialized_
data, we must use the same mechanism.

The main drawback of this is that these data take space in the kernel
image whereas this space is not really used. It's actually the reason
why we prefer to not initialize a normal data when its initial value
is 0.

This patch creates two new init sections called '.bss.init' and
'.bss.exit'.

These sections are similar to the .{init,exit}.data ones but doesn't
consume any space in the vmlinux image because they're part of the bss
section except that they're freed once the kernel has booted.

To select the BSS attribute for a peculiar section, the name of the
section must start with 'bss.' pattern. This is at least how GCC
3.2/4.1.2 works and it's the reason why the 2 new sections haven't
been called '.{init,exit}.bss'.

To mark a data part of one of these 2 sections, we use the 2 new
annotations: __initbss/__exitbss.

All data marked as part of this section must not be initialized,
of course.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/linux/init.h |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 5141381..19e04b2 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -43,6 +43,8 @@
 #define __init		__attribute__ ((__section__ (".init.text"))) __cold
 #define __initdata	__attribute__ ((__section__ (".init.data")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
+#define __initbss	__attribute__ ((__section__ (".bss.init")))
+#define __exitbss	__attribute__ ((__section__ (".bss.exit")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
 /* modpost check for section mismatches during the kernel build.
@@ -71,6 +73,7 @@
 #define __FINIT		.previous
 #define __INITDATA	.section	".init.data","aw"
 #define __INITDATA_REFOK .section	".data.init.refok","aw"
+#define __INITBSS	.section	".bss.init","aw",@nobits
 
 #ifndef __ASSEMBLY__
 /*
@@ -260,10 +263,12 @@ void __init parse_early_param(void);
 #define __devexit
 #define __devexitdata
 #else
-#define __devinit __init
-#define __devinitdata __initdata
-#define __devexit __exit
-#define __devexitdata __exitdata
+#define __devinit	__init
+#define __devinitdata	__initdata
+#define __devinitbss	__initbss
+#define __devexit	__exit
+#define __devexitdata	__exitdata
+#define __devexitbss	__exitbss
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -273,9 +278,11 @@ void __init parse_early_param(void);
 #define __cpuexitdata
 #else
 #define __cpuinit	__init
-#define __cpuinitdata __initdata
-#define __cpuexit __exit
+#define __cpuinitdata	__initdata
+#define __cpuinitbss	__initbss
+#define __cpuexit	__exit
 #define __cpuexitdata	__exitdata
+#define __cpuexitbss	__exitbss
 #endif
 
 #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_ACPI_HOTPLUG_MEMORY) \
@@ -286,9 +293,11 @@ void __init parse_early_param(void);
 #define __memexitdata
 #else
 #define __meminit	__init
-#define __meminitdata __initdata
-#define __memexit __exit
+#define __meminitdata	__initdata
+#define __meminitbss	__meminitbss
+#define __memexit	__exit
 #define __memexitdata	__exitdata
+#define __memexitbss	__exitbss
 #endif
 
 /* Functions marked as __devexit may be discarded at kernel link time, depending
-- 
1.5.3.5
