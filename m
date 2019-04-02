Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A26C43381
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 08:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93D920856
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 08:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T39HgVhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfDBIEK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:04:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34951 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbfDBIEJ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 04:04:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id t4so10700166ljc.2
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=T39HgVhTfm3lONpFgdxOD1TGPLbG6b83NOassGu/3gvknuEd/fHiScZF0AhoH7FMAL
         waJFxE2JT680xA1Q7abjpTd5chvAS3QlB8MKDAsWE9Fa9z2zziAVN7NQQZ4RIR2Dmiqc
         aWViAX6fuEQbnybVnw3LVWqA5rjDIyy8/nsKYF7I5dhHwBWYRole8hsOXnJR4b6ypW9B
         m4M8yTn0eJmLGH2ERRUyFHbaHvxktb93O/n1ZHcLYBP61boJ38o9Xvg5W/taqsFfNvVy
         CxfugJYezoVsOPUKEnibmoM4cCLpLaSujblS116v4+XAgnVQELLVjMu3tXipExFKD3hT
         qeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=aAU4tShiIZj97YWQJ/TSqxGl8tOAtCh8eTGjInk6mawRx26FSt1JYgMuH7IbMLQpBz
         jMD0lNGc2giRDd6ODhJ8WxNCPyNSCIDH4v9STdCuT8UZz+OGpyw8O9Ze5yqKO/3+WHGT
         Btc6ywh+Cu0jR54dv+OvU37vRB3FWg0mCKnYGzn2PNLZ+M650RIBXHCgvIl2FDzlise4
         RPavNbNucJChO6WX35Q40RJWOHr+C50sy7NaBoRddFQtlyzO51hymjTfYvJVGmX3i6NS
         6LmjUp05dojCvIY6pfDKDCRm+28J8xGwP5cJ0fIXC6kkkTf35L3HthT259CXA2TEf72Y
         FryQ==
X-Gm-Message-State: APjAAAX5KXHisrjEsSLgnrBwH1vRum2oRhdZlmoryYMzv1d9uZ3uIq0o
        LIocRPwXZ5ZZVMf1rrs7fPqNgM+zYH4r0DJnXFk9wQ==
X-Google-Smtp-Source: APXvYqz0LSVboO8nkzv8OYG6iQj7BFflFS8Y+r92pPC6YSrlAbev3KiDKxcqFvxVbplFoclQtwbRKJI/DP+ULTDDsGM=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr2172395lja.49.1554192247517;
 Tue, 02 Apr 2019 01:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 15:03:55 +0700
Message-ID: <CACRpkdYB3eatPJQYv1HKvcqY0uA8xjiHWC-kGtmfqHRD8J=bXQ@mail.gmail.com>
Subject: Re: [PATCH 01/42] drivers: gpio: 74xx-mmio: use devm_platform_ioremap_resource()
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

Patch applied.

Yours,
Linus Walleij
