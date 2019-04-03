Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C60C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8690B21473
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5c5lpXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDCCbB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:31:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41869 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfDCCbB (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 22:31:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so5006910lja.8
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 19:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wR8K43oNbJgNeajTdms9sj50vtCSCCkA18rUhuiTdBo=;
        b=q5c5lpXL5oHhPebM/4M4/Kooea6086aoZ/0Ib6oP0JNN2uDiqZMnjRbPcM4khHJq9O
         pBlmTlVKujeATa4RBs7SS2Kqy29xIeB+hX086xREg5MNqhfQWYXtCyiEZ4SCUy0f4gAI
         5ygax+ngHQsmiNaeb7+9FpH5mG7c3L+UQSjBgvNZ5wixKOn0L+k3K8gYbIPKab4FPpkW
         af1JyBTxCIn+xOWNEBrSWzjOw3fkLcH7Tqsds68KHYTct0ayAKWkHSPs/89uTTyqzWak
         k/1igRwNB9LqJSwZ+17ixVHCLdFc+ftZFvLTs1SxrClqEa8oCqIwhnyothZuDoIOOtj3
         tbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wR8K43oNbJgNeajTdms9sj50vtCSCCkA18rUhuiTdBo=;
        b=Tk5teW0NWuLKkwL648eEXGb6kTllTUgUkKbic8bHCAyBMN/SNM0EnGCkPevY8ajUwX
         iSV9wtVWcHgb4BOdHj9yPlabrkafQ5TgboBuY+f5XKy06jb/o3lQQ3vTGrFW+LKgeiUS
         FpjhWPMDXclzODBDqPr09goultD9lPO3Tlg4hUcnD799jilmr/k5V2U3DrufQXyFLtg9
         h5dc2Q1Rv5VIM6DzbjQOUK3XgBZ6eOobZopIG8DFTdXMIGpeqQU2jRucD3faGg+mTdPd
         NVo6QIta3UyhRUe8LWHV4EA1UJEW89lKlaLWWBvtTL8oUz1v1aetq2O5w0bi8m/vuAYO
         EisA==
X-Gm-Message-State: APjAAAVaZIOi2piqwvgcjplAxLkv3w9fqJyWIxm3fjDjogfG5aRqgp+b
        xQzYcnFEaiO9EirvBUrTHSu0BHtxidOcNzjv8Pm1Kw==
X-Google-Smtp-Source: APXvYqxh8Ow04A4DdM8Gy2Hvj9Ug1FS6d4aT1+w5D55BBvB6aNwLxM85HQexD4arkKfC4whlyq4k0pCiK3DeKNtMSoM=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr4975426lja.49.1554258659140;
 Tue, 02 Apr 2019 19:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-13-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-13-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:30:47 +0700
Message-ID: <CACRpkdb6g_aGnoAd4Gp0jsd-xXxzuhtWMUcPRsFN0YsL44d01w@mail.gmail.com>
Subject: Re: [PATCH 13/42] drivers: gpio: hlwd: use devm_platform_ioremap_resource()
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

On Tue, Mar 12, 2019 at 1:55 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Yours,
Linus Walleij
