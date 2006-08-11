Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 16:53:30 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.192]:42830 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20044811AbWHKPwg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 16:52:36 +0100
Received: by nz-out-0102.google.com with SMTP id i1so238195nzh
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2006 08:52:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E/LKBVodJ9rcgbcEpaW9A4AniohjClnOVjLmApxKi2VCjdchPmeiSWGlfzINGmWrUcZ9EfCR+FOEXcwb0Mv2PWb6WlNAFFdDy8Ub1iYIl6ZT0YwOSVIlTtxLEhxdgn2yy9h3jI8daVMWw8rjY2Sla/EB+e8Y4UeLLC2boPLZv/Q=
Received: by 10.65.211.16 with SMTP id n16mr4225069qbq;
        Fri, 11 Aug 2006 08:52:31 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id 1sm1062768qbh.2006.08.11.08.52.29;
        Fri, 11 Aug 2006 08:52:31 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id AF45023F76A; Fri, 11 Aug 2006 17:51:53 +0200 (CEST)
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ralf@linux-mips.org,
	yoichi_yuasa@tripeaks.co.jp, Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 3/6] setup.c: remove useless includes.
Date:	Fri, 11 Aug 2006 17:51:50 +0200
Message-Id: <11553115131530-git-send-email-vagabon.xyz@gmail.com>
X-Mailer: git-send-email 1.4.2.rc4
In-Reply-To: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
References: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12286
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
index ee9e355..7339f54 100644
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
1.4.2.rc4
