Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2017 13:07:00 +0200 (CEST)
Received: from mail-io0-x231.google.com ([IPv6:2607:f8b0:4001:c06::231]:34787
        "EHLO mail-io0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993009AbdEKLGyDx3bZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 May 2017 13:06:54 +0200
Received: by mail-io0-x231.google.com with SMTP id k91so18899904ioi.1
        for <linux-mips@linux-mips.org>; Thu, 11 May 2017 04:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gfYnmZAXqJT4IPFl2Y8UxfxTGkIabz8bb0TZDcj0kG4=;
        b=KOcX6ttp+6SSIw89VJ5Wv9X7uGnszA6jQ1r3qOb891Sm3Hjn74TP11xpq+IspcdvIJ
         wIsj6Hii1lf8MLo22EwI4VkQV93BPgepRBcgEQTkekwJ6zkO7qh2FOhQXGQfmA4+d0Ej
         fsJcALywzhDmGeQ/PtJJoW8j9S1jI0Vk1Rs8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gfYnmZAXqJT4IPFl2Y8UxfxTGkIabz8bb0TZDcj0kG4=;
        b=CN+KKJITQd9oHirlq48NmHGm8u0ft2apH5HWF1XhhxduYhFn3UhxJNHQ9rh+rCFfpz
         yguhwaDaKsSyR2CjNC0IiArzpBhrfBzNhfTvufbnG/l4L/Cyaq4RZsvLYwjiixrg7RsX
         ZvYH+iptNVrCNoylZPHgs02hPX25ndzTRdoYSzyY7kjsqSWZIe4nuqFia0nXN9f/Ckjn
         OoMphbq8UgHVQBCXFYSq0yRmQKYr6wD01ALwKrwk9YvfxSsswZBLQ8gZyjlOUizqIasG
         hb9gvzOuicauOu+z4pqzvgAZCP9S7e4wVu9UIkvSMhqBS4C4mNor++v3/sSTAZv0Teex
         ek3w==
X-Gm-Message-State: AODbwcBYJnYUZIs+P4VE8J1VjCPqn4pU2zbHes8vtTcUnY35lR4lFksf
        0DaPsN/ktPpugw5w9rOECCOzXorjbZek
X-Received: by 10.107.155.76 with SMTP id d73mr8840215ioe.122.1494500808451;
 Thu, 11 May 2017 04:06:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.66 with HTTP; Thu, 11 May 2017 04:06:47 -0700 (PDT)
In-Reply-To: <3a779fca-5a56-44e5-2acf-12b8abdaf906@crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net> <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-5-paul@crapouillou.net> <3a779fca-5a56-44e5-2acf-12b8abdaf906@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2017 13:06:47 +0200
Message-ID: <CACRpkdb+uQpdOfCFTKaMvp=nUxksA0=FWCDbY+JbB_=jDDcXfA@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] GPIO: Add gpio-ingenic driver
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
X-archive-position: 57869
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

On Mon, May 8, 2017 at 12:05 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> It looks like the gpio_get_value() is broken on jz4740.
>
> I'll send a v6.

OK I don't apply this series then, waiting for v6.

The series looks good so as soon you think it is finished
I can apply it I think.

Yours,
Linus Walleij
