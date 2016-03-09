Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Mar 2016 05:10:47 +0100 (CET)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33521 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006547AbcCIEKnWXW3g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Mar 2016 05:10:43 +0100
Received: by mail-ob0-f173.google.com with SMTP id fz5so35413644obc.0
        for <linux-mips@linux-mips.org>; Tue, 08 Mar 2016 20:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nBMja2HaifyAkOMpIExSmrIjkE0oH9IISG1OK+YZ3CI=;
        b=H7xpVHfvGhVF+UDm33LsdClsJiy02D7CRBES+5NuL0YFsxb2TD1F4hyYR/zxn8MHtL
         jOqS4uCklcbWoyArjoHasDlTusyK5cu2kxsd7nlP70VpEHsyiq5Ws9HpLRkGDtySot0f
         UA3DTziCSAcSjMid3NPjrncjj/4qX0FgQ7e4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nBMja2HaifyAkOMpIExSmrIjkE0oH9IISG1OK+YZ3CI=;
        b=HVLI6QWXgWfyKQgqQK47hm9hFaXnPSeCsTPOu+lHksfepo/8pbsBThFYRZwEhyK/na
         v8lMQMKItmrNoiOkkljGv0/WB9AE6NeizmfAh/6x1Ugqc05GE1AhhQCobqmiZiVNjnw+
         vdslDRCckZsIrJHhiHDAIh/OTbKsrk4KShRpO9iXo18ktuBhcjL7HS9bm8qtyZxpluKL
         WPumyQAK2jAjFHsLbKFpbQG2IVIvoDcZYHn/4bT+ygMVSlUjmIWC7eFOx/02Wn3tKmcs
         Dsgzz4BIa0Ub73Uu/7hR5glUsd694O+rpCmbrmVEuPXIbjmljUUvJJUxz7GLalUo8qjD
         FIcQ==
X-Gm-Message-State: AD7BkJKJED4q1ts/7is4/cvk//P4zXhlppyikqtmWYwYY8q+c0oKsEV97w+OiMomGxSeeH8uLQMd0z4iPkNyIB+N
MIME-Version: 1.0
X-Received: by 10.182.51.138 with SMTP id k10mr19342963obo.76.1457496637403;
 Tue, 08 Mar 2016 20:10:37 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Tue, 8 Mar 2016 20:10:37 -0800 (PST)
In-Reply-To: <1456911283-158809-1-git-send-email-manuel.lauss@gmail.com>
References: <1456911283-158809-1-git-send-email-manuel.lauss@gmail.com>
Date:   Wed, 9 Mar 2016 11:10:37 +0700
Message-ID: <CACRpkdZxdaUFCcLroFBc_md6Hh-F5qoDxaF9PCHyfsi-jUbKVw@mail.gmail.com>
Subject: Re: [PATCH v2] pcmcia: db1xxx_ss: fix last irq_to_gpio user
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     linux-pcmcia@lists.infradead.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52563
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

On Wed, Mar 2, 2016 at 4:34 PM, Manuel Lauss <manuel.lauss@gmail.com> wrote:

> remove the usage of removed irq_to_gpio() function.  On pre-DB1200
> boards, pass the actual carddetect GPIO number instead of the IRQ,
> because we need the gpio to actually test card status (inserted or
> not) and can get the irq number with gpio_to_irq() instead.
>
> Tested on DB1300 and DB1500, this patch fixes PCMCIA on the DB1500,
> which used irq_to_gpio().
>
>  stable@vger.kernel.org # v4.3
> Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> v2: "Fixes" line, and CC stable, and added Arnd's ack.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
