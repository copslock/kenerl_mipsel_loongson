Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 16:45:54 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:64413 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S22922266AbYKAQpu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 1 Nov 2008 16:45:50 +0000
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id CD4C43EC9; Sat,  1 Nov 2008 09:45:42 -0700 (PDT)
Message-ID: <490C87B3.1000403@ru.mvista.com>
Date:	Sat, 01 Nov 2008 19:45:39 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Phil Sutter <n0-1@freewrt.org>
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix pata-rb532-cf
References: <20081101160930.GA10321@nuty> <1225555965-27557-1-git-send-email-n0-1@freewrt.org> <490C833A.7010702@ru.mvista.com>
In-Reply-To: <490C833A.7010702@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> After applying the following changes I could verify functionality by
>> mounting a filesystem on the cfdisk and reading/writing files in it.
>>
>> The symbols rb532_gpio_set_ilevel and rb532_gpio_set_istat are not yet
>> available in a vanilla kernel, an appropriate patch has already been
>> sent to the linux-mips mailinglist.
>>
>> Also change rb532_pata_data_xfer() so it reads and writes 4-byte blocks,
>> like the original driver did. Rename the offset definition of the
>> buffered data register for clearness.
>>   
>
>   Looks ike I'll have to NAK this part...

   I'd advise to break up the patch since you're fixing 2 unrelated 
things now...

>> index f8b3ffc..bdf413e 100644
>> --- a/drivers/ata/pata_rb532_cf.c
>> +++ b/drivers/ata/pata_rb532_cf.c
>>   
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> [...]
>> @@ -39,9 +40,11 @@
>>  #define RB500_CF_MAXPORTS    1
>>  #define RB500_CF_IO_DELAY    400
>>  
>> -#define RB500_CF_REG_CMD    0x0800
>> +#define RB500_CF_REG_BASE    0x0800
>>  #define RB500_CF_REG_CTRL    0x080E
>> -#define RB500_CF_REG_DATA    0x0C00
>> +/* 32bit buffered data register offset */
>> +#define RB500_CF_REG_DBUF32    0x0C00
>> +#define RB500_CF_REG_ERR    0x080D
>>   
>
>   Wouldn't hurt to have the macros in the ascending address order...
>
>> @@ -72,21 +75,26 @@ static void rb532_pata_exec_command(struct 
>> ata_port *ap,
>>      rb532_pata_finish_io(ap);
>>  }
>>  
>> -static void rb532_pata_data_xfer(struct ata_device *adev, unsigned 
>> char *buf,
>> +static unsigned int rb532_pata_data_xfer(struct ata_device *adev, 
>> unsigned char *buf,
>>                  unsigned int buflen, int write_data)
>>  {
>> +    int i;

  I'd have made this the last variable in the declartion block...

>>      struct ata_port *ap = adev->link->ap;
>>      void __iomem *ioaddr = ap->ioaddr.data_addr;
>>  
>> +    BUG_ON(buflen % sizeof(u32));

   Well, if there's no chance for an ATAPI device to be connected...

>> +
>>      if (write_data) {
>> -        for (; buflen > 0; buflen--, buf++)
>> -            writeb(*buf, ioaddr);
>> +        for(i = 0; i < buflen / sizeof(u32); i++)
>> +            writel(((u32 *)buf)[i], ioaddr);
>>      } else {
>> -        for (; buflen > 0; buflen--, buf++)
>> -            *buf = readb(ioaddr);
>> +        for(i = 0; i < buflen / sizeof(u32); i++)
>> +            ((u32 *)buf)[i] = readl(ioaddr);
>>      }
>
>   So, I didn't get what was wrong with using readsl() and writesl()?
>   Besides, using readl() and witel() this way would be wrong on BE 
> mode since the data is expected to be stored to memory in the LE order.
>

   Hm, I'seeing that RB532 only supports LE it seems -- though I wodner 
why it also selects CONFIG_SWAP_IO_SPACE which shouldn't affect anything 
in LE mode...
Anyway, using readl()/writel() this way is wrong...

MBR, Sergei
