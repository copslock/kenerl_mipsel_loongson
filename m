Return-Path: <SRS0=IOgP=SF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE39C4360F
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B3F2084C
	for <linux-mips@archiver.kernel.org>; Wed,  3 Apr 2019 02:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHRj07yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfDCC2u (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:28:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40220 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDCC2u (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 2 Apr 2019 22:28:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so13385992ljq.7
        for <linux-mips@vger.kernel.org>; Tue, 02 Apr 2019 19:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=RHRj07yIPbiBz4Fu7vYrfyBxqZqJbq4YWv35BfWEsuunl+AMu+I9eG/+DLUHA1ykKO
         gt6HePyp8GVVjDA+zAsUQ6tjrcLy//4VT2hjloWZTxGe7atIIbT627nRyx6RF/UURzhS
         15FGOMMrzcjjbs+EBiSI1aTFTPocxnJFhUJB7Ozfp7QfzWvXuumgcPFGQbEgK6QM9aR7
         wwR+r6uacLVIKmv39lV7oC2oYtbrW3DpFiTlPzJZP4miFm5odzUVsB1wYpqK4f7BgXZF
         lD37ZnqnKzaHCfRN3F2U83jbUqDVS2Po3fHeiS9ss46lUZTWWmAPcHxM7cIPp6TAavvd
         eprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=kXlLMK5vbI+R0ZmoeA2fEANs5lGlblV97W5ScIRGxC4pmchlZpJqCfASKQkYqoCaRj
         vNi5ewnyLRHJPb9zTpZnaAz2RFVqiC/rnRZDmMT+UrqIhgAKqYJFZrYTmw1cZOq/HHW3
         R8Yw5T3ehxcfunhkYOfVMfNjqmZKPc/SIvMY66t1G+Avo5u2BqleCb6PM5rZzYVc/vbJ
         7h50eysIGq1/fYCa7i2zJCS9LLcYOJFR7C8gi8NNRAvnd80qrhdohq0DrP0+WadDGLn7
         iFx1lfgcriuED0bFvgiYeRvIlcKdnH0QZ5nY5nYruX785/b9uQOEi0qWcegOhBa/BvlD
         M/Qg==
X-Gm-Message-State: APjAAAV6NXoGPPVtNUbLmFbS99hCKqkywjqX75bGIOdBrjW/IuaTlsn2
        8ivJg3PY4XlBWgzTZHCtUGZb5Sjea9oXqHXPki2BSQ==
X-Google-Smtp-Source: APXvYqy/NjEsBF8XZXffh3VE8wr5UcaJo1BuodALE2IWGtpVdB28B/Y5HepfVScciFFyVUftjCRf+JZUwoQ71Nxcen8=
X-Received: by 2002:a2e:5d56:: with SMTP id r83mr37863859ljb.74.1554258528335;
 Tue, 02 Apr 2019 19:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-11-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-11-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:28:36 +0700
Message-ID: <CACRpkdZeDxKSeoHRzxnyCmbgzbo_-dmzuTVYZ+fQod=TeftapA@mail.gmail.com>
Subject: Re: [PATCH 11/42] drivers: gpio: ftgpio010: use devm_platform_ioremap_resource()
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
