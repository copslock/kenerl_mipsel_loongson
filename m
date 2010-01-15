Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2010 08:29:20 +0100 (CET)
Received: from biz61.inmotionhosting.com ([74.124.219.59]:49737 "EHLO
        biz61.inmotionhosting.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491138Ab0AOH3Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2010 08:29:16 +0100
Received: from orthoptera.viasat.com ([199.106.52.17] helo=mud)
        by biz61.inmotionhosting.com with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.69)
        (envelope-from <acmay@acmay.org>)
        id 1NVgcB-0000jt-VM; Thu, 14 Jan 2010 23:29:04 -0800
Date:   Thu, 14 Jan 2010 23:29:00 -0800
From:   Andrew May <acmay@acmay.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 7/7] Staging: Octeon Ethernet: Use constants from in.h
Message-ID: <20100114232900.55111058@mud>
In-Reply-To: <1262891106-32146-7-git-send-email-ddaney@caviumnetworks.com>
References: <4B463005.8060505@caviumnetworks.com>
        <1262891106-32146-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: Claws Mail 3.7.4 (GTK+ 2.18.5; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - biz61.inmotionhosting.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - acmay.org
X-archive-position: 25594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: acmay@acmay.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10019

On Thu,  7 Jan 2010 11:05:06 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  drivers/staging/octeon/ethernet-defines.h |    3 ---
>  drivers/staging/octeon/ethernet-tx.c      |    8 ++++----
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/octeon/ethernet-defines.h
> b/drivers/staging/octeon/ethernet-defines.h index 9c4910e..00a8561
> 100644 --- a/drivers/staging/octeon/ethernet-defines.h
> +++ b/drivers/staging/octeon/ethernet-defines.h
> @@ -98,9 +98,6 @@
>  #define MAX_SKB_TO_FREE 10
>  #define MAX_OUT_QUEUE_DEPTH 1000
>  
> -#define IP_PROTOCOL_TCP             6
> -#define IP_PROTOCOL_UDP             0x11
> -
>  #define FAU_NUM_PACKET_BUFFERS_TO_FREE (CVMX_FAU_REG_END -
> sizeof(uint32_t)) #define TOTAL_NUMBER_OF_PORTS
> (CVMX_PIP_NUM_INPUT_PORTS+1) 
> diff --git a/drivers/staging/octeon/ethernet-tx.c
> b/drivers/staging/octeon/ethernet-tx.c index bc67e41..62258bd 100644
> --- a/drivers/staging/octeon/ethernet-tx.c
> +++ b/drivers/staging/octeon/ethernet-tx.c
> @@ -359,8 +359,8 @@ dont_put_skbuff_in_hw:
>  	if (USE_HW_TCPUDP_CHECKSUM && (skb->protocol ==
> htons(ETH_P_IP)) && (ip_hdr(skb)->version == 4) && (ip_hdr(skb)->ihl
> == 5) && ((ip_hdr(skb)->frag_off == 0) || (ip_hdr(skb)->frag_off == 1
> << 14))
> -	    && ((ip_hdr(skb)->protocol == IP_PROTOCOL_TCP)
> -		|| (ip_hdr(skb)->protocol == IP_PROTOCOL_UDP))) {
> +	    && ((ip_hdr(skb)->protocol == IPPROTO_TCP)
> +		|| (ip_hdr(skb)->protocol == IPPROTO_UDP))) {
>  		/* Use hardware checksum calc */
>  		pko_command.s.ipoffp1 = sizeof(struct ethhdr) + 1;
>  	}

Why isn't skb->ip_summed checked here instead? It seems like the csum
calculation needs to be skipped by the stack if this is actually going
to help performance.

And does this end up re-writing a bad checksum on a routed packet, back
to being a good checksum?
