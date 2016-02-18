Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2016 00:24:02 +0100 (CET)
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33802 "EHLO
        mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012774AbcBRXYAbYG04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2016 00:24:00 +0100
Received: by mail-ob0-f173.google.com with SMTP id kf7so8695455obb.1
        for <linux-mips@linux-mips.org>; Thu, 18 Feb 2016 15:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Xu7j+cMsUXYC+SzslIA9YgtsizvWZSQ8BTqbHeY0aRQ=;
        b=XAjSmuCGZ5JSddFnm5AyFP/D2+0FGUNt94zNC/itD/f5F+IZ/WOyoUMLs2/yI7AmFC
         4vponC1XxiO93A3ZnTDKVzP+4AVrBcVvWCtSYGEgesONyevhWBxHuTiCLBQPGWsLZiPH
         y3FXCFIXWTFXm+vqOCKEuSXxJZmTgtmOWTuZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Xu7j+cMsUXYC+SzslIA9YgtsizvWZSQ8BTqbHeY0aRQ=;
        b=B8xtuZnRB6Dkq+n1RKRWjWlB2XFXcFqosWcAA7YWF7jK1aE1ZZuSMix8yrrzvwdmuq
         7hlO6nTSHB0GG3rkA0WLEZM5+PdfOxm4wQdiL3TzprshoGlBbC0SEmrWMafDCPYx1vSf
         iL3uxnMIRLwwUy2qEo/rqwdKnnAuMnEnEDm6RqgU2wkVPaH0hjfdMB9/EOBqutQWlp4Q
         zvzRQllCCxJWPlaCTpTz/UTS0Dkhyvbigvc4JcPepEBM1oLieZg6KNxSEG1ymMvevjuP
         a012OkTQR6Bsr6a2lVSIL+kZrYdIgNMcsjXvRqQRow0cHkznL98SjXj1FJyP1duHTKX4
         TCDQ==
X-Gm-Message-State: AG10YOTCEHOhtxU+g2JC/ZMb7KnreIorO1zyYxXxSwzL+iMdLxua2GT8aijWPntY/ufDdqvt9HGw9O5hRaWsxp6v
MIME-Version: 1.0
X-Received: by 10.182.76.2 with SMTP id g2mr8786038obw.21.1455837819949; Thu,
 18 Feb 2016 15:23:39 -0800 (PST)
Received: by 10.182.55.105 with HTTP; Thu, 18 Feb 2016 15:23:39 -0800 (PST)
In-Reply-To: <1455637261-2920972-5-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
        <1455637261-2920972-1-git-send-email-arnd@arndb.de>
        <1455637261-2920972-5-git-send-email-arnd@arndb.de>
Date:   Fri, 19 Feb 2016 00:23:39 +0100
Message-ID: <CACRpkdaSxhBrSt5qcUUJPcN6nv9Go96TP52cyU_nBZZM0phuPA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] gpio: allow setting ARCH_NR_GPIOS from Kconfig
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52127
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

On Tue, Feb 16, 2016 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The ARM version of asm/gpio.h basically just contains the same definitions
> as the gpiolib version, with the exception of ARCH_NR_GPIOS.
>
> This adds the option for overriding the constant through Kconfig to
> the architecture-independent header, so we can remove the ARM specific
> file later.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
