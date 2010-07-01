Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2010 17:48:06 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:43127 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491945Ab0GAPsB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jul 2010 17:48:01 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 7B73166A;
        Thu,  1 Jul 2010 17:47:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id pW4ovkHXKJBI; Thu,  1 Jul 2010 17:47:56 +0200 (CEST)
Received: from [172.31.16.228] (d079168.adsl.hansenet.de [80.171.79.168])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 8796F669;
        Thu,  1 Jul 2010 17:47:55 +0200 (CEST)
Message-ID: <4C2CB895.3030402@metafoo.de>
Date:   Thu, 01 Jul 2010 17:47:33 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Matt Fleming <matt@console-pimps.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mmc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3] MMC: Add JZ4740 mmc driver
References: <1276924111-11158-19-git-send-email-lars@metafoo.de> <1277688041-23522-1-git-send-email-lars@metafoo.de> <87aaqd1tmr.fsf@linux-g6p1.site>
In-Reply-To: <87aaqd1tmr.fsf@linux-g6p1.site>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matt Fleming wrote:
> On Mon, 28 Jun 2010 03:20:41 +0200, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> This patch adds support for the mmc controller on JZ4740 SoCs.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Matt Fleming <matt@console-pimps.org>
>> Cc: linux-mmc@vger.kernel.org
>>
>> ---
>> Changes since v1
>> - Do not request IRQ with IRQF_DISABLED since it is a noop now
>> - Use a generous slack for the timeout timer. It does not need to be accurate.
>> Changes since v2
>> - Use sg_mapping_to iterate over sg elements in mmc read and write functions
>> - Use bitops instead of a spinlock and a variable for testing whether a request
>>   has been finished.
>> - Rework irq and timeout handling in order to get rid of locking in hot paths
> 
> Acked-by: Matt Fleming <matt@console-pimps.org>
> 
> Are you planning on maintaining this driver? If so, it'd be a good idea
> to update MAINTAINERS.

Hi

Thanks for reviewing the patch.
I guess I should send a MAINTAINERS patch which adds entries for all of the JZ4740
drivers.

- - Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkwsuJUACgkQBX4mSR26RiNHVgCfTq+tc2I1QBniqijyUjNDxPIX
GsEAn1xgPWz+L0uqHWthzJ+lMtFaUBtY
=nVt9
-----END PGP SIGNATURE-----
