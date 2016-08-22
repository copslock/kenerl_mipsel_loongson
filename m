Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2016 14:13:02 +0200 (CEST)
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33823 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992002AbcHVMMyhfwPm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Aug 2016 14:12:54 +0200
Received: by mail-lf0-f54.google.com with SMTP id l89so76119285lfi.1
        for <linux-mips@linux-mips.org>; Mon, 22 Aug 2016 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iuGjHGur+CQnskYjD81cUcZ5zmwFXRHkloj/p+cZPo8=;
        b=EYx3RU4x86IwZD6nYQd9chYSgSCsKmFEP9d9tiMfC3ejqxxhh7VXK+kSNhC5exT6No
         MGTNQWgDeVL/NsO/1WjC5OSMPV+TpzO4UGAfJyU2P5VXQnvdq815Czzn7gGfGpgTEK6s
         hJOPyyq2+clVkZr7GbBhPLToIbb6CXcDzpZFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iuGjHGur+CQnskYjD81cUcZ5zmwFXRHkloj/p+cZPo8=;
        b=i1hvzl2nPOIrbqViKn/0EPp5sQIPSRgKPstDpvqpOJO4qMpAVC2cbHvJgxMnyE93Tj
         /PwQMWZkoDiM04DnCbs2P88ctMtOTU+RQUW4/eFArNZOZESsEpohD5x+ITYYx0wae03O
         Pr6nIinuTRN+yhVnbJEJ4S1H64GdcAd0dg43BO5GjTmsDqnUuJ1/S9Bu6dq+FWaVTbOi
         58lXsgoz3zyn23Cdk9mHUTuduVf3zWFwu90QXt3HSwxyWWtb8ZPYQhPpnlJz1AGbfDOW
         A6gwHj9YUkJtS2TP3BbXFmfXGPcIoKm5RzbDnvLvW1zSMsbb3brqcKhAsGIeRu9B5Z0m
         jchQ==
X-Gm-Message-State: AEkooutFktNeK/6/jBUZ3E3o4EsuvM1cVTbODV0Pf4Nmxaz89Mzd+Zt8gT+k1jhEefpz/yNhgorgLWGDlTXZhFcl
X-Received: by 10.25.24.30 with SMTP id o30mr5704030lfi.58.1471867968590; Mon,
 22 Aug 2016 05:12:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.10.208 with HTTP; Mon, 22 Aug 2016 05:12:47 -0700 (PDT)
In-Reply-To: <1471525068-1525-2-git-send-email-geert@linux-m68k.org>
References: <1471525068-1525-1-git-send-email-geert@linux-m68k.org> <1471525068-1525-2-git-send-email-geert@linux-m68k.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Aug 2016 14:12:47 +0200
Message-ID: <CACRpkdbJrGOMqV7HBLOj3fOFJT-u-ywCCK7cf_HCraSrz1YQDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: TXx9: tx39xx: Move GPIO setup from .mem_setup()
 to .arch_init()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54722
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

On Thu, Aug 18, 2016 at 2:57 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> txx9_gpio_init() calls gpiochip_add_data(), which fails with -ENOMEM as
> it is called too early in the boot process. This causes all subsequent
> GPIO operations to fail silently.
>
> Postpone all GPIO setup to .arch_init() time to fix this.
>
> Suggested-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this will go through the MIPS tree.

Yours,
Linus Walleij
