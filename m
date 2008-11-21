Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 17:06:21 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5336 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23818815AbYKURGT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Nov 2008 17:06:19 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4926ea710001>; Fri, 21 Nov 2008 12:05:53 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 21 Nov 2008 09:05:46 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 21 Nov 2008 09:05:46 -0800
Message-ID: <4926EA6A.7040704@caviumnetworks.com>
Date:	Fri, 21 Nov 2008 09:05:46 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
CC:	linux-ide@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] ide: New libata driver for OCTEON SOC Compact Flash interface.
References: <49261BE5.2010406@caviumnetworks.com> <20081121102137.634616c5@lxorguk.ukuu.org.uk>
In-Reply-To: <20081121102137.634616c5@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2008 17:05:46.0501 (UTC) FILETIME=[654A4350:01C94BFB]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Alan Cox wrote:
>> + * Called to enable the use of DMA based on kernel command line.
>> + */
>> +void octeon_cf_enable_dma(void)
>> +{
>> +	use_cf_dma = 1;
>> +}
> 
> Why not use the standard module parameter interface ?
> 

I will do that.

> 
>> +	/*
>> +	 * PIO modes 0-4 all allow the device to deassert IORDY to slow down
>> +	 * the host.
>> +	 */
> 
> See ata_timing_compute() which also knows about master/slave timing,
> PIO5/6 rules and timing adjustments as well as doing bus clock
> quantisations and lengthenings for you.
> 

OK.

>> +	use_iordy = 1;
> 
> This depends on the device as well and gets quite complicated. We have
> ata_pio_need_iordy() to do the work for you.
> 
>> +	t1 = (t1 * clocks_us) / 1000 / 2;
>> +	if (t1)
>> +		t1--;
> 
> Even if you wanted to do it this way you could just use arrays and lookup
> tables as many other drivers do - ie
> 
> 	pio = dev->pio_mode - XFER_PIO_0;
> 	t1 = data[pio];
> 

The timing calculations are based on the CPU clock rate, It is difficult 
to encapsulate that in a table.

[...]
>> +	/*
>> +	 * Odd lengths are not supported. We should always be a
>> +	 * multiple of 512.
>> +	 */
>> +	BUG_ON(buflen & 1);
> 
> If you get a request for an odd length you should write an extra word
> containing the last byte and one other. See how the standard methods
> handle this.
> 

OK.

> 
>> +	if (ocd->is16bit) {
> 
> Or you could have two methods and two transfer routines defined
> 

Good idea.

>> +			while (words--) {
>> +				*(uint16_t *)buffer = ioread16(data_addr);
>> +				buffer += sizeof(uint16_t);
> 
> By definition tht is 2. Do you have an ioread16_rep ?
> 

It appears to be broken.  One would expect ioread16 and ioread16_rep to 
do endian swapping in the same manner.  On MIPS they do not.  Perhaps it 
would be better to fix the problem at the source.

> 
>> +
>> +/**
>> + * Get ready for a dma operation.  We do nothing, as all DMA
>> + * operations are taken care of in octeon_cf_bmdma_start.
>> + */
>> +void octeon_cf_qc_prep(struct ata_queued_cmd *qc)
>> +{
>> +}
> 
> ata_noop_qc_prep
> 

OK.

> 
>> +/**
>> + * Check if any queued commands have more DMAs, if so start the next
>> + * transfer, else do standard handling.
>> + */
>> +irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
> 
> A lot of these functions could be static it seems

An oversight on my part.  I will make them all static.

> 
>> +static void octeon_cf_delayed_irq(unsigned long data)
>> +{
> 
> What stops the following occuring
> 
> 	ATA irq
> 		BUSY still set
> 		Queue tasklet
> 
> 	Other irq on same line
> 	ATA busy clear
> 		Handle command
> 
> 	Tasklet runs but command was sorted out
> 
> (or a reset of the ata controller in the gap)
> 

Probably nothing.  I will try to sort it out.


>> +	base = cs0 + ocd->base_region_bias;
>> +	if (!ocd->is16bit) {
> 
> 	ata_std_
>> +		ap->ioaddr.cmd_addr	= base + ATA_REG_CMD;
> 
> ata_sff_std_ports ? (at least for the 8bit case)
> 

OK.

Thanks,

David Daney
