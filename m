Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:57:39 +0200 (CEST)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:33025
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991438AbdIOR5bWV40M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Sep 2017 19:57:31 +0200
Received: by mail-lf0-x242.google.com with SMTP id y15so1559659lfd.0
        for <linux-mips@linux-mips.org>; Fri, 15 Sep 2017 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cy6nRpK1HSD/EUHMSN/SkA/bIRzGlkF0NuR21AOkwWI=;
        b=FHkjkbu8T1bX3i8KVOGmaqA0Mcme6fnFL1CXW3WC0RiYX9kWC/neMY/CzroiWoyGnq
         eL/beicXC8EJJsO9PSDjmO0Xh6UxAUbIok9JJpDTfk/oRVgUfuh72xTXjrRP4o9vUE7S
         Adm+wpwGWCNV6aPfRyus6YqdBbpHIAxR/p8uwOjzFzqkh4rCYxOQw2D/6gdPDsZL10tA
         ItR90DYpw5Mh+2meu+xpc4in+ZU8XvlkPd6bJF8s9cyFzgZf3WHPy8+SvytMBy8AN9aF
         j4TlCAeS1SP2N/6hykWQfraQ4q6TT64tEGKw3tIOD66T1N9xTnv3UUTGY6YYU2joe5cJ
         gSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cy6nRpK1HSD/EUHMSN/SkA/bIRzGlkF0NuR21AOkwWI=;
        b=Tv+boLbwff1DpuINJmQbipILjSyxI4WH3MeZVJzjqOOz55V+W5CrNiTc67peVPv/F9
         YcMhSenI69xlCG709QJGdx+yd8u0zMO8Fi+CpmWLeRD4xbj9xevWyzHWds7J8V11nE0q
         pB8GHqXtV+sUTtT+AZ4738AcOkr+qnUuq+mtkD3PiswqrIo3k5DhDD6nFDpsgzh8/heJ
         UjwSMShzhm4zVrhHN2fRVJP69gxNo24adOx1eiOBDwkOzZWcNzi/PxoAOKPTvErAzUuh
         DOrD897bUhKj6oqrm6FT9J/u/cDZiMobrNlB5VSC0Gw9qHDbDhDRmfnB4sKeRwi2Kn4X
         jgzA==
X-Gm-Message-State: AHPjjUhKvS7HP6N0CGd+e2d6ktJuACYmNwllHPi3ZvthRa/jAD4WNHPt
        1UnPnMuWxfS7g51m9sgiH+TvYeNFe9ATbNQjdcQxoQ==
X-Google-Smtp-Source: AOwi7QANnUseSPsYNdu4eCJz7zUUWKVfTjW/WzPfyB8Lp5QUW6Qwv/idOgSlRUzajrb5FN1sbBhcwMWu3zE6WibgtVA=
X-Received: by 10.46.21.81 with SMTP id 17mr3652180ljv.68.1505498245936; Fri,
 15 Sep 2017 10:57:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.199.193 with HTTP; Fri, 15 Sep 2017 10:57:24 -0700 (PDT)
X-Originating-IP: [209.133.79.7]
In-Reply-To: <20170915175439.izhfpx2ztep4evet@ninjato>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org> <CAOesGMitNqwjEHugsiwsmRAVSinUEv=eprJXHRRhSHUypm=b1A@mail.gmail.com>
 <20170915175439.izhfpx2ztep4evet@ninjato>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 15 Sep 2017 10:57:24 -0700
Message-ID: <CAOesGMi5Jx+hDGtUV_3sE8-7Rc+KronFyUmRzT55hZuRn28OPQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <olof@lixom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: olof@lixom.net
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

On Fri, Sep 15, 2017 at 10:54 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Fri, Sep 15, 2017 at 10:51:28AM -0700, Olof Johansson wrote:
>> On Sun, Sep 10, 2017 at 2:44 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> [...]
>> > Cc: arm@kernel.org
>> > Cc: Steven Miao <realmz6@gmail.com>
>> > Cc: Ralf Baechle <ralf@linux-mips.org>
>> > Cc: Lee Jones <lee.jones@linaro.org>
>> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> > ---
>> > ARM SoC folks: requesting ACK for Wolfram to take this patch.
>> > Steven (Blackfin): requesting ACK for Wolfram to take this patch.
>> > Ralf (MIPS): requesting ACK for Wolfram to take this patch.
>> > Lee: requesting ACK for Wolfram to take this patch.
>>
>> Acked-by: Olof Johansson <olof@lixom.net>
>>
>> Wolfram: Same thing here, maybe this and the other patch can go on one
>> branch for merge in case of conflicts.
>
> Yes, I am fine with picking all these up. However, we already found out
> there needs to be a V2 because Geert had another series cleaning up the
> i2c-gpio driver and it was decided to merge those two series.

Yep, that approach makes sense. I suspect the arm mach pieces will
still look the same so the ack can stay in that case.


-Olof
