Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 19:21:17 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:50596 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492390Ab0FCRVN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 19:21:13 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 5E2BECFE;
        Thu,  3 Jun 2010 19:21:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id v+dsXr6szYbs; Thu,  3 Jun 2010 19:21:05 +0200 (CEST)
Received: from [172.31.16.228] (d078029.adsl.hansenet.de [80.171.78.29])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id BFF84CFD;
        Thu,  3 Jun 2010 19:21:04 +0200 (CEST)
Message-ID: <4C07E461.9000506@metafoo.de>
Date:   Thu, 03 Jun 2010 19:20:33 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Graham Gower <graham.gower@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 03/26] MIPS: JZ4740: Add clock API support.
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>        <1275505397-16758-4-git-send-email-lars@metafoo.de> <AANLkTimVM637peyrPP7dZ3Uy2S-3DAEXspGi-FONcW6p@mail.gmail.com>
In-Reply-To: <AANLkTimVM637peyrPP7dZ3Uy2S-3DAEXspGi-FONcW6p@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2618

Graham Gower wrote:
> On 3 June 2010 04:32, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>   
>> +       {
>> +               .name = "dma",
>> +               .parent = &jz_clk_high_speed_peripheral.clk,
>> +               .gate_bit = JZ_CLOCK_GATE_UART0,
>> +               .ops = &jz_clk_simple_ops,
>> +       },
>>     
>
> Presumably this should be JZ_CLOCK_GATE_DMAC.
>
> -Graham
>   
Hi

Yes.

Thanks for reviewing
- Lars
