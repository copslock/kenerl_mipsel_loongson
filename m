Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 13:52:12 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:48823 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20041132AbWHHMtS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Aug 2006 13:49:18 +0100
Received: by nf-out-0910.google.com with SMTP id o60so240932nfa
        for <linux-mips@linux-mips.org>; Tue, 08 Aug 2006 05:49:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=M9OVrsZxxGj1yOaChYdgtqbKCbYCrhbp58vUwtxptBAshKz5q+Kfujy0YUBsotPkT5WrDBNuLQoiYkMFi5hkDIvy0BOiZ+m+vIA69VzTwMPScENUb4dz+C6t1eYxL6b2tSmY2fnn0q0+i0yq7/UTvgBNq8lXUn3GOHlph5XkeHw=
Received: by 10.48.162.15 with SMTP id k15mr560052nfe;
        Tue, 08 Aug 2006 05:49:14 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id m16sm753921nfc.2006.08.08.05.49.13;
        Tue, 08 Aug 2006 05:49:14 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 4B53F23F76E; Tue,  8 Aug 2006 14:48:33 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 3/6] setup.c: remove useless includes.
Date:	Tue,  8 Aug 2006 14:48:29 +0200
Message-Id: <11550413133675-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc2
In-Reply-To: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
References: <1155041312273-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12238
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
index 45cba98..49a466c 100644
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
