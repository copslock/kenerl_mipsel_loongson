Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 14:33:57 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:1508 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20022185AbXCTOdz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2007 14:33:55 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id EA1AA3ED1; Tue, 20 Mar 2007 07:33:21 -0700 (PDT)
Message-ID: <45FFF0D9.4020905@ru.mvista.com>
Date:	Tue, 20 Mar 2007 17:34:01 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	dsaxena@plexity.net
Cc:	netdev@vger.kernel.org, ralf@linux-mips.org, jeff@garzik.org,
	linux-mips@linux-mips.org, Manish Lachwani <mlachwani@mvista.com>
Subject: Re: [PATCH] Netpoll support for Sibyte MAC
References: <20070319224311.GA10176@plexity.net>
In-Reply-To: <20070319224311.GA10176@plexity.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Deepak Saxena wrote:

> NETPOLL support for Sibyte MAC

> Index: linux-2.6.18/drivers/net/sb1250-mac.c
> ===================================================================
> --- linux-2.6.18.orig/drivers/net/sb1250-mac.c
> +++ linux-2.6.18/drivers/net/sb1250-mac.c
> @@ -1128,6 +1128,26 @@ static void sbdma_fillring(sbmacdma_t *d
>  	}
>  }
>  
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +static void sbmac_netpoll(struct net_device *netdev)
> +{
> +	struct sbmac_softc *sc = netdev_priv(netdev);
> +	int irq = sc->sbm_dev->irq;
> +
> +	__raw_writeq(0, sc->sbm_imr);
> +

    Thinking about it again, I'm not sure that blindly writing to the chip 
reg. to mask interrupts is SMP-safe enough (versus disable_irq()).  I know why 
it was done this way -- to quell the BUG emitted in the realtime mode on SMP 
-- because of scheduling with disabled interrupts in synchoronize_irq(), but 
after having spent much time on netpoll, I'm no longer sure that anything but 
disable_irq() is safe enough for SMP since -- otherwise there's no warranty 
that sbmac_intr() is not running on another CPU...

> +	sbmac_intr(irq, netdev, NULL);
> +
> +#ifdef CONFIG_SBMAC_COALESCE
> +	__raw_writeq(((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << S_MAC_TX_CH0) |
> +	((M_MAC_INT_EOP_COUNT | M_MAC_INT_EOP_TIMER) << S_MAC_RX_CH0),
> +	sc->sbm_imr);
> +#else
> +	__raw_writeq((M_MAC_INT_CHANNEL << S_MAC_TX_CH0) | 
> +	(M_MAC_INT_CHANNEL << S_MAC_RX_CH0), sc->sbm_imr);
> +#endif
> +}
> +#endif

WBR, Sergei
