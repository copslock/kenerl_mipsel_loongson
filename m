Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2010 09:50:46 +0100 (CET)
Received: from bamako.nerim.net ([62.4.17.28]:61502 "EHLO bamako.nerim.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492059Ab0CEIun convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Mar 2010 09:50:43 +0100
Received: from localhost (localhost [127.0.0.1])
        by bamako.nerim.net (Postfix) with ESMTP id 40AFE39DC6B;
        Fri,  5 Mar 2010 09:50:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at nerim.net
Received: from bamako.nerim.net ([127.0.0.1])
        by localhost (bamako.nerim.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tGUr8aZPQJ2S; Fri,  5 Mar 2010 09:50:40 +0100 (CET)
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
        by bamako.nerim.net (Postfix) with ESMTP id ED17139DE4E;
        Fri,  5 Mar 2010 09:50:39 +0100 (CET)
Date:   Fri, 5 Mar 2010 09:50:40 +0100
From:   Jean Delvare <khali@linux-fr.org>
To:     Yang Shi <yang.shi@windriver.com>
Cc:     Wolfram Sang <w.sang@pengutronix.de>, ddaney@caviumnetworks.com,
        ben-linux@fluff.org, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-i2c@vger.kernel.org,
        Konstantin Lazarev <klazarev@sbcglobal.net>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Message-ID: <20100305095040.6ab4612c@hyperion.delvare>
In-Reply-To: <4B90B888.6060005@windriver.com>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>
        <20100305071130.GB21925@pengutronix.de>
        <4B90B341.9000601@windriver.com>
        <20100305074155.GD21925@pengutronix.de>
        <4B90B888.6060005@windriver.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Yang, Wolfram,

On Fri, 05 Mar 2010 15:53:44 +0800, Yang Shi wrote:
> Wolfram Sang 写道:
> >>> Is the use of 'eeprom' instead of 'at24' intentional?
> >>>   
> >>>       
> >> Unfortunately, at24 driver can't work on this board, I must use legacy
> >> eeprom.
> >>     
> >
> > Well, you are of course free to choose here :)
> >
> > I'd just be interested if there is a software limitation which prevents you from
> > using AT24. Because, it _should_ work with all kind of eeproms the legacy driver
> > deals with. Otherwise it is probably a bug which needs to be fixed.
> >   
> 
> Thanks to point out this. Let me take a look at this.

One limitation of the at24 driver is that it needs the underlying
controller to support either raw I2C access or at least I2C block
transactions. Konstantin Lazarev complained about that one month ago
already.

I am currently working on improving the at24 driver so that it falls
back to byte transactions when block transactions are not available. I
might also add word transaction support (as the eeprom driver has) as
it is often the best performance/compatibility trade-off. I'll post the
patch when I'm done.

I'm not yet sure what will happen to the legacy eeprom driver in the
long run, but I would prefer new designs to not rely on it.

-- 
Jean Delvare
