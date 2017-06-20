Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 06:52:15 +0200 (CEST)
Received: from smtpbgau1.qq.com ([54.206.16.166]:41378 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991955AbdFTEwINQqSK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 06:52:08 +0200
X-QQ-mid: bizesmtp13t1497934277tko76bcn
Received: from mail-oi0-f45.google.com (unknown [209.85.218.45])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 20 Jun 2017 12:51:15 +0800 (CST)
X-QQ-SSF: 01100000008000F0FI90B00A0000000
X-QQ-FEAT: oPf+tCeE8zGUuzpVSBfVUxppYaYC0q454n46mAw54iIrMEvPOpbxdKCA8js2K
        nffVFDhxrVMDqU3cxOvJb5mIa/OejU3GH2KwYnW2ogwzuK2vX4D8o/8lLkOHr5ZLN7s9huo
        qJidEPpajr57oPddTS5yTQ7f4fm0e32gaU0/o5fJFAirJTl1CWXp5e0Dxqaz/DTo9DHibYG
        Q9oq6LphYokmH4X2c/W4Ka/vWKMaVB9qIlh3IGh1w2ZKjBN7B/pWYqForCxUFCqydu3L3rL
        SyvMNtBpR0DLxDNdES/52cJBUlalRvr+JS3Q==
X-QQ-GoodBg: 0
Received: by mail-oi0-f45.google.com with SMTP id c189so42914063oia.2;
        Mon, 19 Jun 2017 21:51:17 -0700 (PDT)
X-Gm-Message-State: AKS2vOxeNNm1s8n0bF1jzhODHaKKp0lDXhoDV8kYD9fh2mAPzDa1lRJC
        /LM+DdGU6hfqTc7X7oU4TWsLDpMGTw==
X-Received: by 10.202.192.67 with SMTP id q64mr16645072oif.65.1497934275100;
 Mon, 19 Jun 2017 21:51:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.2.79 with HTTP; Mon, 19 Jun 2017 21:51:14 -0700 (PDT)
In-Reply-To: <20170619233434.GQ20170@codeaurora.org>
References: <1497581573-17258-1-git-send-email-zhoubb@lemote.com>
 <1497581573-17258-8-git-send-email-zhoubb@lemote.com> <20170619233434.GQ20170@codeaurora.org>
From:   zhoubb <zhoubb@lemote.com>
Date:   Tue, 20 Jun 2017 12:51:14 +0800
X-Gmail-Original-Message-ID: <CAMpQs4L1_VvWxk_mkbRgvVb3o23m+RdVosgzxFLMRX7fjKa+6w@mail.gmail.com>
Message-ID: <CAMpQs4L1_VvWxk_mkbRgvVb3o23m+RdVosgzxFLMRX7fjKa+6w@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] clk: Loongson: Add Loongson-1A clock support
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?UTF-8?B?6LCi6Ie06YKm?= <Yeking@red54.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        HuaCai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

On Tue, Jun 20, 2017 at 7:34 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/16, Binbin Zhou wrote:
>> diff --git a/drivers/clk/loongson1/clk-loongson1a.c b/drivers/clk/loongson1/clk-loongson1a.c
>> new file mode 100644
>> index 0000000..263a82c
>> --- /dev/null
>> +++ b/drivers/clk/loongson1/clk-loongson1a.c
>> @@ -0,0 +1,75 @@
>> +/*
>> + * Copyright (c) 2012-2016 Binbin Zhou <zhoubb@lemote.com>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +#include <linux/clkdev.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/err.h>
>> +
>> +#include <loongson1.h>
>> +#include "clk.h"
>> +
>> +#define OSC          (33 * 1000000)
>> +#define DIV_APB              2
>> +
>> +static DEFINE_SPINLOCK(_lock);
>
> I know the other loongson1*.c files also call it "_lock", but
> that's not a very good name for something that may show up in
> lockdep debugging error messages. How about something a bit more
> descriptive, loongson1x_clk_lock?
>
It's a good idea！
Actually, the variable is not be used in this file.
If I rename it in another new patch will be better.
Do you think so ?

Best wishes!

Binbin Zhou

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
