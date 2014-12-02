Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2014 02:31:22 +0100 (CET)
Received: from mout.gmx.net ([212.227.17.20]:60473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007224AbaLBBbUSmXJW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Dec 2014 02:31:20 +0100
Received: from [192.168.178.22] ([78.42.221.218]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LlHsg-1YUOd20ir0-00b1mW; Tue, 02 Dec 2014 02:31:14
 +0100
Message-ID: <547D1660.8070208@gmx.de>
Date:   Tue, 02 Dec 2014 02:31:12 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ben Hutchings <ben@decadent.org.uk>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioc3: fix incorrect use of htons/ntohs
References: <1417344054-4374-1-git-send-email-LinoSanfilippo@gmx.de> <1417406976.7215.126.camel@decadent.org.uk>
In-Reply-To: <1417406976.7215.126.camel@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID:  V03:K0:Qn1jlIVijakX2LYv6MUkCZJL7HTvMhbwOAM0tj4yj6w5MMEvGmK
 pkJmsNRelIkXilE2b/l/Jt7MSE+Etcdt7ALMw47ljAgbANXSp6noBqEllpkC0ND+xLThxkE
 semhLS5uf7yUzLG28tNzIAb99PCY9N3rDMHp/BibP5Ydn8+AhazJSKBOe6OMdgTysfCe2pi
 FPgKDo/0yfKfu6tvYgHYw==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <LinoSanfilippo@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: LinoSanfilippo@gmx.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 01.12.2014 05:09, Ben Hutchings wrote:
> On Sun, 2014-11-30 at 11:40 +0100, Lino Sanfilippo wrote:
>> The protocol type in the ip header struct is a single byte variable. So there
>> is no need to swap bytes depending on host endianness.
>> 
>> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
>> ---
>> 
>> Please note that I could not test this, since I dont have access to the
>> concerning hardware.
>> 
>>  drivers/net/ethernet/sgi/ioc3-eth.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
>> index 7a254da..0bb303d 100644
>> --- a/drivers/net/ethernet/sgi/ioc3-eth.c
>> +++ b/drivers/net/ethernet/sgi/ioc3-eth.c
>> @@ -540,8 +540,7 @@ static void ioc3_tcpudp_checksum(struct sk_buff *skb, uint32_t hwsum, int len)
>>  
>>  	/* Same as tx - compute csum of pseudo header  */
>>  	csum = hwsum +
>> -	       (ih->tot_len - (ih->ihl << 2)) +
>> -	       htons((uint16_t)ih->protocol) +
>> +	       (ih->tot_len - (ih->ihl << 2)) + ih->protocol +
>>  	       (ih->saddr >> 16) + (ih->saddr & 0xffff) +
>>  	       (ih->daddr >> 16) + (ih->daddr & 0xffff);
>>
> 
> The pseudo-header is specified as:
> 
>                      +--------+--------+--------+--------+
>                      |           Source Address          |
>                      +--------+--------+--------+--------+
>                      |         Destination Address       |
>                      +--------+--------+--------+--------+
>                      |  zero  |  PTCL  |    TCP Length   |
>                      +--------+--------+--------+--------+
> 
> The current code zero-extends the protocol number to produce the 5th
> 16-bit word of the pseudo-header, then uses htons() to put it in
> big-endian order, consistent with the other fields.  (Yes, it's doing
> addition on big-endian words; this works even on little-endian machines
> due to the way the checksum is specified.)
> 
> The driver should not be doing this at all, though.  It should set
> skb->csum = hwsum; skb->ip_summed = CHECKSUM_COMPLETE; and let the
> network stack adjust the hardware checksum.
> 
>> @@ -1417,7 +1416,7 @@ static int ioc3_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  	 */
>>  	if (skb->ip_summed == CHECKSUM_PARTIAL) {
>>  		const struct iphdr *ih = ip_hdr(skb);
>> -		const int proto = ntohs(ih->protocol);
>> +		const int proto = ih->protocol;
>>  		unsigned int csoff;
>>  		uint32_t csum, ehsum;
>>  		uint16_t *eh;
> 
> This should logically be __be16 proto = htons(ih->protocol), but the
> current version should work in practice.
> 
> However, the driver should really use skb->csum_start and
> skb->csum_offset to work out where the checksum belongs and which bytes
> to cancel out.
> 
> Ben.
> 

Hi Ben,

youre right, the use of htons/ntohs is correct in this case. So thank
you for the explanation and please ignore that patch.

Regards,
Lino
