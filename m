Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2016 14:03:16 +0200 (CEST)
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35998 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991888AbcIOMDJays62 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Sep 2016 14:03:09 +0200
Received: by mail-oi0-f42.google.com with SMTP id q188so65388546oia.3
        for <linux-mips@linux-mips.org>; Thu, 15 Sep 2016 05:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n+2WsSOYI+Zk4xc1Cy9fyk715aTUwrkXiei/5Om2R9U=;
        b=W++5HzoeUAg0muHPykCaFUkSg51G+mRt7oxxiMT/BU3xJMXLvOzp35SwXUWbxXZ0Q8
         WjUVdnzpiJeDNUZo2StvTaCsk2mrnU+jAHFytI0WJMVaFb7ZPuvH5Ucd+P9qz83vohm+
         ZzzmKAWPUMVTMEPHcianFM3rmlbeCFJO0/SDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n+2WsSOYI+Zk4xc1Cy9fyk715aTUwrkXiei/5Om2R9U=;
        b=fzdLyC87OrwG1gVTpFfqfPcLfdikShNJsyeEeM3ZtqDCnAV2l1tfBsoss2fbsfo8CP
         3AQY4BiptQPpVBXQY5YFtLvQoKABOgXM9pQTFlLyf3tMTb3Z0Cx87bKtkc9GHuedtnwL
         XkZTJnWsao3PtBfzbo9kCJPEDMOoNX/vfC67mJQCC0/SHUafginvTz4yczgp7LW+R36k
         QRpiAHnp2H+QLLTQh+Oyr7HtjLGgL37P8J9kmHsFb7wZB2lRwtG6WFW11tWq/JuVduxX
         9ckMlD0NsEoVBLO6LhhJVMlgOzst3p1Pd+mzdLB7eHjJ9+ZGFl/FiZ5+aTRil9AnH5Qy
         QvVQ==
X-Gm-Message-State: AE9vXwOCVZh2bpVtSczG/NJkmnCdGciA7csDaFDo2EOla8Xv2PKocMluFqTVGuM3IQVaCDJfuVsoomgcrpp+/zOS
X-Received: by 10.202.97.198 with SMTP id v189mr6846273oib.54.1473940983394;
 Thu, 15 Sep 2016 05:03:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.146.7 with HTTP; Thu, 15 Sep 2016 05:03:02 -0700 (PDT)
In-Reply-To: <20160912221631.15812-7-paul.gortmaker@windriver.com>
References: <20160912221631.15812-1-paul.gortmaker@windriver.com> <20160912221631.15812-7-paul.gortmaker@windriver.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Sep 2016 14:03:02 +0200
Message-ID: <CACRpkdYV_uKMaOX1ZLw_hq3BNGXbrtAerwhwnJQixdbLwAP2Uw@mail.gmail.com>
Subject: Re: [PATCH 6/8] gpio: loongson1: fix implicit assumption module.h is present
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55142
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

On Tue, Sep 13, 2016 at 12:16 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> The Kconfig for this file is:
>
> drivers/gpio/Kconfig:config GPIO_LOONGSON1
> drivers/gpio/Kconfig:   tristate "Loongson1 GPIO support"
>
> ...but however it does not include module.h -- it in turn gets it from
> another header (gpio/driver.h) and we'd like to replace that with a
> forward delcaration of "struct module;" but if we do, this file will
> fail to compile.
>
> So we fix this first to avoid putting build failures into the bisect
> commit history.
>
> Cc: Keguang Zhang <keguang.zhang@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Patch applied.

Yours,
Linus Walleij
