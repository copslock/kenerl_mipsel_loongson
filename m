Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Feb 2011 23:19:02 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:52519 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491060Ab1BOWTA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Feb 2011 23:19:00 +0100
Received: by bwz5 with SMTP id 5so929275bwz.36
        for <multiple recipients>; Tue, 15 Feb 2011 14:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=h6r3YEZJp2n6U6qDMjnnXhnUPK5O10wuvX2iHnsyczY=;
        b=CnnBbQ3VTWKrQoMnEzJO59IjUg3IXLTsaFB3QB71EJJlq2YSpNhhbSFLQiun/jyKdJ
         +nl/H4HrjsJihcco2Bg8kmglOInozfRcbDDOMlFNC/sidshoTWe6YZG1zSo5P9kzBQZX
         QXxoZFGrtrPaYSzYcQCo3pzMTO4h/th60aqyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=QT/e9m+m4FqyWIiylJOdOrWknDGdVusvMgSn2VyayVsFJOFpUfLDyAcfdYgW4H10jD
         DaYiSF4nKF05mFtJyRmsTyBpqLgPKZ0aIqkP7VLVUYGSbZZLJ12TVH6ePWSW6aRZ0rgD
         FUUntLeuebZ1pI+EkxDHHARMsQy9/9kbS8Gp0=
Received: by 10.204.46.154 with SMTP id j26mr26567816bkf.134.1297808334658;
        Tue, 15 Feb 2011 14:18:54 -0800 (PST)
Received: from [192.168.2.129] ([217.66.174.142])
        by mx.google.com with ESMTPS id v25sm2976704bkt.18.2011.02.15.14.18.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 14:18:53 -0800 (PST)
Message-ID: <4D5AFBCB.1090907@gmail.com>
Date:   Tue, 15 Feb 2011 23:18:51 +0100
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
References: <20110215220929.1cc6e9d4.nledovskikh@gmail.com>     <4D5AD6A6.8090505@gmail.com>    <AANLkTiks9rG2CzM2LabNerK3zgJ+R+weytQgvXxDbNe7@mail.gmail.com>  <4D5AE52B.80002@gmail.com> <AANLkTinnCOEXF835yhNeJDfBdKjx_dss6TFeUmjL-Yk2@mail.gmail.com> <4D5AFB3B.6080407@gmail.com>
In-Reply-To: <4D5AFB3B.6080407@gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jirislaby@gmail.com
Precedence: bulk
X-list: linux-mips

On 02/15/2011 11:16 PM, Jiri Slaby wrote:
> On 02/15/2011 10:39 PM, Nikolay Ledovskikh wrote:
>>> Maybe the address you got from the platform side was already ored by
>>> KSEG1...
>>
>> I took a look at openwrt atheros platform code and suppose you are right.
>> So what we should do for now? Add pointer cast (void __iomem *)?
>> Because ioremap_nocache doesn't work as expected. I think it's better
>> to rewrote the openwrt
>> code, but not now.
> 
> So I've found:
> http://www.google.com/codesearch/p?hl=en#sayuPQDVf4c/trunk/openwrt/target/linux/atheros/patches-2.6.32/100-board.patch&q=ar231x-wmac&sa=N&cd=4&ct=rc
> 
> There, the res->start may be either of the following:
> AR531X_WLAN0 .. 0x18000000
> AR531X_WLAN1 .. 0x18500000


> AR2315_WLAN0 .. 0xB0000000

Or maybe this should be 0x10000000 in openwrt in the first place? Then
ioremap should do the right thing, right?

> I suppose you have the 3rd otherwise it should die without ORing KSEG1?
> 
> Or maybe MIPS guys will correct me? (The problem is that ioremap of one
> of the addresses above kills the box. If Nikolaj removes the ioremap and
> uses the address directly, it works for him. I'm saying it will die for
> the first 2 addresses if we remove ioremap completely -- from what I
> found in MIPS specs.)
> 
> I _think_ there should be (instead of ioremap):
> sc->iobase = (void __iomem *)KSEG1ADDR(res->start);
> 
> Then we do readl(sc->iobase) et al. in ath5k.
> 
> thanks,
-- 
js
