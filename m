Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2016 05:43:10 +0200 (CEST)
Received: from mail-it0-f66.google.com ([209.85.214.66]:34030 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992984AbcGVDnB102of (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jul 2016 05:43:01 +0200
Received: by mail-it0-f66.google.com with SMTP id u186so2354785ita.1;
        Thu, 21 Jul 2016 20:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GCTZ3d6ZyYlAtaVIuc4qRdsAQ2zHu7icmJifxB7y+k0=;
        b=GrNPLmCWiPPB+xEaMHA6OfWYiHNdU1cmjrQPKS4gW0A8H3w0FpTcZGJvkO/btUEiNQ
         h3nfSdASMoWZZif9wJfv8ZA3msH/nauTtw6tHZi7AVz3zdQLIt2bqJP/hKgCm6KAg2Md
         /1ndnwfmt/3UDhWwoa7clMwHCeGIIsB4XWBzP9Jy6UTO+y47a3cT5q0K9PWkZQSVb/3T
         /baS7L+/L50aU+zmjvwW4T6KWgUOSkSYgw8XOvmgU+ODDU3akIo12PBvWSWd1ip+47dO
         zruccYdY/6pEdwFnwssn5T8Q8BN9BCn0wAdMBmTBKpUQk5ItXTdJiZpHsu4jmrnxiv5/
         k6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GCTZ3d6ZyYlAtaVIuc4qRdsAQ2zHu7icmJifxB7y+k0=;
        b=BQ1gSqoQuk1tyGjwalzz3dZyc8UOA6P/UCPcYTN8ExujIUROUZruBUA4atYdiavZam
         G4znZ2F51vBAkTRMwIc+AvMsuU12RmiJyyMaoD0XFPjiNmEujhsgDqetWtfMZ4IjMtJm
         kPSlDXhrbxIhJnOo7tFXPs+bMxnW6e5NUBydJhKjtBwmpAKVmUY8f2Xn5LkvueBuOnca
         UPqYlzcmhnZtOzPYgI/yP0GDhLaJY/ZZXJJi/kKLAkfTBqAREEP2aup5n5+2S9mxy6JW
         pK8QOl7AtqFAH+2knD7c6rTX0YLOw5r3c4rY7oS0civShxNzzjlWmGgm1sN1kFmhIKIn
         lEWw==
X-Gm-Message-State: ALyK8tJxjdb0GBG+F3m05kWcaoq2W6eKdgqTJDR5oup/DOegdlqsUNqLLFsDYy7NsOSIZRupnCchpe3C0bj3wQ==
X-Received: by 10.36.25.202 with SMTP id b193mr68592673itb.29.1469158975506;
 Thu, 21 Jul 2016 20:42:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.126.13 with HTTP; Thu, 21 Jul 2016 20:42:54 -0700 (PDT)
In-Reply-To: <20160722022007.GC25689@linux-mips.org>
References: <1469082471-4936-1-git-send-email-chenhc@lemote.com>
 <1469082471-4936-2-git-send-email-chenhc@lemote.com> <20160722022007.GC25689@linux-mips.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Fri, 22 Jul 2016 11:42:54 +0800
X-Google-Sender-Auth: XyYQpwaFY7UVc1CAvgHwIrHNCOM
Message-ID: <CAAhV-H4G8cx0064aSGzGPWRE2d4XdHuxum1asqwvnHuHfZr7fQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: Don't register r4k sched clock when CPUFREQ enabled
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Oh, CONFIG_CPUFREQ should be CONFIG_CPU_FREQ. cevt-r4k can be used
because CPUFreq will call clockevents_update_freq() after frequency
changes, and csrc-r4k is need at boot time (then be replaced by other
csrc).

Huacai

On Fri, Jul 22, 2016 at 10:27 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jul 21, 2016 at 02:27:50PM +0800, Huacai Chen wrote:
>
>> Don't register r4k sched clock when CPUFREQ enabled because sched clock
>> need a constant frequency.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/kernel/csrc-r4k.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
>> index 1f91056..5131b98 100644
>> --- a/arch/mips/kernel/csrc-r4k.c
>> +++ b/arch/mips/kernel/csrc-r4k.c
>> @@ -82,7 +82,9 @@ int __init init_r4k_clocksource(void)
>>
>>       clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
>>
>> +#ifndef CONFIG_CPUFREQ
>>       sched_clock_register(r4k_read_sched_clock, 32, mips_hpt_frequency);
>> +#endif
>
> There is no config symbol CONFIG_CPUFREQ and I think if the clock may
> change, we shouldn't register it as csrc or cevt.
>
>   Ralf
>
