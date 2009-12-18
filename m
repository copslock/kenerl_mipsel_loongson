Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2009 14:02:23 +0100 (CET)
Received: from mail-yw0-f203.google.com ([209.85.211.203]:47549 "EHLO
        mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493089AbZLRNBH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2009 14:01:07 +0100
Received: by mail-yw0-f203.google.com with SMTP id 41so8910964ywh.0
        for <multiple recipients>; Fri, 18 Dec 2009 05:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=2/5BVGByTUieeRaE0uy3TDMPKiKrBU+n9OU9u8ELbg8=;
        b=ChSZNFNOBIvEoTZwPoatwOM0PFPqaq/0WMussVrfExqzS+XVxFfoWRPztA1gyl+Kqh
         2zfGcQT1Dz9yCkgmBeX3BZcTgwgHx3/syp+mCr9WaUZGyydthJYmI+0Qposa0kYdBYOz
         h25STYXtNvNwmG3mRlFCjJWXL+HlkYVUozip0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=TVmVpoyoxWkiVOA8WWtb2AqW12r8rxQTY38Yk+NuUDHBk4bbBQiUcvx1X6o3JZKMua
         n8C9FGCVn+A+0x6XFYN2DzZlLN7Ny0pSXDBm7N70aZ5q2IF3z9Gw+weZZBqFG5Y0TdnF
         ghvcAyU6W4f/NDmzBlWlm+aqlWvKdJznp8w+0=
Received: by 10.91.162.31 with SMTP id p31mr3861812ago.121.1261141256394;
        Fri, 18 Dec 2009 05:00:56 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 16sm1427585gxk.3.2009.12.18.05.00.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 05:00:55 -0800 (PST)
Date:   Fri, 18 Dec 2009 21:38:37 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 5/5] MIPS: simplify powertv prom_init_cmdline() and merge to
 prom_init()
Message-Id: <20091218213837.270d3854.yuasa@linux-mips.org>
In-Reply-To: <20091218213632.7d5b0037.yuasa@linux-mips.org>
References: <20091218212917.f42e8180.yuasa@linux-mips.org>
        <20091218213018.79a9fc11.yuasa@linux-mips.org>
        <20091218213346.01f63eac.yuasa@linux-mips.org>
        <20091218213632.7d5b0037.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/powertv/Makefile  |    2 +-
 arch/mips/powertv/cmdline.c |   47 -------------------------------------------
 arch/mips/powertv/init.c    |   15 ++++++++-----
 arch/mips/powertv/init.h    |    2 -
 4 files changed, 10 insertions(+), 56 deletions(-)
 delete mode 100644 arch/mips/powertv/cmdline.c

diff --git a/arch/mips/powertv/Makefile b/arch/mips/powertv/Makefile
index 2c51671..0a0d73c 100644
--- a/arch/mips/powertv/Makefile
+++ b/arch/mips/powertv/Makefile
@@ -23,6 +23,6 @@
 # under Linux.
 #
 
-obj-y += cmdline.o init.o memory.o reset.o time.o powertv_setup.o asic/ pci/
+obj-y += init.o memory.o reset.o time.o powertv_setup.o asic/ pci/
 
 EXTRA_CFLAGS += -Wall -Werror
diff --git a/arch/mips/powertv/cmdline.c b/arch/mips/powertv/cmdline.c
deleted file mode 100644
index ee7ab47..0000000
--- a/arch/mips/powertv/cmdline.c
+++ /dev/null
@@ -1,47 +0,0 @@
-/*
- * Carsten Langgaard, carstenl@mips.com
- * Copyright (C) 1999,2000 MIPS Technologies, Inc.  All rights reserved.
- * Portions copyright (C) 2009 Cisco Systems, Inc.
- *
- * This program is free software; you can distribute it and/or modify it
- * under the terms of the GNU General Public License (Version 2) as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- * for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Kernel command line creation using the prom monitor (YAMON) argc/argv.
- */
-#include <linux/init.h>
-#include <linux/string.h>
-
-#include <asm/bootinfo.h>
-
-#include "init.h"
-
-/*
- * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
- * This macro take care of sign extension.
- */
-#define prom_argv(index) ((char *)(long)_prom_argv[(index)])
-
-void  __init prom_init_cmdline(void)
-{
-	int len;
-
-	if (prom_argc != 1)
-		return;
-
-	len = strlen(arcs_cmdline);
-
-	arcs_cmdline[len] = ' ';
-
-	strlcpy(arcs_cmdline + len + 1, (char *)_prom_argv,
-		COMMAND_LINE_SIZE - len - 1);
-}
diff --git a/arch/mips/powertv/init.c b/arch/mips/powertv/init.c
index 5f4e4c3..de0e46a 100644
--- a/arch/mips/powertv/init.c
+++ b/arch/mips/powertv/init.c
@@ -34,10 +34,7 @@
 #include <asm/mips-boards/generic.h>
 #include <asm/mach-powertv/asic.h>
 
-#include "init.h"
-
-int prom_argc;
-int *_prom_argv, *_prom_envp;
+static int *_prom_envp;
 unsigned long _prom_memsize;
 
 /*
@@ -109,8 +106,11 @@ static void __init mips_ejtag_setup(void)
 
 void __init prom_init(void)
 {
+	int prom_argc;
+	char *prom_argv;
+
 	prom_argc = fw_arg0;
-	_prom_argv = (int *) fw_arg1;
+	prom_argv = (char *) fw_arg1;
 	_prom_envp = (int *) fw_arg2;
 	_prom_memsize = (unsigned long) fw_arg3;
 
@@ -118,7 +118,10 @@ void __init prom_init(void)
 	board_ejtag_handler_setup = mips_ejtag_setup;
 
 	pr_info("\nLINUX started...\n");
-	prom_init_cmdline();
+
+	if (prom_argc == 1)
+		strlcat(arcs_cmdline, prom_argv, COMMAND_LINE_SIZE);
+
 	configure_platform();
 	prom_meminit();
 
diff --git a/arch/mips/powertv/init.h b/arch/mips/powertv/init.h
index 7af6bf2..b194c34 100644
--- a/arch/mips/powertv/init.h
+++ b/arch/mips/powertv/init.h
@@ -22,7 +22,5 @@
 
 #ifndef _POWERTV_INIT_H
 #define _POWERTV_INIT_H
-extern int prom_argc;
-extern int *_prom_argv;
 extern unsigned long _prom_memsize;
 #endif
-- 
1.6.5.7
