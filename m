Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2010 11:39:50 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:57323 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492021Ab0CEKjr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Mar 2010 11:39:47 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o25Ad6gu006108;
        Fri, 5 Mar 2010 02:39:06 -0800 (PST)
Received: from [128.224.161.163] ([128.224.161.163]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Fri, 5 Mar 2010 02:39:06 -0800
Message-ID: <4B90DF48.50005@windriver.com>
Date:   Fri, 05 Mar 2010 18:39:04 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     Michael Lawnick <ml.lawnick@gmx.de>
CC:     Jean Delvare <khali@linux-fr.org>,
        Wolfram Sang <w.sang@pengutronix.de>,
        ddaney@caviumnetworks.com, ben-linux@fluff.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org,
        Konstantin Lazarev <klazarev@sbcglobal.net>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>  <20100305071130.GB21925@pengutronix.de> <4B90B341.9000601@windriver.com>        <20100305074155.GD21925@pengutronix.de> <4B90B888.6060005@windriver.com> <20100305095040.6ab4612c@hyperion.delvare> <4B90D85E.6040308@gmx.de>
In-Reply-To: <4B90D85E.6040308@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Mar 2010 10:39:06.0347 (UTC) FILETIME=[14A873B0:01CABC50]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Hi guys,

Thanks for you guys kind advice. I think I find the cause. I coded a 
wrong eeprom type, "at24" can't work here, it should be "24c64". It 
works with AT24 eeprom driver, but I'm not sure if this is the right type.

So, a possible correct to the patch is that:

+{
+    I2C_BOARD_INFO("24c64",·0x50),
+},

Regards,
Yang

Michael Lawnick 写道:
> Jean Delvare said the following:
>   
>> Hi Yang, Wolfram,
>>
>> On Fri, 05 Mar 2010 15:53:44 +0800, Yang Shi wrote:
>>     
>>> Wolfram Sang 写道:
>>>       
>>>>>> Is the use of 'eeprom' instead of 'at24' intentional?
>>>>>>   
>>>>>>       
>>>>>>             
>>>>> Unfortunately, at24 driver can't work on this board, I must use legacy
>>>>> eeprom.
>>>>>     
>>>>>           
>>>> Well, you are of course free to choose here :)
>>>>
>>>> I'd just be interested if there is a software limitation which prevents you from
>>>> using AT24. Because, it _should_ work with all kind of eeproms the legacy driver
>>>> deals with. Otherwise it is probably a bug which needs to be fixed.
>>>>   
>>>>         
>>> Thanks to point out this. Let me take a look at this.
>>>       
>> One limitation of the at24 driver is that it needs the underlying
>> controller to support either raw I2C access or at least I2C block
>> transactions. Konstantin Lazarev complained about that one month ago
>> already.
>>
>> I am currently working on improving the at24 driver so that it falls
>> back to byte transactions when block transactions are not available. I
>> might also add word transaction support (as the eeprom driver has) as
>> it is often the best performance/compatibility trade-off. I'll post the
>> patch when I'm done.
>>
>> I'm not yet sure what will happen to the legacy eeprom driver in the
>> long run, but I would prefer new designs to not rely on it.
>>
>>     
>
> If I don't get all wrong, my 2 Cents:
> i2c-octeon will/should be based on raw i2c from kernel version .34 on.
> (my patch :-) ) So it should support all transfer modes that i2c can.
> Currently it is limited to 8 bytes per transaction.
>
> If I misunderstood something, please ignore the noise.
>
>   
