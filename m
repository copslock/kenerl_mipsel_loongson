Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2017 15:29:15 +0200 (CEST)
Received: from mail-io0-x22c.google.com ([IPv6:2607:f8b0:4001:c06::22c]:36974
        "EHLO mail-io0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991181AbdGaN3Hh6Voj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2017 15:29:07 +0200
Received: by mail-io0-x22c.google.com with SMTP id c74so110994977iod.4
        for <linux-mips@linux-mips.org>; Mon, 31 Jul 2017 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l2MSpeqhX1Qeus35HEXFDNr0Zd0P6eSol4yITjVdnCs=;
        b=OonBOSH4bVlxQaL2/6TBe8BmJA5zpGyTyTmoCo+5i5LU/M8ZCXk7gYIFVaHet9N28b
         mVoM5yPV5IADa7p8yJImIahZMA2yezTlPg3/3/9k2L9CJDZ3jOSaQlrG6H6x6ORj+f+n
         mKxHCj67qXVVpFJbP81DvfDjTav3/8As2+tho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l2MSpeqhX1Qeus35HEXFDNr0Zd0P6eSol4yITjVdnCs=;
        b=H6TcZLt4mgcRCYWcjYQlTWmh++qM3iNqz0HurCxu35y028v2OAxd5lEKGzXz6sCv1e
         l8zeHWjyqSPGRXTwINb3ioy3sDAvfCRMcCsYrcNVy4x5Dc401Goz3doNktRyCypf+gA6
         G4a9iPfvTsyCCH9+ZlBpUVYUXkkRtN2eY8LbgabUex9t9tBEDxUIG8Tyw2oanr6HVXfR
         Av5bp7Nss/jsgEX0vxwee1NqHBhGzscHhGltuZnDWMw/WPiDmAFOekHZfHTiQYmlHZDx
         vYwc6BHFdKNYzxL24n5Fe7+IaKmmrHmZrxpFiMAMTd9vn3q84fdiVHC9u+gt6BKqJqBr
         G5WQ==
X-Gm-Message-State: AIVw112gDEUbJPYV1GeLfMjnbtXYE03DzMv/xJgieYBvB9Q9/wGQyh8c
        zG3VPsvmabEFQem8jDkkO7YeR9Ph2Fkt
X-Received: by 10.107.157.9 with SMTP id g9mr20099609ioe.46.1501507741830;
 Mon, 31 Jul 2017 06:29:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.154.22 with HTTP; Mon, 31 Jul 2017 06:29:00 -0700 (PDT)
In-Reply-To: <20170703135555.GA686@linux-mips.org>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-6-paul@crapouillou.net> <CACRpkdauf5c2i4o5i8QY8YHPNjizkvTu6kAbnquWiP_=v2=KdQ@mail.gmail.com>
 <1499013301.1477.0@smtp.crapouillou.net> <CACRpkdb=Zti+C+2me_WP0=m6z12G5Kz+W_cPcZsw=CVzBO_wAg@mail.gmail.com>
 <20170703135555.GA686@linux-mips.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 31 Jul 2017 15:29:00 +0200
Message-ID: <CACRpkdZKAR-Ya-j-g=uyb24s1KqyEhbKOxzi=BdAaa29L1BO+w@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] MIPS: ingenic: Enable pinctrl for all ingenic SoCs
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Alexandre Courbot <gnurou@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59309
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

On Mon, Jul 3, 2017 at 3:55 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Jul 03, 2017 at 11:07:09AM +0200, Linus Walleij wrote:
>
>> > There has been no word from Ralf, is this going into 4.13?
>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>
> for the whole series.

Thanks Ralf, I missed to add this in, but everything seems to have
landed smoothly in v4.13.

Yours,
Linus Walleij
