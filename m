Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2002 16:38:13 +0100 (CET)
Received: from p508B591D.dip.t-dialin.net ([80.139.89.29]:6326 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122123AbSKUPiN>; Thu, 21 Nov 2002 16:38:13 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gALFbdD28575;
	Thu, 21 Nov 2002 16:37:39 +0100
Date: Thu, 21 Nov 2002 16:37:39 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
Cc: kevin@gv.com.tw, jsun@mvista.com, linux-mips@linux-mips.org,
	ppopov@mvista.com
Subject: Re: usb hotplug function with linux mips kernel
Message-ID: <20021121163739.D27757@linux-mips.org>
References: <20021118144212.A12262@linux-mips.org> <00a901c28fc4$76ace700$df0210ac@gv.com.tw> <20021119132922.A15266@linux-mips.org> <20021119095444.C18134@mvista.com> <1037729027.17678.112.camel@zeus.mvista.com> <20021120114930.117a78bb.yoichi_yuasa@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021120114930.117a78bb.yoichi_yuasa@montavista.co.jp>; from yoichi_yuasa@montavista.co.jp on Wed, Nov 20, 2002 at 11:49:30AM +0900
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 20, 2002 at 11:49:30AM +0900, Yoichi Yuasa wrote:

> --- linux.orig/drivers/usb/hub.c	Thu Sep 12 13:09:25 2002
> +++ linux/drivers/usb/hub.c	Wed Nov 20 11:43:34 2002
> @@ -698,12 +698,6 @@
>  		return;
>  	}
>  
> -	if (usb_hub_port_debounce(hub, port)) {
> -		err("connect-debounce failed, port %d disabled", port+1);
> -		usb_hub_port_disable(hub, port);
> -		return;
> -	}
> -
>  	down(&usb_address0_sem);
>  
>  	tempstr = kmalloc(1024, GFP_KERNEL);

Looks like a total hack, don't expect me to apply this ...

  Ralf
