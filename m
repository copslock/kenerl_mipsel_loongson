Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g639HKRw021536
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 3 Jul 2002 02:17:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g639HKQM021535
	for linux-mips-outgoing; Wed, 3 Jul 2002 02:17:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from r-bu.iij4u.or.jp (r-bu.iij4u.or.jp [210.130.0.89])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g639HDRw021523
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 02:17:13 -0700
Received: from pudding ([202.216.29.50])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id g639L6G15793;
	Wed, 3 Jul 2002 18:21:07 +0900 (JST)
Date: Wed, 3 Jul 2002 18:16:51 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@oss.sgi.com
Subject: Re: Small correction for fault.c
Message-Id: <20020703181651.779116be.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <20020703081539.GU16753@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020703144404.4d349037.yoichi_yuasa@montavista.co.jp>
	<20020703081539.GU16753@rembrandt.csv.ica.uni-stuttgart.de>
Organization: MontaVista Software Japan Inc.
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Thiemo,

On Wed, 3 Jul 2002 10:15:40 +0200
Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> wrote:

> Yoichi Yuasa wrote:
> > Hi,
> > 
> > I found a include file required for "arch/mips/mm/fault.c".
> > This is for unblank_screen().
> > 
> > --- linux.orig/arch/mips/mm/fault.c     Thu Jun 27 14:14:14 2002
> > +++ linux/arch/mips/mm/fault.c  Wed Jul  3 14:37:03 2002
> > @@ -19,6 +19,7 @@
> >  #include <linux/smp.h>
> >  #include <linux/smp_lock.h>
> >  #include <linux/version.h>
> > +#include <linux/vt_kern.h>
> 
> For MIPS64 this fails (MAX_NR_CONSOLES is defined in linux/tty.h):
> 
> In file included from fault.c:23:
> /bigdisk/combined/source-linux/include/linux/vt_kern.h:32: error:
> MAX_NR_CONSOLES' undeclared here (not in a function)

I did checkout cvs and I checked also about MIPS64.
There was no problem by my correction.

"arch/mips64/mm/fault.c" is including <linux/sched.h>.
<linux/sched.h> is including <linux/tty.h>.

-Yoichi
