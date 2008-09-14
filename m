Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2008 21:55:22 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:7301 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S29586013AbYINUzU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2008 21:55:20 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id A88A33F73; Sun, 14 Sep 2008 13:55:15 -0700 (PDT)
Message-ID: <48CD7A2F.9020306@ru.mvista.com>
Date:	Mon, 15 Sep 2008 00:55:11 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp> <48CC3516.9080404@ru.mvista.com>
In-Reply-To: <48CC3516.9080404@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> +static void mm_insw_swap(unsigned long port, void *addr, u32 count)
>> +{
>> +    unsigned short *ptr = addr;
>> +    unsigned long size = count * 2;
>> +    port &= ~1;
>> +    while (count--)
>> +        *ptr++ = le16_to_cpu(__raw_readw((void __iomem *)port));
>> +    __ide_flush_dcache_range((unsigned long)addr, size);
>> +}
>> +static void mm_outsw_swap(unsigned long port, void *addr, u32 count)
>> +{
>> +    unsigned short *ptr = addr;
>> +    unsigned long size = count * 2;
>> +    port &= ~1;
>> +    while (count--) {
>> +        __raw_writew(cpu_to_le16(*ptr), (void __iomem *)port);
>> +        ptr++;
>> +    }
>> +    __ide_flush_dcache_range((unsigned long)addr, size);
>> +}
>>   
>
>    Hum... but is it really correct to convert from/to LE order above? 
> I'm prett sure that data is expected in LE order -- look ar 
> ide_fix_driveid() for example...
>

   Assuming that the IDE data words' MSB appears at offset 6 and LSB at 
offset 7 (which would seem logical), the data is actually in BE (CPU) 
orger, so
mm_insw_swap() should use cpu_to_le16() and mm_outsw_swap() le16_to_cpu()...

MBR, Sergei
