Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2007 19:49:13 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:17782 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022847AbXCXTtJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2007 19:49:09 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 736FC3ECA; Sat, 24 Mar 2007 12:48:35 -0700 (PDT)
Message-ID: <460580BF.4040904@ru.mvista.com>
Date:	Sat, 24 Mar 2007 22:49:19 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	mason <mason@broadcom.com>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] NAPI support for Sibyte MAC
References: <20070323171132.GA1464@broadcom.com>
In-Reply-To: <20070323171132.GA1464@broadcom.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, you wrote:

>   This patch completes the NAPI functionality for SB1250 MAC, including making
>   NAPI a kernel option that can be turned on or off and adds the "sbmac_poll"
>   routine.

> Index: linux-2.6.14-cgl/drivers/net/Kconfig
> ===================================================================
> --- linux-2.6.14-cgl.orig/drivers/net/Kconfig	2006-09-20 14:58:54.000000000 -0700
> +++ linux-2.6.14-cgl/drivers/net/Kconfig	2006-09-20 17:04:31.000000000 -0700

[...]

> @@ -2075,12 +2143,52 @@
>  		 */
>  
>  		if (isr & (M_MAC_INT_CHANNEL << S_MAC_TX_CH0)) {
> -			sbdma_tx_process(sc,&(sc->sbm_txdma));
> +			sbdma_tx_process(sc,&(sc->sbm_txdma), 0);
> +#ifdef CONFIG_NETPOLL_TRAP
> +		       if (netpoll_trap()) {
> +			       if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state)) 
> +				       __netif_schedule(dev);
> +		       }
> +#endif
>  		}

    This just doesn't make sense. That option is enabled to *prevent* calls to 
__netif_schedule() -- you can't override it that way. (Well, how it works 
currently, doesn't make much sense either since it totally breaks the TX queue 
control -- I was going to post a patch).

> +	if (isr & (M_MAC_INT_CHANNEL << S_MAC_RX_CH0)) {
> +		if (netif_rx_schedule_prep(dev)) {
> +			__raw_writeq(0, sc->sbm_imr);
> +			__netif_rx_schedule(dev);
> +			/* Depend on the exit from poll to reenable intr */
> +		}
> +		else {
> +			/* may leave some packets behind */
> +			sbdma_rx_process(sc,&(sc->sbm_rxdma),
> +					 SBMAC_MAX_RXDESCR * 2, 0);
> +		}
> +	}
> +#else
> +	/* Non NAPI */
> +	for (;;) {
> + 
>  		/*
> -		 * Receives on channel 0
> +		 * Read the ISR (this clears the bits in the real
> +		 * register, except for counter addr)
>  		 */
> +		isr = __raw_readq(sc->sbm_isr) & ~M_MAC_COUNTER_ADDR;
> +
> +		if (isr == 0)
> +			break;
> +
> +		handled = 1;
> +
> +		if (isr & (M_MAC_INT_CHANNEL << S_MAC_TX_CH0)) {
> +			sbdma_tx_process(sc,&(sc->sbm_txdma),
> +					 SBMAC_MAX_RXDESCR * 2);
> +#ifdef CONFIG_NETPOLL_TRAP
> +		       if (netpoll_trap()) {
> +			       if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state)) 
> +				       __netif_schedule(dev);
> +		       }
> +#endif
> +		}

    Same here.

WBR, Sergei
