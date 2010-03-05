Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2010 11:09:49 +0100 (CET)
Received: from mail.gmx.net ([213.165.64.20]:49858 "HELO mail.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1491083Ab0CEKJo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Mar 2010 11:09:44 +0100
Received: (qmail invoked by alias); 05 Mar 2010 10:09:38 -0000
Received: from unknown (EHLO [192.100.130.239]) [192.100.130.239]
  by mail.gmx.net (mp005) with SMTP; 05 Mar 2010 11:09:38 +0100
X-Authenticated: #54578410
X-Provags-ID: V01U2FsdGVkX18vz2lGKR0vGyqROMmgbGagitm/AS23IlHh/bHnVG
        m+fbdYmS9wX8/r
Message-ID: <4B90D85E.6040308@gmx.de>
Date:   Fri, 05 Mar 2010 11:09:34 +0100
From:   Michael Lawnick <ml.lawnick@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 Mnenhy/0.7.5.0
MIME-Version: 1.0
To:     Jean Delvare <khali@linux-fr.org>
CC:     Yang Shi <yang.shi@windriver.com>,
        Wolfram Sang <w.sang@pengutronix.de>,
        ddaney@caviumnetworks.com, ben-linux@fluff.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org,
        Konstantin Lazarev <klazarev@sbcglobal.net>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>  <20100305071130.GB21925@pengutronix.de> <4B90B341.9000601@windriver.com>        <20100305074155.GD21925@pengutronix.de> <4B90B888.6060005@windriver.com> <20100305095040.6ab4612c@hyperion.delvare>
In-Reply-To: <20100305095040.6ab4612c@hyperion.delvare>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58999999999999997
Return-Path: <ml.lawnick@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ml.lawnick@gmx.de
Precedence: bulk
X-list: linux-mips

Jean Delvare said the following:
> Hi Yang, Wolfram,
> 
> On Fri, 05 Mar 2010 15:53:44 +0800, Yang Shi wrote:
>> Wolfram Sang 写道:
>> >>> Is the use of 'eeprom' instead of 'at24' intentional?
>> >>>   
>> >>>       
>> >> Unfortunately, at24 driver can't work on this board, I must use legacy
>> >> eeprom.
>> >>     
>> >
>> > Well, you are of course free to choose here :)
>> >
>> > I'd just be interested if there is a software limitation which prevents you from
>> > using AT24. Because, it _should_ work with all kind of eeproms the legacy driver
>> > deals with. Otherwise it is probably a bug which needs to be fixed.
>> >   
>> 
>> Thanks to point out this. Let me take a look at this.
> 
> One limitation of the at24 driver is that it needs the underlying
> controller to support either raw I2C access or at least I2C block
> transactions. Konstantin Lazarev complained about that one month ago
> already.
> 
> I am currently working on improving the at24 driver so that it falls
> back to byte transactions when block transactions are not available. I
> might also add word transaction support (as the eeprom driver has) as
> it is often the best performance/compatibility trade-off. I'll post the
> patch when I'm done.
> 
> I'm not yet sure what will happen to the legacy eeprom driver in the
> long run, but I would prefer new designs to not rely on it.
> 

If I don't get all wrong, my 2 Cents:
i2c-octeon will/should be based on raw i2c from kernel version .34 on.
(my patch :-) ) So it should support all transfer modes that i2c can.
Currently it is limited to 8 bytes per transaction.

If I misunderstood something, please ignore the noise.

-- 
KR
Michael
