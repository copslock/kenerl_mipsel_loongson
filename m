Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2010 08:54:21 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:60608 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491932Ab0CEHyO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Mar 2010 08:54:14 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o257rkUQ009521;
        Thu, 4 Mar 2010 23:53:46 -0800 (PST)
Received: from [128.224.161.163] ([128.224.161.163]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Thu, 4 Mar 2010 23:53:45 -0800
Message-ID: <4B90B888.6060005@windriver.com>
Date:   Fri, 05 Mar 2010 15:53:44 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     Wolfram Sang <w.sang@pengutronix.de>
CC:     ddaney@caviumnetworks.com, ben-linux@fluff.org, khali@linux-fr.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com> <20100305071130.GB21925@pengutronix.de> <4B90B341.9000601@windriver.com> <20100305074155.GD21925@pengutronix.de>
In-Reply-To: <20100305074155.GD21925@pengutronix.de>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Mar 2010 07:53:45.0916 (UTC) FILETIME=[FB9ECFC0:01CABC38]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

Wolfram Sang Ð´µÀ:
>>> Is the use of 'eeprom' instead of 'at24' intentional?
>>>   
>>>       
>> Unfortunately, at24 driver can't work on this board, I must use legacy
>> eeprom.
>>     
>
> Well, you are of course free to choose here :)
>
> I'd just be interested if there is a software limitation which prevents you from
> using AT24. Because, it _should_ work with all kind of eeproms the legacy driver
> deals with. Otherwise it is probably a bug which needs to be fixed.
>   

Thanks to point out this. Let me take a look at this.

Regards,
Yang

> Regards,
>
>    Wolfram
>
>   
