Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A712BC4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCBF21473
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWIqJY9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDCDnd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:43:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35538 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfDCDnc (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 23:43:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so13522831ljc.2
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 20:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0LO8i/P4ocbb21SDQpdrOuCyeO4aCMaVaU0YL0U9YA=;
        b=tWIqJY9ljIqi4ag/uGSq2A+1a+qk+fJ4OW7dlhsH+6XB6u/Gauo4Hk0NIjgh2w0+p/
         zPluNPAFQWU5LUGSfmu5A1w7+sZDd3eHXtUfc13pLbZZgUewYkEi2aB7HGwWFeNqGzIq
         WBL/5QN44WDRrS8WSxVqyklWkIgmISo5EhbQbdWP0kvZIJ5OjcgGXXsK6BuRCOdr7GF2
         n6n9cCranRHvcp5kfgNTqzwHbTvsJvTYAr2e7Ce8sOeA85mfDjWboEIfoR2ypCKxXPci
         S3ar80W2CmnZ/Q+Kt8Va6Um7EtEPZScqxXUpGOG/XrwNbwEme5TDmCrhbYbEVRPri81T
         Zqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0LO8i/P4ocbb21SDQpdrOuCyeO4aCMaVaU0YL0U9YA=;
        b=oT/7R0fNTXjtsIstmkbhdVTOMhP/N5tEBkmJIW9pb1MVJlEfx29k/Lgn9yHN990e5d
         ExnMy4zR0FIb9Pi9RN/TrtLlxbw3h+UsXRH3y2M5DUlRHeoophxKZKE88fFKGFWto3eQ
         ovWmogQKzXFDEvxm3/3x718gYOS3ToLJ1aVjkSFIQuuBorXqtIkXbNzR0hb58xFuXhu9
         jisSi+wz25vmfIVQFs6yZvykDWQJoqHM3HaUSM2ovCNU4Q5pCJHw3GI1dgvgW4z10yp2
         AjTQebIFZEThRzROMHx8xASVNOoe88oMhrW/LdF0tw5QhD6YHAYORdaojBwfUkyAxaad
         v6Ag==
X-Gm-Message-State: APjAAAVtzNKpEp9PX/aPxJ6VsU/GeTJUVIfGo5gjdSNYhvs+eG7GWjiA
        RN2KBZ1JocVGzGJgNbaLeVjWMEOKvScR/CO9jCl62g==
X-Google-Smtp-Source: APXvYqzs3p5eeekC1smqdb7NhFCNd20lFTWFXxxrhwp2Wf/zcbVWKms0iEnE/4nFz9rN/sJtwN03734jlLGuFWe677c=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr23078320ljg.103.1554263011539;
 Tue, 02 Apr 2019 20:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-31-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-31-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:43:20 +0700
Message-ID: <CACRpkdZ11eFa0NxxjqgGSw=nbv7u5PuiV2yEOJRhmTfJMvFhuw@mail.gmail.com>
Subject: Re: [PATCH 31/42] drivers: gpio: stp-xway: use devm_platform_ioremap_resource()
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

On Tue, Mar 12, 2019 at 1:57 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
