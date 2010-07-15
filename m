Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2010 23:38:28 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:65205 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492115Ab0GOViY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jul 2010 23:38:24 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 56328A9B;
        Thu, 15 Jul 2010 23:38:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 0+PLLWyyW+vi; Thu, 15 Jul 2010 23:38:16 +0200 (CEST)
Received: from [172.31.16.213] (d077238.adsl.hansenet.de [80.171.77.238])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 613BDA9A;
        Thu, 15 Jul 2010 23:38:05 +0200 (CEST)
Message-ID: <4C3F7FAD.5010106@metafoo.de>
Date:   Thu, 15 Jul 2010 23:37:49 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Matt Fleming <matt@console-pimps.org>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v6] MMC: Add JZ4740 mmc driver
References: <1278973245-25451-1-git-send-email-lars@metafoo.de>        <1279227964-17801-1-git-send-email-lars@metafoo.de> <20100715141653.1c0b6a8d.akpm@linux-foundation.org>
In-Reply-To: <20100715141653.1c0b6a8d.akpm@linux-foundation.org>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> On Thu, 15 Jul 2010 23:06:04 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> This patch adds support for the mmc controller on JZ4740 SoCs.
>>
>>
>> ...
>>
>> +		if (gpio_is_valid(host->pdata->gpio_power))
>> +			gpio_set_value(host->pdata->gpio_power,
>> +					!host->pdata->power_active_low);
>>
>> ...
>>
> 
> Should this driver have a `depends on GPIOLIB' in Kconfig?
> 

The driver depends on MACH_JZ4740 which selects ARCH_REQUIRE_GPIOLIB, so there
already is an implicit depends on GPIOLIB.

- - Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEUEARECAAYFAkw/f60ACgkQBX4mSR26RiNexQCfUXt0cqiMqEf17k+z+q6XVwRO
ImEAmPKxeyX9ANVasUNL60f51GxKofg=
=3NrE
-----END PGP SIGNATURE-----
