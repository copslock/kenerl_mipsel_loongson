Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jan 2010 06:44:37 +0100 (CET)
Received: from biz61.inmotionhosting.com ([74.124.219.59]:35084 "EHLO
        biz61.inmotionhosting.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491158Ab0APFoc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jan 2010 06:44:32 +0100
Received: from cpe-76-88-95-122.san.res.rr.com ([76.88.95.122] helo=mud)
        by biz61.inmotionhosting.com with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.69)
        (envelope-from <acmay@acmay.org>)
        id 1NW1SQ-0008Vu-EN; Fri, 15 Jan 2010 21:44:22 -0800
Date:   Fri, 15 Jan 2010 21:44:19 -0800
From:   Andrew May <acmay@acmay.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 7/7] Staging: Octeon Ethernet: Use constants from in.h
Message-ID: <20100115214419.39357506@mud>
In-Reply-To: <4B50C4F4.60903@caviumnetworks.com>
References: <4B463005.8060505@caviumnetworks.com>
        <1262891106-32146-7-git-send-email-ddaney@caviumnetworks.com>
        <20100114232900.55111058@mud>
        <4B50C4F4.60903@caviumnetworks.com>
X-Mailer: Claws Mail 3.7.4 (GTK+ 2.18.5; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - biz61.inmotionhosting.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - acmay.org
X-archive-position: 25601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: acmay@acmay.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10729

On Fri, 15 Jan 2010 11:41:40 -0800
David Daney <ddaney@caviumnetworks.com> wrote:

> Andrew May wrote:
> > On Thu,  7 Jan 2010 11:05:06 -0800
> > David Daney <ddaney@caviumnetworks.com> wrote:
> > 
> >> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> >> ---
> >>  drivers/staging/octeon/ethernet-defines.h |    3 ---
> >>  drivers/staging/octeon/ethernet-tx.c      |    8 ++++----
> >>  2 files changed, 4 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/staging/octeon/ethernet-defines.h
> >> b/drivers/staging/octeon/ethernet-defines.h index 9c4910e..00a8561
> >> 100644 --- a/drivers/staging/octeon/ethernet-defines.h
> >> +++ b/drivers/staging/octeon/ethernet-defines.h
> >> @@ -98,9 +98,6 @@
> >>  #define MAX_SKB_TO_FREE 10
> >>  #define MAX_OUT_QUEUE_DEPTH 1000
> >>  
> >> -#define IP_PROTOCOL_TCP             6
> >> -#define IP_PROTOCOL_UDP             0x11
> >> -
> >>  #define FAU_NUM_PACKET_BUFFERS_TO_FREE (CVMX_FAU_REG_END -
> >> sizeof(uint32_t)) #define TOTAL_NUMBER_OF_PORTS
> >> (CVMX_PIP_NUM_INPUT_PORTS+1) 
> >> diff --git a/drivers/staging/octeon/ethernet-tx.c
> >> b/drivers/staging/octeon/ethernet-tx.c index bc67e41..62258bd
> >> 100644 --- a/drivers/staging/octeon/ethernet-tx.c
> >> +++ b/drivers/staging/octeon/ethernet-tx.c
> >> @@ -359,8 +359,8 @@ dont_put_skbuff_in_hw:
> >>  	if (USE_HW_TCPUDP_CHECKSUM && (skb->protocol ==
> >> htons(ETH_P_IP)) && (ip_hdr(skb)->version == 4) &&
> >> (ip_hdr(skb)->ihl == 5) && ((ip_hdr(skb)->frag_off == 0) ||
> >> (ip_hdr(skb)->frag_off == 1 << 14))
> >> -	    && ((ip_hdr(skb)->protocol == IP_PROTOCOL_TCP)
> >> -		|| (ip_hdr(skb)->protocol == IP_PROTOCOL_UDP))) {
> >> +	    && ((ip_hdr(skb)->protocol == IPPROTO_TCP)
> >> +		|| (ip_hdr(skb)->protocol == IPPROTO_UDP))) {
> >>  		/* Use hardware checksum calc */
> >>  		pko_command.s.ipoffp1 = sizeof(struct ethhdr) + 1;
> >>  	}
> > 
> > Why isn't skb->ip_summed checked here instead?
> 
> That may indeed be the correct thing to do, but the main point of
> this particular patch is to remove local definitions that mirror
> definitions provided by core include files.
> 
> So in order to not let 'the perfect be the enemy of the good' I think 
> this patch should be applied.

I am not against the patch being applied. I also don't think I have
any sort of influence to get it rejected. But in seeing the code it is
just something that jumps out at me, and I wanted to make sure I wasn't
missing something else.

> Indeed it does.  Actually it writes a good checksum on *all* IP
> packets without regard to their source.

That seems like a very bad thing. Maybe the entire section of code
should be removed along with the defines for now.

I don't actually have one of these chips at home to play with and test.
