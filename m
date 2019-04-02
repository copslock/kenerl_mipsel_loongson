Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E53C4360F
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 08:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DBE20857
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 08:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juGOwCA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfDBI4P (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:56:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46465 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfDBI4M (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 04:56:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id r25so8358482lfn.13
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWvxKx5CJ51hqzPgzW3JV6TZMj8L//u4J1Um2PVbGm4=;
        b=juGOwCA4vdMuRWgp7DvnryX01h2d5c7sanazEE6TwojtqCk/mdIOYSzKQgLiHaQGIN
         Jba3jFfUzzHSscxhO6uoGJ/XfQwNgYqjEwuZ42+JL7iY56cH1M/J4AN48VhEpTZ96LNg
         CSZAlcfO12WudWjWXRTYYE4JBfueT7iNg2rRqBJaxjicIYhXBKnG4ocPuVtlVQfcyOAN
         XVh/Hy1TUToUaINmN/t+hb+7eYFtbMnVfdTA2tpDtE7iHFtPe/1OE3yiBENXv3us/2fk
         +VscE6R9ajYlyPBnnTuwYjMihLdLOGfmd5X2qNfqe+yMxoWSkNCAGr0XWRjKjsd9l1o+
         qSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWvxKx5CJ51hqzPgzW3JV6TZMj8L//u4J1Um2PVbGm4=;
        b=nv7AIdpMFjNvTp9Sk9vyMYKq8riBjvWosMIv4cJeJlqik2qL7d3aGH5QHdGXgjBRhA
         V5AaxVjnggplGrfYVmeGYdHQqCnbIFiaapbKaggQfdhesxaA/DxAd8ygF/WUCwki/phg
         H3xgY+wj8N5qoUpgy6whFh1nIZAzluaJraVZwT0PCYUTiRKsJxs974IcVTRu9f8S8shx
         m9y9b3m+/pVFP7rH7n8Xvu+7CxVTCAKmmUInTxAn6rah3P44M8kRtqGO/YtIGDzMdwhD
         cCkrEBsQSeDNOLzFhHAvkJAn37KSmZz3pJrhyQT8ZAsNDWQi321p8ALusxze3EYQxVWO
         A/6w==
X-Gm-Message-State: APjAAAUVooL3diNwq6Ub/c5E201PvEgc0j+3IgOrapeUEyQ3tgGHK74J
        Ic1R9+9P0vL9sSyoBHY+wIsMwwlp84tErLc0O99mMQ==
X-Google-Smtp-Source: APXvYqyWJLpJysl2y68+0/uGdKoguNtBM8sNGXrgpnyLezXNzfrnWyGWG6F4a/IXdgdrwp8YXLoKMBkEbM5a4miM39E=
X-Received: by 2002:ac2:54b0:: with SMTP id w16mr1633898lfk.138.1554195370352;
 Tue, 02 Apr 2019 01:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-4-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-4-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 15:55:58 +0700
Message-ID: <CACRpkdZrKVQpxmsCS6aKStDFA2_zDtTYghdt9LUKF3eQRf63Yw@mail.gmail.com>
Subject: Re: [PATCH 04/42] drivers: gpio: aspeed: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, Mar 12, 2019 at 2:00 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
