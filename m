Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jun 2010 18:49:48 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:58108 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491048Ab0FTQtn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Jun 2010 18:49:43 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id CDFA9866;
        Sun, 20 Jun 2010 18:49:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id HXcMxNgfQiih; Sun, 20 Jun 2010 18:49:34 +0200 (CEST)
Received: from [192.168.37.30] (port-191.pppoe.wtnet.de [84.46.0.191])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id DBBF7865;
        Sun, 20 Jun 2010 18:49:28 +0200 (CEST)
Message-ID: <4C1E467D.5030204@metafoo.de>
Date:   Sun, 20 Jun 2010 18:49:01 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Graham Gower <graham.gower@gmail.com>
Subject: Re: [PATCH v2 00/26] Add support for the Ingenic JZ4740 System-on-a-Chip
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <20100620092610.GA4950@alpha.franken.de> <4C1E263E.1000903@metafoo.de> <20100620163437.GA8329@alpha.franken.de>
In-Reply-To: <20100620163437.GA8329@alpha.franken.de>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13818

Thomas Bogendoerfer wrote:
> On Sun, Jun 20, 2010 at 04:31:26PM +0200, Lars-Peter Clausen wrote:
>   
>> Another issue with naming is that while a component might be similar in
>> JZ4730 and JZ4740 it might be completely different in a different JZ47xx
>> SoC. So naming a driver 'jz47xx_driver' instead of 'jz4740_driver' wont
>> work either.
>>     
>
> so ? call it xx for the common part an exact number for special part.
> It might be just jugglin with pieces, but getting it better in the first
> run is always a plus.
>
> Thomas.
>   
As I said, parts might be common between JZ4730 and JZ4740 but be
different to JZ4750 and JZ4760. So JZ47xx wont fit either.
Right now there is no practical use to moving things around, and there
wont be until somebody who can actually test it starts adding support
for a different JZ47XX SoC.

- Lars
