Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jul 2006 09:45:51 +0100 (BST)
Received: from deliver-2.mx.triera.net ([213.161.0.32]:18086 "EHLO
	deliver-2.mx.triera.net") by ftp.linux-mips.org with ESMTP
	id S8133365AbWGNIpk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Jul 2006 09:45:40 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-2.mx.triera.net (Postfix) with ESMTP id 35D51163;
	Fri, 14 Jul 2006 10:45:30 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id AF2BA1BC08E;
	Fri, 14 Jul 2006 10:45:31 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id D96C21A18C0;
	Fri, 14 Jul 2006 10:45:30 +0200 (CEST)
Date:	Fri, 14 Jul 2006 10:45:33 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
	linux-mips <linux-mips@linux-mips.org>,
	Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] USB: removed a unbalanced #endif from ohci-au1xxx.c
Message-ID: <20060714084533.GP31105@domen.ultra.si>
References: <20060714162935.70502a98.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714162935.70502a98.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

On 14/07/06 16:29 +0900, Yoichi Yuasa wrote:
> Hi,
> 
> This patch has removed a unbalanced #endif from ohci-au1xxx.c .
> 
> Error message was:
> In file included from drivers/usb/host/ohci-hcd.c:909:
> drivers/usb/host/ohci-au1xxx.c:113:2: #endif without #if
> 
> Yoichi
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> diff -pruN -X 2.6.18-rc1/Documentation/dontdiff 2.6.18-rc1-orig/drivers/usb/host/ohci-au1xxx.c 2.6.18-rc1/drivers/usb/host/ohci-au1xxx.c
> --- 2.6.18-rc1-orig/drivers/usb/host/ohci-au1xxx.c	2006-07-14 11:17:34.443211500 +0900
> +++ 2.6.18-rc1/drivers/usb/host/ohci-au1xxx.c	2006-07-14 10:33:47.945949750 +0900
> @@ -110,7 +110,6 @@ static void au1xxx_start_ohc(struct plat
>  
>  	printk(KERN_DEBUG __FILE__
>  	": Clock to USB host has been enabled \n");
> -#endif
>  }
>  
>  static void au1xxx_stop_ohc(struct platform_device *dev)

Looks right to me.

It looks like something went wrong with this patch
http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=d14feb5ee4a46218f92b21ed52338b64130a151b

Looks like ehci-au1xxx.c might also be affected.
Daniel?


	Domen
