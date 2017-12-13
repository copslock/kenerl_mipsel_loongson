Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2017 10:24:16 +0100 (CET)
Received: from mail-wr0-x22e.google.com ([IPv6:2a00:1450:400c:c0c::22e]:35456
        "EHLO mail-wr0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990403AbdLMJYHXMIha (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Dec 2017 10:24:07 +0100
Received: by mail-wr0-x22e.google.com with SMTP id g53so1475727wra.2
        for <linux-mips@linux-mips.org>; Wed, 13 Dec 2017 01:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M3hjuH/kHb7sXy3XfT/xrcRgaEN2F2ZfMLAlv+kORfU=;
        b=jn1CApVGODxZ0L/qv921ew1By9udm2YAR3IdVyu2aAz7AAB0GwheXfY7KQG3hcovgr
         wjQV42bCR/3fdVt3ThK+9e210PxHpO7FNFfrW+OGQLz9xVbEz6+6Z2Cm53TtwPtY13YA
         Ne4kViFUmEDbEccJ1b8hyQh03WB6bbkLon7Qe+uvIw6ONcYwURyagg1TB1UoJIUI9bWU
         YsecxSXANXhDH2q5ybx+giL+4mC8s5QZqd7NvhSB+KSoXzWO18SZXhV4nJpWO+wornfo
         hUwp0m3lITcD/OEioituVJQBVxmeMMV0ChFBOS8sU8EzQI0Ic3HDc4+5fpM2A/+Wqbcn
         Lifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M3hjuH/kHb7sXy3XfT/xrcRgaEN2F2ZfMLAlv+kORfU=;
        b=O7MWUJQzgRlwoO1KTR7IlZ5HDLWKSMIegcavM7nqH/PqAh/5NhlMDD/w+7aDCy2M9P
         NEHXyfYnYkjdfWtuXpT1dP4huXCY9RI1XaT9cfdxRgyHav0tueuk/l633b1rHh1IZB2u
         TtSqXkIhypQaei43yIgwGbRLbnNL8ZG2bpMj7Sk3JZEk6hGvbq/bkCjbVj9QI1E4kUNh
         xtNbinXcP86uGqOQNIiBFjLOpfpAFozNXkSgUTOQi05tEPG+NH17cQspIU3tWNTfrWmU
         dPvz8nF8RSHEQoptsp/YIDt8h+dtx0vemE+KwL9lneUj95qF0NDqSs2TLJv8W+3zLulT
         JqLg==
X-Gm-Message-State: AKGB3mI9rHWR+taD4sOEag3T70g3zMoqpLuM7wAKyoRQS811nLiKfjo7
        PvZlEklTHjPFdyRykZ4ytC95YDqgG08QQ81Vc9WFZg==
X-Google-Smtp-Source: ACJfBosSWFWOLBlvIvK1/Xga/QGNh/Gr1vGGouc46sK3d3gvURF7xJGtbMBzjbwwp/mE9PkN752ZG/sN2EbtDCfbc90=
X-Received: by 10.223.160.111 with SMTP id l44mr1788796wrl.259.1513157041976;
 Wed, 13 Dec 2017 01:24:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.195 with HTTP; Wed, 13 Dec 2017 01:23:21 -0800 (PST)
In-Reply-To: <CACRpkdZ=+pFZYteq=wM=z-CGejY+dX_SqhtDbbGBn+q60arQ4w@mail.gmail.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
 <20171208154618.20105-6-alexandre.belloni@free-electrons.com> <CACRpkdZ=+pFZYteq=wM=z-CGejY+dX_SqhtDbbGBn+q60arQ4w@mail.gmail.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Wed, 13 Dec 2017 10:23:21 +0100
Message-ID: <CAOFm3uF_OjqK0cQ1A4Xkp8kZab+afqPsnF5rB9=a7Dym9jiU4w@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] pinctrl: Add Microsemi Ocelot SoC driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61464
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

On Wed, Dec 13, 2017 at 9:15 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>
> Wow never saw that before. OK I guess.

That's the new thing. Less legalese boilerplate, and more code for the
better IMHO.

You can check the doc patches from Thomas for details [1]

[1] https://lkml.org/lkml/2017/12/4/934
-- 
Cordially
Philippe Ombredanne
