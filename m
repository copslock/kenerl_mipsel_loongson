Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2011 11:49:38 +0100 (CET)
Received: from mail.lemote.com ([222.92.8.141]:42477 "EHLO lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903562Ab1JaKtc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 31 Oct 2011 11:49:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by lemote.com (Postfix) with ESMTP id 9C82631D74D
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 18:24:06 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
        by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hd1Yq9L6V+Yx for <linux-mips@linux-mips.org>;
        Mon, 31 Oct 2011 18:24:06 +0800 (CST)
Received: from mail-fx0-f49.google.com (mail-fx0-f49.google.com [209.85.161.49])
        by lemote.com (Postfix) with ESMTP id 021EB31D74F
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 18:23:57 +0800 (CST)
Received: by faaf16 with SMTP id f16so7258978faa.36
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 03:49:07 -0700 (PDT)
Received: by 10.223.1.12 with SMTP id 12mr19378650fad.32.1320058147137; Mon,
 31 Oct 2011 03:49:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.101.140 with HTTP; Mon, 31 Oct 2011 03:48:45 -0700 (PDT)
In-Reply-To: <CAM2zO=CodQLE05ZNOOba3jv_qJ5XuZj3yrnS0aHCOj+cp_24Xw@mail.gmail.com>
References: <CAGXxSxXmgzxN361Cko1fY_+oWwfgjXLhS61gtvqB8YYXHXZVyw@mail.gmail.com>
 <CAM2zO=CodQLE05ZNOOba3jv_qJ5XuZj3yrnS0aHCOj+cp_24Xw@mail.gmail.com>
From:   Chen Jie <chenj@lemote.com>
Date:   Mon, 31 Oct 2011 18:48:45 +0800
Message-ID: <CAGXxSxUHGN99hXK8K5k9ayVfMenAWAbWVpqkotix_JyUbPCU+w@mail.gmail.com>
Subject: Re: [MIPS]clocks_calc_mult_shift() may gen a too big mult value
To:     Yong Zhang <yong.zhang0@gmail.com>
Cc:     linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        johnstul@us.ibm.com, tglx@linutronix.de, yanhua <yanh@lemote.com>,
        =?UTF-8?B?6aG55a6H?= <xiangy@lemote.com>,
        zhangfx <zhangfx@lemote.com>,
        =?UTF-8?B?5a2Z5rW35YuH?= <sunhy@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21867

Hi,

2011/10/31 Yong Zhang <yong.zhang0@gmail.com>:
> On Mon, Oct 31, 2011 at 5:00 PM, Chen Jie <chenj@lemote.com> wrote:
>> Hi all,
>>
>> On MIPS, with maxsec=4, clocks_calc_mult_shift() may generate a very
>> big mult, which may easily cause timekeeper.mult overflow within
>> timekeeping jobs.
>
> Hmmm, why not use clocksource_register_hz()/clocksource_register_khz()
> instead? it's more convenient.

Thanks for the suggestion. And sorry for I didn't notice the upstream
code has already hooked to clocksource_register_hz() in csrc-r4k.c
(We're using r4000 clock source)

I'm afraid this still doesn't fix my case. Through
clocksource_register_hz()->__clocksource_register_scale()->__clocksource_updatefreq_scale,
I got a calculated maxsec = (0xffffffff - (0xffffffff>>5))/250000500 =
16        # assume mips_hpt_frequency=250000500

With this maxsec, I got a mult of 0xffffde72, still too big.



Regards,
-- Chen Jie
