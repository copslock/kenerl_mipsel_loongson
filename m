Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Nov 2008 15:13:41 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:62858 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23849975AbYKWPNd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 23 Nov 2008 15:13:33 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id F09893EC9; Sun, 23 Nov 2008 07:13:23 -0800 (PST)
Message-ID: <4929730B.2070904@ru.mvista.com>
Date:	Sun, 23 Nov 2008 18:13:15 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	Chad Reese <kreese@caviumnetworks.com>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
References: <49261BE5.2010406@caviumnetworks.com> <49280FC5.3040608@ru.mvista.com> <49282187.8090602@ru.mvista.com> <492851BA.3060306@caviumnetworks.com>
In-Reply-To: <492851BA.3060306@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Chad Reese wrote:

> +    /*
> +     * Don't stop the DMA if the device deasserts DMARQ. Many compact
> +     * flashes deassert DMARQ for a short time between sectors. 
> Instead of

   It's perfectly legal to do for any IDE device -- even not on the 
sector boundaries.

> +     * stoppng and restarting the DMA, we'll let the hardware do it. 
> If the

   stopping

> +     * DMA is really stopped early due to an error condition, a later
> +     * timeout will force us to stop.

   Sigh... So any command error will result in a timeout. I wonder what 
hardware genius decided that CF doesn't need an IRQ...

>>    Also, this fragment of octeon_cf_bmdma_status() looks doubtful to me:
>>     
>>> +    else if (mio_boot_dma_cfg.s.size != 0xfffff)
>>> +        result |= ATA_DMA_ERR; 
>>>       
>>    I suppose this only makes sense when DMA interrupt is active. What 
>> does this bitfield mean?
>>     
>
> When you start the Octeon DMA engine, you program
> mio_boot_dma_cfg.s.size with the number of 16bit words to transfer. As
> the DMA runs, the hardware decrements this field. At the end it ends up
> decrementing past 0 to -1. The above check is simply checking if the DMA
>   

   What warrants that 0xfffff doesn't mean 2 MB transfer?

> completed. Since this specific interrupt can only be generated by the
> DMA engine, it must have been caused by an error condition if the size
> is not -1.
>   

   Note that In the real SFF-8038i BMDMA, error bit doesn't cause an 
interrupt...

> Chad
>   

MBR, Sergei
