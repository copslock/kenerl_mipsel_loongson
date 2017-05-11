Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2017 13:09:10 +0200 (CEST)
Received: from mail-io0-x22e.google.com ([IPv6:2607:f8b0:4001:c06::22e]:35797
        "EHLO mail-io0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993945AbdEKLJB5aoDZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 May 2017 13:09:01 +0200
Received: by mail-io0-x22e.google.com with SMTP id f102so18871385ioi.2
        for <linux-mips@linux-mips.org>; Thu, 11 May 2017 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xemqL2WULGlGrRGHVgzS2ofGSy3wae2cDIH0pwwEoDc=;
        b=kVcG9envHQCXgHCJ1KWieFxBhZj1E3y4mQrhKl6ih1BnTFumzV1L/0VGxbmXwIgvhO
         3khEIUSHHxPGUbDt0dbVJtce4kuXValREDZofoLeQHt7mGOdxupi9sSFCupome/X/2/J
         rBNshGEe/5B/f7SdeZWpMUGvpKgWZHFtAP51o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xemqL2WULGlGrRGHVgzS2ofGSy3wae2cDIH0pwwEoDc=;
        b=cjnBuZ8ZitLon7RUwg6RSztWj93yGLWlXo0Rtl/K2ZoaX3/YuCbEvs5NN1bZUAjwiA
         YaR12u3ih6EzoeDnALbVDXReuRfq6K05SB0iKQBXLQMollVTi6Qyb2ZeU1I++Ya28J6S
         00C7OQejeO5pAGU0BVn48eAUg9NFcPxmWN0/MOL/R3QTsDtosnlE9juM1gtuultGbIp4
         h5xnoD/ZUgZi0e3gU/u9JlXSA4ZO+nJHgKJqOv39V6M2QGbpo9tFd7/QlaCJ0Nn+hBtG
         +bi0NHsyRR+HCb2HG/qkoHOPCe9C7kPXvDb4kASyClFpaX+j3+BfLaZ8wfqo3yVkOA9E
         MhsA==
X-Gm-Message-State: AODbwcCYVpXQvw8UVCJhYtf7H83Va/cA79ssRcls1JAaXvNVLFEc8M3v
        h1Kj1Slbq/rpZB6x5/6uEeNy0/RurytN
X-Received: by 10.107.29.143 with SMTP id d137mr7404585iod.8.1494500936165;
 Thu, 11 May 2017 04:08:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.66 with HTTP; Thu, 11 May 2017 04:08:55 -0700 (PDT)
In-Reply-To: <20170428200824.10906-6-paul@crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-6-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2017 13:08:55 +0200
Message-ID: <CACRpkdaYRmB=i-=k4vfFYL6wHVrpNo1w11xnLGbu+6YPPmT8vA@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] MIPS: ingenic: Enable pinctrl for all ingenic SoCs
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
X-archive-position: 57870
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

On Fri, Apr 28, 2017 at 10:08 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> There is a pinctrl driver for each of the Ingenic SoCs supported by the
> upstream Linux kernel. In order to switch away from the old GPIO
> platform code, we now enable the pinctrl drivers by default for the
> Ingenic SoCs.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/Kconfig | 1 +

So please tell me your desired merge strategy for these bits. I can
provide an immutable branch for pinctrl if you want to pull the deps in
or we can just merge this orthogonally in the MIPS tree and let things
smoothen together in the merge window.

This goes for everything outside of pinctrl/gpio.

If I should merge patches for other subsystems I need ACKs from
the maintainers of MIPS etc.

Yours,
Linus Walleij
