Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2008 11:13:35 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:33110 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28658164AbYICKNd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2008 11:13:33 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id ACC1F3ECA; Wed,  3 Sep 2008 03:13:30 -0700 (PDT)
Message-ID: <48BE6346.4070207@ru.mvista.com>
Date:	Wed, 03 Sep 2008 14:13:26 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/6] TXx9: Microoptimize interrupt handlers
References: <1220275361-5001-2-git-send-email-anemo@mba.ocn.ne.jp>
In-Reply-To: <1220275361-5001-2-git-send-email-anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

> The IOC interrupt status register on RBTX49XX only have 8 bits.  Use
> 8-bit version of __fls() to optimize interrupt handlers.
>   

   But doesn't the patch also change the result of 
toshiba_rbtx49{27|38}_irq_nested() if the register reads back as 0?

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  arch/mips/txx9/rbtx4927/irq.c   |    6 +++---
>  arch/mips/txx9/rbtx4938/irq.c   |    8 ++++----
>  include/asm-mips/txx9/generic.h |   18 ++++++++++++++++++
>  3 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/txx9/rbtx4927/irq.c b/arch/mips/txx9/rbtx4927/irq.c
> index 22076e3..9c14ebb 100644
> --- a/arch/mips/txx9/rbtx4927/irq.c
> +++ b/arch/mips/txx9/rbtx4927/irq.c
> @@ -133,9 +133,9 @@ static int toshiba_rbtx4927_irq_nested(int sw_irq)
>  	u8 level3;
>  
>  	level3 = readb(rbtx4927_imstat_addr) & 0x1f;
> -	if (level3)
> -		sw_irq = RBTX4927_IRQ_IOC + fls(level3) - 1;
> -	return sw_irq;
> +	if (unlikely(!level3))
> +		return -1;
> +	return RBTX4927_IRQ_IOC + __fls8(level3);
>  }
>  
>  static void __init toshiba_rbtx4927_irq_ioc_init(void)
> diff --git a/arch/mips/txx9/rbtx4938/irq.c b/arch/mips/txx9/rbtx4938/irq.c
> index ca2f830..7d21bef 100644
> --- a/arch/mips/txx9/rbtx4938/irq.c
> +++ b/arch/mips/txx9/rbtx4938/irq.c
> @@ -85,10 +85,10 @@ static int toshiba_rbtx4938_irq_nested(int sw_irq)
>  	u8 level3;
>  
>  	level3 = readb(rbtx4938_imstat_addr);
> -	if (level3)
> -		/* must use fls so onboard ATA has priority */
> -		sw_irq = RBTX4938_IRQ_IOC + fls(level3) - 1;
> -	return sw_irq;
> +	if (unlikely(!level3))
> +		return -1;
> +	/* must use fls so onboard ATA has priority */
> +	return RBTX4938_IRQ_IOC + __fls8(level3);
>  }
>  
>  static void __init

WBR, Sergei
