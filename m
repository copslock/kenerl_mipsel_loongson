Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 10:16:09 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:46296 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20026422AbYDPJQG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2008 10:16:06 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Jm3kJ-0002nj-00; Wed, 16 Apr 2008 11:16:03 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id EED88C3E3D; Wed, 16 Apr 2008 11:15:54 +0200 (CEST)
Date:	Wed, 16 Apr 2008 11:15:54 +0200
To:	Roel Kluin <12o3l@tiscali.nl>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] MIPS: ip27-timer: fix unsigned irq < 0
Message-ID: <20080416091554.GA6026@alpha.franken.de>
References: <480559DC.2060807@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480559DC.2060807@tiscali.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Apr 16, 2008 at 03:43:56AM +0200, Roel Kluin wrote:
> irq is unsigned, cast to signed to evaluate the allocate_irqno() return value,
>     
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---   
> diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
> index 25d3baf..3c08afd 100644
> --- a/arch/mips/sgi-ip27/ip27-timer.c
> +++ b/arch/mips/sgi-ip27/ip27-timer.c
> @@ -222,19 +222,19 @@ static void __init hub_rt_clock_event_global_init(void)
>  	unsigned int irq;
>  
>  	do {
>  		smp_wmb();
>  		irq = rt_timer_irq;
>  		if (irq)
>  			break;
>  
>  		irq = allocate_irqno();
> -		if (irq < 0)
> +		if ((int) irq < 0)

Why don't you just make irq and rt_timer_irq an int ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
