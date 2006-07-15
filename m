Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jul 2006 02:20:00 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:19218 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S8133407AbWGOBTv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Jul 2006 02:19:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 7A56F7F4028;
	Sat, 15 Jul 2006 03:19:49 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19862-07; Sat, 15 Jul 2006 03:19:49 +0200 (CEST)
Received: by buzzloop.caiaq.de (Postfix, from userid 1000)
	id 26BA87F4024; Sat, 15 Jul 2006 03:19:49 +0200 (CEST)
Date:	Sat, 15 Jul 2006 03:19:49 +0200
From:	Daniel Mack <daniel@caiaq.de>
To:	Domen Puncer <domen.puncer@ultra.si>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] USB: removed a unbalanced #endif from ohci-au1xxx.c
Message-ID: <20060715011949.GA21737@ipxXXXXX>
References: <20060714162935.70502a98.yoichi_yuasa@tripeaks.co.jp> <20060714084533.GP31105@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714084533.GP31105@domen.ultra.si>
User-Agent: Mutt/1.5.11
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips

On Fri, Jul 14, 2006 at 10:45:33AM +0200, Domen Puncer wrote:
> > Error message was:
> > In file included from drivers/usb/host/ohci-hcd.c:909:
> > drivers/usb/host/ohci-au1xxx.c:113:2: #endif without #if
> > 
> > Yoichi
> > 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > 
> > diff -pruN -X 2.6.18-rc1/Documentation/dontdiff 2.6.18-rc1-orig/drivers/usb/host/ohci-au1xxx.c 2.6.18-rc1/drivers/usb/host/ohci-au1xxx.c
> > --- 2.6.18-rc1-orig/drivers/usb/host/ohci-au1xxx.c	2006-07-14 11:17:34.443211500 +0900
> > +++ 2.6.18-rc1/drivers/usb/host/ohci-au1xxx.c	2006-07-14 10:33:47.945949750 +0900
> > @@ -110,7 +110,6 @@ static void au1xxx_start_ohc(struct plat
> >  
> >  	printk(KERN_DEBUG __FILE__
> >  	": Clock to USB host has been enabled \n");
> > -#endif
> >  }
> >  
> >  static void au1xxx_stop_ohc(struct platform_device *dev)

Yes, you're right.

> It looks like something went wrong with this patch
> http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=d14feb5ee4a46218f92b21ed52338b64130a151b
> 
> Looks like ehci-au1xxx.c might also be affected.

No, ehci-au1xxx.c looks ok to me, at least I was able to compile a
freshly updated git tree with only the above patch applied. Are there
any contrary reports?

Greets,
Daniel
