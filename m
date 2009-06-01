Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 15:46:49 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38230 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025334AbZFAOql (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 15:46:41 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n51EkIcL011853;
	Mon, 1 Jun 2009 15:46:18 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n51EkIS1011851;
	Mon, 1 Jun 2009 15:46:18 +0100
Date:	Mon, 1 Jun 2009 15:46:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: Re: [PATCH 07/10] bcm63xx: fix typo when printing CPU frequency
Message-ID: <20090601144618.GF6604@linux-mips.org>
References: <200905312029.50326.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200905312029.50326.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 31, 2009 at 08:29:49PM +0200, Florian Fainelli wrote:

> This patch corrects the comment about the CPU
> frequency which is actually printed in Hz and not MHz.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
> index 0a403dd..410c788 100644
> --- a/arch/mips/bcm63xx/cpu.c
> +++ b/arch/mips/bcm63xx/cpu.c
> @@ -238,7 +238,7 @@ void __init bcm63xx_cpu_init(void)
>  
>  	printk(KERN_INFO "Detected Broadcom 0x%04x CPU revision %02x\n",
>  	       bcm63xx_cpu_id, bcm63xx_cpu_rev);
> -	printk(KERN_INFO "CPU frequency is %u MHz\n",
> +	printk(KERN_INFO "CPU frequency is %u Hz\n",

While technically ok I would suggest to print the number in MHz.  Acuracy
probably doesn't matter so even rounding to whole MHz would be ok.

Want me to apply anyway?

  Ralf
