Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6FLBtRw013303
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 14:11:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6FLBtgD013302
	for linux-mips-outgoing; Mon, 15 Jul 2002 14:11:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft18-f97.dialo.tiscali.de [62.246.18.97])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6FLBiRw013285
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 14:11:45 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6FD61k05025;
	Mon, 15 Jul 2002 15:06:01 +0200
Date: Mon, 15 Jul 2002 15:06:01 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: [2.5 PATCH] R10K DMA cache flushing routines for non-coherent systems
Message-ID: <20020715150601.B4837@dea.linux-mips.net>
References: <Pine.LNX.4.21.0207142313170.8659-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0207142313170.8659-100000@melkor>; from vivien.chappelier@enst-bretagne.fr on Sun, Jul 14, 2002 at 11:17:39PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jul 14, 2002 at 11:17:39PM +0200, Vivien Chappelier wrote:

> @@ -111,13 +115,96 @@
>  	}
>  }
>  
> +static void
> +andes_flush_cache_all(void)
> +{
> +	andes_flush_cache_l1();
> +	andes_flush_cache_l2();
> +}

We can optimize that slightly.  By leaving it an empty function as it is :-)

>  void
>  andes_flush_icache_page(unsigned long page)
>  {
> -	if (scache_lsz64)
> -		blast_scache64_page(page);
> -	else
> -		blast_scache128_page(page);
> +	switch (sc_lsize) {
> +		case 64:
> +			blast_scache64_page(page);
> +			break;
> +		case 128:
> +			blast_scache128_page(page);
> +			break;

Eh...

So this is replacing a wrong version with another wrong piece of code.
There simply is no reason to flush the second level cache at this point.
That forcing instructions to be re-fetched from memory and that's slooow.

> +	_dma_cache_wback_inv = andes_dma_cache_wback_inv;
> +	_dma_cache_wback = andes_dma_cache_wback;
> +	_dma_cache_inv = andes_dma_cache_inv;

This is breaking cache coherent machines.

Encore une fois :-)

  Ralf
