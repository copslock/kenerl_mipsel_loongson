Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 15:54:47 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:13286 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20042392AbWHIOx0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 15:53:26 +0100
Received: by nf-out-0910.google.com with SMTP id o60so206824nfa
        for <linux-mips@linux-mips.org>; Wed, 09 Aug 2006 07:53:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OTdhtEBmVFFLgOXEi3Ww1qcwJbgoAGHKGGF1aRAQMyG9ZxQGVGPEp3+HRZgd+Gm03xj6+VaXcPGjkoDld4bcbeM0XBaZ95jYPDrXUim2T/5iGVpzJWlf+qkBQvl124fEjVg4sxS2udjZ8ARr7Pgkv9I6NQs8/E1I0SOecm11gkI=
Received: by 10.49.29.2 with SMTP id g2mr1593024nfj;
        Wed, 09 Aug 2006 07:53:21 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id y24sm180514nfb.2006.08.09.07.53.19;
        Wed, 09 Aug 2006 07:53:20 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id DFDC723F76F; Wed,  9 Aug 2006 16:52:39 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 3/6] setup.c: remove useless includes.
Date:	Wed,  9 Aug 2006 16:52:35 +0200
Message-Id: <11551351593754-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <11551351581277-git-send-email-vagabon.xyz@gmail.com>
References: <11551351581277-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 arch/mips/kernel/setup.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8f357c2..c73bd80 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -10,29 +10,15 @@
  * Copyright (C) 1999 Silicon Graphics, Inc.
  * Copyright (C) 2000 2001, 2002  Maciej W. Rozycki
  */
-#include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/stddef.h>
-#include <linux/string.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/user.h>
-#include <linux/utsname.h>
-#include <linux/a.out.h>
 #include <linux/screen_info.h>
 #include <linux/bootmem.h>
 #include <linux/initrd.h>
-#include <linux/major.h>
-#include <linux/kdev_t.h>
 #include <linux/root_dev.h>
 #include <linux/highmem.h>
 #include <linux/console.h>
-#include <linux/mmzone.h>
 #include <linux/pfn.h>
 
 #include <asm/addrspace.h>
-- 
1.4.2.rc2
