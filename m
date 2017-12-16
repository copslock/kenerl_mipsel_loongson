Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Dec 2017 19:29:36 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:39533
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990921AbdLPS306ptia (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Dec 2017 19:29:26 +0100
Received: by mail-wm0-x241.google.com with SMTP id i11so22816893wmf.4
        for <linux-mips@linux-mips.org>; Sat, 16 Dec 2017 10:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eSau6KrxQSQTTmhi/R3bLmRgcljlDucyhDQf1MdKWJo=;
        b=E9rM6xszUJGNwfp3q+5RMK2LECpzR9mxZZgW6x8HnqS+AwvGc4kuXm9xfvJUwwGp9W
         LszJhm2G/uAGJVyyKoPI+5dXAXNtbpqKr6nk91SsSy0KN+n9iKHagO19edZbD8PY4U67
         WqQgVYMnejH7t9Eq2BaoQS/7yFBifa6Ur51WhMFlf1JmgE5asJFZSIhpSPllEOoIF5Gv
         DDvaJYKS5Io/MzFUxIGuk8L1AUetRJJfrJeVdj1VwlbLhqY4ciUA0oU5WjFnDrWcvN7o
         TZaqwkwAOI6IKw1c/cf1rVcC20W3WI3IewEUYr8gcJRSu3hg4RUOb5PXS1smvv1I3now
         mKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eSau6KrxQSQTTmhi/R3bLmRgcljlDucyhDQf1MdKWJo=;
        b=rB3hq8HwN2MonGO3PorBpZydDmFn9sMynhNwAnwiaoUdU1P5K88L2vn+Cdqqfjs+2r
         WfSf1/WEAzFa0nPEHqXtS2ZwtwhFQAoIZe9Okq2ouPaD6AqPFcnLPatMv9LgQn/6LkrM
         z5WjrmJ0gRBfupzIjzWQ8+NNF4iLLWKUf3kz06V9Q3/DxreMPzBcOHrGWuAepPv90A/A
         Z5tQQTkO3nsTmVGrSY8r6xAqaSRwTGrCRHyY8bCahSWTjvGfOaVDF2O4hPbf3beWNzb1
         nuy5UGfSGy04HxYpuqihdvEDkYNKwq6KCvik/MCEymo+IzSXUJT1lkSO16c623OxnvNH
         0Thg==
X-Gm-Message-State: AKGB3mI6Gxtd33rJAiwLSbUS4LDyQloW09sKQcmtUSvKoosDNRvgyiEK
        8tEqRjW7u5DXxWsSpdml4z/1QpssZhipk2IUQusPlA==
X-Google-Smtp-Source: ACJfBos4/tEUKugN8wOaQqllliCKb475Pq0FHSLUwLbrkmVXYUR2wCvzcl5afhVFc42TP4rh+6O2WY16L0S2kG82gNQ=
X-Received: by 10.28.27.206 with SMTP id b197mr8623366wmb.96.1513448961513;
 Sat, 16 Dec 2017 10:29:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.195 with HTTP; Sat, 16 Dec 2017 10:28:40 -0800 (PST)
In-Reply-To: <20171216145751.3486-4-jiaxun.yang@flygoat.com>
References: <20171216145751.3486-1-jiaxun.yang@flygoat.com> <20171216145751.3486-4-jiaxun.yang@flygoat.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Sat, 16 Dec 2017 19:28:40 +0100
Message-ID: <CAOFm3uHEmY-0y5qUDpLW+WLyi+TJd6LeV4qRhbhaXmCtX05mbw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] MIPS: Loongson64: Yeeloong add platform driver
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Huacai Chan <chenhc@lemote.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

Dear Jiaxun,

On Sat, Dec 16, 2017 at 3:57 PM, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> Yeeloong is a laptop with a MIPS Loongson 2F processor, AMD CS5536
> chipset, and KB3310B controller.

<snip>

> --- /dev/null
> +++ b/drivers/platform/mips/yeeloong_laptop.c
> @@ -0,0 +1,1142 @@
> +/*
> + * Driver for YeeLoong laptop extras
> + *
> + *  Copyright (C) 2017 Jiaxun Yang.
> + *  Author: Jiaxun Yang <jiaxun.yang@flygoat.com>
> + *
> + *  Copyright (C) 2009 Lemote Inc.
> + *  Author: Wu Zhangjin <wuzhangjin@gmail.com>, Liu Junliang <liujl@lemote.com>
> + *
> + *  Fixes: Petr Pisar <petr.pisar@atlas.cz>, 2012, 2013, 2014, 2015.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */

Would you mind using the new SPDX tags here. See Thomas patches [1]

> +MODULE_LICENSE("GPL");

Also please make sure your module license (here GPL 2.0 or later per
module.h) matches your top level license tag  correctly (here GPL 2.0
only)?

[1] https://lkml.org/lkml/2017/12/4/934

-- 
Cordially
Philippe Ombredanne
