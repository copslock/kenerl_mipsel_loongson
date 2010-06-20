Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jun 2010 16:32:17 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:51361 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490960Ab0FTOcN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Jun 2010 16:32:13 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 3B6A6604;
        Sun, 20 Jun 2010 16:32:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Xta7qiGw5dHf; Sun, 20 Jun 2010 16:32:04 +0200 (CEST)
Received: from [192.168.37.30] (port-191.pppoe.wtnet.de [84.46.0.191])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 6CA8D600;
        Sun, 20 Jun 2010 16:31:53 +0200 (CEST)
Message-ID: <4C1E263E.1000903@metafoo.de>
Date:   Sun, 20 Jun 2010 16:31:26 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Graham Gower <graham.gower@gmail.com>
Subject: Re: [PATCH v2 00/26] Add support for the Ingenic JZ4740        System-on-a-Chip
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <20100620092610.GA4950@alpha.franken.de>
In-Reply-To: <20100620092610.GA4950@alpha.franken.de>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13793

Thomas Bogendoerfer wrote:
> On Sat, Jun 19, 2010 at 07:08:05AM +0200, Lars-Peter Clausen wrote:
>   
>> This patch series adds support for the Ingenic JZ4740 System-on-a-Chip.
>>     
>
> great stuff. I have a JZ4730 based netbook, for which I started magling
> the provided sources quite some time ago, but I didn't reach the
> point of submitting patches... there are a lot of common stuff between
> JZ4730 and JZ4740 so IMHO it would be a good thing not to nail
> everthing to JZ4740 namewise. It might also a good idea to select
> something like arch/mips/jzrisc as base directory, put the
> factored out code there and add JZ4730/JZ4740 in either seperate
> files or directories.
>
> Thomas.
>   
Hi

Graham Gower started working on JZ4730 support based on this series some
time ago, but had to put a hold on it because he was busy with other
things. You both should probably get in contact.

There are some parts on the JZ4730 which are similar those on the
JZ4740, others are different. So to put support for common parts into a
shared source directory is the right approach. But I think this is
something that can be done when somebody actually steps forward to
implement support for a different JZ47xx SoC. Luckily the code is not
set into stone and can be re-factored or renamed once it is required or
makes sense to do.
Another issue with naming is that while a component might be similar in
JZ4730 and JZ4740 it might be completely different in a different JZ47xx
SoC. So naming a driver 'jz47xx_driver' instead of 'jz4740_driver' wont
work either.

- Lars
