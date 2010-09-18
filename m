Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Sep 2010 00:54:51 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491081Ab0IRWys (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Sep 2010 00:54:48 +0200
Date:   Sat, 18 Sep 2010 23:54:47 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 01/25] arch/mips: Use static const char arrays
Message-ID: <20100918225447.GA4739@linux-mips.org>
References: <cover.1284406638.git.joe@perches.com>
 <8fcec0d2a48e806558e6bc39d5aa98518a97f8c7.1284406638.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fcec0d2a48e806558e6bc39d5aa98518a97f8c7.1284406638.git.joe@perches.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14621

On Mon, Sep 13, 2010 at 12:47:39PM -0700, Joe Perches wrote:

> diff --git a/arch/mips/pnx8550/common/reset.c b/arch/mips/pnx8550/common/reset.c
> index fadd874..e0ac0b2 100644
> --- a/arch/mips/pnx8550/common/reset.c
> +++ b/arch/mips/pnx8550/common/reset.c
> @@ -27,8 +27,8 @@
>  
>  void pnx8550_machine_restart(char *command)
>  {
> -	char head[] = "************* Machine restart *************";
> -	char foot[] = "*******************************************";
> +	static const char head[] = "************* Machine restart *************";
> +	static const char foot[] = "*******************************************";
>  
>  	printk("\n\n");
>  	printk("%s\n", head);

NAK.

The printks should have been taken out and shot.  And while at it line
use the space on the other side of the wall for pnx8550_machine_power_off.

  Ralf
