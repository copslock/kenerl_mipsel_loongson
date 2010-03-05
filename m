Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2010 08:32:07 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:58003 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491948Ab0CEHbm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Mar 2010 08:31:42 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o257VFeI007061;
        Thu, 4 Mar 2010 23:31:15 -0800 (PST)
Received: from [128.224.161.163] ([128.224.161.163]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Thu, 4 Mar 2010 23:31:14 -0800
Message-ID: <4B90B341.9000601@windriver.com>
Date:   Fri, 05 Mar 2010 15:31:13 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     Wolfram Sang <w.sang@pengutronix.de>
CC:     ddaney@caviumnetworks.com, ben-linux@fluff.org, khali@linux-fr.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com> <20100305071130.GB21925@pengutronix.de>
In-Reply-To: <20100305071130.GB21925@pengutronix.de>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Mar 2010 07:31:14.0899 (UTC) FILETIME=[D659FA30:01CABC35]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Wolfram Sang Ð´µÀ:
>> +	{
>> +		I2C_BOARD_INFO("eeprom", 0x50),
>> +	},
>>     
>
> Is the use of 'eeprom' instead of 'at24' intentional?
>   

Unfortunately, at24 driver can't work on this board, I must use legacy
eeprom.

My config:

#CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y

Regards,
Yang

> Regards
>
>   
