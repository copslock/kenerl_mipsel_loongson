Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g69MKtRw003478
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 9 Jul 2002 15:20:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g69MKtRL003477
	for linux-mips-outgoing; Tue, 9 Jul 2002 15:20:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g69MKjRw003467;
	Tue, 9 Jul 2002 15:20:45 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g69MP4C11971;
	Wed, 10 Jul 2002 00:25:04 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g69MP5TF013051;
	Wed, 10 Jul 2002 00:25:05 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17S3Pt-0000B9-00; Wed, 10 Jul 2002 00:25:05 +0200
Date: Wed, 10 Jul 2002 00:25:05 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: [PATCH] 2.5.4 fixes
Message-ID: <Pine.LNX.4.21.0207100022120.536-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
	
	Here is a fix to have mips64 compile on the new 2.5.4 CVS
HEAD kernel. Just a few missing headers.

Vivien.

diff -Naur linux/arch/mips64/kernel/entry.S linux.patch/arch/mips64/kernel/entry.S
--- linux/arch/mips64/kernel/entry.S	Tue Jul  9 22:02:18 2002
+++ linux.patch/arch/mips64/kernel/entry.S	Tue Jul  9 23:44:24 2002
@@ -13,6 +13,7 @@
 #include <asm/regdef.h>
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
+#include <asm/thread_info.h>
 
 #define KU_USER 0x10
 
diff -Naur linux/arch/mips64/kernel/scall_64.S linux.patch/arch/mips64/kernel/scall_64.S
--- linux/arch/mips64/kernel/scall_64.S	Tue Jul  9 22:02:19 2002
+++ linux.patch/arch/mips64/kernel/scall_64.S	Tue Jul  9 23:49:53 2002
@@ -15,6 +15,7 @@
 #include <asm/stackframe.h>
 #include <asm/offset.h>
 #include <asm/unistd.h>
+#include <asm/thread_info.h>
 
 #ifndef CONFIG_MIPS32_COMPAT
 #define handle_sys64 handle_sys
diff -Naur linux/include/asm-mips64/pgalloc.h linux.patch/include/asm-mips64/pgalloc.h
--- linux/include/asm-mips64/pgalloc.h	Mon Jul  8 22:28:12 2002
+++ linux.patch/include/asm-mips64/pgalloc.h	Tue Jul  9 23:22:04 2002
@@ -9,6 +9,7 @@
 #ifndef _ASM_PGALLOC_H
 #define _ASM_PGALLOC_H
 
+#include <asm/pgtable.h>
 #include <linux/config.h>
 
 /* TLB flushing:
