Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 09:47:19 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:27034 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20030929AbZA0JrR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 09:47:17 +0000
Received: (qmail 16192 invoked by uid 1000); 27 Jan 2009 10:47:16 +0100
Date:	Tue, 27 Jan 2009 10:47:16 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] au1000: convert to using gpiolib
Message-ID: <20090127094716.GA16179@roarinelk.homelinux.net>
References: <200901151646.49591.florian@openwrt.org> <200901262340.27613.florian@openwrt.org> <20090127065827.GA14985@roarinelk.homelinux.net> <200901271039.31680.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200901271039.31680.florian@openwrt.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Tue, Jan 27, 2009 at 10:39:30AM +0100, Florian Fainelli wrote:
> Le Tuesday 27 January 2009 07:58:27 Manuel Lauss, vous avez ?crit?:
> > Florian,
> >
> > > Le Monday 19 January 2009 18:12:23 Florian Fainelli, vous avez ?crit?:
> > > > This patch converts the GPIO board code to use gpiolib.
> > > > Changes from v1:
> > > > - allow users not to use the default gpio accessors
> > > > - do not lock au1000_gpio2_set
> > >
> > > I did not receive comments from you on this patch, can I consider it
> > > being ok ?
> >
> > Oh sorry.  Please export all the au1000_gpioX_* functions and I'm happy.
> >
> > Thanks!
> > 	Manuel Lauss
> 
> Here we go. Thanks !

One last nit: please also add function prototypes to the gpio header.

-- ml.
