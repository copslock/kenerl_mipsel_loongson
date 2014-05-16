Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 May 2014 15:30:37 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:56646 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822137AbaEPNaeoAWta (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 May 2014 15:30:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 6715322C33
        for <linux-mips@linux-mips.org>; Fri, 16 May 2014 21:30:24 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rNqUvI27MUzT for <linux-mips@linux-mips.org>;
        Fri, 16 May 2014 21:30:09 +0800 (CST)
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com [209.85.215.45])
        (Authenticated sender: chenj@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPSA id 1B14E234A4
        for <linux-mips@linux-mips.org>; Fri, 16 May 2014 21:30:07 +0800 (CST)
Received: by mail-la0-f45.google.com with SMTP id gl10so1972680lab.32
        for <linux-mips@linux-mips.org>; Fri, 16 May 2014 06:29:59 -0700 (PDT)
X-Received: by 10.112.11.162 with SMTP id r2mr1218713lbb.89.1400246999883;
 Fri, 16 May 2014 06:29:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.176.137 with HTTP; Fri, 16 May 2014 06:29:39 -0700 (PDT)
In-Reply-To: <20140515114053.GW34353@pburton-linux.le.imgtec.org>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
 <1400137743-8806-2-git-send-email-chenj@lemote.com> <20140515114053.GW34353@pburton-linux.le.imgtec.org>
From:   Chen Jie <chenj@lemote.com>
Date:   Fri, 16 May 2014 21:29:39 +0800
Message-ID: <CAGXxSxVUOT_R-zHKpmEGZpE1nCSeOyfNzmc1xooYrKBxTuuaNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        =?UTF-8?B?546L6ZSQ?= <wangr@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

2014-05-15 19:40 GMT+08:00 Paul Burton <paul.burton@imgtec.com>:
> On Thu, May 15, 2014 at 03:09:03PM +0800, chenj wrote:
>> wsbh & movn are available on loongson3 CPU.
>> ---
>>  arch/mips/lib/csum_partial.S | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
>> index 6cea101..ed88647 100644
>> --- a/arch/mips/lib/csum_partial.S
>> +++ b/arch/mips/lib/csum_partial.S
>> @@ -277,9 +277,12 @@ LEAF(csum_partial)
>>  #endif
>>
>>       /* odd buffer alignment? */
>> -#ifdef CONFIG_CPU_MIPSR2
>> +#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_LOONGSON3)
>
> Is there some reason CPU_LOONGSON3 can't select CPU_MIPSR2?

Loongson 3a is not fully mips32r2 compatible, but Loongson 3b is.
