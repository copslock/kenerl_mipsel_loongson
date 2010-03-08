Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2010 05:44:12 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:55982 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490960Ab0CHEoJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Mar 2010 05:44:09 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o284hnjt015773;
        Sun, 7 Mar 2010 20:43:49 -0800 (PST)
Received: from [128.224.162.222] ([128.224.162.222]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Sun, 7 Mar 2010 20:43:48 -0800
Message-ID: <4B948083.6000703@windriver.com>
Date:   Mon, 08 Mar 2010 12:43:47 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     Jean Delvare <khali@linux-fr.org>
CC:     Michael Lawnick <ml.lawnick@gmx.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>  <20100305071130.GB21925@pengutronix.de> <4B90B341.9000601@windriver.com>        <20100305074155.GD21925@pengutronix.de> <4B90B888.6060005@windriver.com>        <20100305095040.6ab4612c@hyperion.delvare>      <4B90D85E.6040308@gmx.de>       <4B90DF48.50005@windriver.com>  <20100305115213.4b504710@hyperion.delvare>      <4B90E83A.5020106@gmx.de> <20100305124200.6f6eccfc@hyperion.delvare>
In-Reply-To: <20100305124200.6f6eccfc@hyperion.delvare>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Mar 2010 04:43:49.0127 (UTC) FILETIME=[F1D81170:01CABE79]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Jean Delvare 写道:
> Hi Michael,
>
> On Fri, 05 Mar 2010 12:17:14 +0100, Michael Lawnick wrote:
>   
>> Jean Delvare said the following:
>>     
>>> Well, what EEPROM type do you have exactly? 24c64 is for 64 kbit (8
>>> kByte) EEPROMs using 16-bit addressing. You must use the correct type,
>>> otherwise the at24 driver will misbehave. I am a little surprised
>>> because originally you went for "eeprom" which is not compatible with
>>> "24c64" (8-bit vs. 16-bit addressing).
>>>       
>> Furthermore this brings up another issue:
>> 0x50 typically is SPD-eeprom (DDR initialisation). Corrupting the
>> contents might make your board unbootable - and using a 16bit driver
>> instead of an 8-bit one can corrupt your contents already on
>> (positioned) reading!
>>     
>
> This is totally correct, but better said loud to the list and the
> original poster than only privately to me ;)
>   

Thanks a lot to point out this.

I double checked the manual, the eeprom is SPD of the DIMMs.

I will rework my patch, then send V2 soon.

Regards,
Yang
