Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g63AOpRw027355
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 3 Jul 2002 03:24:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g63AOpmK027354
	for linux-mips-outgoing; Wed, 3 Jul 2002 03:24:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from r-bu.iij4u.or.jp (r-bu.iij4u.or.jp [210.130.0.89])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g63AOjRw027342
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 03:24:46 -0700
Received: from pudding ([202.216.29.50])
	by r-bu.iij4u.or.jp (8.11.6+IIJ/8.11.6) with SMTP id g63AShG24119
	for <linux-mips@oss.sgi.com>; Wed, 3 Jul 2002 19:28:43 +0900 (JST)
Date: Wed, 3 Jul 2002 19:24:28 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: linux-mips@oss.sgi.com
Subject: Re: Small correction for fault.c
Message-Id: <20020703192428.78aa0c58.yoichi_yuasa@montavista.co.jp>
In-Reply-To: <20020703095224.GV16753@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020703144404.4d349037.yoichi_yuasa@montavista.co.jp>
	<20020703081539.GU16753@rembrandt.csv.ica.uni-stuttgart.de>
	<20020703181651.779116be.yoichi_yuasa@montavista.co.jp>
	<20020703095224.GV16753@rembrandt.csv.ica.uni-stuttgart.de>
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

On Wed, 3 Jul 2002 11:52:24 +0200
Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> wrote:

> Yoichi Yuasa wrote:
> [snip]
> > > In file included from fault.c:23:
> > > /bigdisk/combined/source-linux/include/linux/vt_kern.h:32: error:
> > > MAX_NR_CONSOLES' undeclared here (not in a function)
> > 
> > I did checkout cvs and I checked also about MIPS64.
> > There was no problem by my correction.
> > 
> > "arch/mips64/mm/fault.c" is including <linux/sched.h>.
> > <linux/sched.h> is including <linux/tty.h>.
> 
> Then you are using a different CVS than I do. In CVS at oss.sgi.com,
> linux/sched.h does not include linux/tty.h.

I use version 2.4.19-rc1(linux_2_4 tag) on oss.sgi.com.

-Yoichi
