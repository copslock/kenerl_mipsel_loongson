Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 23:57:43 +0100 (CET)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36446 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012795AbcBEW5lZvAlk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 23:57:41 +0100
Received: by mail-oi0-f47.google.com with SMTP id x21so50436574oix.3
        for <linux-mips@linux-mips.org>; Fri, 05 Feb 2016 14:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p2Z5EctXvH6Z1pcey4wxpA3tTM1imMVYW9mftIY/TFg=;
        b=BuSR8uFeQrYYt1llxMjlZLLvhS4LIy8dS0drCzfn8lZTg5yInHMMr061oEJhUzV9wc
         ANK51Mk+hCv6PsYyl6UFzm7TkOUljBhgm4DsOjmZzldbaQhYhkehbZsZ8Mhy2qovlfcO
         Iwc+wuFo4OTmigceaYIfte5kevUtFTcNMjg5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=p2Z5EctXvH6Z1pcey4wxpA3tTM1imMVYW9mftIY/TFg=;
        b=BqW+/BN47GJn8dOr7DiqlBcbzd3AJV4BUk36kVAehk2CILUtdr6FqYHJgZP6WYq3xi
         GlQI3R98lc2Dai1QuoTK/pSvc+abmTKB/V61Hss0pcexqBJMzrN/AqTzlXCcBcwT3bJz
         sJbFNowK0qABPilC9cW5zLOVEJFB50ravGY2eS0YZLZ7Zx80xF1ABdSJlMuqyB/MBnfe
         tA/NPHBA/G8ZN4grVRc55DSSSmINO1vGJisMEqdDbnKpZUeoVv+T6YHpRFTsNRT3RVkK
         epIYA+43y+1RyRE6+7vQn2YRKQawADHhVicCdIB3w/AbbW4PFuO9d1mRtBEN1mW8Gi43
         5bYQ==
X-Gm-Message-State: AG10YOQ/FPQzQUEsc15e21JuLLrRsundQamaccY29WUKeu8ebr33IzvtiU1VBQgcy5eC0RIgDJXDecV7PETdNQBG
MIME-Version: 1.0
X-Received: by 10.202.56.6 with SMTP id f6mr10137306oia.135.1454713055692;
 Fri, 05 Feb 2016 14:57:35 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Fri, 5 Feb 2016 14:57:35 -0800 (PST)
In-Reply-To: <1454366916-10925-2-git-send-email-joshua.henderson@microchip.com>
References: <1454366916-10925-1-git-send-email-joshua.henderson@microchip.com>
        <1454366916-10925-2-git-send-email-joshua.henderson@microchip.com>
Date:   Fri, 5 Feb 2016 23:57:35 +0100
Message-ID: <CACRpkdYfBNgX8sqOdUfU=qfJkm8MyO88c3PwiOVex=Gpu3s3gg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] pinctrl: pinctrl-pic32: Add PIC32 pin control driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51813
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

On Mon, Feb 1, 2016 at 11:48 PM, Joshua Henderson
<joshua.henderson@microchip.com> wrote:

> Add a driver for the pin controller present on the Microchip PIC32
> including the specific variant PIC32MZDA. This driver provides pinmux
> and pinconfig operations as well as GPIO and IRQ chips for the GPIO
> banks.
>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes since v5:

Patch applied.

Yours,
Linus Walleij
