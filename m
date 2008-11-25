Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 17:25:59 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:56093 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23910479AbYKYRZx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Nov 2008 17:25:53 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492c350b0000>; Tue, 25 Nov 2008 12:25:31 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 09:25:29 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 09:25:29 -0800
Message-ID: <492C3509.8010408@caviumnetworks.com>
Date:	Tue, 25 Nov 2008 09:25:29 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Jeff Garzik <jeff@garzik.org>
CC:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] libata: New driver for OCTEON SOC Compact Flash interface
 (v2).
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-2-git-send-email-ddaney@caviumnetworks.com> <492C2EE2.3090702@garzik.org>
In-Reply-To: <492C2EE2.3090702@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2008 17:25:29.0316 (UTC) FILETIME=[CFF48240:01C94F22]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Jeff Garzik wrote:
> David Daney wrote:
>> +
>> +/* Timing multiple used for configuring the boot bus DMA engine */
>> +#define CF_DMA_TIMING_MULT    4
>> +
>> +static struct scsi_host_template octeon_cf_sht = {
>> +    ATA_PIO_SHT(DRV_NAME),
>> +};
>> +
>> +static int mwdmamodes = 0x1f;    /* Support Multiword DMA 0-4 */
>> +module_param(mwdmamodes, int, 0444);
>> +MODULE_PARM_DESC(mwdmamodes,
>> +         "Bitmask controlling which MWDMA modes are supported.  "
>> +         "Default is 0x1f for MWDMA 0-4.");
> 
> Two comments:
> 
> * perhaps I missed this, but why is this module param necessary?  In 
> general we avoid things like this.
> 

The CF interface is on the SOC's Boot Bus.  Under some circumstances a 
  board wide hardware reset can occur while DMA is in progress, this 
results in the CF driving the Boot Bus while the processor is trying to 
read the boot code from the boot ROM which results in an unbootable 
system.  The only recourse is to cycle power to the board.  By allowing 
DMA to be disabled, we eliminate this problem.


> * I would avoid pretending to be an SFF DMA engine, and just code it in 
> the style of a custom DMA engine with SFF registers/mode, such as 
> sata_mv or sata_promise.
> 

It is certainly possible to do that, however I think it will result in a 
much larger driver.  If you strongly object, we would have to bite the 
bullet and do as you suggest.

David Daney
