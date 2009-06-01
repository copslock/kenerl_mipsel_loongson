Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 15:42:42 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42999 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025340AbZFAOmR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 15:42:17 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n51EfsbP011437;
	Mon, 1 Jun 2009 15:41:54 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n51EfsHL011436;
	Mon, 1 Jun 2009 15:41:54 +0100
Date:	Mon, 1 Jun 2009 15:41:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 06/10] bcm63xx: zero initialize mac_addr_used.
Message-ID: <20090601144154.GE6604@linux-mips.org>
References: <200905312029.07558.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200905312029.07558.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 31, 2009 at 08:29:07PM +0200, Florian Fainelli wrote:

> This patch initializes mac_addr_used to zero, the checks
> against it later would not work properly.
> 
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> index 78a40e7..298804a 100644
> --- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
> +++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> @@ -32,7 +32,7 @@
>  #define PFX	"board_bcm963xx: "
>  
>  static struct bcm963xx_nvram nvram;
> -static unsigned int mac_addr_used;
> +static unsigned int mac_addr_used = 0;

Ditto - the variable defaults to zero.  Explicit initialization however
will inflate the .data section.  Dropped.

  Ralf
