Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2017 10:59:27 +0100 (CET)
Received: from mail-it0-x235.google.com ([IPv6:2607:f8b0:4001:c0b::235]:37356
        "EHLO mail-it0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbdBWJ7VN9zrL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2017 10:59:21 +0100
Received: by mail-it0-x235.google.com with SMTP id 203so10466664ith.0
        for <linux-mips@linux-mips.org>; Thu, 23 Feb 2017 01:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QUnAuXxngTdmOElBbZkGU9HZBXH4Q7RWftvWWNiNYBY=;
        b=KQfxytJQhHcz46XHUhD81UQ+9kgGmyRrF7UVlU1S8LEOFjp1byifWThDEnddzydaM+
         37EmQPpeATQXK3FEakIu/BMLpQdgoMKfdbpX9BoUNZLx8BRYiv11UFiVVA18Eu/Z3oo0
         C/to20Bff8zqtNQAxuvHBPSSHJ+xHBFHsEhqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QUnAuXxngTdmOElBbZkGU9HZBXH4Q7RWftvWWNiNYBY=;
        b=e9u9BInC6RG3eNlx4qi+uZsNxt2Pc2MWTtl+ptQaT46dMoeGOAn35xiHlIc49t6sWp
         /0rDUZ0pZ/ZaYUnpUyheyFt6iyLhScJFPs8IUSCGF30FODeLNrBxHyBC2BAn9q3LRCFv
         UQLZz7UhfIEkbnKLzADdhAdgw3jGOFueVIvuntQFk9rJMFqPt9wGgi4i/lmmNXZoajWV
         Uc5uqyoZGP/RkNaTFFN0owr8Ehz3EPOeDT++Kv0r6CBSaw0Mv2c97oPuFSR7dNllzjZP
         DCX6P/Oddc/y61G/+HnPHtHta2X+4vupjhR6GP/12VcqioiW2fybReAJt5PraWUhmC1C
         jeug==
X-Gm-Message-State: AMke39mptj9rXoTdVlRbsXawwAGjAJjXVdFHKkkpKT8Hvm9URGazO1AtsJptzEDJSSaHy7/Dxu/U0LSqFau9U5EY
X-Received: by 10.36.33.135 with SMTP id e129mr1878914ita.9.1487843955399;
 Thu, 23 Feb 2017 01:59:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Thu, 23 Feb 2017 01:59:14 -0800 (PST)
In-Reply-To: <f19fea79c2616455f5f08070923428cc@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-2-paul@crapouillou.net>
 <20170130203617.hpljtcmzava3rq2n@rob-hp-laptop> <12dc62a7255bd453ff4e5e89f93ebc58@mail.crapouillou.net>
 <CACRpkdbAgy4sh6NT5DdQD6EQtOZEwevohEA6OGRcVz98yqS52Q@mail.gmail.com>
 <fd3c507484a9ee34a08c9f92e60624db@mail.crapouillou.net> <CACRpkdbAA33FFrMgx-eZPmpBBfQ_hF+=dSu0hANVthdbadicDg@mail.gmail.com>
 <f19fea79c2616455f5f08070923428cc@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Feb 2017 10:59:14 +0100
Message-ID: <CACRpkdYiA157afJW2hnJzRgWOT02pCuU5rPCdHC-G5qb-FrxQA@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] Documentation: dt/bindings: Document pinctrl-ingenic
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Tue, Feb 21, 2017 at 12:20 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> Le 2017-02-20 14:56, Linus Walleij a écrit :
>>
>> On Thu, Feb 9, 2017 at 6:28 PM, Paul Cercueil <paul@crapouillou.net>
>> wrote:
>>
>>> I was thinking that instead of having one pinctrl-ingenic instance
>>> covering
>>> 0x600 of register space, and 6 instances of gpio-ingenic having 0x100
>>> each,
>>> I could just have 6 instances of pinctrl-ingenic, each one with an
>>> instance
>>> of gpio-ingenic declared as a sub-node, each handling just 0x100 of
>>> memory
>>> space.
>>
>>
>> My head is spinning,  but I think I get it. What is wrong with the
>> solution
>> I proposed with one pin control instance covering the whole 0x600 and with
>> 6
>> subnodes of GPIO?
>>
>> The GPIO nodes do not even have to have an address range associated with
>> them you know, that can be distributed out with regmap code accessing
>> the parent regmap.
>
>
> OK, but then each GPIO chip 'X' still need to know its offset in the
> register
> area, which is (pinctrl_base + X * 0x100).
> What's the best way to pass that info to the driver? (I assume it's not with
> a custom DT binding...).

I do not really understand what driver you are referring to.

If the pin controller node is overarching and spawning children for
the gpiochips, you use the design pattern from MFD to pass data
from parents to children, e.g.:

#include <linux/regmap.h>

pinctrl driver:
     struct regmap_config mapconf = {
                .reg_bits = 32,
                .val_bits = 32,
                .reg_stride = 4,
     };
    struct regmap *map;

    map = regmap_init_mmio(dev, base, &mapconf);
    if (IS_ERR(map))
          ....
    dev_set_drvdata(dev, map);
    of_populate_children(dev,)..
    (can also use platform_device_add_data() or "simple-bus" etc)

gpio subdrivers:
     struct regmap *map;

     map = dev_get_drvdata(dev->parent);

There are examples of drivers passing more complex things to
their children than a regmap, just put some struct in a <linux/*/*.h>
file and pass it with drvdata as per above.

PS i2c_set_drvdata(), platform_set_drvdata() are just aliases
for dev_set_drvdata().

Yours,
Linus Walleij
