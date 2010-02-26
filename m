Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2010 04:34:31 +0100 (CET)
Received: from mail-pz0-f174.google.com ([209.85.222.174]:60604 "EHLO
        mail-pz0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490961Ab0BZDe1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2010 04:34:27 +0100
Received: by pzk4 with SMTP id 4so1024237pzk.21
        for <linux-mips@linux-mips.org>; Thu, 25 Feb 2010 19:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=EXnM8Yc9e+A/XPW3yrbZfQ5zzpsoziEXt7ACt2fVJJA=;
        b=k1rTfO4PGq62f3FIXsNAlupSHas0s3T268CorEGZ2o01qIjNeoBcuqVNTy2CVKzFag
         23SdG8g5+EITVlWEkgQD9YzX/Gw93xTtP+5d44NCj1w/4Bc7Wtk62Ob55R7dqwEQOKz5
         CslAV8YCPo0VH073zx3xeJSfdPp9EiotA6w3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kNzIO0PRik+Q6zCBouh+5p7SVIm7Kwz4cn1jlJOXd7J8gkJX0Z4S4pp+D8+KwXI5FO
         aU85yi/KV8M3yPy7WTW4cdphqXNHFam/yhE0FApcQVgWynyP3V+ZXKE/hX3GqHq4qeBd
         5wzDjCh8DgjGvx/y/7EIqslSZBVcOJxcvQe4I=
MIME-Version: 1.0
Received: by 10.143.25.27 with SMTP id c27mr232620wfj.249.1267155258268; Thu, 
        25 Feb 2010 19:34:18 -0800 (PST)
In-Reply-To: <4B872904.6070208@metafoo.de>
References: <4B861890.6090002@gmail.com>
         <201002250852.09638.florian@openwrt.org>
         <6ec4247d1002251312h37f409bdp2384d7fcbddbb321@mail.gmail.com>
         <4B872904.6070208@metafoo.de>
Date:   Fri, 26 Feb 2010 14:04:18 +1030
Message-ID: <6ec4247d1002251934h2168a03fqdcb8e6f0132aa547@mail.gmail.com>
Subject: Re: [PATCH 0/3] XBurst JZ4730 support
From:   Graham Gower <graham.gower@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Florian Fainelli <florian@openwrt.org>, Mirko Vogt <lists@nanl.de>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <graham.gower@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: graham.gower@gmail.com
Precedence: bulk
X-list: linux-mips

On 26 February 2010 12:21, Lars-Peter Clausen <lars@metafoo.de> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi
>
> Graham Gower wrote:
>> On 25 February 2010 18:22, Florian Fainelli <florian@openwrt.org> wrote:
>>> Maybe you should work with the OpenWrt and qi-hardware guys to get the
> jz4740
>>> also merged in the same time?
>>
>> I've not seen any active attempt to get xburst code merged before and
>> assumed there was no interest from others. I'm happy to be wrong on
>> this.
> I'm currently working on linux support for a few jz4740 hbased devices.
> And it's definitely a goal get the code merged upstream once it is in
> proper shape, but there is still some stuff that needs to be done.
> Mostly documentation and smaller cleanups.

I was hoping to get something simple (i.e. bootable with serial) into
the tree and submit other drivers later, as time permits.

>>
>> My patch does not preclude adding jz4740 support. I don't have any of
>> these devices however, so have only included code for the jz4730.
> Unfortunately I don't have a jz4730 programmers manual to check so I
> can't say for sure, but I guess there is quite some code that could be
> shared between between both SoCS(and other jz47xx). I think we don't
> want to do what Ingenic did with their codebase and copy 'n paste the
> same file with minor modifications for each soc type.

The 4740 docs are a copy/paste of the 4730 docs with changes here and
there and lots of register shuffling.

>
> You can find the patches (and files) adding jz4740 support to the
> linux kernel at [1] and [2].
> I suggest you take a look at it and see if we could use some of the
> files(irq, gpio, dma, ...) for a common base between all jz47xx SoCs.

The interrupt controllers look quite similar (the irq numbers have
been shuffled around). The gpio and dma controllers are quite
different however.

The MMC and LCD controllers look almost identical. I don't have any
docs for the nand, but Ingenic's code for the 4730 and 4740 look very
similar. The USB gadget code differs (udc controller info is missing
from my 4740 docs) - the jz4730 gadget driver they are shipping is
broken and they ignored my patch to fix it.


-Graham
