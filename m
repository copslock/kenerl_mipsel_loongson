Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2007 23:14:48 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:3568 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022092AbXEXWOo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 May 2007 23:14:44 +0100
Received: (qmail 9054 invoked by uid 101); 24 May 2007 22:13:32 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 24 May 2007 22:13:32 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l4OMDVw1002959;
	Thu, 24 May 2007 15:13:31 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <LGNWYHCM>; Thu, 24 May 2007 15:13:31 -0700
Message-ID: <46560E06.9090506@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Jeff Garzik <jeff@garzik.org>
Cc:	Marc St-Jean <stjeanma@pmc-sierra.com>, akpm@linux-foundation.org,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 10/12] drivers: PMC MSP71xx ethernet driver
Date:	Thu, 24 May 2007 15:13:26 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 24 May 2007 22:13:27.0097 (UTC) FILETIME=[C0B46A90:01C79E50]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Jeff Garzik wrote:
> Marc St-Jean wrote:
>  > +inline static void
>  > +mspeth_skb_headerinit(struct sk_buff *skb)
>  > +{
>  > +     /* these are essential before init */
>  > +     dst_release(skb->dst);
>  > +#ifdef CONFIG_XFRM
>  > +     secpath_put(skb->sp);
>  > +#endif
>  > +#ifdef CONFIG_NETFILTER
>  > +     nf_conntrack_put(skb->nfct);
>  > +#if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
>  > +     nf_conntrack_put_reasm(skb->nfct_reasm);
>  > +#endif
>  > +#ifdef CONFIG_BRIDGE_NETFILTER
>  > +     nf_bridge_put(skb->nf_bridge);
>  > +#endif
>  > +#endif /* CONFIG_NETFILTER */
>  > +
>  > +     /*
>  > +      * Now initialise the skb...
>  > +      * Clear the members till skb->truesize.
>  > +      */
>  > +     memset(skb, 0, offsetof(struct sk_buff, truesize));
>  > +}
>  > +#endif /* CONFIG_MSPETH_SKB_RECYCLE */
> 
> Did you ever resend this driver addition, with the above unmaintainable
> skb init hacks removed?
> 
>         Jeff
> 

I removed the section you originally refererd to as it was associated with the
linux 2.4 support which was also removed.

I asked if the remaining section (above) was acceptable so we could retain our
buffer recycling which enhances throughput. I never received a rely so it was
left in my last patch.

The above comment now answers my part of my initial question. Are you aware of
a better way to implement this or must we lose all our recycling enhancements?

Thanks,
Marc
