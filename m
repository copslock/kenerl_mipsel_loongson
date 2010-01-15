Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jan 2010 20:43:03 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5637 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492928Ab0AOTm4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jan 2010 20:42:56 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b50c5340000>; Fri, 15 Jan 2010 11:42:44 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 15 Jan 2010 11:41:41 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 15 Jan 2010 11:41:41 -0800
Message-ID: <4B50C4F4.60903@caviumnetworks.com>
Date:   Fri, 15 Jan 2010 11:41:40 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Andrew May <acmay@acmay.org>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 7/7] Staging: Octeon Ethernet: Use constants from in.h
References: <4B463005.8060505@caviumnetworks.com>       <1262891106-32146-7-git-send-email-ddaney@caviumnetworks.com> <20100114232900.55111058@mud>
In-Reply-To: <20100114232900.55111058@mud>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2010 19:41:41.0186 (UTC) FILETIME=[C29CEA20:01CA961A]
X-archive-position: 25600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10385

Andrew May wrote:
> On Thu,  7 Jan 2010 11:05:06 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
> 
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  drivers/staging/octeon/ethernet-defines.h |    3 ---
>>  drivers/staging/octeon/ethernet-tx.c      |    8 ++++----
>>  2 files changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/octeon/ethernet-defines.h
>> b/drivers/staging/octeon/ethernet-defines.h index 9c4910e..00a8561
>> 100644 --- a/drivers/staging/octeon/ethernet-defines.h
>> +++ b/drivers/staging/octeon/ethernet-defines.h
>> @@ -98,9 +98,6 @@
>>  #define MAX_SKB_TO_FREE 10
>>  #define MAX_OUT_QUEUE_DEPTH 1000
>>  
>> -#define IP_PROTOCOL_TCP             6
>> -#define IP_PROTOCOL_UDP             0x11
>> -
>>  #define FAU_NUM_PACKET_BUFFERS_TO_FREE (CVMX_FAU_REG_END -
>> sizeof(uint32_t)) #define TOTAL_NUMBER_OF_PORTS
>> (CVMX_PIP_NUM_INPUT_PORTS+1) 
>> diff --git a/drivers/staging/octeon/ethernet-tx.c
>> b/drivers/staging/octeon/ethernet-tx.c index bc67e41..62258bd 100644
>> --- a/drivers/staging/octeon/ethernet-tx.c
>> +++ b/drivers/staging/octeon/ethernet-tx.c
>> @@ -359,8 +359,8 @@ dont_put_skbuff_in_hw:
>>  	if (USE_HW_TCPUDP_CHECKSUM && (skb->protocol ==
>> htons(ETH_P_IP)) && (ip_hdr(skb)->version == 4) && (ip_hdr(skb)->ihl
>> == 5) && ((ip_hdr(skb)->frag_off == 0) || (ip_hdr(skb)->frag_off == 1
>> << 14))
>> -	    && ((ip_hdr(skb)->protocol == IP_PROTOCOL_TCP)
>> -		|| (ip_hdr(skb)->protocol == IP_PROTOCOL_UDP))) {
>> +	    && ((ip_hdr(skb)->protocol == IPPROTO_TCP)
>> +		|| (ip_hdr(skb)->protocol == IPPROTO_UDP))) {
>>  		/* Use hardware checksum calc */
>>  		pko_command.s.ipoffp1 = sizeof(struct ethhdr) + 1;
>>  	}
> 
> Why isn't skb->ip_summed checked here instead?

That may indeed be the correct thing to do, but the main point of this 
particular patch is to remove local definitions that mirror definitions 
provided by core include files.

So in order to not let 'the perfect be the enemy of the good' I think 
this patch should be applied.

> It seems like the csum
> calculation needs to be skipped by the stack if this is actually going
> to help performance.

FWIW: We do set NETIF_F_IP_CSUM.  We are certainly open to suggestions 
as to how the code could be improved, so I may look at this again in the 
future.  Patches from others are also welcome.

> 
> And does this end up re-writing a bad checksum on a routed packet, back
> to being a good checksum?

Indeed it does.  Actually it writes a good checksum on *all* IP packets 
without regard to their source.

David Daney
