Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 05:14:58 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:34356 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023379AbXIMEOu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2007 05:14:50 +0100
Received: by mo.po.2iij.net (mo30) id l8D4DW8g059553; Thu, 13 Sep 2007 13:13:32 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox301) id l8D4DS73011392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Sep 2007 13:13:29 +0900
Message-Id: <200709130413.l8D4DS73011392@po-mbox301.hop.2iij.net>
Date:	Thu, 13 Sep 2007 13:13:28 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH][MIPS] add #include <linux/profile.h> to
 arch/mips/kernel/time.c
In-Reply-To: <20070913.112917.76463355.nemoto@toshiba-tops.co.jp>
References: <20070912232333.22c4f7bb.yoichi_yuasa@tripeaks.co.jp>
	<20070913.003319.41011558.anemo@mba.ocn.ne.jp>
	<200709130204.l8D244XV029841@po-mbox300.hop.2iij.net>
	<20070913.112917.76463355.nemoto@toshiba-tops.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Thu, 13 Sep 2007 11:29:17 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Thu, 13 Sep 2007 11:04:04 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > diff -pruN -X mips/Documentation/dontdiff mips-orig/include/asm-mips/hw_irq.h mips/include/asm-mips/hw_irq.h
> > --- mips-orig/include/asm-mips/hw_irq.h	2007-09-13 10:41:51.559222750 +0900
> > +++ mips/include/asm-mips/hw_irq.h	2007-09-13 10:39:56.480030750 +0900
> > @@ -8,15 +8,8 @@
> >  #ifndef __ASM_HW_IRQ_H
> >  #define __ASM_HW_IRQ_H
> >  
> > -#include <linux/profile.h>
> >  #include <asm/atomic.h>
> 
> This breaks some build.  
> 
> linux/arch/mips/kernel/time.c:142: error: implicit declaration of function 'profile_tick'
> 
> Proper fix would be including profile.h from time.c, but this is
> irrelevant to i8259, so should be a separate patch.

I found a patch for it in my patch queue.
 
> Other parts looks good to me.  Thanks.

Add #include <linux/profile.h> to arch/mips/kernel/time.c
It refer to CPU_PROFILING.

arch/mips/kernel/time.c: In function 'local_timer_interrupt':
arch/mips/kernel/time.c:142: error: implicit declaration of function 'profile_tick'
arch/mips/kernel/time.c:142: error: 'CPU_PROFILING' undeclared (first use in this function)
arch/mips/kernel/time.c:142: error: (Each undeclared identifier is reported only once
arch/mips/kernel/time.c:142: error: for each function it appears in.)

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/time.c mips/arch/mips/kernel/time.c
--- mips-orig/arch/mips/kernel/time.c	2007-09-12 11:10:18.577854500 +0900
+++ mips/arch/mips/kernel/time.c	2007-09-12 14:15:48.490857250 +0900
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/param.h>
+#include <linux/profile.h>
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/smp.h>
