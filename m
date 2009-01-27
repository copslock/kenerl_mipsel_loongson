Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 06:58:30 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:7073 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21366037AbZA0G62 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 06:58:28 +0000
Received: (qmail 14992 invoked by uid 1000); 27 Jan 2009 07:58:27 +0100
Date:	Tue, 27 Jan 2009 07:58:27 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] au1000: convert to using gpiolib
Message-ID: <20090127065827.GA14985@roarinelk.homelinux.net>
References: <200901151646.49591.florian@openwrt.org> <20090116174753.GA18764@roarinelk.homelinux.net> <200901191812.24377.florian@openwrt.org> <200901262340.27613.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200901262340.27613.florian@openwrt.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Florian,

> Le Monday 19 January 2009 18:12:23 Florian Fainelli, vous avez ?crit?:
> > This patch converts the GPIO board code to use gpiolib.
> > Changes from v1:
> > - allow users not to use the default gpio accessors
> > - do not lock au1000_gpio2_set
> 
> I did not receive comments from you on this patch, can I consider it being 
> ok ?

Oh sorry.  Please export all the au1000_gpioX_* functions and I'm happy.

Thanks!
	Manuel Lauss
