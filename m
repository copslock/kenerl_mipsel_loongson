Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2008 15:13:30 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:42332 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S23834811AbYKVPNV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Nov 2008 15:13:21 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 0B2493EC9; Sat, 22 Nov 2008 07:13:15 -0800 (PST)
Message-ID: <49282187.8090602@ru.mvista.com>
Date:	Sat, 22 Nov 2008 18:13:11 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-ide@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
References: <49261BE5.2010406@caviumnetworks.com> <49280FC5.3040608@ru.mvista.com>
In-Reply-To: <49280FC5.3040608@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> As part of our efforts to get the Cavium OCTEON processor support
>> merged (see: http://marc.info/?l=linux-mips&m=122704699515601), we
>> have this CF driver for your consideration.
>>
>> Most OCTEON variants have *no* DMA or interrupt support on the CF
>> interface so for these, only PIO is supported.  Although if DMA is
>> available, we do take advantage of it.
>>
>> The register definitions are part of the chip support patch set
>> mentioned above, and are not included here.
>>
>> At this point I would like to get feedback on the patch and would
>> expect that it would merge via the linux-mips tree along with the rest
>> of the chip support.
>>
>> Thanks,
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> [...]
>> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
>> new file mode 100644
>> index 0000000..e8712c0
>> --- /dev/null
>> +++ b/drivers/ata/pata_octeon_cf.c
>> @@ -0,0 +1,942 @@
> [...]
>> +/**
>> + * Get the status of the DMA engine. The results of this function
>> + * must emulate the BMDMA engine expected by libata.
>> + *
>> + * @ap:     ATA port to check status on
>> + *
>> + * Returns BMDMA status bits
>> + */
>> +static uint8_t octeon_cf_bmdma_status(struct ata_port *ap)
>> +{
>> +    struct octeon_cf_data *ocd = ap->dev->platform_data;
>> +    cvmx_mio_boot_dma_intx_t mio_boot_dma_int;
>> +    cvmx_mio_boot_dma_cfgx_t mio_boot_dma_cfg;
>> +    uint8_t result = 0;
>> +
>> +    mio_boot_dma_int.u64 =
>> +        cvmx_read_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine));
>> +    if (mio_boot_dma_int.s.done)
>> +        result |= ATA_DMA_INTR;
>
>   But if you're saying that there is only DMA completion inetrrupt, 
> you *cannot* completely emulate SFF-8038i BMDMA since its interrupt 
> status is the (delayed) IDE INTRQ status. I suggest that you move away 
> from the emulation -- Alan has said it's possible.

   My suggestion then is not to emulate the ATA_DMA_INTR bit (always 
returning it as 0) and use:

    mio_boot_dma_int.u64 = 
cvmx_read_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine));
    if (mio_boot_dma_int.s.done)

directly in octeon_cf_interrupt().

   Also, this fragment of octeon_cf_bmdma_status() looks doubtful to me:

> +    else if (mio_boot_dma_cfg.s.size != 0xfffff)
> +        result |= ATA_DMA_ERR; 

   I suppose this only makes sense when DMA interrupt is active. What 
does this bitfield mean?

MBR, Sergei
