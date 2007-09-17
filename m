Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2007 19:31:01 +0100 (BST)
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:28934 "EHLO
	tuxland.pl") by ftp.linux-mips.org with ESMTP id S20022637AbXIQSax
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Sep 2007 19:30:53 +0100
Received: from public-gprs36899.centertel.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by tuxland.pl (Postfix) with ESMTP id 4E533D2C18;
	Mon, 17 Sep 2007 20:29:43 +0200 (CEST)
Received: from public-gprs36899.centertel.pl (public-gprs36899.centertel.pl [91.94.16.69])
	by tuxland.pl (AISK); Mon, 17 Sep 2007 20:29:40 +0200 (CEST)
From:	Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] drivers/video/pmagb-b-fb.c: Improve diagnostics
Date:	Mon, 17 Sep 2007 20:30:08 +0200
User-Agent: KMail/1.9.7
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	Antonino Daplas <adaplas@pol.net>,
	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64N.0709171746030.17606@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0709171746030.17606@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709172030.08568.m.kozlowski@tuxland.pl>
Return-Path: <m.kozlowski@tuxland.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.kozlowski@tuxland.pl
Precedence: bulk
X-list: linux-mips

Hello,

>  Add error messages to the probe call.

You added them but probably forgot to return them ;)

>  While they may rarely trigger, they may be useful when something weird is 
> going on.  Also this is good style.

[snip]
 
> patch-mips-2.6.18-20060920-pmagb-b-err-1
> diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/pmagb-b-fb.c linux-mips-2.6.18-20060920/drivers/video/pmagb-b-fb.c
> --- linux-mips-2.6.18-20060920.macro/drivers/video/pmagb-b-fb.c	2006-12-16 16:44:41.000000000 +0000
> +++ linux-mips-2.6.18-20060920/drivers/video/pmagb-b-fb.c	2006-12-16 16:44:52.000000000 +0000
> @@ -254,16 +254,23 @@ static int __init pmagbbfb_probe(struct 
>  	struct pmagbbfb_par *par;
>  	char freq0[12], freq1[12];
>  	u32 vid_base;
> +	int err = 0;  

[snip]

> -	if (register_framebuffer(info) < 0)
> +	err = register_framebuffer(info);
> +	if (err < 0) {
> +		printk(KERN_ERR "%s: Cannot register framebuffer\n",
> +		       dev->bus_id);
>  		goto err_smem_map;
> +	}
>  
>  	get_device(dev);

Sth like this is missing?

@@ -330,7 +350,7 @@ err_cmap:

 err_alloc:
 	framebuffer_release(info);
-	return -ENXIO;
+	return err;
 }

No?

Regards,

	Mariusz
