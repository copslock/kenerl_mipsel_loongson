Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2009 17:48:28 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:55682 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21365664AbZAPRs0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Jan 2009 17:48:26 +0000
Received: (qmail 18781 invoked by uid 1000); 16 Jan 2009 18:47:53 +0100
Date:	Fri, 16 Jan 2009 18:47:53 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] au1000: convert to using gpiolib
Message-ID: <20090116174753.GA18764@roarinelk.homelinux.net>
References: <200901151646.49591.florian@openwrt.org> <20090115205851.GD8656@roarinelk.homelinux.net> <86ee6fd0901160210pdb7f52nf761f8706a56f8fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ee6fd0901160210pdb7f52nf761f8706a56f8fe@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Florian,

On Fri, Jan 16, 2009 at 11:10:25AM +0100, Florian Fainelli wrote:
> > Can you please make the gpiolib registration dependent on a
> > CONFIG symbol?  I.e. make the au1000_gpio{,2}_direction() and
> > friends calls globally visible but let the individual boards
> > decide whether they want to use the gpio numbering imposed by
> > this patch.
> 
> 
> Would something like #ifdef CONFIG_AU1000_NON_STD_GPIOS be ok with you ?
> Or maybe we could get the base information from board-specific code ?

Well, we could move the core_initcall() to all boards' setup function,
and stick a comment on top of it explaining why it's there.

Config symbol or the above, either is fine with me.

Thanks!
	Manuel Lauss
