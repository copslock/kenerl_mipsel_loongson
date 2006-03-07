Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2006 16:46:51 +0000 (GMT)
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:22689
	"EHLO aria.kroah.org") by ftp.linux-mips.org with ESMTP
	id S8133621AbWCGQqh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Mar 2006 16:46:37 +0000
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1FGfSS-0008KA-E2; Tue, 07 Mar 2006 08:54:48 -0800
Date:	Tue, 7 Mar 2006 08:54:45 -0800
From:	Greg KH <gregkh@suse.de>
To:	"Hamilton, Ian" <Ian.Hamilton@xerox.com>
Cc:	Greg KH <greg@kroah.com>, Martin Michlmayr <tbm@cyrius.com>,
	Jordan Crouse <jordan.crouse@amd.com>,
	linux-usb-devel@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: [PATCH] Buglet in Alchemy OHCI driver
Message-ID: <20060307165445.GA6623@suse.de>
References: <DAF42D2FFC65A146BAB240719E4AD214EE459A@gbrwgceumf02.eu.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAF42D2FFC65A146BAB240719E4AD214EE459A@gbrwgceumf02.eu.xerox.net>
User-Agent: Mutt/1.5.11
Return-Path: <greg@kroah.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Tue, Mar 07, 2006 at 12:17:21PM -0000, Hamilton, Ian wrote:
> Hi Greg,
> 
> I spotted this in the current latest version of ohci-au1xxx.c (accessed
> via git web interface):
> 
> 94
> 95 		if (dev->resource[1].flags != IORESOURCE_IRQ) {
> 96 		pr_debug ("resource[1] is not IORESOURCE_IRQ");
> 97 		retval -ENOMEM;
> 98 	}
> 99  
> 
> instead this from Martin's patch:
> 
> diff --git a/drivers/usb/host/ohci-au1xxx.c
> b/drivers/usb/host/ohci-au1xxx.c
> index aa4d0cd..d8fb1bb 100644
> --- a/drivers/usb/host/ohci-au1xxx.c
> +++ b/drivers/usb/host/ohci-au1xxx.c
> @@ -94,7 +94,7 @@ int usb_hcd_au1xxx_probe (const struct h
>  
>         if (dev->resource[1].flags != IORESOURCE_IRQ) {
>                 pr_debug ("resource[1] is not IORESOURCE_IRQ");
> -               retval = -ENOMEM;
> +               return -ENOMEM;
>         }
> 
> Line 97 produces a warning, but doesn't stop the build, so may have been
> missed.

Can you check the -mm tree to see if it is fixed there or not?  That has
the patches that are pending from my usb tree in it.

And if not, can you send me a patch against the latest -mm?

thanks,

greg k-h
