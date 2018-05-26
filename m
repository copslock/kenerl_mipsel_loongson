Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 May 2018 18:38:57 +0200 (CEST)
Received: from mail-io0-x233.google.com ([IPv6:2607:f8b0:4001:c06::233]:33454
        "EHLO mail-io0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994697AbeEZQiuMbGUB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 May 2018 18:38:50 +0200
Received: by mail-io0-x233.google.com with SMTP id o185-v6so9747201iod.0
        for <linux-mips@linux-mips.org>; Sat, 26 May 2018 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IzrP1Rk/l0QjVUrXlCZ2IYIhRHPTqACtq0QeiuNkZUE=;
        b=d5zd32Ax4t8MU1Fe0I6ZuX/b2NtlnpzJmZGsVz8+hsqXmyJeqoF2uvqt4hjX0O5Hk8
         AIcmGYSbKvBf2/ZKFtF39xe7+xq4VQp1CGYGcyCCf1JlOYBRKUiQwvK91Uk29TjfHJBd
         iOeh7pAidB8tdwuVevV2h4cjURo6Yl55TaVw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IzrP1Rk/l0QjVUrXlCZ2IYIhRHPTqACtq0QeiuNkZUE=;
        b=oA+5WHoZwuTjTBvHrXehgXTqIutRHolds1KYYR5dHscz5ng5NxerS6czaA/x0YroNM
         IaR1hJcC0jIs9NuCCizf4lJ0sGY0b4I9p1WTEuhjZ8EapPq8JnglB13uUMdQBKhBLC7q
         FI5K1qixb0JPZ++sfRM+xsGKE0V+kkIY9NvaFB6ls9xI4Nu3QZEzDr+c7HdTapCPB1Yg
         VjbcahkF9+//HhJRGdTExglKrfywQGL3zC7qqUQQ/j7sU2s/tvNBABDGgL+mp+aU+AxO
         8ps+gBOJsRVtTsQzZTd9ZED5ApJLaPsuy63Dj5iSITnamLAXITj+Fvk6iVNA9fGihPAO
         Iq2A==
X-Gm-Message-State: ALKqPwfdTk0TZan32icbKUg5jgQc2WQzSHTBL0ghQ9W4204t9ZFWFaAp
        sViHtWkhwohSOs7j8XlatrmKdIbZV+0vGHs9u2c4Gg==
X-Google-Smtp-Source: ADUXVKJ0tJdzwpUcyQNV+Ilm04+DKVtpgMC66FaMWOpz4z7g5v/d6Zudck/Pfiqdf9G3JnsvA6wi1iOllxNlU7OCJnM=
X-Received: by 2002:a6b:4014:: with SMTP id k20-v6mr5597697ioa.277.1527352723872;
 Sat, 26 May 2018 09:38:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Sat, 26 May 2018 09:38:43
 -0700 (PDT)
In-Reply-To: <20180525154144.GC19100@kw.sim.vm.gnt>
References: <20180525154144.GC19100@kw.sim.vm.gnt>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 May 2018 18:38:43 +0200
Message-ID: <CACRpkdb26T7JNHOPSFxmPLyNnMDqpNYnMZxKEHGL8gPo9V2Sjg@mail.gmail.com>
Subject: Re: i2c-gpio and boards conversions to GPIO descriptors
To:     Simon Guinot <simon.guinot@sequanux.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64063
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

On Fri, May 25, 2018 at 5:41 PM, Simon Guinot <simon.guinot@sequanux.org> wrote:
> Hi Linus,
>
> I think your patch b2e63555592f "i2c: gpio: Convert to use descriptors"
> may have broken i2c-gpio support for some boards using old fashion
> platform_device declarations.
>
> Indeed when an "i2c-gpio" platform_device is registered with a fixed id
> e.g. 0, then I think the device name becomes "i2c-gpio.0". And then this
> won't match a lookup table registered with an "i2c-gpio" dev_id.

Yeah what a mess, I'm sending patches to fix it up, the ARM
patch already sent, I will send a separate one for the MIPS
machines.

Sorry for the mess! :(

Yours,
Linus Walleij
