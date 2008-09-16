Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2008 11:36:30 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:43581 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20135185AbYIPK3i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2008 11:29:38 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 2B07E3EC9; Tue, 16 Sep 2008 03:29:32 -0700 (PDT)
Message-ID: <48CF8A87.6030908@ru.mvista.com>
Date:	Tue, 16 Sep 2008 14:29:27 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>	<48CC3516.9080404@ru.mvista.com> <20080914.220512.126760706.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080914.220512.126760706.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>> +#ifdef __BIG_ENDIAN
>>> +/* custom iops (independent from SWAP_IO_SPACE) */
>>> +static u8 mm_inb(unsigned long port)
>>> +{
>>> +	return (u8)readb((void __iomem *)port);
>>> +}
>>> +static void mm_outb(u8 value, unsigned long port)
>>> +{
>>> +	writeb(value, (void __iomem *)port);
>>> +}
>>> +static void mm_tf_load(ide_drive_t *drive, ide_task_t *task)
>>> +{
>>> +	ide_hwif_t *hwif = drive->hwif;
>>> +	struct ide_io_ports *io_ports = &hwif->io_ports;
>>> +	struct ide_taskfile *tf = &task->tf;
>>> +	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
>>> +
>>> +	if (task->tf_flags & IDE_TFLAG_FLAGGED)
>>> +		HIHI = 0xFF;
>>> +
>>> +	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
>>> +		u16 data = (tf->hob_data << 8) | tf->data;
>>> +
>>> +		__raw_writew(data, (void __iomem *)io_ports->data_addr);
>>>   
>>>       
>>    This doesn't look consistent (aside from the TX4939IDE_REG8/16 issue) 
>> -- mm_outsw_swap() calls cpu_to_le16() before writing 16-bit data but 
>> this code doesn't. So, either one of those should be wrong...
>>     
>
> Thanks, this code should be wrong.  IDE_TFLAG_OUT_DATA is totally
> untested...
>   

   Hum, not necessarily...
   If the data register is BE, this should work correctly, if I don't 
mistake (once you fix the data register's address).

MBR, Sergei
