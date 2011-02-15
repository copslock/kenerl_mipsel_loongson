Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 23:16:40 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:33537 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491060Ab1BOWQh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Feb 2011 23:16:37 +0100
Received: by bwz5 with SMTP id 5so926403bwz.36
        for <multiple recipients>; Tue, 15 Feb 2011 14:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=PEplgnLS1fXrsaKRy99CZkvG2sTcsdwhyYkNzRt8eOY=;
        b=PFnTnjHyNy2DwJaAZVLOgC40r21ooQUZbLTtBOSD2wLdZxh80O4BWI7jnYo4n8Mw4W
         +Ct5i4YXVrGQhZA/srNXrfuJHQBhqGpT4yzlNmY1bFNRkjwE+gcVLi5DWL40tjzWXtog
         k2o/Sjf7neuUoygUQRXqErWaVKWi08phzJwiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=jj+w2h3+xC8ayFIAc62tWgE3oroeoVZpil/s7pjXavnp4M0Tir0hQXIaGEb6Vwv3h1
         qDs/tdswXqMns5wh05Y+GqNV6Zfq1Xq9vNcXr59cKtp345tKK5YTIr8o6fOXN8PjRdqw
         fa4Jvy0g1vXgsfTIfR1sUkgcD769xoR7KpgWU=
Received: by 10.204.121.73 with SMTP id g9mr5019570bkr.37.1297808191876;
        Tue, 15 Feb 2011 14:16:31 -0800 (PST)
Received: from [192.168.2.129] ([217.66.174.142])
        by mx.google.com with ESMTPS id u23sm2975855bkw.9.2011.02.15.14.16.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 14:16:31 -0800 (PST)
Message-ID: <4D5AFB3B.6080407@gmail.com>
Date:   Tue, 15 Feb 2011 23:16:27 +0100
From:   Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; cs-CZ; rv:1.9.2.13) Gecko/20101206 SUSE/3.1.7 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Nikolay Ledovskikh <nledovskikh@gmail.com>
CC:     "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, lrodriguez@atheros.com,
        mickflemm@gmail.com, me@bobcopeland.com,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] ath5k: Use mips generic dma-mapping functions to avoid
 seqfault on AHB chips
References: <20110215220929.1cc6e9d4.nledovskikh@gmail.com>     <4D5AD6A6.8090505@gmail.com>    <AANLkTiks9rG2CzM2LabNerK3zgJ+R+weytQgvXxDbNe7@mail.gmail.com>  <4D5AE52B.80002@gmail.com> <AANLkTinnCOEXF835yhNeJDfBdKjx_dss6TFeUmjL-Yk2@mail.gmail.com>
In-Reply-To: <AANLkTinnCOEXF835yhNeJDfBdKjx_dss6TFeUmjL-Yk2@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jirislaby@gmail.com
Precedence: bulk
X-list: linux-mips

On 02/15/2011 10:39 PM, Nikolay Ledovskikh wrote:
>> Maybe the address you got from the platform side was already ored by
>> KSEG1...
> 
> I took a look at openwrt atheros platform code and suppose you are right.
> So what we should do for now? Add pointer cast (void __iomem *)?
> Because ioremap_nocache doesn't work as expected. I think it's better
> to rewrote the openwrt
> code, but not now.

So I've found:
http://www.google.com/codesearch/p?hl=en#sayuPQDVf4c/trunk/openwrt/target/linux/atheros/patches-2.6.32/100-board.patch&q=ar231x-wmac&sa=N&cd=4&ct=rc

There, the res->start may be either of the following:
AR531X_WLAN0 .. 0x18000000
AR531X_WLAN1 .. 0x18500000
AR2315_WLAN0 .. 0xB0000000

I suppose you have the 3rd otherwise it should die without ORing KSEG1?

Or maybe MIPS guys will correct me? (The problem is that ioremap of one
of the addresses above kills the box. If Nikolaj removes the ioremap and
uses the address directly, it works for him. I'm saying it will die for
the first 2 addresses if we remove ioremap completely -- from what I
found in MIPS specs.)

I _think_ there should be (instead of ioremap):
sc->iobase = (void __iomem *)KSEG1ADDR(res->start);

Then we do readl(sc->iobase) et al. in ath5k.

thanks,
-- 
js
