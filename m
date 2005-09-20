Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 09:06:35 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:46276 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225198AbVITIGR>;
	Tue, 20 Sep 2005 09:06:17 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id j8K86F6t029020
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Sep 2005 10:06:15 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id j8K86ErO029018;
	Tue, 20 Sep 2005 10:06:14 +0200
Date:	Tue, 20 Sep 2005 10:06:14 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] switch sibyte profiling driver to ->compat_ioctl
Message-ID: <20050920080614.GA29000@lst.de>
References: <20050919150822.GB13478@lst.de> <Pine.LNX.4.62.0509200802570.2617@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0509200802570.2617@numbat.sonytel.be>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Tue, Sep 20, 2005 at 08:03:56AM +0200, Geert Uytterhoeven wrote:
> On Mon, 19 Sep 2005, Christoph Hellwig wrote:
> > --- linux-2.6.orig/arch/mips/sibyte/sb1250/bcm1250_tbprof.c	2005-09-18 13:46:52.000000000 +0200
> > +++ linux-2.6/arch/mips/sibyte/sb1250/bcm1250_tbprof.c	2005-09-19 15:13:53.000000000 +0200
> > @@ -364,7 +366,8 @@
> >  	.open		= sbprof_tb_open,
> >  	.release	= sbprof_tb_release,
> >  	.read		= sbprof_tb_read,
> > -	.ioctl		= sbprof_tb_ioctl,
> > +	.unlocked_ioctl	= sbprof_tb_ioctl,
> > +	.comapt_ioctl	= sbprof_tb_ioctl,
>          ^^^^^^^^^^^^
> >  	.mmap		= NULL,
> >  };
> 
> DISCLAIMER: I didn't check whether the spelling error is in the struct
> definition as well.

no, it's not.  thanks for catching it :)
