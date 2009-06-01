Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 15:41:44 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42993 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025340AbZFAOlg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 15:41:36 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n51EfDnd011416;
	Mon, 1 Jun 2009 15:41:13 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n51EfDmN011414;
	Mon, 1 Jun 2009 15:41:13 +0100
Date:	Mon, 1 Jun 2009 15:41:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 05/10] bcm63xx: dev-enet: initialize
	shared_device_registered to 0
Message-ID: <20090601144113.GD6604@linux-mips.org>
References: <200905312028.37498.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200905312028.37498.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 31, 2009 at 08:28:37PM +0200, Florian Fainelli wrote:

> This patch initialize the shared_device_registered
> variable with 0, actually required for the check
> to be working.
> 
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
> index 51c2e5a..0298973 100644
> --- a/arch/mips/bcm63xx/dev-enet.c
> +++ b/arch/mips/bcm63xx/dev-enet.c
> @@ -28,7 +28,7 @@ static struct platform_device bcm63xx_enet_shared_device = {
>  	.resource	= shared_res,
>  };
>  
> -static int shared_device_registered;
> +static int shared_device_registered = 0;

This is bogus.  The variable defaults to zero.  Explicit initialization
however will inflate the .data section.  Dropped.

  Ralf
