Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2018 04:08:44 +0200 (CEST)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:33174
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990393AbeGYCIkonG1u convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jul 2018 04:08:40 +0200
Received: by mail-it0-x243.google.com with SMTP id d16-v6so7489834itj.0;
        Tue, 24 Jul 2018 19:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=AQPDYzhQVqCiIV2w0xSvAzK3E6Zcl1cMl9M73opV3wM=;
        b=A9JPddt68OrwUgOC2yVXRYD5zWYD8glZDrFopBoQZm/nZUKhd6H0yNr3DMmObS6oG0
         vgMeC86IzPpAv1m9Ci0+9Ekl0To3t/D616Ol5JvYAiKPCZIeogZkalXwNO1BoAar/m5W
         NwZMJ4JtN2jnnnqKBgBngnzbscvoZoMDDYYiqqUxP/eJmC/hnxgyMKFniPmUWEYoQ66n
         kJ5k3AfGKJ5kU8J5shAQ8Q1jrikC93cLs7U2sb71xyhhYIzRbommPhiiWbKQ5A/IM2qO
         0piVLMNH65CLvTd/wR8jyRz6Bedg1M7hH5zlA6SYn2SEnn6P5RZ/8TlYEn7jeoWVx5Oo
         63cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=AQPDYzhQVqCiIV2w0xSvAzK3E6Zcl1cMl9M73opV3wM=;
        b=EhBsbLhPp/Q6xjyJ9cdynNxWZD84Zolt/fw1Batofm+O/KGjXiMKwrBvwYx+NB/nYc
         cXtw/OTk6whCzbKLDp8KS4P8i3WxijbITNnMbW/mOMQ+GRMf2ly24COUFRf/iFxZ3G8y
         6qdwqQlo3BSv8IutHVksIMpBNDJrDitZaqG5uYMYhkfqMJGKL+Zh5EbY2NF9/EztS2xF
         CJjj8iU1bhIWdzgkUzKGJH5pL9PWqgWsyFxmRS0rSc2YMvweScc1xmQzUy5f/yufo/RJ
         4fdxIal+Ak07w8SWWpXIC7zmu5nKasNdleyqzGOjxCJXxFt4dVvuzxpbDpu2fDz8nFpf
         Df/w==
X-Gm-Message-State: AOUpUlF3qZegN+iEm44tRPQW792ptpMTjuMizUEftfQ5Inj0PfEPIwix
        76MnOlI8HttLRd/iAyNFtWzJtl8C0U7yVyT/uEI=
X-Google-Smtp-Source: AAOMgpeWQR9QJBVe5fopcA/KW6WA3pZ6GYmY61UW0pRMBcrHOZBKK73QYfT6oYDyDEIm81sdqV98G2yNj6MQQcOBWLc=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr4674454itb.16.1532484514455;
 Tue, 24 Jul 2018 19:08:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:3757:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 19:08:33
 -0700 (PDT)
In-Reply-To: <20180724012116.bxtzn7g6qmri43bd@pburton-laptop>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
 <1524885694-18132-4-git-send-email-chenhc@lemote.com> <20180618210507.akcvvigzj7qis3re@pburton-laptop>
 <tencent_3C127D3D5620B83833D77E8A@qq.com> <20180724012116.bxtzn7g6qmri43bd@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Wed, 25 Jul 2018 10:08:33 +0800
X-Google-Sender-Auth: XigxwRQ_qS9tILQ_SUurh54wdQE
Message-ID: <CAAhV-H5eUPOGxDMLZGThMjidCRjAc2e8e8LS1JGWgJwW71uk0g@mail.gmail.com>
Subject: Re: [PATCH V3 03/10] MIPS: Loongson-3: Enable Store Fill Buffer atruntime
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65127
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

On Tue, Jul 24, 2018 at 9:21 AM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Huacai,
>
> Please stop top-posting - you make it difficult to reply. I know you've
> mentioned difficulties sending mail from your @lemote.com address but no
> matter which email address you're using you should be able to format
> your email properly if you're using a suitable email client.
>
> On Tue, Jun 19, 2018 at 02:50:36PM +0800, 陈华才 wrote:
>> > I think it'd be neater if we did this from C in cpu_probe_loongson()
>> > though. If we add __BUILD_SET_C0(config6) to asm/mipsregs.h and define a
>> > macro naming the SFB enable bit then both boot CPU & secondary cases
>> > could be handled by a single line in cpu_probe_loongson(). Something
>> > like this:
>> >
>> >     set_c0_config6(LOONGSON_CONFIG6_SFB_ENABLE);
>> >
>> > Unless there's a technical reason this doesn't work I'd prefer it to the
>> > assembly version (and maybe we could move the LPA & ELPA configuration
>> > into cpu-probe.c too then remove asm/mach-loongson64/kernel-entry-init.h
>> > entirely).
>>
>> We should enable SFB/ELPA as early as possible, because it is
>> dangerous if one core is SFB-enabled why another core isn't. ELPA is
>> similar.
>
> Why is it dangerous, and in what circumstances?
>
> Based on commit messages & our other discussions about the SFB my
> understanding is that it sits within a core, between the CPU pipeline &
> the core's L1 data cache. Why would another core care about it being
> enabled or disabled? How could the other core even tell?
In practice, SFB cannot be enabled/disabled dynamically. But I don't
know why because I'm not the CPU designer.

Huacai

>
> Thanks,
>     Paul
