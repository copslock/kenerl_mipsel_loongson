Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Mar 2010 11:52:19 +0100 (CET)
Received: from poutre.nerim.net ([62.4.16.124]:52853 "EHLO poutre.nerim.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492021Ab0CEKwP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Mar 2010 11:52:15 +0100
Received: from localhost (localhost [127.0.0.1])
        by poutre.nerim.net (Postfix) with ESMTP id A185239DE5D;
        Fri,  5 Mar 2010 11:52:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at nerim.net
Received: from poutre.nerim.net ([127.0.0.1])
        by localhost (poutre.nerim.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K9jcy-4BTAHe; Fri,  5 Mar 2010 11:52:12 +0100 (CET)
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
        by poutre.nerim.net (Postfix) with ESMTP id 5917E39DE52;
        Fri,  5 Mar 2010 11:52:12 +0100 (CET)
Date:   Fri, 5 Mar 2010 11:52:13 +0100
From:   Jean Delvare <khali@linux-fr.org>
To:     Yang Shi <yang.shi@windriver.com>
Cc:     Michael Lawnick <ml.lawnick@gmx.de>,
        Wolfram Sang <w.sang@pengutronix.de>,
        ddaney@caviumnetworks.com, ben-linux@fluff.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-i2c@vger.kernel.org,
        Konstantin Lazarev <klazarev@sbcglobal.net>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Message-ID: <20100305115213.4b504710@hyperion.delvare>
In-Reply-To: <4B90DF48.50005@windriver.com>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com>
        <20100305071130.GB21925@pengutronix.de>
        <4B90B341.9000601@windriver.com>
        <20100305074155.GD21925@pengutronix.de>
        <4B90B888.6060005@windriver.com>
        <20100305095040.6ab4612c@hyperion.delvare>
        <4B90D85E.6040308@gmx.de>
        <4B90DF48.50005@windriver.com>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

On Fri, 05 Mar 2010 18:39:04 +0800, Yang Shi wrote:
> Hi guys,
> 
> Thanks for you guys kind advice. I think I find the cause. I coded a 
> wrong eeprom type, "at24" can't work here, it should be "24c64". It 
> works with AT24 eeprom driver, but I'm not sure if this is the right type.

Actually, "at24" can work but you have to provide extra parameters
detailing the size, page size etc. of the EEPROM. All the "24cXX" names
are shortcuts with predefined sizes.

> 
> So, a possible correct to the patch is that:
> 
> +{
> +    I2C_BOARD_INFO("24c64",·0x50),
> +},

Well, what EEPROM type do you have exactly? 24c64 is for 64 kbit (8
kByte) EEPROMs using 16-bit addressing. You must use the correct type,
otherwise the at24 driver will misbehave. I am a little surprised
because originally you went for "eeprom" which is not compatible with
"24c64" (8-bit vs. 16-bit addressing).

Also note that you may want to provide specific page size if you have
tight control over what hardware is used and you intend to write to the
EEPROM on a regular basis. The driver defaults to safe but slow
settings.

OTOH, if you do _not_ want to write to the EEPROM, you want to provide
the AT24_FLAG_READONLY flag.

-- 
Jean Delvare
