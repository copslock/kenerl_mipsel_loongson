Return-Path: <SRS0=6JhV=SE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D8DC4360F
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 08:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C6920883
	for <linux-mips@archiver.kernel.org>; Tue,  2 Apr 2019 08:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJsPh5Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfDBI6E (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:58:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41985 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729670AbfDBI6E (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 04:58:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id v22so6151032lje.9
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHPapakipVF+IlDmV1uxsFzg+cFJnSIOX+OXVInwoHQ=;
        b=nJsPh5Wnr57TXHSHpgGFiCB8+4JU4vhb7D3iaHa7r6H1C7j3v/KErU/dNRcTz/fbn/
         SmYfWy/Tw18Dyteca8yVB8Pq4Mx4RpEJ9sJ4qzXKuO98chDdzMl9ic63xntU5376Z5pn
         hU9Zxp7VK4WLyOVUrIe0QiAjTEszps9Wk6HRxM7+3kq9dbGE09qxjm4Bh+NkZKOC1n8p
         rdr5pcmpoAm5TA5T64lVKYuo8xQ7lbAQa8HuUgeLMWdoTz3EzVcDNyfDLkXZ7W2oLt7d
         9WlM7u80cSU0c7xM1mZOKTLFk7/sj39O5noKx6Shg4P7J3stFW8GFqwO+FY3tOVln+Ok
         iVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHPapakipVF+IlDmV1uxsFzg+cFJnSIOX+OXVInwoHQ=;
        b=njT80yAqSWG3Owj2+CWXgVJ3OOkMIak4JxjcQ4tzcu/5HOtZcSDrfg7SYH8uNF83p/
         Y0kLGh5pZKF3YzlrlOcC5re5l2vvJqcdvZJpqUFIwQOY1r5fEDG6A6Nkbl9XiIhCxoqE
         VOvrz9Ftol7vFeImVutgIixeoRWphO7DeGrBA25YhlVaAHBh1I0z7mtp7RzcMY47tj8G
         h0Oap3/ToAB+8BavDP4ZYJtfbnkOVLtlGJXfYxYdyXiEMgQXQlz0JuwbilKonIwfMNI4
         Kxk149cED/qrTcSDl1W7l9SH0he0JL4D0t7y4schEc8fpObKDqXqOhiLFEc7bDI0DX7/
         AUVw==
X-Gm-Message-State: APjAAAXh8PGWaksJoLsA/s+2TZCMZlXOY3P6SuIqz3njPc98iFVuxvmo
        INQe3jP2vQO+pUDTFGLzoWy5nNE1omLXMCpbcAX/Pw==
X-Google-Smtp-Source: APXvYqw+qie5FmIxKv90NJ6cVymC3Ijj86umRzjBW7o7X4Iy/tDSgELJgQTMPcqa2NWbuXlrpHjftCAwq6D8YVbeM5s=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr2330248lja.49.1554195482337;
 Tue, 02 Apr 2019 01:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-5-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-5-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 15:57:50 +0700
Message-ID: <CACRpkdZCawLmDFXKGXXGWTqN9r5dHevHLLBOs=ou-ro6G2-HKQ@mail.gmail.com>
Subject: Re: [PATCH 05/42] drivers: gpio: bcm-kona: use devm_platform_ioremap_resource()
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

Patch applied with Florian's ACK.

Yours,
Linus Walleij
