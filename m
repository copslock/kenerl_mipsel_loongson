Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 21:09:52 +0200 (CEST)
Received: from mail-io0-x231.google.com ([IPv6:2607:f8b0:4001:c06::231]:46484
        "EHLO mail-io0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993179AbdIRTJp6KK7n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 21:09:45 +0200
Received: by mail-io0-x231.google.com with SMTP id d16so4632454ioj.3
        for <linux-mips@linux-mips.org>; Mon, 18 Sep 2017 12:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mZij9RtT0OwvSzjyWH0ZMI7sELbw0Dm4WuovXS483Go=;
        b=FMxLbJstjzS0nqAmu7dDqJbJSo3KHlNpc4lc5418pWE+F4JumgdmH7m4T6e4uJu17F
         2A6c4mHbyMvLdRZN4UqRORzZuJa1G6iiAfVBPmp8H6u9OF1BykgG8tyAw3khBc/EmTSE
         S3cZIbU+D4T5lgKfMPVoyVhFyDlvx/FDxdjTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mZij9RtT0OwvSzjyWH0ZMI7sELbw0Dm4WuovXS483Go=;
        b=U90SSVnmrBX7O8wVbhs58B5Ykbn1+eUX3aFzBVIItwqrg55fSZD5QgIAegXnSoYmmq
         4JvJt+CSnCRhLpupRJ2jUyQHvUD6oll3sYF/Y5HH1sgY8IgSbofDCyzNRT7seCcmvFzV
         lhDkoklJKcqZN12sJLyXKOr5ADJYab9gHNDHwz37N0wGUOnMvJRhJ3uFLbvelQ4b3mUA
         nm5rC3gEWNkSxBJidy4lFwEOgB79BeYkhPP4aHDFIxjOHzh2eR5hNdWEr5fiVECA8JBx
         E0tVi7R0D9WEZiRlrvcD3MX16TXgd0Vb268vAKKRSA6yZRNyBke3R1H7tpgqHRu8L+VN
         MDKA==
X-Gm-Message-State: AHPjjUhix8Ebw3zyYnO0Djrd1vF1T/lWlJcWN4XBlAgN9bv1moWQEJHQ
        BfxDF9f+8617t1CmNN0BtkUyCaQYA5KQrb2JZlwaKw==
X-Google-Smtp-Source: AOwi7QACPkDFrauGqTzQkQg4Yyp3Jooi9/x13tVm/ywRvAFaZCF+UJRPvsdgbzgsdYjlBcZyO8Rd/VqwIxAJ7nweqq0=
X-Received: by 10.107.139.215 with SMTP id n206mr22532675iod.155.1505761780058;
 Mon, 18 Sep 2017 12:09:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.164.78 with HTTP; Mon, 18 Sep 2017 12:09:39 -0700 (PDT)
In-Reply-To: <CAMuHMdX+bx9pNEAFoBzfM7JhhH800u-HumpQYRsG3d5BNuduvg@mail.gmail.com>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-8-linus.walleij@linaro.org> <CAMuHMdX+bx9pNEAFoBzfM7JhhH800u-HumpQYRsG3d5BNuduvg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Sep 2017 21:09:39 +0200
Message-ID: <CACRpkdaYjQC9wTCvAJ-zEdX9fvBTRK5sazCd4L32zG3WkB1q4A@mail.gmail.com>
Subject: Re: [PATCH 7/7] i2c: gpio: Add support for named gpios in DT
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60064
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

On Mon, Sep 18, 2017 at 11:58 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

>> +       if (ret != -EPROBE_DEFER)
>> +               dev_err(dev, "error trying to get descriptor: %ld\n", ret);
>
> warning: format '%ld' expects argument of type 'long int', but
> argument 3 has type 'int' [-Wformat=]
>
> %d (0day busy?)

Bah haven't pushed it to the 0day builders yet.
I'll do that tonight so I can drown in the build errors.
:-D

Fixing it.

Yours,
Linus Walleij
