Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2017 08:39:34 +0100 (CET)
Received: from mail-it0-x22f.google.com ([IPv6:2607:f8b0:4001:c0b::22f]:32905
        "EHLO mail-it0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992396AbdLMHj07VkJA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Dec 2017 08:39:26 +0100
Received: by mail-it0-x22f.google.com with SMTP id o130so20032540itg.0
        for <linux-mips@linux-mips.org>; Tue, 12 Dec 2017 23:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GSRz6IERQ6ETTvUSkdTnQBHTQShOwXlsSNja50gdCfo=;
        b=OSj9thL22nkRp6C1rkIPnJ5NDTnmd/cAT0TUL7WWPFVBEbSAgN6Az8XJi1eH3Ek3Ki
         rRHqIiI36U6by3IADMAsBfAfwLMsJb8qZxYeGbMx32whJsr/8HnL2EaLwRB5eZZ9kMnt
         OCu6PcTFIkcYZg/Qj1PzvEJzoEvOOve9zoQFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GSRz6IERQ6ETTvUSkdTnQBHTQShOwXlsSNja50gdCfo=;
        b=Lm5m1fYEpvLdSZHM/kORTHEUvHzRFOrNZTihpdvs7F3ZZJ5C+6Sy28l4bOfdoYTA2n
         z4Q+a2Xl1Yh9j84fq+uWa4Dl2WFgiwZOg9e4lAy7uBBBDolw3j+dkiPeN8LXg/TVGAEU
         6blPTg255kp3VA+8rLuUz59fqakUXPT6+HG+uOYJ0ouud+2jTC3uAALMfPPXQWKADJNg
         0SDARJuMu+ZpVZjjDNnjJrhbhx+iPPY9ua2d0GoF/5zeYwgxN4NM5xSAVfnCGuVv7XYE
         U4Yphw+SKWQLkpMi+NlYT73aEvBEMWY3gSWQM+wEXyzvESMjEldjvO70nu0zgDdXCrjG
         /o5Q==
X-Gm-Message-State: AKGB3mLw4L5DjPvvFEkINK4u0yy6d0hIB2o8OdVizPUb9KqxE/AH4EiI
        9TJ047G7lpXEP+m7yI/lLnygeNshXNt3VxKyYfLEOw==
X-Google-Smtp-Source: ACJfBovkhik5FK4sPzArLCZvhxnfBDzxWAkjgogxNZYuRcM9fF2k5jXSXVR1UIXpOM1sZ5952gV2h2uv3/o2dby4ANI=
X-Received: by 10.36.112.132 with SMTP id f126mr1937648itc.7.1513150760702;
 Tue, 12 Dec 2017 23:39:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.87.84 with HTTP; Tue, 12 Dec 2017 23:39:20 -0800 (PST)
In-Reply-To: <20171208154618.20105-5-alexandre.belloni@free-electrons.com>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com> <20171208154618.20105-5-alexandre.belloni@free-electrons.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Dec 2017 08:39:20 +0100
Message-ID: <CACRpkdYmQ2vWdp5DFoVM7d_CE0rV2Sh9BRb7qu4apC9_=yeo3A@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] dt-bindings: pinctrl: Add bindings for Microsemi Ocelot
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61462
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

On Fri, Dec 8, 2017 at 4:46 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> Add the documentation for the Microsemi Ocelot pinmuxing and gpio
> controller.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>

Patch applied.

Yours,
Linus Walleij
