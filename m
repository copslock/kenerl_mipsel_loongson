Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 17:31:35 +0200 (CEST)
Received: from mail-it0-x22a.google.com ([IPv6:2607:f8b0:4001:c0b::22a]:38620
        "EHLO mail-it0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993962AbdEVPb1g10y5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 17:31:27 +0200
Received: by mail-it0-x22a.google.com with SMTP id r63so25381692itc.1
        for <linux-mips@linux-mips.org>; Mon, 22 May 2017 08:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Olr/ttijX1u9lH7sRxfr1eWadtwuCabHBzq/4UDOMho=;
        b=Kw3xUawtXxYc7DdbPcX5HEXCrtlx1WBx17g42KlIy+hiNGMJKHUuW/nHHUqsA3kSy+
         9JRiyD7aFjPViOIbQTvHU2pOeDlhBvPQpPdh0c0LsZE6mvLX7VKSSd/Uqnn8rn9fEzoa
         9bSzbAfwG3ZxCZK4sodbCveJORoyP4JOPxFKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Olr/ttijX1u9lH7sRxfr1eWadtwuCabHBzq/4UDOMho=;
        b=ftaTUzwE8Woy8n1YZ32FSphiSBSQRf1luVYrtNr1TWMfe8oajz6HSj2aY7jLW3236y
         Ko8BuhdrumNvnukJiOFHKdZlAof7lfvGlGKwocRNvmYNvQ0on8x0HfvZXr+l9mF00kRq
         qWQbAhC4nnqbXX5/ixBowdyNSkIjqS2EL4kbp3rj3d3RaXTQf4qxeP+tzJcVWdGYuW8R
         2oc5t7Mdrn6iwP48/1yq85xZxBRlKmcAR/LORowADzNLSa3Ij7PxfSXG3OdMhGEoaDJB
         INAgq3SfIhAsXU0Pm9C4lFNWXWU8kAz8xAeShdtk5gDlUtMZNoo7ZP6t5vukkwC4VnH/
         EA0A==
X-Gm-Message-State: AODbwcAcu/fEP540LQGUXzv9TBFuuXsFkDYGQ/d4bLR4bf1/JEB8ji7v
        ryGAlLo1k9rSPEHppUTeGhVc/5qWNK2x
X-Received: by 10.36.51.76 with SMTP id k73mr22299116itk.27.1495467081809;
 Mon, 22 May 2017 08:31:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.154.7 with HTTP; Mon, 22 May 2017 08:31:20 -0700 (PDT)
In-Reply-To: <20170428200824.10906-6-paul@crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-6-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2017 17:31:20 +0200
Message-ID: <CACRpkdauf5c2i4o5i8QY8YHPNjizkvTu6kAbnquWiP_=v2=KdQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] MIPS: ingenic: Enable pinctrl for all ingenic SoCs
To:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
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
X-archive-position: 57937
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

I applied all the patches to a branch in pinctrl and merged into my
devel branch for testing:

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/
Branch: ingenic

Ralf: are you OK with this? It would be nice to have your ACK on
all patches. If you want you can pull this branch into the MIPS
tree, or we can hope for it all to settle nicely because of low platform
activity in MIPS on this platform, so it only needs to come in
from my trees.

Yours,
Linus Walleij
