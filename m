Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 06:03:46 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:11455 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20024998AbYG2FDl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Jul 2008 06:03:41 +0100
Received: (qmail 3982 invoked by uid 1000); 29 Jul 2008 07:03:38 +0200
Date:	Tue, 29 Jul 2008 07:03:38 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	drzeus@drzeus.cx, linux-mips@linux-mips.org
Subject: Re: [PATCH] au1xmmc: raise segment size limit.
Message-ID: <20080729050338.GA3908@roarinelk.homelinux.net>
References: <20080728133120.GB26494@roarinelk.homelinux.net> <488E4670.7090305@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <488E4670.7090305@ru.mvista.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Sergei,

> Manuel Lauss wrote:
>> Please apply this patch, as it fixes an oops when MMC-DMA and network
>> traffic are active at the same time.  This seems to be a 2.6.27-only 
>> thing;
>> the current au1xmmc code (minus the polling parts) works fine on 2.6.26.
>>
>> ---
>>
>> Raise the DMA block size limit from 2048 bytes to the maximum supported
>> by the DMA controllers on the chip (128kB on Au1100, 4MB on Au1200).
>>
>> This gives a small performance boost and apparently fixes an oops when
>> MMC-DMA and network traffic are active at the same time.
>>
>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>>
>>   
> [...]
>> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
>> index 99b2091..dd414f1 100644
>> --- a/drivers/mmc/host/au1xmmc.c
>> +++ b/drivers/mmc/host/au1xmmc.c
>> @@ -61,7 +61,13 @@
>>   /* Hardware definitions */
>>  #define AU1XMMC_DESCRIPTOR_COUNT 1
>> -#define AU1XMMC_DESCRIPTOR_SIZE  2048
>> +
>> +/* max DMA seg size: 64kB on Au1100, 4MB on Au1200 */
>>   
>
>  So, it's 64 or 128 KB? KB since k prefix usualy means decimal kilo... :-)

I'm not so sure myself.  If I understand the datasheet correctly, the Au1100
DMA ctrl always transfers 2 segments of up to 64KB each.  I'll correct the
commit-text and resend. Someone else with Au1100 hardware can figure that
out if they want; for now this only matter for Au1200 DMA.

(And I refuse to acknowledge the existence of that 'kibibyte' crap ;-) )

> WBR, Sergei

Thank you Sergei,
	Manuel Lauss
