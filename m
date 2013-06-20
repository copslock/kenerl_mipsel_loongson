Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 03:28:54 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50273 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834832Ab3FTB2wVEl2d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 03:28:52 +0200
Received: by mail-pa0-f46.google.com with SMTP id fa11so5730467pad.33
        for <linux-mips@linux-mips.org>; Wed, 19 Jun 2013 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tEEGI5qPsxOvBUJPNnvZZ49hmfhSB4oMR3MQw0TXUv0=;
        b=AAbUHPlaeuRZlMGBcpcdxazw+z3FTxO24PegJEPeA4OUyoFqlbaSC6Kxm8SQS2svLu
         4OmAFskVl7bONafy2ztaMgaOGJ1zZRFNSs614lLUITQBzWirW/ZKuz5cNSuhHUkdQYFj
         AkqL6jGrOT+tkQ97xIrB3DEVbygUUgcbFXwlBjF3PzlhchmDFJiPga+cKrc5LMpM3GoF
         RmV73rHjbKamq8XN5YL6FPMeFmGeoHT3zbysibRip4HwP7+L6ZChyxLv4DqcfWsIK8V8
         eKZ/ZTqiyLh9f4GZhwfm6TugCGYgM+XsSJsdT3xHCqjP2gTpNOXn2zpcaE6xKoVT75wT
         TLOg==
X-Received: by 10.66.224.73 with SMTP id ra9mr9114938pac.163.1371691725686;
        Wed, 19 Jun 2013 18:28:45 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id bg3sm25290117pbb.44.2013.06.19.18.28.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 18:28:44 -0700 (PDT)
Message-ID: <51C25ACA.1070907@gmail.com>
Date:   Wed, 19 Jun 2013 18:28:42 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Joe Perches <joe@perches.com>
CC:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/2] netdev: octeon_mgmt: Correct tx IFG workaround.
References: <1371688820-4585-1-git-send-email-ddaney.cavm@gmail.com>  <1371688820-4585-2-git-send-email-ddaney.cavm@gmail.com> <1371690487.2146.5.camel@joe-AO722>
In-Reply-To: <1371690487.2146.5.camel@joe-AO722>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/19/2013 06:08 PM, Joe Perches wrote:
> On Wed, 2013-06-19 at 17:40 -0700, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> The previous fix was still too agressive to meet ieee specs.  Increase
>> to (14, 10).
> []
>> diff --git a/drivers/net/ethernet/octeon/octeon_mgmt.c b/drivers/net/ethernet/octeon/octeon_mgmt.c
> []
>> @@ -1141,10 +1141,13 @@ static int octeon_mgmt_open(struct net_device *netdev)
>>   		/* For compensation state to lock. */
>>   		ndelay(1040 * NS_PER_PHY_CLK);
>>
>> -		/* Some Ethernet switches cannot handle standard
>> -		 * Interframe Gap, increase to 16 bytes.
>> +		/* Default Interframe Gaps are too small.  Recommended
>> +		 * workaround is.
>> +		 *
>> +		 * AGL_GMX_TX_IFG[IFG1]=14
>> +		 * AGL_GMX_TX_IFG[IFG2]=10
>
> Why isn't the TX IFG just 96 bit times?

I don't have a full understanding of how the transistors are wired up on 
the chip, so I cannot accurately answer your question.  But I can say 
that after I empirically found the previous values to get the thing to 
work, the hardware designers independently found that the values 
supplied in this patch are required to achieve industry standard IFGs 
with this hardware.


>
> I'm also confused a bit here by the difference between the
> bsd implementation and yours.
>
> http://fxr.watson.org/fxr/source/contrib/octeon-sdk/cvmx-csr-typedefs.h?v=FREEBSD8
>
>   2628  * * Programming IFG1 and IFG2.
>   2629  *
>   2630  *   For half-duplex systems that require IEEE 802.3 compatibility, IFG1 must
>   2631  *   be in the range of 1-8, IFG2 must be in the range of 4-12, and the
>   2632  *   IFG1+IFG2 sum must be 12.
>   2633  *
>   2634  *   For full-duplex systems that require IEEE 802.3 compatibility, IFG1 must
>   2635  *   be in the range of 1-11, IFG2 must be in the range of 1-11, and the
>   2636  *   IFG1+IFG2 sum must be 12.
>   2637  *
>   2638  *   For all other systems, IFG1 and IFG2 can be any value in the range of
>   2639  *   1-15.  Allowing for a total possible IFG sum of 2-30.
>   2640  *
>   2641  * Additionally reset when both MIX0/1_CTL[RESET] are set to 1.
>

The advice in that particular comment in the BSD source code has been 
found to be incorrect, that is why we are overriding the default value 
of this register in the first place.

>>   		 */
>> -		cvmx_write_csr(CVMX_AGL_GMX_TX_IFG, 0x88);
>> +		cvmx_write_csr(CVMX_AGL_GMX_TX_IFG, 0xae);
>>   	}
>>
>>   	octeon_mgmt_rx_fill_ring(netdev);
>
> I don't have a datasheet.  Is one available?
>

I don't believe the datasheets are publicly available, but they do 
exist.  If you feel you have a compelling reason to have one, and don't 
mind jumping through hoops, you could contact me privately.

David Daney
