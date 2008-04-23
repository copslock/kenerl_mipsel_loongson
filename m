Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2008 05:07:43 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:11287 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20023463AbYDWEHk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2008 05:07:40 +0100
Received: by mo.po.2iij.net (mo32) id m3N47bhV015503; Wed, 23 Apr 2008 13:07:37 +0900 (JST)
Received: from rally.tripeaks.co.jp (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox304) id m3N47ZvT009775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Apr 2008 13:07:36 +0900
Message-Id: <200804230407.m3N47ZvT009775@po-mbox304.hop.2iij.net>
Date:	Wed, 23 Apr 2008 13:07:37 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] [MIPS] add DECstation DS1287 clockevent
In-Reply-To: <20080423.115528.59033169.nemoto@toshiba-tops.co.jp>
References: <20080423085140.a693b2e5.yoichi_yuasa@tripeaks.co.jp>
	<200804222353.m3MNr8m4025538@po-mbox303.hop.2iij.net>
	<20080423.115528.59033169.nemoto@toshiba-tops.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 23 Apr 2008 11:55:28 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Wed, 23 Apr 2008 08:52:45 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > add DECstation DS1287 clockevent
> > 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> ...
> > --- linux-orig/arch/mips/kernel/Makefile	2008-04-22 19:01:43.957134178 +0900
> > +++ linux/arch/mips/kernel/Makefile	2008-04-22 18:03:05.427649422 +0900
> > @@ -9,8 +9,9 @@ obj-y		+= cpu-probe.o branch.o entry.o g
> >  		   time.o topology.o traps.o unaligned.o
> >  
> >  obj-$(CONFIG_CEVT_BCM1480)	+= cevt-bcm1480.o
> > -obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
> > +obj-$(CONFIG_CEVT_DS1287)	+= cevt-ds1287.o
> >  obj-$(CONFIG_CEVT_GT641XX)	+= cevt-gt641xx.o
> > +obj-$(CONFIG_CEVT_R4K)		+= cevt-r4k.o
> >  obj-$(CONFIG_CEVT_SB1250)	+= cevt-sb1250.o
> >  obj-$(CONFIG_CEVT_TXX9)		+= cevt-txx9.o
> >  obj-$(CONFIG_CSRC_BCM1480)	+= csrc-bcm1480.o
> 
> Why CONFIG_CEVT_R4K line was moved?  The order is important?

Just sorted.
It's not important.

> 
> > --- linux-orig/arch/mips/kernel/cevt-ds1287.c	1970-01-01 09:00:00.000000000 +0900
> > +++ linux/arch/mips/kernel/cevt-ds1287.c	2008-04-22 18:03:05.455637018 +0900
> ...
> > +static void ds1287_set_mode(enum clock_event_mode mode,
> > +			    struct clock_event_device *evt)
> > +{
> > +	unsigned long flags;
> > +	u8 val;
> > +
> > +	spin_lock_irqsave(&rtc_lock, flags);
> 
> You do not have to use irqsave here, while set_mode is always called
> with interrupts disabled.  And for rtc_lock ... I don't know if this
> code could be used on SMP :-)
> 
> > --- linux-orig/include/asm-mips/dec/ds1287.h	1970-01-01 09:00:00.000000000 +0900
> > +++ linux/include/asm-mips/dec/ds1287.h	2008-04-22 18:03:05.455637018 +0900
> > @@ -0,0 +1,27 @@
> ...
> 
> I suppose CEVT_DS1287 is not DEC specific one.  If so,
> include/asm-mips/ would be better place.

Thank you for your comment.
I'll update this patch.

Yoichi
