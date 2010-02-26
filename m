Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2010 02:51:36 +0100 (CET)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:34441 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492207Ab0BZBvd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2010 02:51:33 +0100
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 1E5472D0;
        Fri, 26 Feb 2010 02:51:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id gv1QdSVUabuo; Fri, 26 Feb 2010 02:51:26 +0100 (CET)
Received: from [192.168.37.30] (port-12319.pppoe.wtnet.de [84.46.48.79])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id C32A12CF;
        Fri, 26 Feb 2010 02:51:20 +0100 (CET)
Message-ID: <4B872904.6070208@metafoo.de>
Date:   Fri, 26 Feb 2010 02:51:00 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090707)
MIME-Version: 1.0
To:     Graham Gower <graham.gower@gmail.com>
CC:     Florian Fainelli <florian@openwrt.org>, Mirko Vogt <lists@nanl.de>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] XBurst JZ4730 support
References: <4B861890.6090002@gmail.com>         <201002250852.09638.florian@openwrt.org> <6ec4247d1002251312h37f409bdp2384d7fcbddbb321@mail.gmail.com>
In-Reply-To: <6ec4247d1002251312h37f409bdp2384d7fcbddbb321@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

Graham Gower wrote:
> On 25 February 2010 18:22, Florian Fainelli <florian@openwrt.org> wrote:
>> Maybe you should work with the OpenWrt and qi-hardware guys to get the
jz4740
>> also merged in the same time?
>
> I've not seen any active attempt to get xburst code merged before and
> assumed there was no interest from others. I'm happy to be wrong on
> this.
I'm currently working on linux support for a few jz4740 hbased devices.
And it's definitely a goal get the code merged upstream once it is in
proper shape, but there is still some stuff that needs to be done.
Mostly documentation and smaller cleanups.
>
> My patch does not preclude adding jz4740 support. I don't have any of
> these devices however, so have only included code for the jz4730.
Unfortunately I don't have a jz4730 programmers manual to check so I
can't say for sure, but I guess there is quite some code that could be
shared between between both SoCS(and other jz47xx). I think we don't
want to do what Ingenic did with their codebase and copy 'n paste the
same file with minor modifications for each soc type.

You can find the patches (and files) adding jz4740 support to the
linux kernel at [1] and [2].
I suggest you take a look at it and see if we could use some of the
files(irq, gpio, dma, ...) for a common base between all jz47xx SoCs.
>
> -Graham
- - Lars

[1]
https://dev.openwrt.org/browser/trunk/target/linux/xburst/patches-2.6.32
[2] https://dev.openwrt.org/browser/trunk/target/linux/xburst/files-2.6.32
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkuHKQMACgkQBX4mSR26RiOGCgCdGzATziYC4wYLvz0HNhqwFOYi
OXAAn2mZx0e8qmqHtl+Vfm9vau9urpW+
=nIni
-----END PGP SIGNATURE-----
