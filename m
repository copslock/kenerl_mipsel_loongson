Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2017 00:25:27 +0200 (CEST)
Received: from mail-it0-x234.google.com ([IPv6:2607:f8b0:4001:c0b::234]:53006
        "EHLO mail-it0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991131AbdIPWZTHsnrt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2017 00:25:19 +0200
Received: by mail-it0-x234.google.com with SMTP id c195so6355234itb.1
        for <linux-mips@linux-mips.org>; Sat, 16 Sep 2017 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/JpJP9zITUcO1kOvMiEpyYzAAqq1gbyKwqxBHtVl4jQ=;
        b=PJkyjuS1wLM+63aRbrl5l8eXqxVqKY6+/DioR++YGJ8t80h29EXu0/mcmUfPIgz4HN
         6MCT08IAHD0wbJZVU/ulRf6zdMhZTtBJXRgb1xygCB9jFAoHqiWWjqnHych/kKMSbxFG
         M9EO6C+GRf51dEmpMHk3X68Tfyn/5008iN7FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/JpJP9zITUcO1kOvMiEpyYzAAqq1gbyKwqxBHtVl4jQ=;
        b=CYvUivQ5icEalsGYQBfJldOnNvX+e8JiZgJ82JENn/UgJizhMLfUBso6D/+mc+FqQp
         PaXgRjcYO1D5Wg070IApu8VDkWO3TLDrhsdatQpThBp7zG0ZY8sBytT7rUN3Rs/Lj5J3
         brbgs6Vnyrx8lZznsmnlPBIH04rYqnzo3fbO+UfQGdCH9dCZ9z1OgdRwvWzGXWW08MCD
         tu0lBKUq1GnzBy03Xb1HaqFjYXvv2HKV8SwJq3xjGud2rnbJbcT9M5rK+m0RPPBTqjnv
         IF5vY65bdFwBRYzFL75KZRA2PC5jS83CY1FO/TXoZqYIU5eSrTmZ3JE0ZS0ggYF6sSrE
         OKKw==
X-Gm-Message-State: AHPjjUjewd4wxApCL0hiomFwp/Hpxu0c3yRZXoF85npZQVvbn6SCxITL
        vnma1Azd5v9k5TIxav3LHnSypJNeMHXkL8hlXFe8CA==
X-Google-Smtp-Source: AOwi7QA/hQdD529TqqLshBCsdNn4VDC36dHzQJEv0C6OQ1+aCsOyW7fahIjALdnsPpA3Ms5Lv8BfMW9jCRuMFzqcqqQ=
X-Received: by 10.36.6.3 with SMTP id 3mr4255166itv.36.1505600712813; Sat, 16
 Sep 2017 15:25:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.164.78 with HTTP; Sat, 16 Sep 2017 15:25:12 -0700 (PDT)
In-Reply-To: <20170914093509.uwk47vt3wnm3rtqb@dell>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org> <20170914093509.uwk47vt3wnm3rtqb@dell>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 17 Sep 2017 00:25:12 +0200
Message-ID: <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
To:     Lee Jones <lee.jones@linaro.org>, Ben Dooks <ben@fluff.org.uk>,
        Ville Syrjala <syrjala@sci.fi>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Schocher <hs@denx.de>, Guenter Roeck <linux@roeck-us.net>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60034
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

On Thu, Sep 14, 2017 at 11:35 AM, Lee Jones <lee.jones@linaro.org> wrote:

>>  drivers/mfd/sm501.c                          |  49 +++++-----
>
> I'd prefer for this to be applied with a Tested-by.  I appreciate that
> this is an old driver, but can you attempt to contact one of the
> authors or someone else who might have hardware please?

For SM501 specifically I guess.

OK makes sense as it is the most invasive one, paging around...

Ben, Ville, Magnus, Heiko, Guenther: is one of you still using this
hardware so you can test the patch set?

Yours,
Linus Walleij
