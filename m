Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 10:07:18 +0100 (CET)
Received: from mail-qt0-x235.google.com ([IPv6:2607:f8b0:400d:c0d::235]:34915
        "EHLO mail-qt0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993014AbdASJHJMiTQ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2017 10:07:09 +0100
Received: by mail-qt0-x235.google.com with SMTP id x49so57027580qtc.2
        for <linux-mips@linux-mips.org>; Thu, 19 Jan 2017 01:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vRkkNs0bx1+GRaFuFtdb30BwJCqY4I5zn/YkN0drvIE=;
        b=YiEySPQE0LBt66oszSOkuqkjJM0k463VkLr4/Nd23qFUFczF5HzhDu8JMif8lzkLwN
         055xfo680UsLqLAE59VMigCd9RGyPpYi5hkw6XDhJSyOiniR08Ozg6QUIHCmfrwpPdOy
         XamOqVUWLSclhtde+Vi0bRV1/fDDdMhGbm4AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vRkkNs0bx1+GRaFuFtdb30BwJCqY4I5zn/YkN0drvIE=;
        b=TujEEjLWhBzgxJ9swqmH30q/GagWkPFAERFOwJMI6nr4eGY/DkSBV8yZCKYV8Wwe9j
         tID0K/wdzfyw98nXMTIdIsbrZgYvFsSTSk/RA02kXM6tJaUyEhkrn+NgYXIS6Mp8Y8Ns
         HOM2W2scYneWYnczLS19GU8EkWRpiWEwHOLYGrqutV7EB3e1xY/TaR/VBXhrAxl7iBiR
         S+qRHyr2Nip+IXcEZpMiYAxmF2oNPfX/WQR2Fb+zDBoxU0xGJ7W2BiUgJMEl085y/ThN
         2Qry1DqQcfUxT80jmn+QQd3sJvLVupZavRESCA+z6kuQP1wRye9YKu6kBQ1tFNyYKaIP
         uJLQ==
X-Gm-Message-State: AIkVDXK5bPE54HvcGitsQMv5lEfX1s0uRbqdiiY0ABrv6ZRpwJmHmbHzniY/jW6Kt+7kTrU7nbxV02ZgfA9tw5r1
X-Received: by 10.237.33.185 with SMTP id l54mr7296566qtc.111.1484816823455;
 Thu, 19 Jan 2017 01:07:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.177.145 with HTTP; Thu, 19 Jan 2017 01:07:03 -0800 (PST)
In-Reply-To: <20170117231421.16310-14-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170117231421.16310-14-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Jan 2017 10:07:03 +0100
Message-ID: <CACRpkdYMm0iWxmEGyQyEz4JfWukXNyGXO1rqw1dSiABgHdA1tQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] MIPS: jz4740: Remove custom GPIO code
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56406
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

On Wed, Jan 18, 2017 at 12:14 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> All the drivers for the various hardware elements of the jz4740 SoC have
> been modified to use the pinctrl framework for their pin configuration
> needs.
> As such, this platform code is now unused and can be deleted.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

I feel I might have come across as a bit harsh in the previous review of the
patches leading up to this one. In that case I'm sorry.

I can clearly see that the intent of the series is to remove this hopelessly
idiomatic code from the MIPS hurdle, and move these systems over
to standard frameworks.

In a way, if I look at the kernel as a whole, it would likely look better
after these patches were merged, than before. Even with the
shortcomings I painted out in the previous review comments.

A very complicated piece of messy code is cut from MIPS.

I think this is very valuable work and well worth persuing, so please
go ahead and work with the series, your effort is very much appreciated!

Yours,
Linus Walleij
