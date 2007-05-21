Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 23:15:55 +0100 (BST)
Received: from mo30.po.2iij.NET ([210.128.50.53]:30999 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20024384AbXEUWPu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2007 23:15:50 +0100
Received: by mo.po.2iij.net (mo30) id l4LMFiWR033840; Tue, 22 May 2007 07:15:44 +0900 (JST)
Received: from localhost.localdomain (70.27.30.125.dy.iij4u.or.jp [125.30.27.70])
	by mbox.po.2iij.net (mbox32) id l4LMFejB063770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 May 2007 07:15:40 +0900 (JST)
Date:	Tue, 22 May 2007 07:15:38 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	florian.fainelli@telecomint.eu, linux-mips@linux-mips.org,
	anemo@mba.ocn.ne.jp
Subject: Re: [PATCH UPDATE] Add MIPS generic GPIO support
Message-Id: <20070522071538.26136e7f.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <Pine.LNX.4.64.0705212331210.6011@anakin>
References: <20070521.001238.41198930.anemo@mba.ocn.ne.jp>
	<20070521161303.0d9db8e4.yoichi_yuasa@tripeaks.co.jp>
	<200705210729.l4L7TZB3079730@mbox31.po.2iij.net>
	<20070521.231200.74752428.anemo@mba.ocn.ne.jp>
	<20070522000558.7dc5b747.yoichi_yuasa@tripeaks.co.jp>
	<Pine.LNX.4.64.0705212331210.6011@anakin>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 21 May 2007 23:31:44 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Tue, 22 May 2007, Yoichi Yuasa wrote:
> > --- mips-orig/include/asm-mips/gpio.h	1970-01-01 09:00:00.000000000 +0900
> > +++ mips/include/asm-mips/gpio.h	2007-05-21 17:07:51.769161250 +0900
> > @@ -0,0 +1,6 @@
> > +#ifndef __ASM_MIPS_GPIO_H
> > +#define __ASM_MIPS_GPIO_H
> > +
> > +#include <gpio.h>
>             ^^^^^^^^
> > +
> > +#endif /* __ASM_MIPS_GPIO_H */
> 
> Just wondering, where is it supposed to find <gpio.h>?

It should be include/asm-mips/mach-*/gpio.h .

Yoichi
