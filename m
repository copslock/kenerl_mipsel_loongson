Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 14:58:16 +0200 (CEST)
Received: from mail-it0-x22c.google.com ([IPv6:2607:f8b0:4001:c0b::22c]:32964
        "EHLO mail-it0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993552AbdDXM6Hna0Fm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2017 14:58:07 +0200
Received: by mail-it0-x22c.google.com with SMTP id 70so14218075ita.0
        for <linux-mips@linux-mips.org>; Mon, 24 Apr 2017 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kLOj/5daszZyY+HocUR8I6nMOeJzHA5NPOqC8zImezc=;
        b=L0Mu3kLcPFi3QO0xGxMu+AKD4gODtAxwqBZi0u+HpLJCnNDYCz7VmZSC/x+8n8X6JX
         nhwC2rnzmDCRVNtF0VO0FpPzKfiykPGrcPFj+6kbb5U6Js2awSwocIahKVU+s9tbp7gV
         3vq376vUL16gaJdjzeaE6E0/yjrlzlIVoO1ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kLOj/5daszZyY+HocUR8I6nMOeJzHA5NPOqC8zImezc=;
        b=E5Bexx4q8+cPUnkre4Jh39L7Tjj8HlBQfjK0tHGNE68e19ZW/XKtaOzUhY03Y/roJV
         Nmf2RtezfolCzkKrQksRl2oGxHEs6wAXsLh5Sjwjmw6fBIHrBJFRbSSG60PtkA+h9J9J
         Z2nEq66osBhJv0BumTgJD17+PaXjNR3Gg/l2VWRWUWpExCIUnit22/kBmc4PlmEP67Mq
         Lqh7NTNTSxBCT20eJtN5Kgip8s7y7xR6SI6GuuN1kZf2cwrl5jDrXtP+nAYnvOQW9kwD
         n0TTctnNKlEdB457dPWs/m4FjqEn3PDEHVbAHfqmCJeSzJJAjyz3eGxQsv2IzD94XMYZ
         233g==
X-Gm-Message-State: AN3rC/5JjGrFLIZK7xiQ1Y4mQHWXetmBsG+8XUvrNE2nmcI7RJ9evsSN
        Pudn6/B/YHyOUESscOH62F1JCQk9oNKPguY=
X-Received: by 10.36.33.73 with SMTP id e70mr12750589ita.9.1493038681977; Mon,
 24 Apr 2017 05:58:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.76.210 with HTTP; Mon, 24 Apr 2017 05:58:00 -0700 (PDT)
In-Reply-To: <e4aaf8c3e8a54df2c5878f8e873e290f@crapouillou.net>
References: <20170125185207.23902-2-paul@crapouillou.net> <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-7-paul@crapouillou.net> <CACRpkdbXe1Xxk93jqLXBdEDwWOnWD+CkZrqvok-PcmWxzBbSZA@mail.gmail.com>
 <e4aaf8c3e8a54df2c5878f8e873e290f@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 Apr 2017 14:58:00 +0200
Message-ID: <CACRpkdZ8o1OFC0HGaVuLWy5JbnHjeXmAYorii7eX=XvJNkSSvA@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57768
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

On Fri, Apr 7, 2017 at 3:57 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> I think the 'reg' property makes more sense, yes. I'll fix this in the v5,
> this
> week-end. Do you think it can go in 4.12?

Surely, Torvalds just cut an -rc8 giving me more time to queue more
material, and I really like this series.

Yours,
Linus Walleij
