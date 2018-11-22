Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2018 23:32:10 +0100 (CET)
Received: from mail-lj1-x244.google.com ([IPv6:2a00:1450:4864:20::244]:36460
        "EHLO mail-lj1-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992241AbeKVWaSlbPcn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Nov 2018 23:30:18 +0100
Received: by mail-lj1-x244.google.com with SMTP id g11-v6so9130801ljk.3
        for <linux-mips@linux-mips.org>; Thu, 22 Nov 2018 14:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=taghS2a4kfby+oaS1DmzBKciKlLssq1DfIV6AXhthoI=;
        b=URhMrLwkwgP6GxijgMTqJLmkf90TUqbv3TP2cV3wm03K7EQrZmhT1TibSEZJfmGm8x
         MnXUtUnRjZxdeHU3sbkU/i+jlNg3op+wlyLXKSwmezqoAWFFoGgobnPVmnbynW7S92cS
         TL3p4AP3vtzuwD+2U1BS1dmrrbGn/my8k6J+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=taghS2a4kfby+oaS1DmzBKciKlLssq1DfIV6AXhthoI=;
        b=nPqoxyGJEUt7VY0Y30xNHYfzyHwip8vMUT50yXH0a/EExOJReY0I1tSa6dKYPuszL4
         k+ddKmresPM4r1Eou9ln7MJDBUdO4tzWYchHEw0IQ55HUAlAzHA+EnKqtuSvXdgCYANY
         +X+RE1gTM7O49NayiprLjZO22SM2/QEtTwM74D09ly1kPmGyecIZVBwMVtw1aszb8M00
         UAA/w89hvk8rbsjb0jNzkv+pKP6i4zSQQ/Kc3Me7a/pFi+C5iljxiH3wevlfMdViuhMK
         RowW8Tf2Y8yR4KFxvpqavfSlXt4PZpnCkazcACes7FivjvP66A3C9wA/EtDuuQ7GBK+/
         K5NQ==
X-Gm-Message-State: AA+aEWYRvmDZG/BVzPvFvtzLOuIf78e/5FH+r/BGF6MwUNbArl4EP/Xe
        1JD7jBvlyLegwTxXK55U3RPK7zOubI4m0xCQmXelag==
X-Google-Smtp-Source: AJdET5eAjpmHJ+dyrpAP211s0CZcqlwVJuXPGXERgSaa6JIkesqOri3WjMVIWERVThJmhWIyaxt8X7bk8QcknyjQ/R0=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr8115341ljc.97.1542925818190;
 Thu, 22 Nov 2018 14:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20181112141239.19646-1-linus.walleij@linaro.org>
 <20181112141239.19646-4-linus.walleij@linaro.org> <CAPDyKFqVHYCBZUO273rS70veKRtuNy3iROkeAkdB_QSkzxcpPQ@mail.gmail.com>
 <cb5ddbe663345981fc4039264e139733@crapouillou.net>
In-Reply-To: <cb5ddbe663345981fc4039264e139733@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Nov 2018 23:30:06 +0100
Message-ID: <CACRpkdZGe+zQ9_1TnVqcpi93LADxdWhq4h8bjVfW_+FB76ThOg@mail.gmail.com>
Subject: Re: [PATCH 03/10] mmc: jz4740: Use GPIO descriptor for power
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67458
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

On Thu, Nov 22, 2018 at 5:26 PM Paul Cercueil <paul@crapouillou.net> wrote:

> I think the driver should just call mmc_regulator_get_supply() in the
> probe function,
> and then call mmc_regulator_set_ocr() to power ON or OFF the card. The
> board file would
> then provide the power regulator that triggers the GPIO line.

One does not exclude the other, feel free (or anyone else)
to switch this to a fixed regulator. (Using descriptors!)

I feel insecure about cold-coding that without being able to
test it, I think I am on deep waters already. Someone with
the proper hardware should do radical semantic patches
like that. Introducing the regulator abstraction can lead
to probe deferrals and whatnot.

Yours,
Linus Walleij
