Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jul 2010 19:02:53 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:41910 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491937Ab0GRRCr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jul 2010 19:02:47 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 2A60EBD3;
        Sun, 18 Jul 2010 19:02:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id VamjYYpqBIvP; Sun, 18 Jul 2010 19:02:41 +0200 (CEST)
Received: from [192.168.37.30] (port-3254.pppoe.wtnet.de [84.46.12.194])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 5FAA1BD1;
        Sun, 18 Jul 2010 19:02:20 +0200 (CEST)
Message-ID: <4C43338E.7030706@metafoo.de>
Date:   Sun, 18 Jul 2010 19:02:06 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3] MTD: Nand: Add JZ4740 NAND driver
References: <1276924111-11158-18-git-send-email-lars@metafoo.de>         <1279368929-21193-1-git-send-email-lars@metafoo.de> <1279472048.16247.63.camel@localhost.localdomain>
In-Reply-To: <1279472048.16247.63.camel@localhost.localdomain>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Artem Bityutskiy wrote:
> On Sat, 2010-07-17 at 14:15 +0200, Lars-Peter Clausen wrote:
>> This patch adds support for the NAND controller on JZ4740 SoCs.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: linux-mtd@lists.infradead.org
>>
> 
> Do you expect this patch to go in via the MTD tree? I guess it might be
> better if it was MIPS tree?

Hi

Yes, letting it go through the MIPS tree is the plan.

- Lars
