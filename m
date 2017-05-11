Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2017 13:01:44 +0200 (CEST)
Received: from mail-it0-x233.google.com ([IPv6:2607:f8b0:4001:c0b::233]:38449
        "EHLO mail-it0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993009AbdEKLBh1fp3Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 May 2017 13:01:37 +0200
Received: by mail-it0-x233.google.com with SMTP id e65so17416371ita.1
        for <linux-mips@linux-mips.org>; Thu, 11 May 2017 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CDPX8KAQNaorGUg1AiHQglS/io4UT6KwE10c1xm6Uf0=;
        b=OZS36eElCFtSRUKlFSJFF9mpPhDbuavvfEItW4ucS3R29KFgWfFT7OyyAavTB+JVHD
         wStdRMHNOPbv2giStE3fxwKYqfXxeAgl8LUR4ML6ra4reOapebR+APrueZfG+Q7O3c6Z
         KqekHqvt+eLGxx8HGAnCsp0lHQSuINCOls/r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CDPX8KAQNaorGUg1AiHQglS/io4UT6KwE10c1xm6Uf0=;
        b=hzdCKeOTRX71+hNJhYazeyTjwe83n5QDH/hEzFwSI5M82zACOPMSILkygqf5izfhsf
         PTc6BbzmxPGR7A3JLc0R7T7kw41S7MYC/yLq0pkzAC/nV8qTgAWVMNRV5s+amYTZgQZZ
         2N0yyzLZt7Sly4XqQ2SUeUpXTAY/2nlBqdWI7LHQSg0zR3ZrZb8FU9w+BAIdjfO7E3jN
         CmDGL+ixlghLtFyAo1x7CDzyyXyi8LzMwp/uKbqvN16EjAg9aH7Y6HykQNKwSBi+NeGW
         o0ODkoaOGpo+KHsumywTI12ZZe2yi2IQff3NtnV2o8YCCCeRz38OjhCFKFOyWZYEBIX5
         TVbw==
X-Gm-Message-State: AODbwcBNt8mEJrMnsWmPwjHNzdQuRnysD0actq54Pxru0hrF2UeG3Wnk
        XL/uQG80Y/DYaf7G9j7UTM/WTt+r6XjP
X-Received: by 10.36.104.72 with SMTP id v69mr5565079itb.27.1494500491648;
 Thu, 11 May 2017 04:01:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.66 with HTTP; Thu, 11 May 2017 04:01:30 -0700 (PDT)
In-Reply-To: <7941dbfbaeaf5c23bb177e66165060d3@crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-4-paul@crapouillou.net> <7941dbfbaeaf5c23bb177e66165060d3@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2017 13:01:30 +0200
Message-ID: <CACRpkdYR8Y77VXrNz=NwczgxZvitkO72bAYcDuhneZbVVsT6=g@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] pinctrl: add a pinctrl driver for the Ingenic
 jz47xx SoCs
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
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57868
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

On Wed, May 3, 2017 at 11:12 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> The dependency on MFD is gone but now I notice I forgot to remove the
> 'select MFD_CORE'
> in the Kconfig. It'd be great if you can make a quick edit when merging
> this,
> otherwise I'll send a v6.

No problem I can fix it up.

Yours,
Linus Walleij
