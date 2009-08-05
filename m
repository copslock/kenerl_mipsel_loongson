Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2009 10:19:27 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:40439 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492443AbZHEITP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Aug 2009 10:19:15 +0200
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 669F33ECA; Wed,  5 Aug 2009 01:19:11 -0700 (PDT)
Message-ID: <4A79407B.7070604@ru.mvista.com>
Date:	Wed, 05 Aug 2009 12:19:07 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
MIME-Version: 1.0
To:	Alexander Clouter <alex@digriz.org.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] ar7: register watchdog driver only if enabled in hardware
 configuration
References: <200908042309.36721.florian@openwrt.org> <62qmk6-g11.ln1@chipmunk.wormnet.eu>
In-Reply-To: <62qmk6-g11.ln1@chipmunk.wormnet.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Alexander Clouter wrote:

>> This patch checks if the watchdog enable bit is set in the DCL
>> register meaning that the hardware watchdog actually works and
>> if so, register the ar7_wdt platform_device.
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>> ---
>> diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
>> index e2278c0..835f3f0 100644
>> --- a/arch/mips/ar7/platform.c
>> +++ b/arch/mips/ar7/platform.c
>> @@ -503,6 +503,7 @@ static int __init ar7_register_devices(void)
>> {
>>        u16 chip_id;
>>        int res;
>> +       u32 *bootcr, val;
>> #ifdef CONFIG_SERIAL_8250
>>        static struct uart_port uart_port[2];
>>
>> @@ -595,7 +596,13 @@ static int __init ar7_register_devices(void)
>>
>>        ar7_wdt_res.end = ar7_wdt_res.start + 0x20;
>>
>> -       res = platform_device_register(&ar7_wdt);
>> +       bootcr = (u32 *)ioremap_nocache(AR7_REGS_DCL, 4);
>> +       val = *bootcr;
>> +       iounmap(bootcr);
>> +
>> +       /* Register watchdog only if enabled in hardware */
>> +       if (val & AR7_WDT_HW_ENA)
>> +               res = platform_device_register(&ar7_wdt);
>>
>>     
> I think the 'correct' way to do this is:
> ---
> void __iomem *bootcr;
> u32 val;
>
> ...
>
> bootcr = ioremap_nocache(AR7_REGS_DCL, 4);
> val = *bootcr;
>   

  Wait, you can't dereference a pointer to void...

WBR, Sergei
