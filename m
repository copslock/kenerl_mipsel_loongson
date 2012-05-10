Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 May 2012 15:24:15 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:53867 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903652Ab2EJNYL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 May 2012 15:24:11 +0200
Received: by ggcs5 with SMTP id s5so1084508ggc.36
        for <linux-mips@linux-mips.org>; Thu, 10 May 2012 06:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=SfqS7ImB/x9zZG2IV1Zz0fAPIufHU6UGB6s9C3thDsU=;
        b=S6ou5RnTNVKwEjnahY6nz+AHicE9HAshId/cSSqeMt912z3NNxwKb/S+YN+BYYTvmK
         HY+O7XmNve7OglSyyuQ/7RFACCZEp4LpmrgNUIaCdCg+GqdLT1uEMK+CBcIli7AQ2zAt
         mJp3gaNW1DN3JoedP57Gc+o+BTD7W1AkpaQbxJkLqGsfhafN84kKdY/1ANGyY5t3J35J
         Q/OuPoX2e+KTcmnasmUwm7ecpPv+XkHwR2W490QvYfBct4vP8M4LE8aGKXSEAsvdT05O
         ofY7cLo06cIkaQ9U3spbqowiRBbyx0LE70oAF92cwCoD7IF2JP6PECPJJRC1QFHJaKnb
         Dn2w==
MIME-Version: 1.0
Received: by 10.236.76.41 with SMTP id a29mr5034089yhe.117.1336656244835; Thu,
 10 May 2012 06:24:04 -0700 (PDT)
Received: by 10.147.137.4 with HTTP; Thu, 10 May 2012 06:24:04 -0700 (PDT)
In-Reply-To: <1336652846-31871-2-git-send-email-blogic@openwrt.org>
References: <1336652846-31871-1-git-send-email-blogic@openwrt.org>
        <1336652846-31871-2-git-send-email-blogic@openwrt.org>
Date:   Thu, 10 May 2012 15:24:04 +0200
Message-ID: <CACRpkdZ7YHQ0yhUOM=FB0MqbrT+QT7Zb9YP=JSADJB52qr68Yw@mail.gmail.com>
Subject: Re: [PATCH V2 04/14] OF: pinctrl: MIPS: lantiq: implement lantiq/xway
 pinctrl support
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org,
        Stephen Warren <swarren@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Gm-Message-State: ALoCoQkdgjfKxavM/HPbf5DZdCX2znvi/U9k40D27kDvNmbn5Vjxzc+aIOel651FDI9nY9sG7edL
X-archive-position: 33231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, May 10, 2012 at 2:27 PM, John Crispin <blogic@openwrt.org> wrote:

> Implement support for pinctrl on lantiq/xway socs. The IO core found on these
> socs has the registers for pinctrl, pinconf and gpio mixed up in the same
> register range. As the gpio_chip handling is only a few lines, the driver also
> implements the gpio functionality. This obseletes the old gpio driver that was
> located in the arch/ folder.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> ---
> This patch is part of a series moving the mips/lantiq target to OF and clkdev
> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.
>
> Changes in V2
> * cleanup select/depends of the relevant Kconfig symbols
> * dont assume that the arry with out MFPs is linearly mapped
> * sane return code checks inside ltq_pinctrl_dt_node_to_map
> * remove 2 calls to pr_err and replace them with calls to dev_err
> * propagate gpio_chips base addr to the gpio_range
> * define the pin count inside the of_device_id.data
> * minor changes to accomodate the pinctrl-falcon driver (more virt pointers
>  and clocks)
> * change from core_initcall_sync to arch_initcall
> * several typos, codestyle and whitespace cleanups
> * use BIT(x) in favour of (1 << x)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
