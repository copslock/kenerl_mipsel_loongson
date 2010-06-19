Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 17:30:33 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:63981 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492382Ab0FSPa2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jun 2010 17:30:28 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id EC58BFA1;
        Sat, 19 Jun 2010 17:30:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 5s4mijyKfr8V; Sat, 19 Jun 2010 17:30:19 +0200 (CEST)
Received: from [192.168.37.30] (port-13469.pppoe.wtnet.de [84.46.52.209])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 18A53FA0;
        Sat, 19 Jun 2010 17:30:05 +0200 (CEST)
Message-ID: <4C1CE25F.70606@metafoo.de>
Date:   Sat, 19 Jun 2010 17:29:35 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Matt Fleming <matt@console-pimps.org>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mmc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 18/26] MMC: Add JZ4740 mmc driver
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <1276924111-11158-19-git-send-email-lars@metafoo.de> <87ocf7ozb2.fsf@linux-g6p1.site>
In-Reply-To: <87ocf7ozb2.fsf@linux-g6p1.site>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13548

Hi

Matt Fleming wrote:
> On Sat, 19 Jun 2010 07:08:23 +0200, Lars-Peter Clausen
<lars@metafoo.de> wrote:
>> This patch adds support for the mmc controller on JZ4740 SoCs.
>>
>
> Hey Lars-Peter,
>
> I had a quick look over this patch and it looks OK. Just a few comments.
>
>> +static void jz4740_mmc_timeout(unsigned long data)
>> +{
>> +    struct jz4740_mmc_host *host = (struct jz4740_mmc_host *)data;
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&host->lock, flags);
>> +    if (!host->waiting) {
>> +        spin_unlock_irqrestore(&host->lock, flags);
>> +        return;
>> +    }
>> +
>> +    host->waiting = 0;
>> +
>> +    spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +    host->req->cmd->error = -ETIMEDOUT;
>> +    jz4740_mmc_request_done(host);
>> +}
>> +
>
> Taking a spinlock and disabling interrupts seems like too much overhead
> to simply test and clear a bit. Wouldn't it be better to implement this
> with test_and_clear_bit(), which on MIPS will likely be implemented with
> ll/sc instructions? It's particularly important to keep this
> low-overhead since this bit is modified in the interrupt handler.
>
Sounds like a good idea :)
>> +static void jz4740_mmc_request_done(struct jz4740_mmc_host *host)
>> +{
>> +    struct mmc_request *req;
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&host->lock, flags);
>> +    req = host->req;
>> +    host->req = NULL;
>> +    host->waiting = 0;
>> +    spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +    if (!unlikely(req))
>> +        return;
>> +
>> +    mmc_request_done(host->mmc, req);
>> +}
>> +
>
> Am I right in thinking that this spinlock guards against the interrupt
> handler and the timeout function running at the same time? So it's not
> really possible to drop the spinlock from here?
>
Yes, at least that is what it was meant for. But it was there before
the waiting bit and right now I can not construct any code paths that
could lead to jz4740_mmc_request_done from two paths at the same time.
The timer wont call it if the waiting bit is not set and the irq
handler won't wake the threaded irq handler if the waiting bit is not
set. I'll think a bit more about it and eventually drop the spinlock here.
Thanks for your review :)

- Lars
