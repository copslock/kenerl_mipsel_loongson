Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 00:40:56 +0000 (GMT)
Received: from mo31.po.2iij.net ([210.128.50.54]:11281 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20039087AbWLFAkv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 00:40:51 +0000
Received: by mo.po.2iij.net (mo31) id kB60emZM068441; Wed, 6 Dec 2006 09:40:48 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox32) id kB60ejPO055477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 6 Dec 2006 09:40:45 +0900 (JST)
Date:	Wed, 6 Dec 2006 09:40:45 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] MIPS: fix cobalt I/O resource range
Message-Id: <20061206094045.785f57b9.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061204141042.GA7231@linux-mips.org>
References: <20061201221242.261f57b0.yoichi_yuasa@tripeaks.co.jp>
	<20061204141042.GA7231@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Thank you for your comments.
I'll update my patches.

Yoichi

On Mon, 4 Dec 2006 14:10:42 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Dec 01, 2006 at 10:12:42PM +0900, Yoichi Yuasa wrote:
> 
> > This patch has fixed cobalt I/O reource range.
> > The cobalt real I/O resource range from 0x0 to 0xffff.
> > 
> > Yoichi
> > 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > 
> > diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/cobalt/setup.c mips/arch/mips/cobalt/setup.c
> > --- mips-orig/arch/mips/cobalt/setup.c	2006-10-12 01:03:18.055569000 +0900
> > +++ mips/arch/mips/cobalt/setup.c	2006-10-12 01:01:59.973744750 +0900
> > @@ -130,8 +130,7 @@ void __init plat_mem_setup(void)
> >  
> >  	set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
> >  
> > -	/* I/O port resource must include UART and LCD/buttons */
> > -	ioport_resource.end = 0x0fffffff;
> > +	ioport_resource.end = 0xffff;
> 
> This is actually the default, so the code can go and anyway then the
> code stops making sense, too.
> 
>   Ralf
> 
