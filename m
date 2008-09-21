Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Sep 2008 10:36:07 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:24780 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S62074248AbYIUJV3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 21 Sep 2008 10:21:29 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C39E33ECA; Sun, 21 Sep 2008 02:21:23 -0700 (PDT)
Message-ID: <48D6120F.5000802@ru.mvista.com>
Date:	Sun, 21 Sep 2008 13:21:19 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp> <48D57245.8060606@ru.mvista.com>
In-Reply-To: <48D57245.8060606@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> This controller has standard ATA taskfile registers and DMA
>> command/status registers, but the register layout is swapped on big
>> endian.  There are some other endian issue and some special registers
>> which requires many custom dma_ops/port_ops routines.
>>
>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>>   
>
>   I thought that I'd only have the stylyistic comments and ACK the 
> patch but it shouldn't even compile... :-/

   Hm, it should compile in the context of linux-next tree..

>> +static void tx4939ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
>> +{
>> +    ide_hwif_t *hwif = HWIF(drive);
>> +    int is_slave = drive->dn & 1;
>> +    u32 mask, val;
>> +    u8 safe = pio;
>> +    ide_drive_t *pair;
>> +
>> +    pair = ide_get_pair_dev(drive);
>>   
>
>   Wait, have you tried to compile this driver? The function is called 
> ide_get_paired_drive() -- and I did name it correctly in my previous 
> review.

   I didn't realize that Bart has renamed the function in one of the 
pending patches...

MBR, Sergei
