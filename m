Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 08:13:11 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:28444 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022056AbXEUHNJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2007 08:13:09 +0100
Received: by mo.po.2iij.net (mo30) id l4L7D6Ko051353; Mon, 21 May 2007 16:13:06 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox31) id l4L7D3DA028957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2007 16:13:03 +0900 (JST)
Date:	Mon, 21 May 2007 16:13:03 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, florian.fainelli@telecomint.eu,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] Add MIPS generic GPIO support
Message-Id: <20070521161303.0d9db8e4.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070521.001238.41198930.anemo@mba.ocn.ne.jp>
References: <200705192151.37338.florian.fainelli@telecomint.eu>
	<20070520182301.7d7831e5.yoichi_yuasa@tripeaks.co.jp>
	<20070521.001238.41198930.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 21 May 2007 00:12:38 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Sun, 20 May 2007 18:23:01 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > diff -pruN -X gpio/Documentation/dontdiff gpio-orig/include/asm-mips/gpio.h gpio/include/asm-mips/gpio.h
> > --- gpio-orig/include/asm-mips/gpio.h	1970-01-01 09:00:00.000000000 +0900
> > +++ gpio/include/asm-mips/gpio.h	2007-05-20 17:21:36.332456000 +0900
> > @@ -0,0 +1,6 @@
> > +#ifndef __ASM_MIPS_GPIO_H
> > +#define __ASM_MIPS_GPIO_H
> > +
> > +#include <gpio.h>
> > +
> > +#endif /* __ASM_MIPS_GPIO_H */
> 
> This looks good for me.
> 
> > diff -pruN -X gpio/Documentation/dontdiff gpio-orig/include/asm-mips/mach-generic/gpio.h gpio/include/asm-mips/mach-generic/gpio.h
> > --- gpio-orig/include/asm-mips/mach-generic/gpio.h	1970-01-01 09:00:00.000000000 +0900
> > +++ gpio/include/asm-mips/mach-generic/gpio.h	2007-05-20 17:24:07.401897250 +0900
> > @@ -0,0 +1,6 @@
> > +#ifndef __ASM_MACH_GENERIC_GPIO_H
> > +#define __ASM_MACH_GENERIC_GPIO_H
> > +
> > +/* no GPIO support */ 
> > +
> > +#endif /* __ASM_MACH_GENERIC_GPIO_H */
> 
> But is this really needed?  I can not see any point of this empty gpio.h ...

No, it is not must.
I'll update it soon.

Yoichi
