Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 15:22:59 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:56681 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008934AbaIONWy0rx9z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 15:22:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=b5g8MDyxitZ/Tyvu421JuojGz4t/UtCtOR9KPUXvFrA=;
        b=ak6WxSR/X4dnqOHmLQ87m01/6l7KnKyICVrqlynrzWC8hOsHlLi6CwiEUHedweDfxMHnBjd9t5itZ4sEph3Dkvwnd8D1Wn/EuS7H8ekkfd60xn2aydoD2m61/AzU4g2/gUcNzoLg4v3k8l8VcHaK0W0u/JA9fUyz3zAsi1z4soM=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XTWEx-0024Xj-QH
        for linux-mips@linux-mips.org; Mon, 15 Sep 2014 13:22:47 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43218 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XTWEt-0024Vn-6k; Mon, 15 Sep 2014 13:22:44 +0000
Message-ID: <5416E820.3070305@roeck-us.net>
Date:   Mon, 15 Sep 2014 06:22:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: Re: [RFC 13/18] watchdog: add Atheros AR2315 watchdog driver
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>  <1410723213-22440-14-git-send-email-ryazanov.s.a@gmail.com>     <541656A3.8030906@roeck-us.net> <CAHNKnsT5AHT9xaaY44yTo7uMiOGL9fekGkEzjQuYvdUyJs-WQA@mail.gmail.com>
In-Reply-To: <CAHNKnsT5AHT9xaaY44yTo7uMiOGL9fekGkEzjQuYvdUyJs-WQA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020202.5416E827.019F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 3
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 09/15/2014 02:42 AM, Sergey Ryazanov wrote:
> 2014-09-15 7:01 GMT+04:00, Guenter Roeck <linux@roeck-us.net>:
>> On 09/14/2014 12:33 PM, Sergey Ryazanov wrote:
>>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>>> Cc: Wim Van Sebroeck <wim@iguana.be>
>>> Cc: linux-watchdog@vger.kernel.org
>>> ---
>>>    arch/mips/ar231x/ar2315.c     |  26 +++++-
>>>    drivers/watchdog/Kconfig      |   7 ++
>>>    drivers/watchdog/Makefile     |   1 +
>>>    drivers/watchdog/ar2315-wtd.c | 202
>>> ++++++++++++++++++++++++++++++++++++++++++
>>
>> This should be two patches: One to instantiate the watchdog,
>> the second the watchdog driver itself. The weatchdog driver
>> should use the watchdog infrastructure.
>>
> Ok. Will do in v2.
>
> [skipped]
>
>>> + *
>>> + * Copyright (C) 2008 John Crispin <blogic@openwrt.org>
>>> + * Based on EP93xx and ifxmips wdt driver
>>
>> 2008 ?
>>
> Yes. This driver is pretty old.
>
> [skipped]
>
>>> +
>>> +#define CLOCK_RATE 40000000
>>> +#define HEARTBEAT(x) (x < 1 || x > 90 ? 20 : x)
>>> +
>> Whatever the logic is here, it does not make much sense to me.
>>
> 90 second is maximal value which we could write to register, and value
> below 1 second is senseless. So this macros always return a value
> which make sense: specified by user or default.
>
I would agree that the value generates would be clamped, for example
by using the clamp_val macro. Bit your logic is such that the user
gets a timeout of 90 seconds when specifying 90 seconds, and 20
seconds when specifying 91 seconds.

Doesn't really matter much if you use the watchdog framework,
as it takes care of range checking.

Guenter
