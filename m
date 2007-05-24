Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2007 22:46:57 +0100 (BST)
Received: from srv5.dvmed.net ([207.36.208.214]:62140 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S20022042AbXEXVqz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2007 22:46:55 +0100
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.10])
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HrL8I-0007tN-5S; Thu, 24 May 2007 21:46:53 +0000
Message-ID: <4656079D.6010109@garzik.org>
Date:	Thu, 24 May 2007 17:46:05 -0400
From:	Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
CC:	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 10/12] drivers: PMC MSP71xx ethernet driver
References: <200705101839.l4AIdHB9030885@pasqua.pmc-sierra.bc.ca>
In-Reply-To: <200705101839.l4AIdHB9030885@pasqua.pmc-sierra.bc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jeff@garzik.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff@garzik.org
Precedence: bulk
X-list: linux-mips

Marc St-Jean wrote:
> +inline static void
> +mspeth_skb_headerinit(struct sk_buff *skb)
> +{
> +	/* these are essential before init */
> +	dst_release(skb->dst);
> +#ifdef CONFIG_XFRM
> +	secpath_put(skb->sp);
> +#endif
> +#ifdef CONFIG_NETFILTER
> +	nf_conntrack_put(skb->nfct);
> +#if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
> +	nf_conntrack_put_reasm(skb->nfct_reasm);
> +#endif
> +#ifdef CONFIG_BRIDGE_NETFILTER
> +	nf_bridge_put(skb->nf_bridge);
> +#endif
> +#endif /* CONFIG_NETFILTER */
> +
> +	/*
> +	 * Now initialise the skb...
> +	 * Clear the members till skb->truesize.
> +	 */
> +	memset(skb, 0, offsetof(struct sk_buff, truesize));
> +}
> +#endif /* CONFIG_MSPETH_SKB_RECYCLE */

Did you ever resend this driver addition, with the above unmaintainable 
skb init hacks removed?

	Jeff
