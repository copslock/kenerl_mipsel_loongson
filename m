Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C757FC4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9180720830
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 03:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKtYxtwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfDCDcu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:32:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37607 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfDCDcu (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 23:32:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id o19so207519lfl.4
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 20:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCHuYZwShC0SSs91PVEBOAxkLphUC+4MrAsjagpLwQk=;
        b=tKtYxtwHdsLitqDbT/bvLkz/4V+uSdm52IelVe+0R10Hlpn7uZ8f2m+yBHTLtTS/ql
         oTF0U0W56WcZeLoXnzXhtsIYoZWY+CS8nbHV5mHPTpK4JXu9BJDkGsx7PI54SEbU6EMI
         yzjfp8gqinwFEW1S0MCz6pusVYWhsSe3AfphjSW8+7qCYix3vFFMI0sOvR2oRnnSeZI1
         eKp4N2yd9nvV9Wjx6pBwygg+DJ8IAXA7JWIu/1wLftNrbzSlDmqutCuPF1vtEbE2LCbU
         Fvmygs5hqhh+tIjRIlpa/6rBhrPzf8dTikDKSQJYG85HNS4wRkNmv9roLZpI0fMwrRhU
         iqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCHuYZwShC0SSs91PVEBOAxkLphUC+4MrAsjagpLwQk=;
        b=ed50u9Kl0UFkbr/RMurokI1eR1K+Hy9S1+muUZ49/kKuhEcmrSvtnJvbfljXp9BJ9o
         DvvROaPi70ZIyLZDuXmH2OQma2ibqPJa+ii9XpKhYmPZyDfmfeVsQEbCr99V4u/eqCuF
         cKbxRccu0eCKuxmicI1klHMpXH5RHQVwGrrShFAT3rRjDwQCWnUTB/KuJEFIMdBTzNn8
         pBt1vCmqvpL+RFZCQPGTccvJ7kGsCkOF9629aTF9Xa+vQXQhylcKrxtYeuYjl9vLzT2B
         8OYHP+99bRaUHnu4ljOuaOasgdES+OCQcDOodc7pR3xau7rEHSJi7n2VC6lAyWPu/Ibt
         5CHA==
X-Gm-Message-State: APjAAAVzaspusrRorMLtIADZ4+d+fXc37HfK68gP9t/TRiegAVj4iK93
        3mTg/hzl86sIq3wCEuPDs6GEYJYH3A+juEBVAItyfw==
X-Google-Smtp-Source: APXvYqxa1xT6zd5hRIjquO+yC8wbkQmhFYE+rBC5zjqTeiysQx+MXMz4hfJFE0sZkfDH9CPtVTk9JV2OWY/SSk02REY=
X-Received: by 2002:a19:ec14:: with SMTP id b20mr24261664lfa.55.1554262367930;
 Tue, 02 Apr 2019 20:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-26-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-26-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 10:32:36 +0700
Message-ID: <CACRpkdbwFpX6CR=25fW4hxwZrdpq6vbyMw06J6Ff2un9OUarcw@mail.gmail.com>
Subject: Re: [PATCH 26/42] drivers: gpio: rcar: pendantic formatting
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

On Tue, Mar 12, 2019 at 1:56 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> a tab sneaked in, where it shouldn't be.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Waiting for a new version of this patch.

Yours,
Linus Walleij
